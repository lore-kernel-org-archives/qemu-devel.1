Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534DFC33C99
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 02:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28D9020692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 02:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D9020692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip0mc-0000MG-3s
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 21:09:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1ip0jQ-0003mr-Ut
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 21:06:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1ip0jP-00086w-Qh
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 21:06:00 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2286 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1ip0jN-000844-5L; Tue, 07 Jan 2020 21:05:57 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 481913990FF36C2D1493;
 Wed,  8 Jan 2020 10:05:50 +0800 (CST)
Received: from [10.184.39.213] (10.184.39.213) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 8 Jan 2020
 10:05:25 +0800
Subject: Re: [PATCH] nbd: fix uninitialized variable warning
To: Eric Blake <eblake@redhat.com>
References: <20200106015443.38540-1-pannengyuan@huawei.com>
 <a67b1b6c-addf-da76-b8b3-8af0dd48a1d8@redhat.com>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <647caa9c-c800-24f8-28b8-207c8a660959@huawei.com>
Date: Wed, 8 Jan 2020 10:05:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <a67b1b6c-addf-da76-b8b3-8af0dd48a1d8@redhat.com>
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.184.39.213]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, Euler Robot <euler.robot@huawei.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 1/8/2020 6:24 AM, Eric Blake wrote:
> On 1/5/20 7:54 PM, pannengyuan@huawei.com wrote:
>> From: Pan Nengyuan <pannengyuan@huawei.com>
>>
>> Fixes:
>> /mnt/sdb/qemu/nbd/server.c: In function 'nbd_handle_request':
>> /mnt/sdb/qemu/nbd/server.c:2313:9: error: 'ret' may be used uninitiali=
zed in this function [-Werror=3Dmaybe-uninitialized]
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>=20
> False positive in the robot - I cannot see any path where ret is used u=
ninitialized.=C2=A0 Closest might be the handling of NBD_CMD_BLOCK_STATUS=
, which looks like:
>=20
> if (a || b) {
> =C2=A0 if (a) {
> =C2=A0=C2=A0=C2=A0 ret =3D ...;
> =C2=A0=C2=A0=C2=A0 if (ret < 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> =C2=A0=C2=A0=C2=A0 }
> =C2=A0 }
> =C2=A0 if (b) {
> =C2=A0=C2=A0=C2=A0 ret =3D ...;
> =C2=A0=C2=A0=C2=A0 if (ret < 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> =C2=A0=C2=A0=C2=A0 }
> =C2=A0 }
> =C2=A0 return ret;
> }
>=20
> In fact, those 'if (ret < 0)' tests are pointless, since nothing else r=
eally happens before the final return ret.
>=20
> If I'm right about this being what trips up the robot, does changing 'i=
f (b)' into 'else' solve the problem, rather than adding an initializer? =
And if so, can we clean up the pointless code while at it?

Yes, you are right, Changing 'if(b)' to 'else' solves the problem.
I will change it and clean up the pointless code in next version.

Thanks.

>=20
>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>> ---
>> =C2=A0 nbd/server.c | 2 +-
>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/nbd/server.c b/nbd/server.c
>> index 24ebc1a805..7eb3de0842 100644
>> --- a/nbd/server.c
>> +++ b/nbd/server.c
>> @@ -2310,7 +2310,7 @@ static coroutine_fn int nbd_handle_request(NBDCl=
ient *client,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NBDRequest *request,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t *data, Error **errp)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 int ret;
>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int flags;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NBDExport *exp =3D client->exp;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *msg;
>>
>=20


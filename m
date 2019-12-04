Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377DCC432C0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 03:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 079752068E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 03:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 079752068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icLXv-0008Aw-3B
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 22:41:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1icLNn-00060F-MA
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 22:31:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1icLNj-00010n-8C
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 22:31:19 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:52710 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1icLNX-0008E9-W2; Tue, 03 Dec 2019 22:31:04 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 89B0DE1142E1988051D4;
 Wed,  4 Dec 2019 11:30:53 +0800 (CST)
Received: from [127.0.0.1] (10.120.177.99) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Dec 2019
 11:30:46 +0800
Subject: Re: for 4.2 ??? Re: [PATCH V3 2/2] block/nbd: fix memory leak in
 nbd_open()
To: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy
 <vsementsov@virtuozzo.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "sgarzare@redhat.com"
 <sgarzare@redhat.com>
References: <1575012326-51324-1-git-send-email-pannengyuan@huawei.com>
 <1575012326-51324-2-git-send-email-pannengyuan@huawei.com>
 <1cff97de-303b-3b27-f737-3f69759746b0@virtuozzo.com>
 <08f0d51d-f352-5d64-26a4-9a741a4cf2e0@redhat.com>
From: pannengyuan <pannengyuan@huawei.com>
Message-ID: <20c34f0f-17cb-8de0-2cfc-7610bcad3b8e@huawei.com>
Date: Wed, 4 Dec 2019 11:30:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <08f0d51d-f352-5d64-26a4-9a741a4cf2e0@redhat.com>
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.120.177.99]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: "liyiting@huawei.com" <liyiting@huawei.com>,
 "zhang.zhanghailiang@huawei.com" <zhang.zhanghailiang@huawei.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kuhn.chenqun@huawei.com" <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/12/4 2:54, Eric Blake wrote:
> On 12/3/19 11:52 AM, Vladimir Sementsov-Ogievskiy wrote:
>> It's just a memory leak, but it's a regression in 4.2.
>>
>> Should we take it into 4.2?
>=20
> Sorry, I was on holiday and then jury service, so I missed any chance a=
t
> getting this into -rc3.=C2=A0 The memory leak only happens on failure, =
and
> you'd have to be pretty desperate to purposefully attempt to open a lot
> of NBD devices where you know you'll get a failure just to trigger
> enough of a leak to cause the OOM-killer to target qemu.=C2=A0 So I'm f=
ine if
> this is deferred to 5.0, and just cc's qemu-stable (now done).
>=20
> I'll queue this through my NBD tree for 5.0.
>=20
>>
>>
>> 29.11.2019 10:25, pannengyuan@huawei.com wrote:
>>> From: PanNengyuan <pannengyuan@huawei.com>
>=20
>>>
>>> Reported-by: Euler Robot <euler.robot@huawei.com>
>>> Signed-off-by: PanNengyuan <pannengyuan@huawei.com>
>=20
> I'm not one to tell you that your name is written incorrectly, but it
> does look odd to have a single word rather than a space between two
> capitalized portions.=C2=A0 If that's really how you want your S-o-b an=
d
> authorship to appear, I'm happy to preserve it; but you may want to
> consider updating your git settings, and posting a v4 with an updated
> spelling if you would prefer something different.=C2=A0 (It is also
> acceptable to use UTF-8 characters; some people like listing an S-o-b i=
n
> both native characters and a Westernized variant).
>=20

Thanks for your advice, I will update my git settings.

>>
>> May add:
>>
>> Fixes: 8f071c9db506e03ab
>=20
> Yes, information like that helps in deciding how long the problem has
> been present (in this case, it is indeed a regression added in 4.2, eve=
n
> if minor in nature).
>=20

ok, I will add it next time.




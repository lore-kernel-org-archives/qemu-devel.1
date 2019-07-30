Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A08C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 14:02:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A7BC20693
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 14:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7BC20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsShh-0002gf-7B
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 10:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55008)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <piaojun@huawei.com>) id 1hsSgQ-0001Hg-12
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 10:00:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <piaojun@huawei.com>) id 1hsSgN-0000b3-VV
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 10:00:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2182 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <piaojun@huawei.com>) id 1hsSgN-0000Y8-1B
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 10:00:51 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id A0569FCD0B5F2BC12D2B;
 Tue, 30 Jul 2019 22:00:43 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Tue, 30 Jul 2019
 22:00:39 +0800
To: Eric Blake <eblake@redhat.com>, <virtio-fs@redhat.com>,
 <qemu-devel@nongnu.org>
References: <5D3F8F04.3030404@huawei.com>
 <4ec43f2f-1d72-5fe1-3b93-2c75ee6f87b4@redhat.com>
From: piaojun <piaojun@huawei.com>
Message-ID: <5D404D85.1050109@huawei.com>
Date: Tue, 30 Jul 2019 22:00:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <4ec43f2f-1d72-5fe1-3b93-2c75ee6f87b4@redhat.com>
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.190
Subject: Re: [Qemu-devel] [PATCH] virtiofsd: fix compile error if
 'F_OFD_GETLK' not defined
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric,

On 2019/7/30 21:28, Eric Blake wrote:
> On 7/29/19 7:27 PM, piaojun wrote:
>> Use F_GETLK for fcntl when F_OFD_GETLK not defined.
>=20
> Which system are you hitting this problem on?
>=20
> The problem with F_GETLK is that it is NOT as safe as F_OFD_GETLK.
>=20
> We already have fcntl_op_getlk and qemu_probe_lock_ops() in util/osdep.=
c
> to not only determine which form to use, but also to emit a warning to
> the end user if we had to fall back to the unsafe F_GETLK. Why is your
> code not reusing that logic?

virtiofsd compile error due to missed 'F_OFD_GETLK'. My kernel version is
3.10.

linux-PUALcm:/home/code/virtiofs/qemu # make -j 8 virtiofsd

make[1]: Entering directory `/home/code/virtiofs/qemu/slirp'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory `/home/code/virtiofs/qemu/slirp'
	CHK version_gen.h
  CC      contrib/virtiofsd/passthrough_ll.o
  CC      qapi/qapi-clone-visitor.o
  CC      qapi/qmp-event.o
  CC      qapi/qapi-util.o
  CC      qapi/qapi-builtin-types.o
  CC      qapi/qapi-types-audio.o
  CC      qapi/qapi-types-authz.o
  CC      qapi/qapi-types-block-core.o
contrib/virtiofsd/passthrough_ll.c: In function =E2=80=98lo_getlk=E2=80=99=
:
contrib/virtiofsd/passthrough_ll.c:1622:25: error: =E2=80=98F_OFD_GETLK=E2=
=80=99 undeclared (first use in this function)
  ret =3D fcntl(plock->fd, F_OFD_GETLK, lock);
                         ^
contrib/virtiofsd/passthrough_ll.c:1622:25: note: each undeclared identif=
ier is reported only once for each function it appears in
contrib/virtiofsd/passthrough_ll.c: In function =E2=80=98lo_setlk=E2=80=99=
:
contrib/virtiofsd/passthrough_ll.c:1671:25: error: =E2=80=98F_OFD_SETLK=E2=
=80=99 undeclared (first use in this function)

>=20
>>
>> Signed-off-by: Jun Piao <piaojun@huawei.com>
>> ---
>>  contrib/virtiofsd/passthrough_ll.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/pa=
ssthrough_ll.c
>> index 9ae1381..757785b 100644
>> --- a/contrib/virtiofsd/passthrough_ll.c
>> +++ b/contrib/virtiofsd/passthrough_ll.c
>> @@ -1619,7 +1619,11 @@ static void lo_getlk(fuse_req_t req, fuse_ino_t=
 ino,
>>  		return;
>>  	}
>>
>> +#ifdef F_OFD_GETLK
>>  	ret =3D fcntl(plock->fd, F_OFD_GETLK, lock);
>> +#else
>> +	ret =3D fcntl(plock->fd, F_GETLK, lock);
>> +#endif
>=20
> Hmm. Since this is in contrib, you are trying to compile something that
> is independent of util/osdep.c (at least, I assume that's the case, as
> contrib/virtiofsd/ is not even part of qemu.git master yet - in which
> case, why is this not being squashed in to the patch introducing that
> file, rather than sent standalone).  On the other hand, that raises the
> question - who is trying to use virtiofsd on a kernel that is too old t=
o
> provid F_OFD_GETLK?  Isn't the whole point of virtiofsd to be speeding
> up modern usage, at which point an old kernel is just gumming up the
> works?  It seems like you are better off letting compilation fail on a
> system that is too old to support decent F_OFD_GETLK, rather than
> silently falling back to something that is unsafe.

Perhaps reusing qemu_lock_fd() looks a better way to solve this.

Thanks,
Jun

>=20



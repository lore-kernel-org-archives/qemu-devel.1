Return-Path: <SRS0=5wN1=WA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0080C433FF
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2019 08:19:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B511A20844
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2019 08:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B511A20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huBjb-0001Vk-Qh
	for qemu-devel@archiver.kernel.org; Sun, 04 Aug 2019 04:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44734)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <piaojun@huawei.com>) id 1huBjE-00017F-OL
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 04:18:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <piaojun@huawei.com>) id 1huBjD-000852-Gw
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 04:18:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2248 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <piaojun@huawei.com>) id 1huBjD-00083K-6W
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 04:18:55 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id EFCAEB9FEE6DA4F68028;
 Sun,  4 Aug 2019 16:18:44 +0800 (CST)
Received: from [10.45.4.110] (10.45.4.110) by smtp.huawei.com (10.3.19.203)
 with Microsoft SMTP Server id 14.3.439.0; Sun, 4 Aug 2019 16:18:41 +0800
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>
References: <5D43F688.8000607@huawei.com> <20190802105352.GF2899@work-vm>
 <20190802111034.GC30115@redhat.com>
From: piaojun <piaojun@huawei.com>
Message-ID: <6390d190-88ac-f1f5-9151-4c70f401db14@huawei.com>
Date: Sun, 4 Aug 2019 16:18:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802111034.GC30115@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
X-Originating-IP: [10.45.4.110]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.191
Subject: Re: [Qemu-devel] [PATCH v2] virtiofsd: fix compile error if
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Daniel and Dave,

On 2019/8/2 19:10, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Aug 02, 2019 at 11:53:52AM +0100, Dr. David Alan Gilbert wrote:
>> * piaojun (piaojun@huawei.com) wrote:
>>> Use F_GETLK for fcntl when F_OFD_GETLK not defined, such as kernel 3.=
10.
>>>
>>> Signed-off-by: Jun Piao <piaojun@huawei.com>
>>
>>
>>> ---
>>> v2:
>>> - Use F_OFD_SETLK to replace F_OFD_GETLK in #ifdef.
>>>
>>> ---
>>>  contrib/virtiofsd/passthrough_ll.c | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/p=
assthrough_ll.c
>>> index a81c01d..c69f2f3 100644
>>> --- a/contrib/virtiofsd/passthrough_ll.c
>>> +++ b/contrib/virtiofsd/passthrough_ll.c
>>> @@ -1780,7 +1780,11 @@ static void lo_getlk(fuse_req_t req, fuse_ino_=
t ino,
>>>  		goto out;
>>>  	}
>>>
>>> +#ifdef F_OFD_GETLK
>>>  	ret =3D fcntl(plock->fd, F_OFD_GETLK, lock);
>>> +#else
>>> +	ret =3D fcntl(plock->fd, F_GETLK, lock);
>>> +#endif
>>>  	if (ret =3D=3D -1)
>>>  		saverr =3D errno;
>>>
>>> @@ -1831,7 +1835,11 @@ static void lo_setlk(fuse_req_t req, fuse_ino_=
t ino,
>>>
>>>  	/* TODO: Is it alright to modify flock? */
>>>  	lock->l_pid =3D 0;
>>> +#ifdef F_OFD_SETLK
>>>  	ret =3D fcntl(plock->fd, F_OFD_SETLK, lock);
>>> +#else
>>> +	ret =3D fcntl(plock->fd, F_GETLK, lock);
>>                                ^^^^^^^
>>
>> Typo! You've got GETLK rather than SETLK.

Yes, it's a shame for the mistake.

>>
>> But, a bigger question - does this actually work!
>> The manpage says:
>>    'If a process closes any file descriptor referring to a file, then
>>    all of the process's locks on that file are released, regardless of=
 the
>>    file descriptor(s) on which the locks were obtained.'
>>
>> the fd we're using here came from lookup_create_plock_ctx which did
>> a new openat to get this fd; so we've already got multiple fd's
>> referring to this file; and thus I worry we're going to close
>> one of them and lose all our locks on it.
>=20
> Yeah, this is what makes F_GETLK/F_SETLK such an awful thing to
> use. It is just about managable if an app is single threaded
> and the developer can examine all code paths to make sure there
> are no other open FDs referring to the same underling file.
> If code has multiple FDs open, and/or is a multithreaded app,
> F_SETLK is really fragile / error prone.
>=20
> In QEMU proper, we used the fallback to F_GETLK/F_SETLK because
> we were adding locking to existing features. If we didn't have
> the fallback then we would either be breaking existing usage by
> mandating OFD locks, or leaving those users with no locking at
> all by disabling locking entirely.
>=20
> For a program like virtiofsd that is brand new functionality
> we don't have to worry about breaking existing users. Thus I
> would strongly recommend we just mandate OFD locks, and entirely
> disable the build of virtiofsd if OFD is missing on the host.
>=20
> RHEL-7's 3.10 kernel *does* have OFD locking as it was backported
> and QEMU in RHEL-7 already uses this. Users just need to make
> sure they have updates applied to their RHEL-7 hosts to get this.

I checked the linux kernel commit history and found that F_OFD_SETLK was
introduced at v3.15 as below:

https://github.com/torvalds/linux/commit/0d3f7a2dd2f5cf9642982515e020c1ae=
e2cf7af6

So maybe I need update my kernel to fit this new macro, and as you said,
most users will compile virtiofsd based on new kernel, that seems not a
big deal. At last, thanks for your detailed explanation.

Thanks,
Jun

>=20
> Regards,
> Daniel
>=20


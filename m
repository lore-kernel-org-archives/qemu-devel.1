Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87286C32753
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 08:16:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 640DF20880
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 08:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640DF20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htSkE-0000jg-ET
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 04:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39199)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <piaojun@huawei.com>) id 1htSjp-0000Kj-Qc
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 04:16:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <piaojun@huawei.com>) id 1htSjo-000112-Ak
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 04:16:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2183 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <piaojun@huawei.com>) id 1htSjo-0000vT-04
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 04:16:32 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id A029CE61FE73E52B6563;
 Fri,  2 Aug 2019 16:16:21 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Fri, 2 Aug 2019
 16:16:20 +0800
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake
 <eblake@redhat.com>
References: <5D3F8F04.3030404@huawei.com>
 <4ec43f2f-1d72-5fe1-3b93-2c75ee6f87b4@redhat.com>
 <20190801142016.GI2773@work-vm> <20190801142637.GJ2773@work-vm>
From: piaojun <piaojun@huawei.com>
Message-ID: <5D43F143.6060901@huawei.com>
Date: Fri, 2 Aug 2019 16:16:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20190801142637.GJ2773@work-vm>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.190
Subject: Re: [Qemu-devel] [Virtio-fs] [PATCH] virtiofsd: fix compile error
 if 'F_OFD_GETLK' not defined
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

Hi Dave and Eric,

On 2019/8/1 22:26, Dr. David Alan Gilbert wrote:
> * Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
>> * Eric Blake (eblake@redhat.com) wrote:
>>> On 7/29/19 7:27 PM, piaojun wrote:
>>>> Use F_GETLK for fcntl when F_OFD_GETLK not defined.
>>>
>>> Which system are you hitting this problem on?
>>>
>>> The problem with F_GETLK is that it is NOT as safe as F_OFD_GETLK.
>>>
>>> We already have fcntl_op_getlk and qemu_probe_lock_ops() in util/osdep.c
>>> to not only determine which form to use, but also to emit a warning to
>>> the end user if we had to fall back to the unsafe F_GETLK. Why is your
>>> code not reusing that logic?
>>>
>>>>
>>>> Signed-off-by: Jun Piao <piaojun@huawei.com>
>>>> ---
>>>>  contrib/virtiofsd/passthrough_ll.c | 9 +++++++++
>>>>  1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthrough_ll.c
>>>> index 9ae1381..757785b 100644
>>>> --- a/contrib/virtiofsd/passthrough_ll.c
>>>> +++ b/contrib/virtiofsd/passthrough_ll.c
>>>> @@ -1619,7 +1619,11 @@ static void lo_getlk(fuse_req_t req, fuse_ino_t ino,
>>>>  		return;
>>>>  	}
>>>>
>>>> +#ifdef F_OFD_GETLK
>>>>  	ret = fcntl(plock->fd, F_OFD_GETLK, lock);
>>>> +#else
>>>> +	ret = fcntl(plock->fd, F_GETLK, lock);
>>>> +#endif
>>>
>>> Hmm. Since this is in contrib, you are trying to compile something that
>>> is independent of util/osdep.c (at least, I assume that's the case, as
>>> contrib/virtiofsd/ is not even part of qemu.git master yet - in which
>>> case, why is this not being squashed in to the patch introducing that
>>> file, rather than sent standalone).  On the other hand, that raises the
>>> question - who is trying to use virtiofsd on a kernel that is too old to
>>> provid F_OFD_GETLK?  Isn't the whole point of virtiofsd to be speeding
>>> up modern usage, at which point an old kernel is just gumming up the
>>> works?  It seems like you are better off letting compilation fail on a
>>> system that is too old to support decent F_OFD_GETLK, rather than
>>> silently falling back to something that is unsafe.
>>
>> It is, but I guess the answer here is someone wanted to build on RHEL7.
> 
> although looking at the tools it went in 7.6
> 
> Dave
> 

Yes, the compile error comes from kernel 3.10, and it seems necessary
to solve this. I try to reuse qemu_lock_fd() to compat F_GETLK/F_SETLK,
but its semantics differs from fcntl, so I think using #ifdef will be
easier.

We could delete F_GETLK/F_SETLK compat when virtiofsd is limited to be
built in newer kernel. And I'm glad to hear from other developers.

Thanks,
Jun

>> Dave
>>
>>>
>>> -- 
>>> Eric Blake, Principal Software Engineer
>>> Red Hat, Inc.           +1-919-301-3226
>>> Virtualization:  qemu.org | libvirt.org
>>>
>>
>>
>>
>>
>>> _______________________________________________
>>> Virtio-fs mailing list
>>> Virtio-fs@redhat.com
>>> https://www.redhat.com/mailman/listinfo/virtio-fs
>>
>> --
>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>
>> _______________________________________________
>> Virtio-fs mailing list
>> Virtio-fs@redhat.com
>> https://www.redhat.com/mailman/listinfo/virtio-fs
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://www.redhat.com/mailman/listinfo/virtio-fs
> .
> 


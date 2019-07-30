Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AD7C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 13:09:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59F6F206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 13:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F6F206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsRsl-0000na-Mv
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 09:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44485)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <piaojun@huawei.com>) id 1hsRsM-0000N7-DG
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:09:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <piaojun@huawei.com>) id 1hsRsL-0007he-8n
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:09:10 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2247 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <piaojun@huawei.com>) id 1hsRsK-0007ev-Sz
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:09:09 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id DF3C3253C2D5B25C9F41;
 Tue, 30 Jul 2019 21:09:00 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Tue, 30 Jul 2019
 21:08:55 +0800
To: Liam Merwick <liam.merwick@oracle.com>, <virtio-fs@redhat.com>,
 <qemu-devel@nongnu.org>
References: <5D3F8F04.3030404@huawei.com>
 <8748798a-ac4f-4c0a-96fa-190e24dca52b@oracle.com>
From: piaojun <piaojun@huawei.com>
Message-ID: <5D404166.1010506@huawei.com>
Date: Tue, 30 Jul 2019 21:08:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <8748798a-ac4f-4c0a-96fa-190e24dca52b@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.191
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

Hi Liam,

On 2019/7/30 20:22, Liam Merwick wrote:
> On 30/07/2019 01:27, piaojun wrote:
>> Use F_GETLK for fcntl when F_OFD_GETLK not defined.
> 
> 
> Use F_GETLK/F_SETLK for fcntl when F_OFD_GETLK/F_OFD_SETLK not defined.
> 
>>
>> Signed-off-by: Jun Piao <piaojun@huawei.com>
>> ---
>>   contrib/virtiofsd/passthrough_ll.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthrough_ll.c
>> index 9ae1381..757785b 100644
>> --- a/contrib/virtiofsd/passthrough_ll.c
>> +++ b/contrib/virtiofsd/passthrough_ll.c
>> @@ -1619,7 +1619,11 @@ static void lo_getlk(fuse_req_t req, fuse_ino_t ino,
>>           return;
>>       }
>>
>> +#ifdef F_OFD_GETLK
>>       ret = fcntl(plock->fd, F_OFD_GETLK, lock);
>> +#else
>> +    ret = fcntl(plock->fd, F_GETLK, lock);
>> +#endif
>>       if (ret == -1)
>>           saverr = errno;
>>       pthread_mutex_unlock(&inode->plock_mutex);
>> @@ -1668,7 +1672,12 @@ static void lo_setlk(fuse_req_t req, fuse_ino_t ino,
>>
>>       /* TODO: Is it alright to modify flock? */
>>       lock->l_pid = 0;
>> +
>> +#ifdef F_OFD_GETLK
> 
> 
> This checks for F_OFD_GETLK but uses F_OFD_SETLK (albeit unlikely one being defined without the other)

Right, F_OFD_SETLK looks better.

> 
> 
>>       ret = fcntl(plock->fd, F_OFD_SETLK, lock);
>> +#else
>> +    ret = fcntl(plock->fd, F_SETLK, lock);
>> +#endif
>>       if (ret == -1) {
>>           saverr = errno;
>>       }
>>
> Might qemu_lock_fd()/qemu_unlock_fd() in util/osdep.c be useful to hide this instead?

Yes, I'm trying re-write do_getlk/setlk with qemu_lock_fd, and thanks for
your suggestion.

Thanks,
Jun

> 
> Regards,
> Liam
> 


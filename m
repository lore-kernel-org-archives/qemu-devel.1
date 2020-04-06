Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA367C2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 20:04:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA6F7206C0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 20:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4OFb5dq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6F7206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLXyo-0007pi-Rx
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 16:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jLXyD-0007OP-P6
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 16:03:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jLXyC-0006FE-M7
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 16:03:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51985
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jLXyC-0006Ew-IX
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 16:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586203424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BzWPROx9kB5Me64iUA7TrpsbLSyXAPm/Iyg4PjVYfvg=;
 b=J4OFb5dqREx4HIIX0xzrAhvzAcjixi3YcPqMKdw3sj2+094dp7ZeH3jdOTE20MMVxMabAO
 MszqT5HJSOwuQqrBieYukpWcFSFp7Lfc7uYTuCoU76zv5vA7MdxIVbaMLEZTC+tdskEwh3
 /jiRqufEiGzCyansT9iGmZCQDP8I+d4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-EIv-SCgKMwyhav1glqzPVg-1; Mon, 06 Apr 2020 16:03:42 -0400
X-MC-Unique: EIv-SCgKMwyhav1glqzPVg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BA731005055;
 Mon,  6 Apr 2020 20:03:41 +0000 (UTC)
Received: from [10.3.114.49] (ovpn-114-49.phx2.redhat.com [10.3.114.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 167995D9C5;
 Mon,  6 Apr 2020 20:03:38 +0000 (UTC)
Subject: Re: [PATCH 2/4] atomics: update documentation for C11
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200406191320.13371-1-pbonzini@redhat.com>
 <20200406191320.13371-3-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8545eb0f-99de-8b00-8506-4aca0a844c36@redhat.com>
Date: Mon, 6 Apr 2020 15:03:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200406191320.13371-3-pbonzini@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Ying Fang <fangying1@huawei.com>, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/6/20 2:13 PM, Paolo Bonzini wrote:
> Deprecate atomic_mb_read and atomic_mb_set; it is not really possible to
> use them correctly because they do not interoperate with sequentially-consistent
> RMW operations.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   docs/devel/atomics.rst | 290 ++++++++++++++++-------------------------
>   1 file changed, 114 insertions(+), 176 deletions(-)
> 

> @@ -24,6 +29,14 @@ Macros defined by ``qemu/atomic.h`` fall in three camps:
>   
>   - sequentially consistent atomic access: everything else.
>   
> +In general, use of ``qemu/atomic.h`` should be wrapped with more easily
> +used data structures (e.g. the lock-free singly-liked list operations

linked

> +``QSLIST_INSERT_HEAD_ATOMIC`` and ``QSLIST_MOVE_ATOMIC``) or synchronization
> +primitives (such as RCU, ``QemuEvent`` or ``QemuLockCnt``).  Bare use of
> +atomic operations and memory barriers should be limited to inter-thread
> +checking of flags and documented thoroughly.
> +
> +
>   
>   Compiler memory barrier
>   =======================
> @@ -85,36 +98,14 @@ Similar operations return the new value of ``*ptr``::
>       typeof(*ptr) atomic_or_fetch(ptr, val)
>       typeof(*ptr) atomic_xor_fetch(ptr, val)
>   
> -Sequentially consistent loads and stores can be done using::
> -
> -    atomic_fetch_add(ptr, 0) for loads
> -    atomic_xchg(ptr, val) for stores
> +These operations operate on any type that is as wide as an int or smaller.
>   
> -However, they are quite expensive on some platforms, notably POWER and
> -Arm.  Therefore, qemu/atomic.h provides two primitives with slightly
> -weaker constraints::
> +``qemu/atomic.h`` also provides sequentially consistent loads and stores can::
>   

s/ can//

>       typeof(*ptr) atomic_mb_read(ptr)
>       void         atomic_mb_set(ptr, val)
>   
> -The semantics of these primitives map to Java volatile variables,
> -and are strongly related to memory barriers as used in the Linux
> -kernel (see below).
> -
> -As long as you use atomic_mb_read and atomic_mb_set, accesses cannot
> -be reordered with each other, and it is also not possible to reorder
> -"normal" accesses around them.
> -
> -However, and this is the important difference between
> -atomic_mb_read/atomic_mb_set and sequential consistency, it is important
> -for both threads to access the same volatile variable.  It is not the
> -case that everything visible to thread A when it writes volatile field f
> -becomes visible to thread B after it reads volatile field g. The store
> -and load have to "match" (i.e., be performed on the same volatile
> -field) to achieve the right semantics.
> -
> -
> -These operations operate on any type that is as wide as an int or smaller.
> +which however are deprecated.
>   
-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org



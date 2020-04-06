Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCD1C2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 19:59:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 512AA206C0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 19:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="clotFUMs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 512AA206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLXuY-0006IL-Gc
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 15:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jLXto-0005sp-MU
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 15:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jLXtn-0002zZ-CS
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 15:59:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42117
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jLXtm-0002yO-W7
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 15:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586203150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l9+ji3xaXKxyfr2ITKBdZWIG6xJgpqEZtRAIct9C+KY=;
 b=clotFUMspZLiX43qanTqCVRcNsgfuKqSUfZx0tq/09zL9aR6gOR/CqR2kQIYnwxKgJtzLy
 jFAv09OqeneYHpj2IB2TYwECkPOGq1PwL2rIuW06tL0rCU/1zwPFwwX60w48GUnLkX25t8
 LARll+xAiEWv4w6OlfN9IhejW9gvmu0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-1Du1Zg5ePnqAnCdwSecYfw-1; Mon, 06 Apr 2020 15:59:04 -0400
X-MC-Unique: 1Du1Zg5ePnqAnCdwSecYfw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 965CE18C43C7;
 Mon,  6 Apr 2020 19:59:03 +0000 (UTC)
Received: from [10.3.114.49] (ovpn-114-49.phx2.redhat.com [10.3.114.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D92778F34F;
 Mon,  6 Apr 2020 19:59:00 +0000 (UTC)
Subject: Re: [PATCH 1/4] atomics: convert to reStructuredText
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200406191320.13371-1-pbonzini@redhat.com>
 <20200406191320.13371-2-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d0585240-030b-00c3-cece-bec1d2fa2870@redhat.com>
Date: Mon, 6 Apr 2020 14:58:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200406191320.13371-2-pbonzini@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   docs/devel/atomics.rst | 447 +++++++++++++++++++++++++++++++++++++++++
>   docs/devel/atomics.txt | 403 -------------------------------------
>   docs/devel/index.rst   |   1 +
>   3 files changed, 448 insertions(+), 403 deletions(-)
>   create mode 100644 docs/devel/atomics.rst
>   delete mode 100644 docs/devel/atomics.txt
> 

Pre-existing grammar nits, that you may want to touch up while reformatting:

> +Compiler memory barrier
> +=======================
> +
> +``barrier()`` prevents the compiler from moving the memory accesses either
> +side of it to the other side.  The compiler barrier has no direct effect

s/either/on either/


> +``qemu/atomic.h`` provides the following set of atomic read-modify-write
> +operations::
> +
> +    void atomic_inc(ptr)
> +    void atomic_dec(ptr)
> +    void atomic_add(ptr, val)
> +    void atomic_sub(ptr, val)
> +    void atomic_and(ptr, val)
> +    void atomic_or(ptr, val)
> +
> +    typeof(*ptr) atomic_fetch_inc(ptr)
> +    typeof(*ptr) atomic_fetch_dec(ptr)
> +    typeof(*ptr) atomic_fetch_add(ptr, val)
> +    typeof(*ptr) atomic_fetch_sub(ptr, val)
> +    typeof(*ptr) atomic_fetch_and(ptr, val)
> +    typeof(*ptr) atomic_fetch_or(ptr, val)
> +    typeof(*ptr) atomic_fetch_xor(ptr, val)
> +    typeof(*ptr) atomic_fetch_inc_nonzero(ptr)
> +    typeof(*ptr) atomic_xchg(ptr, val)
> +    typeof(*ptr) atomic_cmpxchg(ptr, old, new)
> +
> +all of which return the old value of ``*ptr``.  These operations are
> +polymorphic; they operate on any type that is as wide as a pointer.

Is th is 'as wide as a pointer' or 'no wider than a pointer'? In other 
words, can 'val' be a narrower type?


> +However, and this is the important difference between
> +atomic_mb_read/atomic_mb_set and sequential consistency, it is important
> +for both threads to access the same volatile variable.  It is not the
> +case that everything visible to thread A when it writes volatile field f
> +becomes visible to thread B after it reads volatile field g. The store
> +and load have to "match" (i.e., be performed on the same volatile
> +field) to achieve the right semantics.
> +
> +
> +These operations operate on any type that is as wide as an int or smaller.

Is that all operations in this same section, or only the last set of two 
operations (atomic_mb_read/set)?  What is the appropriate code to use if 
a pointer is wider than int?


> +
> +You can see that the two possible definitions of ``atomic_mb_read()``
> +and ``atomic_mb_set()`` are the following:
> +
> +  1) | atomic_mb_read(p)   = atomic_read(p); smp_mb_acquire()
> +     | atomic_mb_set(p, v) = smp_mb_release(); atomic_set(p, v); smp_mb()
> +
> +  2) | atomic_mb_read(p)   = smp_mb() atomic_read(p); smp_mb_acquire()

Missing semicolon after smp_mb()

> +     | atomic_mb_set(p, v) = smp_mb_release(); atomic_set(p, v);
> +
> +Usually the former is used, because ``smp_mb()`` is expensive and a program
> +normally has more reads than writes.  Therefore it makes more sense to
> +make ``atomic_mb_set()`` the more expensive operation.
> +

> +Memory barrier pairing
> +----------------------
> +
> +A useful rule of thumb is that memory barriers should always, or almost
> +always, be paired with another barrier.  In the case of QEMU, however,
> +note that the other barrier may actually be in a driver that runs in
> +the guest!
> +
> +For the purposes of pairing, ``smp_read_barrier_depends()`` and ``smp_rmb()``
> +both count as read barriers.  A read barrier shall pair with a write
> +barrier or a full barrier; a write barrier shall pair with a read

'shall' is awkward (if this is not a formal RFC-style requirement), 
better for colloquial English is 'must' or 'should' (twice)

> +barrier or a full barrier.  A full barrier can pair with anything.

> +Comparison with Linux kernel memory barriers
> +============================================
> +
> +Here is a list of differences between Linux kernel atomic operations
> +and memory barriers, and the equivalents in QEMU:
> +
> +- atomic operations in Linux are always on a 32-bit int type and
> +  use a boxed atomic_t type; atomic operations in QEMU are polymorphic
> +  and use normal C types.
> +
> +- Originally, atomic_read and atomic_set in Linux gave no guarantee
> +  at all. Linux 4.1 updated them to implement volatile
> +  semantics via ACCESS_ONCE (or the more recent READ/WRITE_ONCE).
> +
> +  QEMU's atomic_read/set implement, if the compiler supports it, C11
> +  atomic relaxed semantics, and volatile semantics otherwise.

Reads better as:

QEMU's atomic_read/set implement C11 atomic relaxed semantics if the 
compiler supports it, and volatile semantics otherwise.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org



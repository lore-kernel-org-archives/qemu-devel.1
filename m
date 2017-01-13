Received: from eggs.gnu.org ([2001:4830:134:3::10]:49749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cRs0J-0001ul-2n
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 21:54:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cRs0F-0000E8-Ot
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 21:54:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cRs0F-0000Dd-JJ
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 21:54:07 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C766C056791
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 02:54:07 +0000 (UTC)
Date: Fri, 13 Jan 2017 10:54:00 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170113025315.GA23020@lemon>
References: <20170112180800.21085-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170112180800.21085-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 00/10] aio_context_acquire/release
 pushdown, part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

On Thu, 01/12 19:07, Paolo Bonzini wrote:
> This is the first step of pushing down the AioContext lock.  Bottom halves
> are already protected by their own lock, use it also for walking_bh
> and for the handlers list (including walking_handlers).  The (lock,
> walking_foo) pair is wrapped into the QemuLockCnt primitive.
> 
> The only difference from v3 is a smattering of tiny nice improvements
> to QemuLockCnt.
> 
> Paolo
> 
> v4->v5:
>         remove stray tabs [patchew]
> 
> v3->v4:
>         Avoid useless atomic_mb_read in non-futex lockcnt [Stefan]
>         Use atomic_read in qemu_lockcnt_count [Stefan]
>         Tweak comment for qemu_lockcnt_cmpxchg_or_wait [Fam]
>         Use if/else in qemu_lockcnt_dec_and_lock [Fam]
>         Comment QEMU_LOCKCNT_STATE_* definitions [Fam]

Perfect!

Reviewed-by: Fam Zheng <famz@redhat.com>

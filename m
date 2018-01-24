Received: from eggs.gnu.org ([2001:4830:134:3::10]:53233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1eeCE1-0004b0-2o
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 23:00:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1eeCDb-0005PI-4t
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 22:59:49 -0500
Received: from mail-wr0-f170.google.com ([209.85.128.170]:38564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1eeCDa-0005Mh-Pg
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 22:59:22 -0500
Received: by mail-wr0-f170.google.com with SMTP id x1so2742319wrb.5
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 19:59:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180116142316.30486-1-pbonzini@redhat.com>
References: <20180116142316.30486-1-pbonzini@redhat.com>
From: Fam Zheng <famz@redhat.com>
Date: Wed, 24 Jan 2018 11:58:50 +0800
Message-ID: <CAK1Eb9niRFD-QK4LMnevaonkrFyWcQidcmYqq2-hf1-4vVSWjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/4] coroutine-lock: polymorphic CoQueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, Jan 16, 2018 at 10:23 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> There are cases in which a queued coroutine must be restarted from
> non-coroutine context (with qemu_co_enter_next).  In this cases,
> qemu_co_enter_next also needs to be thread-safe, but it cannot use a
> CoMutex and so cannot qemu_co_queue_wait.  This happens in curl (which
> right now is rolling its own list of Coroutines) and will happen in
> Fam's NVMe driver as well.
>
> This series extracts the idea of a polymorphic lockable object
> from my "scoped lock guard" proposal, and applies it to CoQueue.
> The implementation of QemuLockable is similar to C11 _Generic, but
> redone using the preprocessor and GCC builtins for compatibility.
>
> In general, while a bit on the esoteric side, the functionality used
> to emulate _Generic is fairly old in GCC, and the builtins are already
> used by include/qemu/atomic.h; the series was tested with Fedora 27 (boot
> Damn Small Linux via http) and CentOS 6 (compiled only).
>
> Paolo
>
> v1->v2: fix typos and copyright year

Reviewed-by: Fam Zheng <famz@redhat.com>

Should I include this series in my pull request for the NVMe driver?

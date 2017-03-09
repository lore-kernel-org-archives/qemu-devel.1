Received: from eggs.gnu.org ([2001:4830:134:3::10]:50518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cm1is-00012z-Dv
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:19:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cm1ip-0007CG-6s
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:19:30 -0500
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:35490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cm1io-0007Bj-W2
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:19:27 -0500
Received: by mail-wr0-x22c.google.com with SMTP id g10so49600614wrg.2
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 09:19:26 -0800 (PST)
References: <20170303131113.25898-1-pbonzini@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170303131113.25898-1-pbonzini@redhat.com>
Date: Thu, 09 Mar 2017 17:19:36 +0000
Message-ID: <8737emid07.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/6] tcg: fix icount super slowdown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org


Paolo Bonzini <pbonzini@redhat.com> writes:

Hmm your subject line was:

  Subject: [PATCH 0/6] tcg: fix icount super slowdown

But:

> Paolo Bonzini (5):
>   qemu-timer: fix off-by-one
>   qemu-timer: do not include sysemu/cpus.h from util/qemu-timer.h
>   cpus: define QEMUTimerListNotifyCB for QEMU system emulation
>   main-loop: remove now unnecessary optimization
>   icount: process QEMU_CLOCK_VIRTUAL timers in vCPU thread

Did the tooling missing something or is this just a git-format-patch burp?

--
Alex Bennée

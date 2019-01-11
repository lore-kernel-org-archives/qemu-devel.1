Received: from eggs.gnu.org ([209.51.188.92]:59629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1ghwQm-0003Zp-0g
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:01:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1ghwQl-0007BO-9V
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:00:59 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1ghwQl-00078x-3S
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:00:59 -0500
Received: by mail-ot1-x342.google.com with SMTP id e12so13026374otl.5
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 05:00:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1539860473.git.artem.k.pisarenko@gmail.com>
	<000601d4a8e8$a8a10170$f9e30450$@ru>
In-Reply-To: <000601d4a8e8$a8a10170$f9e30450$@ru>
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Fri, 11 Jan 2019 19:00:46 +0600
Message-ID: <CANzW0mtY6R0HtZJCoT5OTNdz9+ycrktnbMVjZ0uMAmXT69=N3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce attributes for timers
 subsystem and remove QEMU_CLOCK_VIRTUAL_EXT clock type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>

> It seems, that this approach is not always correct.
> Now timerlist_deadline_ns uses all virtual timers for deadline calculation (including external
> ones).
> qemu_start_warp_timer uses the deadline for setting warp timer (which should be deterministic).
> Therefore warp timer may become non-deterministic and replay may behave differently compared to
> recording phase.
>
> We have to rollback these or improve somehow to avoid non-determinism.

I dont understand how this approach would even introduce
non-determinism. I'm not sure about aspects of timers subsystem you
mentioned, assuming that maybe we missed something when tried to
optimize. But this has nothing to do with determinism as long as we
treat all virtual clock timers as deterministic, regardless of
EXTERNAL attribute being set or not. They are intended to be used as
such by design, aren't? This attribute was introduced purely to avoid
extra events in log.

Artem

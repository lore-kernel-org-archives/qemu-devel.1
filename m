Received: from eggs.gnu.org ([209.51.188.92]:58487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gk7mx-0000JF-JN
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:33:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gk7aI-0002Kq-Cb
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:19:51 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gk7aI-0002H7-7u
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:19:50 -0500
Received: by mail-ot1-x343.google.com with SMTP id i20so11108027otl.0
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 05:19:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1539860473.git.artem.k.pisarenko@gmail.com>
	<000601d4a8e8$a8a10170$f9e30450$@ru>
	<CANzW0mtY6R0HtZJCoT5OTNdz9+ycrktnbMVjZ0uMAmXT69=N3g@mail.gmail.com>
	<001301d4ad62$f3f44820$dbdcd860$@ru>
	<CANzW0mtVkiZJdYMytbDf2QwGDKTKL453zNbQDV6=xO=XvewmZg@mail.gmail.com>
	<000601d4ae38$35431f60$9fc95e20$@ru>
In-Reply-To: <000601d4ae38$35431f60$9fc95e20$@ru>
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Thu, 17 Jan 2019 19:19:37 +0600
Message-ID: <CANzW0mv0C6Kytf8jrOC-ec7MU6Q9BAi8rcDksVPxPT94NisjQg@mail.gmail.com>
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

> The source is the external timers, that depend on "outer world", e.g., slirp.
> These timers are not recorded/replayed, but may affect the icount warping
> (which should remain deterministic).

I thought we agreed earlier in this discussion that external timers
are deterministic by design, because they are subset of virtual clock
timers. Regarding slirp module, although it interfaces "outer world"
(except when 'restrict' option is on), it still uses IPv6 timer
deterministically. You may check it yourself. Otherwise it shouldn't
use timer of 'virtual clock' type for this purpose and this needs to
be fixed.
So I still don't understand. And I'm not asking you to explain. I'm
just hinting you that your fix may finally happen to be incorrect in
case if it based on wrong assertion I'm talking about.

> Please check the new version of the series.

Sorry, I'm too busy right now for deep analysis. I've just tried to
briefly understand issue you pointed and provide minimal feedback in
order to prevent possible wrong decisions. I'll return to this work
later.

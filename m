Received: from eggs.gnu.org ([209.51.188.92]:36057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guL8C-0005PC-N4
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:49:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guL8B-0004zP-Lk
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:49:04 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guL8B-0004xQ-DL
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:49:03 -0500
Received: by mail-ot1-x342.google.com with SMTP id i20so12016335otl.0
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 09:49:03 -0800 (PST)
MIME-Version: 1.0
References: <1550008033-26540-1-git-send-email-sandra@codesourcery.com>
In-Reply-To: <1550008033-26540-1-git-send-email-sandra@codesourcery.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 17:48:50 +0000
Message-ID: <CAFEAcA8eFexmymsaur-DtgYdKcyJB0ia7dW_vp358hbySsyBDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] gdbstub: Send a reply to the vKill packet.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sandra Loosemore <sandra@codesourcery.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On Tue, 12 Feb 2019 at 21:52, Sandra Loosemore <sandra@codesourcery.com> wrote:
>
> Per the GDB remote protocol documentation
>
> https://sourceware.org/gdb/current/onlinedocs/gdb/Packets.html#index-vKill-packet
>
> the debug stub is expected to send a reply to the 'vKill' packet.  At
> least some versions of GDB crash if the gdb stub simply exits without
> sending a reply.  This patch fixes QEMU's gdb stub to conform to the
> expected behavior.
>
> Note that QEMU's existing handling of the legacy 'k' packet is
> correct: in that case GDB does not expect a reply, and QEMU does not
> send one.
>
> Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>

Thanks, applied to target-arm.next.

As an aside, do you know if there is any kind of test suite for
the remote protocol that implementors of a debug stub can use to
check that they're conforming to it?

-- PMM

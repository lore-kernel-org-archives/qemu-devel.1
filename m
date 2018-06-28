Received: from eggs.gnu.org ([2001:4830:134:3::10]:51792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYa0O-0005Gw-Rr
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:42:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYa0O-0006FG-0M
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:42:48 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:33933)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYa0N-0006EV-Qf
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:42:47 -0400
Received: by mail-ot0-x242.google.com with SMTP id i17-v6so6861256otl.1
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 09:42:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1529699547-17044-1-git-send-email-alindsay@codeaurora.org>
References: <1529699547-17044-1-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Jun 2018 17:42:26 +0100
Message-ID: <CAFEAcA8gS4GD0UYpR4nKRzF6eSSJd7F8fYw48UEsyQQUJxe8sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 00/13] More fully implement ARM PMUv3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <aclindsa@gmail.com>

On 22 June 2018 at 21:32, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> The ARM PMU implementation currently contains a basic cycle counter, but it is
> often useful to gather counts of other events and filter them based on
> execution mode. These patches flesh out the implementations of various PMU
> registers including PM[X]EVCNTR and PM[X]EVTYPER, add a struct definition to
> represent arbitrary counter types, implement mode filtering, send interrupts on
> counter overflow, and add instruction, cycle, and software increment events.
>
> Since v4 I've added improved V7VE handling with Peter's direction, fixed up a
> few patch staging issues, and fixed a bug causing cycle counter overflow to be
> checked every instruction.

Hi; I've reviewed some of the simpler parts of this, but I
suspect I'm not going to get to the rest of it for a bit (the
softfreeze deadline is next Tuesday, so it's a busy time of
the release cycle for me). For the moment I'm going to take
patches 4, 5 and 12 into target-arm.next, which should at least
reduce the size of the patchset for next time.

thanks
-- PMM

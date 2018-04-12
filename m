Received: from eggs.gnu.org ([2001:4830:134:3::10]:43041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6g5K-0007sN-RX
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 13:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6g5I-00025d-5G
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 13:32:33 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:39110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6g5I-00025H-07
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 13:32:32 -0400
Received: by mail-oi0-x231.google.com with SMTP id q71-v6so5930791oic.6
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 10:32:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Apr 2018 18:32:10 +0100
Message-ID: <CAFEAcA8G-WD2U4+NUzWYk_gwM51-mmDNj6o9CeeAjW+USSW=uw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 00/22] More fully implement ARM PMUv3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On 16 March 2018 at 20:30, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> The ARM PMU implementation currently contains a basic cycle counter, but it is
> often useful to gather counts of other events and filter them based on
> execution mode. These patches flesh out the implementations of various PMU
> registers including PM[X]EVCNTR and PM[X]EVTYPER, add a struct definition to
> represent arbitrary counter types, implement mode filtering, and add
> instruction, cycle, and software increment events.

Hi; sorry it's taken me a while to get to this (I've been focusing
on for-2.12 work). I've now reviewed most of the patches in this
set. My suggestion is that you fix the stuff I've commented on
and send out a v4, and then I can take some of the patches from
the start of that into target-arm.next, and I'll review the tail
end of the set then.

thanks
-- PMM

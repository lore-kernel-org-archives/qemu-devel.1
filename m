Received: from eggs.gnu.org ([209.51.188.92]:58493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmfFl-0005kV-U8
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:41:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmf1Q-0003QY-O9
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:26:22 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmf1P-0003P3-6P
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:26:20 -0500
Received: by mail-ot1-x344.google.com with SMTP id t5so5225336otk.1
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 05:26:19 -0800 (PST)
MIME-Version: 1.0
References: <20190123195814.29253-1-aaron@os.amperecomputing.com>
In-Reply-To: <20190123195814.29253-1-aaron@os.amperecomputing.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Jan 2019 13:26:06 +0000
Message-ID: <CAFEAcA8F+YdjAMSEFTzmkfNi9dg1nYZXUpi_fKtxUHcaN48+Dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: Don't clear supported PMU
 events when initializing PMCEID1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On Wed, 23 Jan 2019 at 19:59, Aaron Lindsay OS
<aaron@os.amperecomputing.com> wrote:
>
> A bug was introduced during a respin of:
>
>         commit 57a4a11b2b281bb548b419ca81bfafb214e4c77a
>         target/arm: Add array for supported PMU events, generate PMCEID[01]_EL0
>
> This patch introduced two calls to get_pmceid() during CPU
> initialization - one each for PMCEID0 and PMCEID1. In addition to
> building the register values, get_pmceid() clears an internal array
> mapping event numbers to their implementations (supported_event_map)
> before rebuilding it. This is an optimization since much of the logic is
> shared. However, since it was called twice, the contents of
> supported_event_map reflect only the events in PMCEID1 (the second call
> to get_pmceid()).
>
> Fix this bug by moving the initialization of PMCEID0 and PMCEID1 back
> into a single function call, and name it more appropriately since it is
> doing more than simply generating the contents of the PMCEID[01]
> registers.
>
> Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>



Applied to target-arm.next, thanks.

-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:53205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxV9J-0006dN-CD
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxV9I-00011O-MX
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:58:13 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:33830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cxV9I-00010y-F2
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:58:12 -0400
Received: by mail-wr0-x235.google.com with SMTP id z109so3972747wrb.1
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 01:58:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170410084456.GB19103@toto>
References: <1491486152-24304-1-git-send-email-peter.maydell@linaro.org>
	<20170410084456.GB19103@toto>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Apr 2017 09:57:50 +0100
Message-ID: <CAFEAcA-W_OGF7zjzZmPDBT+t2CKziyW-01VJxStfcxjr3Rfnww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] target/arm: Add assertion about FSC format
 for syndrome registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, "patches@linaro.org" <patches@linaro.org>

On 10 April 2017 at 09:44, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> Have you seen something suspicous when running code or was
> this a theoretical issue?

No, I was looking at the code for a different reason and
was surprised that the syndrome-generation code wasn't doing
anything to handle short-format FSRs. I started out thinking
that this was just a corner case we'd forgotten since it
only affects AArch32 guests (and even wrote some code to do
short-to-long status code conversion), but after some thought
I realised that it's not possible to get to a point where
we would need the syndrome after such a fault. It's a
tricky enough point that it seems worth having an assert
and some comments to assure future readers that it isn't
just something we forgot to handle...

thanks
-- PMM

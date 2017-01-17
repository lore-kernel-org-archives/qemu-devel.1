Received: from eggs.gnu.org ([2001:4830:134:3::10]:38042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTUQW-0005Hc-SE
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:07:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTUQS-0004Za-WD
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:07:56 -0500
Received: from mail-ua0-x233.google.com ([2607:f8b0:400c:c08::233]:36543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cTUQS-0004Yl-KI
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:07:52 -0500
Received: by mail-ua0-x233.google.com with SMTP id 96so103087042uaq.3
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 06:07:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1483977924-14522-1-git-send-email-peter.maydell@linaro.org>
References: <1483977924-14522-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jan 2017 14:07:31 +0000
Message-ID: <CAFEAcA9N_YXFCPo8ja-Nan3roL=gdNpFQHoLk_aw6tDixwoT3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 00/18] arm: Add
 virtualization to GICv3, and enable EL2 on 64-bit CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrew Jones <drjones@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Christoffer Dall <christoffer.dall@linaro.org>, "patches@linaro.org" <patches@linaro.org>

On 9 January 2017 at 16:05, Peter Maydell <peter.maydell@linaro.org> wrote:
> This patchset adds support for the Virtualization extensions to QEMU's
> GICv3 emulation. This was the last missing piece that was stopping
> us from turning on the EL2 support in the CPU model, so the patchset
> also adds support for enabling it all on the virt board via the
> '-machine virtualization=on' option.

> Patches 1, 4-13, 15, 16 still need review.

So is anybody interested in reviewing the complicated
bits in the middle of this patchset (5-13) or shall I
just throw it into target-arm.next? :-)

thanks
-- PMM

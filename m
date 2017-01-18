Received: from eggs.gnu.org ([2001:4830:134:3::10]:52947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cTmMb-0005kl-3Y
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 04:17:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cTmMa-0005IK-3z
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 04:17:05 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9N_YXFCPo8ja-Nan3roL=gdNpFQHoLk_aw6tDixwoT3w@mail.gmail.com>
References: <1483977924-14522-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA9N_YXFCPo8ja-Nan3roL=gdNpFQHoLk_aw6tDixwoT3w@mail.gmail.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 18 Jan 2017 10:17:01 +0100
Message-ID: <CAJy5ezpYPaEdWG_4JQaQTL56EZYDT-TCYLaFtrKzpZUcu9DKHg@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, "patches@linaro.org" <patches@linaro.org>, Christoffer Dall <christoffer.dall@linaro.org>, Andrew Jones <drjones@redhat.com>

Hi Peter,  I'm on holidays and won't have time to review for a couple of
weeks at least...

Cheers,
Edgar

---
Sent from my phone

On 17 Jan 2017 14:08, "Peter Maydell" <peter.maydell@linaro.org> wrote:

> On 9 January 2017 at 16:05, Peter Maydell <peter.maydell@linaro.org>
> wrote:
> > This patchset adds support for the Virtualization extensions to QEMU's
> > GICv3 emulation. This was the last missing piece that was stopping
> > us from turning on the EL2 support in the CPU model, so the patchset
> > also adds support for enabling it all on the virt board via the
> > '-machine virtualization=on' option.
>
> > Patches 1, 4-13, 15, 16 still need review.
>
> So is anybody interested in reviewing the complicated
> bits in the middle of this patchset (5-13) or shall I
> just throw it into target-arm.next? :-)
>
> thanks
> -- PMM
>
>

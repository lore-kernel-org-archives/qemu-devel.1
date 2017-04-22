Received: from eggs.gnu.org ([2001:4830:134:3::10]:47648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1d20O4-0008Mh-PT
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 15:08:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1d20O3-00073H-Vi
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 15:08:04 -0400
Date: Sat, 22 Apr 2017 21:07:54 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <20170422190754.3tsrihhj5e57r2sy@kozik-lap>
References: <20170416151604.22506-1-krzk@kernel.org>
	<CAFEAcA915o-MYNYwPQXpAs7sWS=4ft_iXG41uZx=S27JuutH7Q@mail.gmail.com>
	<20170422184632.nm2s7shuo34ukswd@kozik-lap>
	<CAFEAcA-8JJtYjAzq=gXJsRHTnO2xiu_EdFEsMR174jh=G0zW8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-8JJtYjAzq=gXJsRHTnO2xiu_EdFEsMR174jh=G0zW8A@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC] hw/arm/exynos: Add generic SDHCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Sat, Apr 22, 2017 at 08:05:41PM +0100, Peter Maydell wrote:
> On 22 April 2017 at 19:46, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > On Thu, Apr 20, 2017 at 02:51:00PM +0100, Peter Maydell wrote:
> >> Incidentally someday maybe we should convert this Exynos4210 code
> >> to a proper QOM SoC container object, but that would be a lot of
> >> work.
> >
> > Any existing platforms which I could take as an good example? Maybe I'll
> > have some time to do it.
> 
> The Xilinx ones, or stm32f205_soc, maybe. Basically the idea
> is that instead of having a random function which is doing
> a lot of instantiation of SoC devices, you have a QoM device
> which encapsulates all this, and the board level code just
> creates and configures that device.

Right, I've seen this pattern. Thanks for the hint.

Best regards,
Krzysztof

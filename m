Received: from eggs.gnu.org ([2001:4830:134:3::10]:47115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d20M9-0007ON-HA
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 15:06:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d20M8-0006Lz-B8
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 15:06:05 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:36258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d20M8-0006K0-16
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 15:06:04 -0400
Received: by mail-wm0-x236.google.com with SMTP id o81so36262062wmb.1
	for <qemu-devel@nongnu.org>; Sat, 22 Apr 2017 12:06:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170422184632.nm2s7shuo34ukswd@kozik-lap>
References: <20170416151604.22506-1-krzk@kernel.org>
	<CAFEAcA915o-MYNYwPQXpAs7sWS=4ft_iXG41uZx=S27JuutH7Q@mail.gmail.com>
	<20170422184632.nm2s7shuo34ukswd@kozik-lap>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 22 Apr 2017 20:05:41 +0100
Message-ID: <CAFEAcA-8JJtYjAzq=gXJsRHTnO2xiu_EdFEsMR174jh=G0zW8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC] hw/arm/exynos: Add generic SDHCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 22 April 2017 at 19:46, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Thu, Apr 20, 2017 at 02:51:00PM +0100, Peter Maydell wrote:
>> Incidentally someday maybe we should convert this Exynos4210 code
>> to a proper QOM SoC container object, but that would be a lot of
>> work.
>
> Any existing platforms which I could take as an good example? Maybe I'll
> have some time to do it.

The Xilinx ones, or stm32f205_soc, maybe. Basically the idea
is that instead of having a random function which is doing
a lot of instantiation of SoC devices, you have a QoM device
which encapsulates all this, and the board level code just
creates and configures that device.

thanks
-- PMM

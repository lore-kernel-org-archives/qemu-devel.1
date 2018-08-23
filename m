Received: from eggs.gnu.org ([2001:4830:134:3::10]:44168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fsmb4-0007Jl-Of
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:12:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fsmb3-0001rG-Gs
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:12:10 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:46966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fsmb3-0001qM-9N
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:12:09 -0400
Received: by mail-oi0-x242.google.com with SMTP id y207-v6so8274990oie.13
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 03:12:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5da29ed5-0003-a18f-65e0-a408b5f46b92@amsat.org>
References: <20180820141116.9118-1-peter.maydell@linaro.org>
	<20180820141116.9118-19-peter.maydell@linaro.org>
	<5da29ed5-0003-a18f-65e0-a408b5f46b92@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Aug 2018 11:11:47 +0100
Message-ID: <CAFEAcA_wFiOqKB4auHc9NFMOOrsBmXF4EmS+TWMEC8uxq=_02w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 18/22] hw/ssi/pl022: Use
 DeviceState::realize rather than SysBusDevice::init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 21 August 2018 at 07:53, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> On 08/20/2018 11:11 AM, Peter Maydell wrote:
>> Move from the legacy SysBusDevice::init method to using
>> DeviceState::realize.
>
> It would be nice to have a wiki page where each maintainer list his
> deprecated/legacy API and which current API to use instead (and why,
> some examples how to use or port, pointing to git commits).

This one is mentioned in:
https://wiki.qemu.org/ToDo/CodeTransitions

thanks
-- PMM

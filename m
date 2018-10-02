Received: from eggs.gnu.org ([2001:4830:134:3::10]:50828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7KUo-0003HM-9f
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 09:13:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7KUn-00038a-Jm
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 09:13:50 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7KUn-00038J-FA
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 09:13:49 -0400
Received: by mail-oi1-x242.google.com with SMTP id e17-v6so1443384oib.4
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 06:13:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181001220942.2382-6-f4bug@amsat.org>
References: <20181001220942.2382-1-f4bug@amsat.org>
	<20181001220942.2382-6-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Oct 2018 14:13:28 +0100
Message-ID: <CAFEAcA-ZQ4nj6x1Uc7TaKRQr-6bH+q0gp6RK6v2b=XYWFsxouA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/15] hw/sh4/sh_pci: Use
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
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On 1 October 2018 at 23:09, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> Move from the legacy SysBusDevice::init method to using DeviceState::real=
ize.

Comment says DeviceState::realize but the code is using
PCIDevice::realize ?

I didn't realize pci devices had their own realize method:
what's the difference between it and plain old DeviceState::realize,
which they also have, since PCIDeviceClass inherits from DeviceClass ?

thanks
-- PMM

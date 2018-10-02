Received: from eggs.gnu.org ([2001:4830:134:3::10]:53317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7Qp9-0002sg-V5
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 15:59:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7Qp4-0000CN-NI
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 15:59:15 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7Qp4-0000Bm-3f
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 15:59:10 -0400
Received: by mail-wr1-x441.google.com with SMTP id n1-v6so3585575wrt.10
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 12:59:09 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20181001220942.2382-1-f4bug@amsat.org>
	<20181001220942.2382-6-f4bug@amsat.org>
	<CAFEAcA-ZQ4nj6x1Uc7TaKRQr-6bH+q0gp6RK6v2b=XYWFsxouA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b7a53ef4-ee8e-de31-d0c7-2a03ab16aa4b@amsat.org>
Date: Tue, 2 Oct 2018 21:59:03 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-ZQ4nj6x1Uc7TaKRQr-6bH+q0gp6RK6v2b=XYWFsxouA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 10/2/18 3:13 PM, Peter Maydell wrote:
> On 1 October 2018 at 23:09, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Move from the legacy SysBusDevice::init method to using DeviceState::realize.
> 
> Comment says DeviceState::realize but the code is using
> PCIDevice::realize ?
> 
> I didn't realize pci devices had their own realize method:
> what's the difference between it and plain old DeviceState::realize,
> which they also have, since PCIDeviceClass inherits from DeviceClass ?

Cc'ing Michael and Marcel.

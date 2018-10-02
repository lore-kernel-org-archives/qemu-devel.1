Received: from eggs.gnu.org ([2001:4830:134:3::10]:33355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1g7RPF-0007Vj-2i
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 16:36:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1g7RP6-0000a5-5B
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 16:36:32 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1g7RP5-0000Zy-T4
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 16:36:24 -0400
Received: by mail-wm1-x343.google.com with SMTP id r63-v6so3565190wma.4
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 13:36:23 -0700 (PDT)
References: <20181001220942.2382-1-f4bug@amsat.org>
	<20181001220942.2382-6-f4bug@amsat.org>
	<CAFEAcA-ZQ4nj6x1Uc7TaKRQr-6bH+q0gp6RK6v2b=XYWFsxouA@mail.gmail.com>
	<b7a53ef4-ee8e-de31-d0c7-2a03ab16aa4b@amsat.org>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <9ce1d491-b1dc-30ac-bf0b-60032b224432@gmail.com>
Date: Tue, 2 Oct 2018 23:37:08 +0300
MIME-Version: 1.0
In-Reply-To: <b7a53ef4-ee8e-de31-d0c7-2a03ab16aa4b@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

Hi Philippe, Peter

On 10/2/18 10:59 PM, Philippe Mathieu-Daudé wrote:
> On 10/2/18 3:13 PM, Peter Maydell wrote:
>> On 1 October 2018 at 23:09, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>> Move from the legacy SysBusDevice::init method to using DeviceState::realize.
>> Comment says DeviceState::realize but the code is using
>> PCIDevice::realize ?
>>
>> I didn't realize pci devices had their own realize method:
>> what's the difference between it and plain old DeviceState::realize,

PCIDevice:realize handles PCI specific "realization" tasks:
* setup of the PCI configuration space
* PCI BARs configuration
* MSI initalization
*...

The PCIDevice's DeviceState::realize function named 'pci_qdev_realize'
calls PCIDevice:realize after it runs some generic initialization code.

It is possible we have this design so we would be able to move from
"qdev" to QOM.

Thanks,
Marcel

>> which they also have, since PCIDeviceClass inherits from DeviceClass ?
> Cc'ing Michael and Marcel.

Received: from eggs.gnu.org ([209.51.188.92]:57708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJeHi-0001mS-3Y
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:19:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJeHh-0001wU-0V
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:19:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJeHg-0001vm-QB
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:19:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id o25so9237032wmf.5
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:19:28 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-3-thuth@redhat.com>
	<9f1355f2-3508-3f0a-512b-8b97fbda9ae1@redhat.com>
Message-ID: <ca065ba9-45b4-2272-538b-67ad0b6df3a3@redhat.com>
Date: Thu, 25 Apr 2019 15:19:23 +0200
MIME-Version: 1.0
In-Reply-To: <9f1355f2-3508-3f0a-512b-8b97fbda9ae1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 02/29] hw/ide/ahci: Add a
 Kconfig switch for the AHDI-ICH9 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>, Rob Herring <robh@kernel.org>, qemu-block@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>, Joel Stanley <joel@jms.id.au>, Antony Pavlov <antonynpavlov@gmail.com>, Alistair Francis <alistair@alistair23.me>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Cedric Le Goater <clg@kaod.org>, John Snow <jsnow@redhat.com>, Andrew Jeffery <andrew@aj.id.au>, Philippe Mathieu-Daude <f4bug@amsat.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Jan Kiszka <jan.kiszka@web.de>

On 4/20/19 12:31 PM, Philippe Mathieu-Daudé wrote:
> On 4/18/19 8:00 PM, Thomas Huth wrote:
>> Some of our machines (like the ARM cubieboard) use CONFIG_AHCI for an AHCI
>> sysbus device, but do not use CONFIG_PCI since they do not feature a PCI
>> bus. With CONFIG_AHCI but without CONFIG_PCI, currently linking fails:
>>
>>     ../hw/ide/ich.o: In function `pci_ich9_ahci_realize':
>>     hw/ide/ich.c:124: undefined reference to `pci_allocate_irq'
>>     hw/ide/ich.c:126: undefined reference to `pci_register_bar'
>>     hw/ide/ich.c:128: undefined reference to `pci_register_bar'
>>     hw/ide/ich.c:131: undefined reference to `pci_add_capability'
>>     hw/ide/ich.c:147: undefined reference to `msi_init'
>>     ../hw/ide/ich.o: In function `pci_ich9_uninit':
>>     hw/ide/ich.c:158: undefined reference to `msi_uninit'
>>     ../hw/ide/ich.o:(.data.rel+0x50): undefined reference to `vmstate_pci_device'
>>
>> We must only compile ich.c if CONFIG_PCI is available, too, so introduce a
>> new config switch for this device.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Oops, "AHCI" in patch subject (D -> C).

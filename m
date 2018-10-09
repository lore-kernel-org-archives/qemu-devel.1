Received: from eggs.gnu.org ([2001:4830:134:3::10]:59489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9tWH-0000bB-SQ
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:02:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9tWC-00084o-Rb
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:01:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g9tWC-00083k-IT
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:01:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id y16so2202016wrw.3
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 08:01:52 -0700 (PDT)
References: <20181002212522.23303-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <41e8ac78-1a7a-c937-6e66-c84afc89f1d7@redhat.com>
Date: Tue, 9 Oct 2018 17:01:49 +0200
MIME-Version: 1.0
In-Reply-To: <20181002212522.23303-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 00/12] another SysBusDevice::init to
 Device::realize cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goate?= =?UTF-8?Q?r?= <clg@kaod.org>, qemu-devel@nongnu.org

Hi Eduardo,

On 02/10/2018 23:25, Philippe Mathieu-Daudé wrote:
> Peter suggested [1] another crusade for this merge window,
> then Cédric jumped on his horse [2]. My turn on my dromedary.
> 
> since v1:
> - let the empty_slot
> - sh4_pci and bonito use DeviceState::realize instead of PCIDevice::realize
> - reword niagara-iob commit message
> 
> v1: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00220.html
> - convert few devices to DeviceState::realize,
> - kill the empty_slot device,
> - remove unuseful class_init() code [RFC, do we want to keep this?]
> - few other minor fixes catched while editing
> 
> Regards,
> 
> Phil.
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg03605.html
> [2] https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00001.html
> 
> 001/12:[----] [--] 'trace-events: Fix copy/paste typo'
> 002/12:[----] [--] 'hw/timer/sun4v-rtc: Convert from DPRINTF() macro to trace events'
> 003/12:[----] [--] 'hw/timer/sun4v-rtc: Use DeviceState::realize rather than SysBusDevice::init'
> 004/12:[----] [--] 'hw/ssi/xilinx_spi: Use DeviceState::realize rather than SysBusDevice::init'
> 005/12:[0006] [FC] 'hw/sh4/sh_pci: Use DeviceState::realize rather than SysBusDevice::init'
> 006/12:[0006] [FC] 'hw/pci-host/bonito: Use DeviceState::realize rather than SysBusDevice::init'
> 007/12:[----] [--] 'hw/mips/gt64xxx_pci: Convert gt64120_reset() function into Device reset method'
> 008/12:[----] [--] 'hw/mips/gt64xxx_pci: Mark as bridge device'
> 009/12:[----] [--] 'hw/sparc64/niagara: Model the I/O Bridge with the 'unimplemented_device''
> 010/12:[----] [--] 'hw/alpha/typhoon: Remove unuseful code'
> 011/12:[----] [--] 'hw/hppa/dino: Remove unuseful code'
> 012/12:[----] [--] 'hw/mips/malta: Remove unuseful code'

Can you take this via your machine-next tree?

Thanks,

Phil.

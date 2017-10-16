Received: from eggs.gnu.org ([2001:4830:134:3::10]:48057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4ECe-0001Pw-1g
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 18:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4ECa-0008NG-W4
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 18:49:44 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170922154014.29350-1-f4bug@amsat.org>
	<f49c0fb8-5232-ff31-e18b-217c79afb7ee@msgid.tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <28251758-632c-97ba-9815-8d9d53a95c23@amsat.org>
Date: Mon, 16 Oct 2017 19:49:32 -0300
MIME-Version: 1.0
In-Reply-To: <f49c0fb8-5232-ff31-e18b-217c79afb7ee@msgid.tls.msk.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 00/34] remove i386/pc dependency from
 non-PC world (part 1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>, Eduardo Habkost <ehabkost@redhat.com>, Eduardo Otubo <otubo@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org

Hi Michael,

Thanks for your comments!

>>   hw: remove "qemu/osdep.h" from header files
> not applied, doing two things, suggested split-up
> (I'm fine with it as it is)

split out MAINTAINERS entry

>>   i386/hax: remove duplicated includes
> applied (note it can be trimmed more)

done in another patch.

>>   misc: avoid "include/" in include path
> not applied, probably should be split, but I'm fine with it as it is

split out numa.c

>>   hw/timer/i8254: rename pit_init() -> i8254_pit_init()
> not applied, split?

split out MAINTAINERS entry

>>   hw/display/vga: remove the old i386/pc dependency
> somehow I can't find this patch, neither in my inbox nor in patchwork

weird...

>>   hw/input/i8042: extract API from hw/i386/pc.h
> CHECK

split out MAINTAINERS entry

>>   hw/dma/i8257: rename DMA_init() to i8257_dma_init()
> not applied, pending **errp addition

attempt to fix it...

>>   hw/timer/m48t59: use TYPE_M48T59_ISA, add entries to MAINTAINERS
> not applied, it went out of context without i8257_dma_init rename
> btw, why do we prefer these TYPE_XXX things instead of simple "xxx" stuff?

split out MAINTAINERS entry, dropped out TYPE_M48T59_ISA use.

>>   hw/pci: declare pci_nic_init_nofail() in "hw/net/pci.h"
> not applied, it does more than mentioned

dropped from this series.

>>   hw/net/e1000: use TYPE_PCI_E1000
>>   hw/net/e1000e: use TYPE_PCI_E1000E
>>   hw/net/pcnet: use TYPE_PCI_PCNET
>>   hw/net/rtl8139: use TYPE_PCI_RTL8139
>>   hw/net/ne2000: use TYPE_PCI_NE2000
> 
> Not applied, at least not yet, why do we use these TYPE_XX stuff to
> start with?

TYPE_XX is the interface, having the devices using TYPE_XX instead of
hardcoded name guarantee safe rename/refactor.

anyway, dropped.

> Applying these series is quite a bit boring task I'd say :)

separating them from the whole branch too! but they are required for the
final objective which I'll send in 3 or 4 parts.

Regards,

Phil.

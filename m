Received: from eggs.gnu.org ([2001:4830:134:3::10]:41458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1fyfr6-0005y2-SM
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 12:13:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1fyfr3-0001WP-LD
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 12:13:04 -0400
References: <20180908090820.15591-1-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <8c95062a-8f66-7640-a140-bf23ca206ec7@reactos.org>
Date: Sat, 8 Sep 2018 18:07:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180908090820.15591-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] 40p: fix PCI interrupt routing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, david@gibson.dropbear.id.au, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

Le 08/09/2018 à 11:08, Mark Cave-Ayland a écrit :
> According to the PReP specification section 6.1.6 "System Interrupt
> Assignments", all PCI interrupts are routed via IRQ 15.
> 
> In the case of the 40p machine this isn't quite true in that it has a routing
> quirk: the LSI SCSI device is always routed to IRQ 13. At least Linux and
> NetBSD compare the model name presented by the firmware to "IBM PPS Model
> 6015", and if it matches will active this quirk.
> 
> There is also a slight issue in that whilst the legacy PReP machine is still
> present in the codebase, the old IRQ routing must still be preserved. This is
> done by introducing a new "is-legacy-prep" qdev property to the raven PCI host
> bridge which preserves the old routing for -M prep until that code is finally
> removed.
> 

Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
Tested-by: Hervé Poussineau <hpoussin@reactos.org>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:59735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fybBH-0004fq-Rf
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 07:13:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fybBE-0008Oq-Op
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 07:13:35 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180907125653.5010-1-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3b38ed9b-9fa4-85c5-5f79-033bd7f28e84@amsat.org>
Date: Sat, 8 Sep 2018 08:08:12 -0300
MIME-Version: 1.0
In-Reply-To: <20180907125653.5010-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] scsi: replace lsi53c895a_create()
 and lsi53c810_create() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com, famz@redhat.com, hpoussin@reactos.org, rth@twiddle.net, peter.maydell@linaro.org, thuth@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 9/7/18 9:56 AM, Mark Cave-Ayland wrote:
> As part of an upcoming 40p patchset I have a requirement to change the PCI
> configuration of the LSI SCSI. However since commits a64aa5785d "hw: Deprecate -drive
> if=scsi with non-onboard HBAs" and b891538e81 "hw/ppc/prep: Fix implicit creation of
> "-drive if=scsi", the lsi53c8*_create() wrapper functions don't return the device
> state itself.
> 
> This patchset replaces the lsi53c895a_create() and lsi53c810_create() functions
> with a single lsi53c8xx_handle_legacy_cmdline() function as suggested by Thomas,
> which makes the caller responsible for initing the LSI SCSI device and hence
> allowing it to be configured as required.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> v2:
> - Don't split LSIState into separate lsi53c895a.h header but instead use a new
>   lsi53c8xx_handle_legacy_cmdline() function as suggested by Thomas
> 
> 
> Mark Cave-Ayland (3):
>   scsi: add lsi53c8xx_handle_legacy_cmdline() function
>   scsi: move lsi53c8xx_create() callers to
>     lsi53c8xx_handle_legacy_cmdline()
>   scsi: remove unused lsi53c895a_create() and lsi53c810_create()
>     functions
> 
>  hw/arm/realview.c    |  3 ++-
>  hw/arm/versatilepb.c |  3 ++-
>  hw/hppa/machine.c    |  4 +++-
>  hw/ppc/prep.c        |  4 +++-
>  hw/scsi/lsi53c895a.c | 11 ++---------
>  include/hw/pci/pci.h |  3 +--
>  6 files changed, 13 insertions(+), 15 deletions(-)
> 

Received: from eggs.gnu.org ([2001:4830:134:3::10]:36225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fyGVi-0001xo-RT
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fyGVd-0002XV-SC
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:09:18 -0400
References: <20180907125653.5010-1-mark.cave-ayland@ilande.co.uk>
	<20180907125653.5010-3-mark.cave-ayland@ilande.co.uk>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2625edb6-7263-fe59-97ed-122d84d9de53@redhat.com>
Date: Fri, 7 Sep 2018 15:09:05 +0200
MIME-Version: 1.0
In-Reply-To: <20180907125653.5010-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] scsi: move lsi53c8xx_create()
 callers to lsi53c8xx_handle_legacy_cmdline()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com, famz@redhat.com, hpoussin@reactos.org, rth@twiddle.net, peter.maydell@linaro.org, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 2018-09-07 14:56, Mark Cave-Ayland wrote:
> As part of commits a64aa5785d "hw: Deprecate -drive if=scsi with non-onboard
> HBAs" and b891538e81 "hw/ppc/prep: Fix implicit creation of "-drive if=scsi"
> devices" the lsi53c895a_create() and lsi53c810_create() functions were added
> to wrap pci_create_simple() and scsi_bus_legacy_handle_cmdline().
> 
> Unfortunately this prevents us from changing qdev properties on the device
> and/or changing the PCI configuration. By switching over to using the new
> lsi53c8xx_handle_legacy_cmdline() function then the caller can now configure
> and realize the LSI SCSI device exactly as required.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/arm/realview.c    | 3 ++-
>  hw/arm/versatilepb.c | 3 ++-
>  hw/hppa/machine.c    | 4 +++-
>  hw/ppc/prep.c        | 4 +++-
>  4 files changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

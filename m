Received: from eggs.gnu.org ([2001:4830:134:3::10]:33817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cYcGY-0006dH-Hm
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 12:30:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cYcGX-0006ZH-J5
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 12:30:50 -0500
Date: Tue, 31 Jan 2017 10:30:44 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170131103044.66316989@t450s.home>
In-Reply-To: <1485880595-16376-1-git-send-email-thuth@redhat.com>
References: <1485880595-16376-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/vfio: Add CONFIG switches for
 calxeda-xgmac and amd-xgbe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org

On Tue, 31 Jan 2017 17:36:35 +0100
Thomas Huth <thuth@redhat.com> wrote:

> Both devices seem to be specific to the ARM platform. It's confusing
> for the users if they show up on other target architectures, too
> (e.g. when the user runs QEMU with "-device ?" to get a list of
> supported devices). Thus let's introduce proper configuration switches
> so that the devices are only compiled and included when they are
> really required.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  default-configs/arm-softmmu.mak | 2 ++
>  hw/vfio/Makefile.objs           | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 6de3e16..a78be51 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -94,6 +94,8 @@ CONFIG_VERSATILE_PCI=y
>  CONFIG_VERSATILE_I2C=y
>  
>  CONFIG_PCI_GENERIC=y
> +CONFIG_VFIO_XGMAC=y
> +CONFIG_VFIO_AMD_XGBE=y
>  
>  CONFIG_SDHCI=y
>  CONFIG_INTEGRATOR_DEBUG=y
> diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
> index c25e32b..05e7fbb 100644
> --- a/hw/vfio/Makefile.objs
> +++ b/hw/vfio/Makefile.objs
> @@ -2,7 +2,7 @@ ifeq ($(CONFIG_LINUX), y)
>  obj-$(CONFIG_SOFTMMU) += common.o
>  obj-$(CONFIG_PCI) += pci.o pci-quirks.o
>  obj-$(CONFIG_SOFTMMU) += platform.o
> -obj-$(CONFIG_SOFTMMU) += calxeda-xgmac.o
> -obj-$(CONFIG_SOFTMMU) += amd-xgbe.o
> +obj-$(CONFIG_VFIO_XGMAC) += calxeda-xgmac.o
> +obj-$(CONFIG_VFIO_AMD_XGBE) += amd-xgbe.o
>  obj-$(CONFIG_SOFTMMU) += spapr.o
>  endif

I can't say that I fully agree that this is a good idea.  How many
users are actually confused by this, versus the benefit of ensuring
that it builds across all architectures?  Do we want to make platform
also specific to ARM and spapr specific to ppc64?  Thanks,

Alex

Received: from eggs.gnu.org ([2001:4830:134:3::10]:52977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dY9St-00016P-6k
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 07:17:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dY9So-0005Z1-Ej
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 07:17:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dY9So-0005Yo-8G
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 07:17:50 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1500021225-4118-1-git-send-email-peter.maydell@linaro.org>
	<1500021225-4118-2-git-send-email-peter.maydell@linaro.org>
Date: Thu, 20 Jul 2017 13:17:47 +0200
In-Reply-To: <1500021225-4118-2-git-send-email-peter.maydell@linaro.org>
	(Peter Maydell's message of "Fri, 14 Jul 2017 09:33:43 +0100")
Message-ID: <874lu74ask.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/3] configure: Rename CONFIG_IVSHMEM to
 CONFIG_IVSHMEM_DEVICE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Kamil Rytarowski <n54@gmx.com>, patches@linaro.org

Peter Maydell <peter.maydell@linaro.org> writes:

> The current CONFIG_IVSHMEM is confusing, because it looks like it's a
> flag for "do we have ivshmem support?", but actually it's a flag for
> "is the ivshmem PCI device being compiled?" (and implicitly "do we
> have ivshmem support?" is tested with CONFIG_EVENTFD).
>
> Rename it to CONFIG_IVSHMEM_DEVICE to clear this confusion up;
> shortly we will add a new CONFIG_IVSHMEM which really does indicate
> whether the host can support ivshmem.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

I don't really care how we name this macro, but I can't help to
wonder...  We have many CONFIG_<dev>.  The pci.mak context even shows
some.  Why is <dev> = IVSHMEM confusing?  Why is <dev> = EDU *not*
confusing?

> ---
>  hw/misc/Makefile.objs   | 2 +-
>  default-configs/pci.mak | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index 7e373db..28c1560 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -23,7 +23,7 @@ common-obj-$(CONFIG_PUV3) += puv3_pm.o
>  
>  common-obj-$(CONFIG_MACIO) += macio/
>  
> -obj-$(CONFIG_IVSHMEM) += ivshmem.o
> +obj-$(CONFIG_IVSHMEM_DEVICE) += ivshmem.o
>  
>  obj-$(CONFIG_REALVIEW) += arm_sysctl.o
>  obj-$(CONFIG_NSERIES) += cbus.o
> diff --git a/default-configs/pci.mak b/default-configs/pci.mak
> index 53ff109..2451eb2 100644
> --- a/default-configs/pci.mak
> +++ b/default-configs/pci.mak
> @@ -41,6 +41,6 @@ CONFIG_SDHCI=y
>  CONFIG_EDU=y
>  CONFIG_VGA=y
>  CONFIG_VGA_PCI=y
> -CONFIG_IVSHMEM=$(CONFIG_EVENTFD)
> +CONFIG_IVSHMEM_DEVICE=$(CONFIG_EVENTFD)
>  CONFIG_ROCKER=y
>  CONFIG_VHOST_USER_SCSI=$(CONFIG_LINUX)

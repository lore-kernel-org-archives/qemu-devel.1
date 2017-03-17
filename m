Received: from eggs.gnu.org ([2001:4830:134:3::10]:42548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1copkF-0001Kr-39
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:08:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1copkC-00085w-BW
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:08:31 -0400
Received: from 9.mo69.mail-out.ovh.net ([46.105.56.78]:37441)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1copkC-00085Y-28
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:08:28 -0400
Received: from player738.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 740541DDAF
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 12:08:26 +0100 (CET)
Date: Fri, 17 Mar 2017 12:08:15 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170317120815.212a8f8e@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <1489694518-16978-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1703161241220.14378@sstabellini-ThinkPad-X260>
	<1489694518-16978-1-git-send-email-sstabellini@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/5TOl5OeIBD3FxcsXI1PyDvk";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v3 1/9] xen: do not build backends for
 targets that do not support xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, jgross@suse.com, Stefano Stabellini <stefano@aporeto.com>, pbonzini@redhat.com, peter.maydell@linaro.org, rth@twiddle.net, stefanha@redhat.com

--Sig_/5TOl5OeIBD3FxcsXI1PyDvk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Mar 2017 13:01:50 -0700
Stefano Stabellini <sstabellini@kernel.org> wrote:

> Change Makefile.objs to use CONFIG_XEN instead of CONFIG_XEN_BACKEND, so
> that the Xen backends are only built for targets that support Xen.
>=20
> Set CONFIG_XEN in the toplevel Makefile to ensure that files that are
> built only once pick up Xen support properly.
>=20
> Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
> CC: groug@kaod.org
> CC: pbonzini@redhat.com
> CC: peter.maydell@linaro.org
> CC: rth@twiddle.net
> CC: stefanha@redhat.com
> ---

Tested-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>

>  Makefile                 | 1 +
>  hw/block/Makefile.objs   | 2 +-
>  hw/char/Makefile.objs    | 2 +-
>  hw/display/Makefile.objs | 2 +-
>  hw/net/Makefile.objs     | 2 +-
>  hw/usb/Makefile.objs     | 2 +-
>  hw/xen/Makefile.objs     | 2 +-
>  7 files changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 1c4c04f..b246138 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -26,6 +26,7 @@ endif
> =20
>  CONFIG_SOFTMMU :=3D $(if $(filter %-softmmu,$(TARGET_DIRS)),y)
>  CONFIG_USER_ONLY :=3D $(if $(filter %-user,$(TARGET_DIRS)),y)
> +CONFIG_XEN :=3D $(CONFIG_XEN_BACKEND)
>  CONFIG_ALL=3Dy
>  -include config-all-devices.mak
>  -include config-all-disas.mak
> diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
> index d4c3ab7..e0ed980 100644
> --- a/hw/block/Makefile.objs
> +++ b/hw/block/Makefile.objs
> @@ -4,7 +4,7 @@ common-obj-$(CONFIG_SSI_M25P80) +=3D m25p80.o
>  common-obj-$(CONFIG_NAND) +=3D nand.o
>  common-obj-$(CONFIG_PFLASH_CFI01) +=3D pflash_cfi01.o
>  common-obj-$(CONFIG_PFLASH_CFI02) +=3D pflash_cfi02.o
> -common-obj-$(CONFIG_XEN_BACKEND) +=3D xen_disk.o
> +common-obj-$(CONFIG_XEN) +=3D xen_disk.o
>  common-obj-$(CONFIG_ECC) +=3D ecc.o
>  common-obj-$(CONFIG_ONENAND) +=3D onenand.o
>  common-obj-$(CONFIG_NVME_PCI) +=3D nvme.o
> diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
> index 6ea76fe..725fdc4 100644
> --- a/hw/char/Makefile.objs
> +++ b/hw/char/Makefile.objs
> @@ -7,7 +7,7 @@ common-obj-$(CONFIG_SERIAL_ISA) +=3D serial-isa.o
>  common-obj-$(CONFIG_SERIAL_PCI) +=3D serial-pci.o
>  common-obj-$(CONFIG_VIRTIO) +=3D virtio-console.o
>  common-obj-$(CONFIG_XILINX) +=3D xilinx_uartlite.o
> -common-obj-$(CONFIG_XEN_BACKEND) +=3D xen_console.o
> +common-obj-$(CONFIG_XEN) +=3D xen_console.o
>  common-obj-$(CONFIG_CADENCE) +=3D cadence_uart.o
> =20
>  obj-$(CONFIG_EXYNOS4) +=3D exynos4210_uart.o
> diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
> index 063889b..3d02e8b 100644
> --- a/hw/display/Makefile.objs
> +++ b/hw/display/Makefile.objs
> @@ -5,7 +5,7 @@ common-obj-$(CONFIG_JAZZ_LED) +=3D jazz_led.o
>  common-obj-$(CONFIG_PL110) +=3D pl110.o
>  common-obj-$(CONFIG_SSD0303) +=3D ssd0303.o
>  common-obj-$(CONFIG_SSD0323) +=3D ssd0323.o
> -common-obj-$(CONFIG_XEN_BACKEND) +=3D xenfb.o
> +common-obj-$(CONFIG_XEN) +=3D xenfb.o
> =20
>  common-obj-$(CONFIG_VGA_PCI) +=3D vga-pci.o
>  common-obj-$(CONFIG_VGA_ISA) +=3D vga-isa.o
> diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
> index 610ed3e..6a95d92 100644
> --- a/hw/net/Makefile.objs
> +++ b/hw/net/Makefile.objs
> @@ -1,5 +1,5 @@
>  common-obj-$(CONFIG_DP8393X) +=3D dp8393x.o
> -common-obj-$(CONFIG_XEN_BACKEND) +=3D xen_nic.o
> +common-obj-$(CONFIG_XEN) +=3D xen_nic.o
> =20
>  # PCI network cards
>  common-obj-$(CONFIG_NE2000_PCI) +=3D ne2000.o
> diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
> index 98b5c9d..5958be8 100644
> --- a/hw/usb/Makefile.objs
> +++ b/hw/usb/Makefile.objs
> @@ -40,5 +40,5 @@ common-obj-$(CONFIG_USB_REDIR) +=3D redirect.o quirks.o
>  common-obj-y +=3D $(patsubst %,host-%.o,$(HOST_USB))
> =20
>  ifeq ($(CONFIG_USB_LIBUSB),y)
> -common-obj-$(CONFIG_XEN_BACKEND) +=3D xen-usb.o
> +common-obj-$(CONFIG_XEN) +=3D xen-usb.o
>  endif
> diff --git a/hw/xen/Makefile.objs b/hw/xen/Makefile.objs
> index 591cdc2..4be3ec9 100644
> --- a/hw/xen/Makefile.objs
> +++ b/hw/xen/Makefile.objs
> @@ -1,5 +1,5 @@
>  # xen backend driver support
> -common-obj-$(CONFIG_XEN_BACKEND) +=3D xen_backend.o xen_devconfig.o xen_=
pvdev.o
> +common-obj-$(CONFIG_XEN) +=3D xen_backend.o xen_devconfig.o xen_pvdev.o
> =20
>  obj-$(CONFIG_XEN_PCI_PASSTHROUGH) +=3D xen-host-pci-device.o
>  obj-$(CONFIG_XEN_PCI_PASSTHROUGH) +=3D xen_pt.o xen_pt_config_init.o xen=
_pt_graphics.o xen_pt_msi.o


--Sig_/5TOl5OeIBD3FxcsXI1PyDvk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljLw58ACgkQAvw66wEB28I/aACfZynY9K1QCnHfYg3aLglOl7yN
pEEAoILmAcRE7T/WkRQNpXW+lHlXC/yt
=Py7t
-----END PGP SIGNATURE-----

--Sig_/5TOl5OeIBD3FxcsXI1PyDvk--

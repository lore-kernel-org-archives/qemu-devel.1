Received: from eggs.gnu.org ([2001:4830:134:3::10]:36157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cnxLb-00028g-TM
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 21:03:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cnxLX-0000SG-Tu
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 21:03:27 -0400
Received: from 6.mo68.mail-out.ovh.net ([46.105.63.100]:56192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cnxLX-0000PC-KC
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 21:03:23 -0400
Received: from player763.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id A08204209A
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 02:03:14 +0100 (CET)
Date: Wed, 15 Mar 2017 02:03:03 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170315020303.28c78d34@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <alpine.DEB.2.10.1703141318470.4807@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1703131650550.21520@sstabellini-ThinkPad-X260>
	<1489449360-14411-1-git-send-email-sstabellini@kernel.org>
	<1b077b13-2464-224a-3942-db0015951c32@redhat.com>
	<alpine.DEB.2.10.1703141201300.4807@sstabellini-ThinkPad-X260>
	<alpine.DEB.2.10.1703141318470.4807@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/f4P4Z+jTdnGTdgTAC=W5tvY";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2 1/9] configure: change
 CONFIG_XEN_BACKEND to be a target property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, anthony.perard@citrix.com, Stefano Stabellini <stefano@aporeto.com>, peter.maydell@linaro.org, rth@twiddle.net, stefanha@redhat.com

--Sig_/f4P4Z+jTdnGTdgTAC=W5tvY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Mar 2017 13:23:09 -0700 (PDT)
Stefano Stabellini <sstabellini@kernel.org> wrote:

> On Tue, 14 Mar 2017, Stefano Stabellini wrote:
> > On Tue, 14 Mar 2017, Paolo Bonzini wrote: =20
> > > On 14/03/2017 00:55, Stefano Stabellini wrote: =20
> > > > CONFIG_XEN_BACKEND is currently set when the host supports Xen,
> > > > regardless of the chosen targets. As a consequence, Xen backends ca=
n be
> > > > enabled even on targets that don't support Xen.
> > > >=20
> > > > Fix the issue by setting CONFIG_XEN_BACKEND only for targets that
> > > > support Xen.
> > > >=20
> > > > Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
> > > > CC: groug@kaod.org
> > > > CC: groug@kaod.org
> > > > CC: pbonzini@redhat.com
> > > > CC: peter.maydell@linaro.org
> > > > CC: rth@twiddle.net
> > > > CC: stefanha@redhat.com
> > > > ---
> > > >  configure | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/configure b/configure
> > > > index 6c21975..6d8f752 100755
> > > > --- a/configure
> > > > +++ b/configure
> > > > @@ -5442,7 +5442,6 @@ if test "$virglrenderer" =3D "yes" ; then
> > > >    echo "VIRGL_LIBS=3D$virgl_libs" >> $config_host_mak
> > > >  fi
> > > >  if test "$xen" =3D "yes" ; then
> > > > -  echo "CONFIG_XEN_BACKEND=3Dy" >> $config_host_mak
> > > >    echo "CONFIG_XEN_CTRL_INTERFACE_VERSION=3D$xen_ctrl_version" >> =
$config_host_mak
> > > >    if test "$xen_pv_domain_build" =3D "yes" ; then
> > > >      echo "CONFIG_XEN_PV_DOMAIN_BUILD=3Dy" >> $config_host_mak
> > > > @@ -6028,6 +6027,7 @@ case "$target_name" in
> > > >    i386|x86_64)
> > > >      if test "$xen" =3D "yes" -a "$target_softmmu" =3D "yes" ; then
> > > >        echo "CONFIG_XEN=3Dy" >> $config_target_mak
> > > > +      echo "CONFIG_XEN_BACKEND=3Dy" >> $config_target_mak
> > > >        if test "$xen_pci_passthrough" =3D yes; then
> > > >          echo "CONFIG_XEN_PCI_PASSTHROUGH=3Dy" >> "$config_target_m=
ak"
> > > >        fi
> > > >  =20
> > >=20
> > > This messes up a bit the way xen_nic.o and friends are compiled, I
> > > think, because they are common-obj-y but they are only found when
> > > compiling in the target subdirectories.  So you end up building
> > > x86_64-softmmu/../hw/net/xen_nic.o
> > >=20
> > > If you're unlucky, I believe this can lead to a link failure where a
> > > target is building xen_nic.o, while the other tries to link to a
> > > partially written object file.
> > >=20
> > > I think the files should be changed from
> > > common-obj-$(CONFIG_XEN_BACKEND) to common-obj-$(CONFIG_XEN).
> > >
> > > The Makefile.objs change ensures that Xen backends are not enabled on
> > > targets that support Xen. =20
> >=20
> > Actually I thought about doing that instead of the configure change. It
> > makes sense to me.
> >=20
> >  =20
> > > Then you add to Makefile:
> > >=20
> > >  CONFIG_SOFTMMU :=3D $(if $(filter %-softmmu,$(TARGET_DIRS)),y)
> > >  CONFIG_USER_ONLY :=3D $(if $(filter %-user,$(TARGET_DIRS)),y)
> > > +CONFIG_XEN :=3D $(CONFIG_XEN_BACKEND)
> > >  CONFIG_ALL=3Dy
> > >  -include config-all-devices.mak
> > >  -include config-all-disas.mak
> > >=20
> > > The Makefile change ensures that they are built before descending in =
the
> > > target-specific directories. =20
> >=20
> > But I don't understand this. Please correct me if I am wrong, but this
> > change looks like it would end up setting CONFIG_XEN every time that
> > CONFIG_XEN_BACKEND is set. Without the configure change at the top, it
> > would end up setting CONFIG_XEN whenever the host supports Xen, even for
> > non-x86 and non-ARM targets. What am I missing? =20
>=20
> FYI I made the following changes:
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
>=20
> I applied the rest of the series and did
>=20
>   ./configure --enable-virtfs --enable-xen; make -j5
>=20
> I got the following error:
>=20
>   LINK    aarch64-softmmu/qemu-system-aarch64
> ../hw/9pfs/xen-9p-backend.o: In function `xen_9pfs_alloc':

It looks like hw/9pfs/Makefile.objs may still have:

common-obj-$(CONFIG_XEN_BACKEND) +=3D xen-9p-backend.o

instead of:

common-obj-$(CONFIG_XEN) +=3D xen-9p-backend.o

... which builds like a charm.

Cheers.

--
Greg

> /local/qemu/hw/9pfs/xen-9p-backend.c:387: undefined reference to `xenstor=
e_write_be_str'
> /local/qemu/hw/9pfs/xen-9p-backend.c:388: undefined reference to `xenstor=
e_write_be_int'
> ../hw/9pfs/xen-9p-backend.o: In function `xen_9pfs_connect':
> /local/qemu/hw/9pfs/xen-9p-backend.c:292: undefined reference to `xenstor=
e_read_fe_int'
> /local/qemu/hw/9pfs/xen-9p-backend.c:313: undefined reference to `xenstor=
e_read_fe_int'
> /local/qemu/hw/9pfs/xen-9p-backend.c:357: undefined reference to `xen_pv_=
printf'
> /local/qemu/hw/9pfs/xen-9p-backend.c:307: undefined reference to `xenstor=
e_read_fe_int'
> /local/qemu/hw/9pfs/xen-9p-backend.c:362: undefined reference to `xenstor=
e_read_be_str'
> /local/qemu/hw/9pfs/xen-9p-backend.c:363: undefined reference to `xenstor=
e_read_be_str'
> /local/qemu/hw/9pfs/xen-9p-backend.c:366: undefined reference to `xenstor=
e_read_fe_str'
> /local/qemu/hw/9pfs/xen-9p-backend.c:353: undefined reference to `xen_pv_=
printf'
> ../hw/9pfs/xen-9p-backend.o: In function `xen_9pfs_alloc':
> /local/qemu/hw/9pfs/xen-9p-backend.c:389: undefined reference to `xenstor=
e_write_be_int'
> collect2: error: ld returned 1 exit status
> make[1]: *** [qemu-system-arm] Error 1
> make: *** [subdir-arm-softmmu] Error 2
> ../hw/9pfs/xen-9p-backend.o: In function `xen_9pfs_alloc':
> /local/qemu/hw/9pfs/xen-9p-backend.c:387: undefined reference to `xenstor=
e_write_be_str'
> /local/qemu/hw/9pfs/xen-9p-backend.c:388: undefined reference to `xenstor=
e_write_be_int'
> ../hw/9pfs/xen-9p-backend.o: In function `xen_9pfs_connect':
> /local/qemu/hw/9pfs/xen-9p-backend.c:292: undefined reference to `xenstor=
e_read_fe_int'
> /local/qemu/hw/9pfs/xen-9p-backend.c:313: undefined reference to `xenstor=
e_read_fe_int'
> /local/qemu/hw/9pfs/xen-9p-backend.c:357: undefined reference to `xen_pv_=
printf'
> /local/qemu/hw/9pfs/xen-9p-backend.c:307: undefined reference to `xenstor=
e_read_fe_int'
> /local/qemu/hw/9pfs/xen-9p-backend.c:362: undefined reference to `xenstor=
e_read_be_str'
> /local/qemu/hw/9pfs/xen-9p-backend.c:363: undefined reference to `xenstor=
e_read_be_str'
> /local/qemu/hw/9pfs/xen-9p-backend.c:366: undefined reference to `xenstor=
e_read_fe_str'
> /local/qemu/hw/9pfs/xen-9p-backend.c:353: undefined reference to `xen_pv_=
printf'
> ../hw/9pfs/xen-9p-backend.o: In function `xen_9pfs_alloc':
> /local/qemu/hw/9pfs/xen-9p-backend.c:389: undefined reference to `xenstor=
e_write_be_int'
> collect2: error: ld returned 1 exit status
> make[1]: *** [qemu-system-aarch64] Error 1
> make: *** [subdir-aarch64-softmmu] Error 2
>=20


--Sig_/f4P4Z+jTdnGTdgTAC=W5tvY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljIksgACgkQAvw66wEB28JoWwCfSPe92gJxm4Qg79L6N5y9bcLj
ltUAn3LgzlqbORngXmhitTkZe6kfE11h
=h1pt
-----END PGP SIGNATURE-----

--Sig_/f4P4Z+jTdnGTdgTAC=W5tvY--

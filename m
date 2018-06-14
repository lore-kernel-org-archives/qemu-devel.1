Received: from eggs.gnu.org ([2001:4830:134:3::10]:52996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTXhY-0001Ds-Ju
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:14:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTXhU-0001IN-Bf
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:14:32 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180612065150.21110-1-ville.skytta@iki.fi>
Date: Thu, 14 Jun 2018 21:14:25 +0200
In-Reply-To: <20180612065150.21110-1-ville.skytta@iki.fi> ("Ville
	=?utf-8?Q?Skytt=C3=A4=22's?=
	message of "Tue, 12 Jun 2018 09:51:50 +0300")
Message-ID: <87in6lfaem.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docs: Grammar and spelling fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: Ville =?utf-8?Q?Skytt=C3=A4?= <ville.skytta@iki.fi>, qemu-devel@nongnu.org

Looks like a candidate for merging via qemu-trivial.

Ville Skytt=C3=A4 <ville.skytta@iki.fi> writes:

> Signed-off-by: Ville Skytt=C3=A4 <ville.skytta@iki.fi>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  docs/colo-proxy.txt                  | 2 +-
>  docs/config/mach-virt-graphical.cfg  | 2 +-
>  docs/config/mach-virt-serial.cfg     | 2 +-
>  docs/config/q35-emulated.cfg         | 2 +-
>  docs/config/q35-virtio-graphical.cfg | 2 +-
>  docs/config/q35-virtio-serial.cfg    | 2 +-
>  docs/devel/migration.rst             | 2 +-
>  docs/devel/multi-thread-tcg.txt      | 2 +-
>  docs/interop/qcow2.txt               | 6 +++---
>  docs/interop/vhost-user.txt          | 4 ++--
>  docs/memory-hotplug.txt              | 2 +-
>  docs/multiseat.txt                   | 2 +-
>  docs/qemu-block-drivers.texi         | 2 +-
>  docs/qemupciserial.inf               | 2 +-
>  docs/specs/acpi_nvdimm.txt           | 3 ++-
>  docs/specs/ppc-spapr-hcalls.txt      | 2 +-
>  docs/specs/tpm.txt                   | 2 +-
>  docs/usb2.txt                        | 2 +-
>  18 files changed, 22 insertions(+), 21 deletions(-)
>
> diff --git a/docs/colo-proxy.txt b/docs/colo-proxy.txt
> index 8b726ea094..1f8e4b4e77 100644
> --- a/docs/colo-proxy.txt
> +++ b/docs/colo-proxy.txt
> @@ -145,7 +145,7 @@ and redirect indev's packet to filter.
>  COLO-compare, we do packet comparing job.
>  Packets coming from the primary char indev will be sent to outdev.
>  Packets coming from the secondary char dev will be dropped after compari=
ng.
> -COLO-comapre need two input chardev and one output chardev:
> +COLO-compare needs two input chardevs and one output chardev:
>  primary_in=3Dchardev1-id (source: primary send packet)
>  secondary_in=3Dchardev2-id (source: secondary send packet)
>  outdev=3Dchardev3-id
> diff --git a/docs/config/mach-virt-graphical.cfg b/docs/config/mach-virt-=
graphical.cfg
> index 0fdf6846dd..d6d31b17f5 100644
> --- a/docs/config/mach-virt-graphical.cfg
> +++ b/docs/config/mach-virt-graphical.cfg
> @@ -185,7 +185,7 @@
>  # attached to it.
>  #
>  # We also create an optical disk, mostly for installation
> -# purposes: once the guest OS has been succesfully
> +# purposes: once the guest OS has been successfully
>  # installed, the guest will no longer boot from optical
>  # media. If you don't want, or no longer want, to have an
>  # optical disk in the guest you can safely comment out
> diff --git a/docs/config/mach-virt-serial.cfg b/docs/config/mach-virt-ser=
ial.cfg
> index aee9f1c5a1..18a7c83731 100644
> --- a/docs/config/mach-virt-serial.cfg
> +++ b/docs/config/mach-virt-serial.cfg
> @@ -191,7 +191,7 @@
>  # attached to it.
>  #
>  # We also create an optical disk, mostly for installation
> -# purposes: once the guest OS has been succesfully
> +# purposes: once the guest OS has been successfully
>  # installed, the guest will no longer boot from optical
>  # media. If you don't want, or no longer want, to have an
>  # optical disk in the guest you can safely comment out
> diff --git a/docs/config/q35-emulated.cfg b/docs/config/q35-emulated.cfg
> index c6416d6545..99ac918e78 100644
> --- a/docs/config/q35-emulated.cfg
> +++ b/docs/config/q35-emulated.cfg
> @@ -130,7 +130,7 @@
>  # it to that controller so that the guest can use it.
>  #
>  # We also create an optical disk, mostly for installation
> -# purposes: once the guest OS has been succesfully
> +# purposes: once the guest OS has been successfully
>  # installed, the guest will no longer boot from optical
>  # media. If you don't want, or no longer want, to have an
>  # optical disk in the guest you can safely comment out
> diff --git a/docs/config/q35-virtio-graphical.cfg b/docs/config/q35-virti=
o-graphical.cfg
> index 28bde2fc57..4207f11e4f 100644
> --- a/docs/config/q35-virtio-graphical.cfg
> +++ b/docs/config/q35-virtio-graphical.cfg
> @@ -136,7 +136,7 @@
>  # attached to it.
>  #
>  # We also create an optical disk, mostly for installation
> -# purposes: once the guest OS has been succesfully
> +# purposes: once the guest OS has been successfully
>  # installed, the guest will no longer boot from optical
>  # media. If you don't want, or no longer want, to have an
>  # optical disk in the guest you can safely comment out
> diff --git a/docs/config/q35-virtio-serial.cfg b/docs/config/q35-virtio-s=
erial.cfg
> index c33c9cc07a..d2830aec5e 100644
> --- a/docs/config/q35-virtio-serial.cfg
> +++ b/docs/config/q35-virtio-serial.cfg
> @@ -141,7 +141,7 @@
>  # attached to it.
>  #
>  # We also create an optical disk, mostly for installation
> -# purposes: once the guest OS has been succesfully
> +# purposes: once the guest OS has been successfully
>  # installed, the guest will no longer boot from optical
>  # media. If you don't want, or no longer want, to have an
>  # optical disk in the guest you can safely comment out
> diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
> index 40f136f6be..6ed3fce061 100644
> --- a/docs/devel/migration.rst
> +++ b/docs/devel/migration.rst
> @@ -37,7 +37,7 @@ over any transport.
>  - tcp migration: do the migration using tcp sockets
>  - unix migration: do the migration using unix sockets
>  - exec migration: do the migration using the stdin/stdout through a proc=
ess.
> -- fd migration: do the migration using an file descriptor that is
> +- fd migration: do the migration using a file descriptor that is
>    passed to QEMU.  QEMU doesn't care how this file descriptor is opened.
>=20=20
>  In addition, support is included for migration using RDMA, which
> diff --git a/docs/devel/multi-thread-tcg.txt b/docs/devel/multi-thread-tc=
g.txt
> index a99b4564c6..ac485c8e62 100644
> --- a/docs/devel/multi-thread-tcg.txt
> +++ b/docs/devel/multi-thread-tcg.txt
> @@ -308,7 +308,7 @@ other cores sharing access to the memory. The classic=
 example is the
>  x86 cmpxchg instruction.
>=20=20
>  The second type offer a pair of load/store instructions which offer a
> -guarantee that an region of memory has not been touched between the
> +guarantee that a region of memory has not been touched between the
>  load and store instructions. An example of this is ARM's ldrex/strex
>  pair where the strex instruction will return a flag indicating a
>  successful store only if no other CPU has accessed the memory region
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index 8e1547ded2..845d40a086 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -326,8 +326,8 @@ in the image file.
>  It contains pointers to the second level structures which are called ref=
count
>  blocks and are exactly one cluster in size.
>=20=20
> -Given a offset into the image file, the refcount of its cluster can be o=
btained
> -as follows:
> +Given an offset into the image file, the refcount of its cluster can be
> +obtained as follows:
>=20=20
>      refcount_block_entries =3D (cluster_size * 8 / refcount_bits)
>=20=20
> @@ -365,7 +365,7 @@ The L1 table has a variable size (stored in the heade=
r) and may use multiple
>  clusters, however it must be contiguous in the image file. L2 tables are
>  exactly one cluster in size.
>=20=20
> -Given a offset into the virtual disk, the offset into the image file can=
 be
> +Given an offset into the virtual disk, the offset into the image file ca=
n be
>  obtained as follows:
>=20=20
>      l2_entries =3D (cluster_size / sizeof(uint64_t))
> diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
> index d51fd58242..f59667f498 100644
> --- a/docs/interop/vhost-user.txt
> +++ b/docs/interop/vhost-user.txt
> @@ -108,12 +108,12 @@ Depending on the request type, payload can be:
>     IOVA: a 64-bit I/O virtual address programmed by the guest
>     Size: a 64-bit size
>     User address: a 64-bit user address
> -   Permissions: a 8-bit value:
> +   Permissions: an 8-bit value:
>      - 0: No access
>      - 1: Read access
>      - 2: Write access
>      - 3: Read/Write access
> -   Type: a 8-bit IOTLB message type:
> +   Type: an 8-bit IOTLB message type:
>      - 1: IOTLB miss
>      - 2: IOTLB update
>      - 3: IOTLB invalidate
> diff --git a/docs/memory-hotplug.txt b/docs/memory-hotplug.txt
> index d96397c1af..6aa5e17e26 100644
> --- a/docs/memory-hotplug.txt
> +++ b/docs/memory-hotplug.txt
> @@ -62,7 +62,7 @@ It's also possible to start a guest with memory cold-pl=
ugged into the
>  hotpluggable memory slots. This might seem counterintuitive at first,
>  but this allows for a lot of flexibility when using the file backend.
>=20=20
> -In the following command-line example, a 8GB guest is created where 6GB
> +In the following command-line example, an 8GB guest is created where 6GB
>  comes from regular RAM, 1GB is a 1GB hugepage page and 256MB is from
>  2MB pages. Also, the guest has additional memory slots to hotplug more
>  2GB if needed:
> diff --git a/docs/multiseat.txt b/docs/multiseat.txt
> index 807518c8af..fb7e790b22 100644
> --- a/docs/multiseat.txt
> +++ b/docs/multiseat.txt
> @@ -62,7 +62,7 @@ to its own window so you can see both display devices s=
ide-by-side.
>=20=20
>  For vnc some additional configuration on the command line is needed.
>  We'll create two vnc server instances, and bind the second one to the
> -second seat, simliar to input devices:
> +second seat, similar to input devices:
>=20=20
>  	-display vnc=3D:1,id=3Dprimary \
>  	-display vnc=3D:2,id=3Dsecondary,display=3Dvideo.2
> diff --git a/docs/qemu-block-drivers.texi b/docs/qemu-block-drivers.texi
> index f1793692bb..38e9f34cc9 100644
> --- a/docs/qemu-block-drivers.texi
> +++ b/docs/qemu-block-drivers.texi
> @@ -524,7 +524,7 @@ You can create a cloned image from the existing snaps=
hot.
>  @example
>  qemu-img create -b sheepdog:///@var{base}#@var{tag} sheepdog:///@var{ima=
ge}
>  @end example
> -where @var{base} is a image name of the source snapshot and @var{tag}
> +where @var{base} is an image name of the source snapshot and @var{tag}
>  is its tag name.
>=20=20
>  You can use an unix socket instead of an inet socket:
> diff --git a/docs/qemupciserial.inf b/docs/qemupciserial.inf
> index 6f7eef49cc..7ca766745d 100644
> --- a/docs/qemupciserial.inf
> +++ b/docs/qemupciserial.inf
> @@ -1,7 +1,7 @@
>  ; qemupciserial.inf for QEMU, based on MSPORTS.INF
>=20=20
>  ; The driver itself is shipped with Windows (serial.sys).  This is
> -; just a inf file to tell windows which pci id the serial pci card
> +; just an inf file to tell windows which pci id the serial pci card
>  ; emulated by qemu has, and to apply a name tag to it which windows
>  ; will show in the device manager.
>=20=20
> diff --git a/docs/specs/acpi_nvdimm.txt b/docs/specs/acpi_nvdimm.txt
> index 3f322e6f55..3ec42ecbce 100644
> --- a/docs/specs/acpi_nvdimm.txt
> +++ b/docs/specs/acpi_nvdimm.txt
> @@ -72,7 +72,8 @@ for NVDIMM ACPI.
>=20=20
>  Memory:
>     QEMU uses BIOS Linker/loader feature to ask BIOS to allocate a memory
> -   page and dynamically patch its into a int32 object named "MEMA" in AC=
PI.
> +   page and dynamically patch its address into an int32 object named "ME=
MA"
> +   in ACPI.
>=20=20
>     This page is RAM-based and it is used to transfer data between _DSM
>     method and QEMU. If ACPI has control, this pages is owned by ACPI whi=
ch
> diff --git a/docs/specs/ppc-spapr-hcalls.txt b/docs/specs/ppc-spapr-hcall=
s.txt
> index 5bd8eab78f..93fe3da91b 100644
> --- a/docs/specs/ppc-spapr-hcalls.txt
> +++ b/docs/specs/ppc-spapr-hcalls.txt
> @@ -10,7 +10,7 @@ calls which are mostly used as a private interface betw=
een the firmware
>  running in the guest and QEMU.
>=20=20
>  All those hypercalls start at hcall number 0xf000 which correspond
> -to a implementation specific range in PAPR.
> +to an implementation specific range in PAPR.
>=20=20
>  - H_RTAS (0xf000)
>=20=20
> diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
> index c230c4c93e..575a267611 100644
> --- a/docs/specs/tpm.txt
> +++ b/docs/specs/tpm.txt
> @@ -252,7 +252,7 @@ swtpm socket --tpmstate dir=3D/tmp/mytpm1 \
>    --ctrl type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock \
>    --log level=3D20 --tpm2
>=20=20
> -In the 2nd terminal restore the state of the VM using the additonal
> +In the 2nd terminal restore the state of the VM using the additional
>  '-incoming' option.
>=20=20
>  qemu-system-x86_64 -display sdl -enable-kvm \
> diff --git a/docs/usb2.txt b/docs/usb2.txt
> index 09df45b5b1..9e47169f45 100644
> --- a/docs/usb2.txt
> +++ b/docs/usb2.txt
> @@ -15,7 +15,7 @@ the PIIX3 chipset.  The USB 1.1 bus will carry the name=
 "usb-bus.0".
>=20=20
>  You can use the standard -device switch to add a EHCI controller to
>  your virtual machine.  It is strongly recommended to specify an ID for
> -the controller so the USB 2.0 bus gets a individual name, for example
> +the controller so the USB 2.0 bus gets an individual name, for example
>  '-device usb-ehci,id=3Dehci".  This will give you a USB 2.0 bus named
>  "ehci.0".

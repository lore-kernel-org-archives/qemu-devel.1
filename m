Received: from eggs.gnu.org ([2001:4830:134:3::10]:47100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dTINh-0001fs-5V
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 21:48:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dTINc-00051K-UA
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 21:48:29 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:48579)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1dTINb-0004yQ-AG
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 21:48:24 -0400
Date: Fri, 7 Jul 2017 11:09:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170707010905.GR2180@umbus.fritz.box>
References: <cover.1499381754.git.alistair.francis@xilinx.com>
	<0a1d5638543965d532284bdc6fce391cf9f509d0.1499381754.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RpDyejMaDGJhP2PU"
Content-Disposition: inline
In-Reply-To: <0a1d5638543965d532284bdc6fce391cf9f509d0.1499381754.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH v1 3/6] Convert error_report() to
 warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, philippe@mathieu-daude.net, berrange@redhat.com, armbru@redhat.com, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, Josh Durgin <jdurgin@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, Rob Herring <robh@kernel.org>, Peter Maydell <peter.maydell@linaro.org>, Peter Chubb <peter.chubb@nicta.com.au>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>


--RpDyejMaDGJhP2PU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2017 at 04:49:44PM -0700, Alistair Francis wrote:
> Convert all uses of error_report("[Ww]arning:"... to use warn_report()
> instead. This helps standardise on a single method of printing warnings
> to the user.
>=20
> All of the warnings were found using this regex expression:
>     error_report.*[Ww]arning:
> and replaced with:
>     warn_report("

ppc parts

Acked-by: David Gibson <david@gibson.dropbear.id.au>

>=20
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Cc: Jeff Cody <jcody@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Lieven <pl@kamp.de>
> Cc: Josh Durgin <jdurgin@redhat.com>
> Cc: "Richard W.M. Jones" <rjones@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> Cc: Greg Kurz <groug@kaod.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Peter Chubb <peter.chubb@nicta.com.au>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>=20
>  block/backup.c                 | 10 +++++-----
>  block/gluster.c                |  2 +-
>  block/iscsi.c                  |  2 +-
>  block/nfs.c                    | 12 ++++++------
>  block/rbd.c                    |  6 +++---
>  block/ssh.c                    |  4 ++--
>  blockdev.c                     |  2 +-
>  cpus.c                         |  2 +-
>  hw/9pfs/9p.c                   |  2 +-
>  hw/arm/highbank.c              |  6 +++---
>  hw/arm/imx25_pdk.c             |  6 +++---
>  hw/arm/kzm.c                   |  6 +++---
>  hw/core/machine.c              | 10 +++++-----
>  hw/core/qdev-properties.c      |  8 ++++----
>  hw/i386/acpi-build.c           | 10 +++++-----
>  hw/i386/kvm/pci-assign.c       |  6 +++---
>  hw/i386/pc.c                   | 12 ++++++------
>  hw/i386/pc_piix.c              |  8 ++++----
>  hw/i386/pc_q35.c               |  6 +++---
>  hw/misc/aspeed_sdmc.c          |  8 ++++----
>  hw/nvram/fw_cfg.c              |  2 +-
>  hw/pci-host/piix.c             |  2 +-
>  hw/ppc/pnv.c                   |  6 +++---
>  hw/ppc/spapr.c                 |  4 ++--
>  hw/ppc/spapr_iommu.c           |  2 +-
>  hw/scsi/scsi-bus.c             |  6 +++---
>  hw/usb/dev-smartcard-reader.c  |  6 +++---
>  hw/usb/redirect.c              |  2 +-
>  net/tap-linux.c                |  2 +-
>  target/i386/cpu.c              | 22 +++++++++++-----------
>  target/i386/kvm.c              | 10 +++++-----
>  target/s390x/cpu_models.c      |  6 +++---
>  target/s390x/kvm.c             |  4 ++--
>  tests/test-qdev-global-props.c |  6 +++---
>  trace/control.c                |  8 ++++----
>  vl.c                           | 20 ++++++++++----------
>  36 files changed, 118 insertions(+), 118 deletions(-)
>=20
> diff --git a/block/backup.c b/block/backup.c
> index 5387fbd84e..a0f059a0b6 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -657,11 +657,11 @@ BlockJob *backup_job_create(const char *job_id, Blo=
ckDriverState *bs,
>      ret =3D bdrv_get_info(target, &bdi);
>      if (ret =3D=3D -ENOTSUP && !target->backing) {
>          /* Cluster size is not defined */
> -        error_report("WARNING: The target block device doesn't provide "
> -                     "information about the block size and it doesn't ha=
ve a "
> -                     "backing file. The default block size of %u bytes i=
s "
> -                     "used. If the actual block size of the target excee=
ds "
> -                     "this default, the backup may be unusable",
> +        warn_report("The target block device doesn't provide "
> +                    "information about the block size and it doesn't hav=
e a "
> +                    "backing file. The default block size of %u bytes is=
 "
> +                    "used. If the actual block size of the target exceed=
s "
> +                    "this default, the backup may be unusable",
>                       BACKUP_CLUSTER_SIZE_DEFAULT);
>          job->cluster_size =3D BACKUP_CLUSTER_SIZE_DEFAULT;
>      } else if (ret < 0 && !target->backing) {
> diff --git a/block/gluster.c b/block/gluster.c
> index addceed6eb..79b790c4fc 100644
> --- a/block/gluster.c
> +++ b/block/gluster.c
> @@ -345,7 +345,7 @@ static int qemu_gluster_parse_uri(BlockdevOptionsGlus=
ter *gconf,
>          is_unix =3D true;
>      } else if (!strcmp(uri->scheme, "gluster+rdma")) {
>          gsconf->type =3D SOCKET_ADDRESS_TYPE_INET;
> -        error_report("Warning: rdma feature is not supported, falling "
> +        warn_report(rdma feature is not supported, falling "
>                       "back to tcp");
>      } else {
>          ret =3D -EINVAL;
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 54067e2620..22911e7526 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -1761,7 +1761,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *=
options, int flags,
>       * filename encoded options */
>      filename =3D qdict_get_try_str(options, "filename");
>      if (filename) {
> -        error_report("Warning: 'filename' option specified. "
> +        warn_report('filename' option specified. "
>                        "This is an unsupported option, and may be depreca=
ted "
>                        "in the future");
>          iscsi_parse_filename(filename, options, &local_err);
> diff --git a/block/nfs.c b/block/nfs.c
> index c3c5de0113..43929c6f23 100644
> --- a/block/nfs.c
> +++ b/block/nfs.c
> @@ -558,8 +558,8 @@ static int64_t nfs_client_open(NFSClient *client, QDi=
ct *options,
>          }
>          client->readahead =3D qemu_opt_get_number(opts, "readahead-size"=
, 0);
>          if (client->readahead > QEMU_NFS_MAX_READAHEAD_SIZE) {
> -            error_report("NFS Warning: Truncating NFS readahead "
> -                         "size to %d", QEMU_NFS_MAX_READAHEAD_SIZE);
> +            warn_report("Truncating NFS readahead "
> +                        "size to %d", QEMU_NFS_MAX_READAHEAD_SIZE);
>              client->readahead =3D QEMU_NFS_MAX_READAHEAD_SIZE;
>          }
>          nfs_set_readahead(client->context, client->readahead);
> @@ -579,8 +579,8 @@ static int64_t nfs_client_open(NFSClient *client, QDi=
ct *options,
>          }
>          client->pagecache =3D qemu_opt_get_number(opts, "page-cache-size=
", 0);
>          if (client->pagecache > QEMU_NFS_MAX_PAGECACHE_SIZE) {
> -            error_report("NFS Warning: Truncating NFS pagecache "
> -                         "size to %d pages", QEMU_NFS_MAX_PAGECACHE_SIZE=
);
> +            warn_report("Truncating NFS pagecache "
> +                        "size to %d pages", QEMU_NFS_MAX_PAGECACHE_SIZE);
>              client->pagecache =3D QEMU_NFS_MAX_PAGECACHE_SIZE;
>          }
>          nfs_set_pagecache(client->context, client->pagecache);
> @@ -595,8 +595,8 @@ static int64_t nfs_client_open(NFSClient *client, QDi=
ct *options,
>          /* limit the maximum debug level to avoid potential flooding
>           * of our log files. */
>          if (client->debug > QEMU_NFS_MAX_DEBUG_LEVEL) {
> -            error_report("NFS Warning: Limiting NFS debug level "
> -                         "to %d", QEMU_NFS_MAX_DEBUG_LEVEL);
> +            warn_report("Limiting NFS debug level "
> +                        "to %d", QEMU_NFS_MAX_DEBUG_LEVEL);
>              client->debug =3D QEMU_NFS_MAX_DEBUG_LEVEL;
>          }
>          nfs_set_debug(client->context, client->debug);
> diff --git a/block/rbd.c b/block/rbd.c
> index 9da02cdceb..d461f7dc87 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -555,9 +555,9 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict =
*options, int flags,
>       * filename encoded options */
>      filename =3D qdict_get_try_str(options, "filename");
>      if (filename) {
> -        error_report("Warning: 'filename' option specified. "
> -                      "This is an unsupported option, and may be depreca=
ted "
> -                      "in the future");
> +        warn_report("'filename' option specified. "
> +                    "This is an unsupported option, and may be deprecate=
d "
> +                    "in the future");
>          qemu_rbd_parse_filename(filename, options, &local_err);
>          if (local_err) {
>              r =3D -EINVAL;
> diff --git a/block/ssh.c b/block/ssh.c
> index 52964416da..07a57eb466 100644
> --- a/block/ssh.c
> +++ b/block/ssh.c
> @@ -1114,8 +1114,8 @@ static coroutine_fn int ssh_co_writev(BlockDriverSt=
ate *bs,
>  static void unsafe_flush_warning(BDRVSSHState *s, const char *what)
>  {
>      if (!s->unsafe_flush_warning) {
> -        error_report("warning: ssh server %s does not support fsync",
> -                     s->inet->host);
> +        warn_report("ssh server %s does not support fsync",
> +                    s->inet->host);
>          if (what) {
>              error_report("to support fsync, you need %s", what);
>          }
> diff --git a/blockdev.c b/blockdev.c
> index f92dcf24bf..46428af3c8 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -900,7 +900,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfa=
ceType block_default_type)
>      copy_on_read =3D qemu_opt_get_bool(legacy_opts, "copy-on-read", fals=
e);
> =20
>      if (read_only && copy_on_read) {
> -        error_report("warning: disabling copy-on-read on read-only drive=
");
> +        warn_report("disabling copy-on-read on read-only drive");
>          copy_on_read =3D false;
>      }
> =20
> diff --git a/cpus.c b/cpus.c
> index 14bb8d552e..9bed61eefc 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -557,7 +557,7 @@ void qemu_start_warp_timer(void)
>      if (deadline < 0) {
>          static bool notified;
>          if (!icount_sleep && !notified) {
> -            error_report("WARNING: icount sleep disabled and no active t=
imers");
> +            warn_report("icount sleep disabled and no active timers");
>              notified =3D true;
>          }
>          return;
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 6c92bad5b3..333dbb6f8e 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -2376,7 +2376,7 @@ static void coroutine_fn v9fs_flush(void *opaque)
>      trace_v9fs_flush(pdu->tag, pdu->id, tag);
> =20
>      if (pdu->tag =3D=3D tag) {
> -        error_report("Warning: the guest sent a self-referencing 9P flus=
h request");
> +        warn_report("the guest sent a self-referencing 9P flush request"=
);
>      } else {
>          QLIST_FOREACH(cancel_pdu, &s->active_list, next) {
>              if (cancel_pdu->tag =3D=3D tag) {
> diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
> index d209b97dee..750c463e2a 100644
> --- a/hw/arm/highbank.c
> +++ b/hw/arm/highbank.c
> @@ -383,9 +383,9 @@ static void calxeda_init(MachineState *machine, enum =
cxmachines machine_id)
>          highbank_binfo.write_board_setup =3D hb_write_board_setup;
>          highbank_binfo.secure_board_setup =3D true;
>      } else {
> -        error_report("WARNING: cannot load built-in Monitor support "
> -                     "if KVM is enabled. Some guests (such as Linux) "
> -                     "may not boot.");
> +        warn_report("cannot load built-in Monitor support "
> +                    "if KVM is enabled. Some guests (such as Linux) "
> +                    "may not boot.");
>      }
> =20
>      arm_load_kernel(ARM_CPU(first_cpu), &highbank_binfo);
> diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
> index 44e741fde3..7d42c74001 100644
> --- a/hw/arm/imx25_pdk.c
> +++ b/hw/arm/imx25_pdk.c
> @@ -80,9 +80,9 @@ static void imx25_pdk_init(MachineState *machine)
> =20
>      /* We need to initialize our memory */
>      if (machine->ram_size > (FSL_IMX25_SDRAM0_SIZE + FSL_IMX25_SDRAM1_SI=
ZE)) {
> -        error_report("WARNING: RAM size " RAM_ADDR_FMT " above max suppo=
rted, "
> -                     "reduced to %x", machine->ram_size,
> -                     FSL_IMX25_SDRAM0_SIZE + FSL_IMX25_SDRAM1_SIZE);
> +        warn_report("RAM size " RAM_ADDR_FMT " above max supported, "
> +                    "reduced to %x", machine->ram_size,
> +                    FSL_IMX25_SDRAM0_SIZE + FSL_IMX25_SDRAM1_SIZE);
>          machine->ram_size =3D FSL_IMX25_SDRAM0_SIZE + FSL_IMX25_SDRAM1_S=
IZE;
>      }
> =20
> diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
> index 2c96ee33b6..3ed6577a55 100644
> --- a/hw/arm/kzm.c
> +++ b/hw/arm/kzm.c
> @@ -79,9 +79,9 @@ static void kzm_init(MachineState *machine)
> =20
>      /* Check the amount of memory is compatible with the SOC */
>      if (machine->ram_size > (FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDRAM1_SI=
ZE)) {
> -        error_report("WARNING: RAM size " RAM_ADDR_FMT " above max suppo=
rted, "
> -                     "reduced to %x", machine->ram_size,
> -                     FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDRAM1_SIZE);
> +        warn_report("RAM size " RAM_ADDR_FMT " above max supported, "
> +                    "reduced to %x", machine->ram_size,
> +                    FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDRAM1_SIZE);
>          machine->ram_size =3D FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDRAM1_S=
IZE;
>      }
> =20
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index ecb55528e8..dc431fabf5 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -741,11 +741,11 @@ static void machine_numa_finish_init(MachineState *=
machine)
>          }
>      }
>      if (s->len && !qtest_enabled()) {
> -        error_report("warning: CPU(s) not present in any NUMA nodes: %s",
> -                     s->str);
> -        error_report("warning: All CPU(s) up to maxcpus should be descri=
bed "
> -                     "in NUMA config, ability to start up with partial N=
UMA "
> -                     "mappings is obsoleted and will be removed in futur=
e");
> +        warn_report("CPU(s) not present in any NUMA nodes: %s",
> +                    s->str);
> +        warn_report("All CPU(s) up to maxcpus should be described "
> +                    "in NUMA config, ability to start up with partial NU=
MA "
> +                    "mappings is obsoleted and will be removed in future=
");
>      }
>      g_string_free(s, true);
>  }
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index f11d57831b..f5983c83da 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -1132,15 +1132,15 @@ int qdev_prop_check_globals(void)
>          oc =3D object_class_by_name(prop->driver);
>          oc =3D object_class_dynamic_cast(oc, TYPE_DEVICE);
>          if (!oc) {
> -            error_report("Warning: global %s.%s has invalid class name",
> -                       prop->driver, prop->property);
> +            warn_report("global %s.%s has invalid class name",
> +                        prop->driver, prop->property);
>              ret =3D 1;
>              continue;
>          }
>          dc =3D DEVICE_CLASS(oc);
>          if (!dc->hotpluggable && !prop->used) {
> -            error_report("Warning: global %s.%s=3D%s not used",
> -                       prop->driver, prop->property, prop->value);
> +            warn_report("global %s.%s=3D%s not used",
> +                        prop->driver, prop->property, prop->value);
>              ret =3D 1;
>              continue;
>          }
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 5464977424..6b7bade183 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2766,17 +2766,17 @@ void acpi_build(AcpiBuildTables *tables, MachineS=
tate *machine)
>                       ACPI_BUILD_ALIGN_SIZE);
>          if (tables_blob->len > legacy_table_size) {
>              /* Should happen only with PCI bridges and -M pc-i440fx-2.0.=
  */
> -            error_report("Warning: migration may not work.");
> +            warn_report("migration may not work.");
>          }
>          g_array_set_size(tables_blob, legacy_table_size);
>      } else {
>          /* Make sure we have a buffer in case we need to resize the tabl=
es. */
>          if (tables_blob->len > ACPI_BUILD_TABLE_SIZE / 2) {
>              /* As of QEMU 2.1, this fires with 160 VCPUs and 255 memory =
slots.  */
> -            error_report("Warning: ACPI tables are larger than 64k.");
> -            error_report("Warning: migration may not work.");
> -            error_report("Warning: please remove CPUs, NUMA nodes, "
> -                         "memory slots or PCI bridges.");
> +            warn_report("ACPI tables are larger than 64k.");
> +            warn_report("migration may not work.");
> +            warn_report("please remove CPUs, NUMA nodes, "
> +                        "memory slots or PCI bridges.");
>          }
>          acpi_align_size(tables_blob, ACPI_BUILD_TABLE_SIZE);
>      }
> diff --git a/hw/i386/kvm/pci-assign.c b/hw/i386/kvm/pci-assign.c
> index 9f2615cbe0..33e20cb3e8 100644
> --- a/hw/i386/kvm/pci-assign.c
> +++ b/hw/i386/kvm/pci-assign.c
> @@ -1353,9 +1353,9 @@ static int assigned_device_pci_cap_init(PCIDevice *=
pci_dev, Error **errp)
>                             PCI_CAP_ID_EXP);
>                  return -EINVAL;
>              } else if (size !=3D 0x3c) {
> -                error_report("WARNING, %s: PCIe cap-id 0x%x has "
> -                             "non-standard size 0x%x; std size should be=
 0x3c",
> -                             __func__, PCI_CAP_ID_EXP, size);
> +                warn_report("%s: PCIe cap-id 0x%x has "
> +                            "non-standard size 0x%x; std size should be =
0x3c",
> +                            __func__, PCI_CAP_ID_EXP, size);
>              }
>          } else if (version =3D=3D 0) {
>              uint16_t vid, did;
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 224fe58fe7..58f8a4f4a5 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -381,8 +381,8 @@ ISADevice *pc_find_fdc0(void)
>      }
> =20
>      if (state.multiple) {
> -        error_report("warning: multiple floppy disk controllers with "
> -                     "iobase=3D0x3f0 have been found");
> +        warn_report("multiple floppy disk controllers with "
> +                    "iobase=3D0x3f0 have been found");
>          error_printf("the one being picked for CMOS setup might not refl=
ect "
>                       "your intent\n");
>      }
> @@ -1310,7 +1310,7 @@ void pc_acpi_init(const char *default_dsdt)
> =20
>      filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, default_dsdt);
>      if (filename =3D=3D NULL) {
> -        fprintf(stderr, "WARNING: failed to find %s\n", default_dsdt);
> +        warn_report("failed to find %s", default_dsdt);
>      } else {
>          QemuOpts *opts =3D qemu_opts_create(qemu_find_opts("acpi"), NULL=
, 0,
>                                            &error_abort);
> @@ -2087,9 +2087,9 @@ static void pc_machine_set_max_ram_below_4g(Object =
*obj, Visitor *v,
>      }
> =20
>      if (value < (1ULL << 20)) {
> -        error_report("Warning: small max_ram_below_4g(%"PRIu64
> -                     ") less than 1M.  BIOS may not work..",
> -                     value);
> +        warn_report("small max_ram_below_4g(%"PRIu64
> +                    ") less than 1M.  BIOS may not work..",
> +                    value);
>      }
> =20
>      pcms->max_ram_below_4g =3D value;
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 22dbef64c6..11b4336a42 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -131,10 +131,10 @@ static void pc_init1(MachineState *machine,
>                      lowmem =3D 0xc0000000;
>                  }
>                  if (lowmem & ((1ULL << 30) - 1)) {
> -                    error_report("Warning: Large machine and max_ram_bel=
ow_4g "
> -                                 "(%" PRIu64 ") not a multiple of 1G; "
> -                                 "possible bad performance.",
> -                                 pcms->max_ram_below_4g);
> +                    warn_report("Large machine and max_ram_below_4g "
> +                                "(%" PRIu64 ") not a multiple of 1G; "
> +                                "possible bad performance.",
> +                                pcms->max_ram_below_4g);
>                  }
>              }
>          }
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 8f696b7cb6..1653a47f0a 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -101,9 +101,9 @@ static void pc_q35_init(MachineState *machine)
>          lowmem =3D pcms->max_ram_below_4g;
>          if (machine->ram_size - lowmem > lowmem &&
>              lowmem & ((1ULL << 30) - 1)) {
> -            error_report("Warning: Large machine and max_ram_below_4g(%"=
PRIu64
> -                         ") not a multiple of 1G; possible bad performan=
ce.",
> -                         pcms->max_ram_below_4g);
> +            warn_report("Large machine and max_ram_below_4g(%"PRIu64
> +                        ") not a multiple of 1G; possible bad performanc=
e.",
> +                        pcms->max_ram_below_4g);
>          }
>      }
> =20
> diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
> index 5f3ac0b6f6..633fa4510e 100644
> --- a/hw/misc/aspeed_sdmc.c
> +++ b/hw/misc/aspeed_sdmc.c
> @@ -157,8 +157,8 @@ static int ast2400_rambits(AspeedSDMCState *s)
>      }
> =20
>      /* use a common default */
> -    error_report("warning: Invalid RAM size 0x%" PRIx64
> -                 ". Using default 256M", s->ram_size);
> +    warn_report("Invalid RAM size 0x%" PRIx64
> +                ". Using default 256M", s->ram_size);
>      s->ram_size =3D 256 << 20;
>      return ASPEED_SDMC_DRAM_256MB;
>  }
> @@ -179,8 +179,8 @@ static int ast2500_rambits(AspeedSDMCState *s)
>      }
> =20
>      /* use a common default */
> -    error_report("warning: Invalid RAM size 0x%" PRIx64
> -                 ". Using default 512M", s->ram_size);
> +    warn_report("Invalid RAM size 0x%" PRIx64
> +                ". Using default 512M", s->ram_size);
>      s->ram_size =3D 512 << 20;
>      return ASPEED_SDMC_AST2500_512MB;
>  }
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 99bdbc2233..e881e3b812 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -781,7 +781,7 @@ static int get_fw_cfg_order(FWCfgState *s, const char=
 *name)
>      }
> =20
>      /* Stick unknown stuff at the end. */
> -    error_report("warning: Unknown firmware file in legacy mode: %s", na=
me);
> +    warn_report("Unknown firmware file in legacy mode: %s", name);
>      return FW_CFG_ORDER_OVERRIDE_LAST;
>  }
> =20
> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
> index a2c1033dbe..072a04e318 100644
> --- a/hw/pci-host/piix.c
> +++ b/hw/pci-host/piix.c
> @@ -307,7 +307,7 @@ static void i440fx_realize(PCIDevice *dev, Error **er=
rp)
>      dev->config[I440FX_SMRAM] =3D 0x02;
> =20
>      if (object_property_get_bool(qdev_get_machine(), "iommu", NULL)) {
> -        error_report("warning: i440fx doesn't support emulated iommu");
> +        warn_report("i440fx doesn't support emulated iommu");
>      }
>  }
> =20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index a4cd733cba..47221158d4 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -160,13 +160,13 @@ static void powernv_create_core_node(PnvChip *chip,=
 PnvCore *pc, void *fdt)
>          _FDT((fdt_setprop_cell(fdt, offset, "d-cache-size",
>                                 pcc->l1_dcache_size)));
>      } else {
> -        error_report("Warning: Unknown L1 dcache size for cpu");
> +        warn_report("Unknown L1 dcache size for cpu");
>      }
>      if (pcc->l1_icache_size) {
>          _FDT((fdt_setprop_cell(fdt, offset, "i-cache-size",
>                                 pcc->l1_icache_size)));
>      } else {
> -        error_report("Warning: Unknown L1 icache size for cpu");
> +        warn_report("Unknown L1 icache size for cpu");
>      }
> =20
>      _FDT((fdt_setprop_cell(fdt, offset, "timebase-frequency", tbfreq)));
> @@ -556,7 +556,7 @@ static void ppc_powernv_init(MachineState *machine)
> =20
>      /* allocate RAM */
>      if (machine->ram_size < (1 * G_BYTE)) {
> -        error_report("Warning: skiboot may not work with < 1GB of RAM");
> +        warn_report("skiboot may not work with < 1GB of RAM");
>      }
> =20
>      ram =3D g_new(MemoryRegion, 1);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0ee9fac50b..fdd55d4820 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -534,13 +534,13 @@ static void spapr_populate_cpu_dt(CPUState *cs, voi=
d *fdt, int offset,
>          _FDT((fdt_setprop_cell(fdt, offset, "d-cache-size",
>                                 pcc->l1_dcache_size)));
>      } else {
> -        error_report("Warning: Unknown L1 dcache size for cpu");
> +        warn_report("Unknown L1 dcache size for cpu");
>      }
>      if (pcc->l1_icache_size) {
>          _FDT((fdt_setprop_cell(fdt, offset, "i-cache-size",
>                                 pcc->l1_icache_size)));
>      } else {
> -        error_report("Warning: Unknown L1 icache size for cpu");
> +        warn_report("Unknown L1 icache size for cpu");
>      }
> =20
>      _FDT((fdt_setprop_cell(fdt, offset, "timebase-frequency", tbfreq)));
> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> index 8656a54a3e..583afc1a46 100644
> --- a/hw/ppc/spapr_iommu.c
> +++ b/hw/ppc/spapr_iommu.c
> @@ -334,7 +334,7 @@ void spapr_tce_table_enable(sPAPRTCETable *tcet,
>                              uint32_t nb_table)
>  {
>      if (tcet->nb_table) {
> -        error_report("Warning: trying to enable already enabled TCE tabl=
e");
> +        warn_report("trying to enable already enabled TCE table");
>          return;
>      }
> =20
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index f5574469c8..23c51de66a 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -282,9 +282,9 @@ void scsi_bus_legacy_handle_cmdline(SCSIBus *bus, boo=
l deprecated)
>                  continue;       /* claimed */
>              }
>              if (!dinfo->is_default) {
> -                error_report("warning: bus=3D%d,unit=3D%d is deprecated =
with this"
> -                             " machine type",
> -                             bus->busnr, unit);
> +                warn_report("bus=3D%d,unit=3D%d is deprecated with this"
> +                            " machine type",
> +                            bus->busnr, unit);
>              }
>          }
>          scsi_bus_legacy_add_drive(bus, blk_by_legacy_dinfo(dinfo),
> diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
> index 49cb1829b5..bef1f03c42 100644
> --- a/hw/usb/dev-smartcard-reader.c
> +++ b/hw/usb/dev-smartcard-reader.c
> @@ -1314,12 +1314,12 @@ static int ccid_card_init(DeviceState *qdev)
>      int ret =3D 0;
> =20
>      if (card->slot !=3D 0) {
> -        error_report("Warning: usb-ccid supports one slot, can't add %d",
> -                card->slot);
> +        warn_report("usb-ccid supports one slot, can't add %d",
> +                    card->slot);
>          return -1;
>      }
>      if (s->card !=3D NULL) {
> -        error_report("Warning: usb-ccid card already full, not adding");
> +        warn_report("usb-ccid card already full, not adding");
>          return -1;
>      }
>      ret =3D ccid_card_initfn(card);
> diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
> index aa22d69216..5b65965cc2 100644
> --- a/hw/usb/redirect.c
> +++ b/hw/usb/redirect.c
> @@ -193,7 +193,7 @@ static void usbredir_handle_status(USBRedirDevice *de=
v, USBPacket *p,
>  #define WARNING(...) \
>      do { \
>          if (dev->debug >=3D usbredirparser_warning) { \
> -            error_report("usb-redir warning: " __VA_ARGS__); \
> +            warn_report("" __VA_ARGS__); \
>          } \
>      } while (0)
>  #define INFO(...) \
> diff --git a/net/tap-linux.c b/net/tap-linux.c
> index a503fa9c6e..535b1ddb61 100644
> --- a/net/tap-linux.c
> +++ b/net/tap-linux.c
> @@ -55,7 +55,7 @@ int tap_open(char *ifname, int ifname_size, int *vnet_h=
dr,
>      ifr.ifr_flags =3D IFF_TAP | IFF_NO_PI;
> =20
>      if (ioctl(fd, TUNGETFEATURES, &features) =3D=3D -1) {
> -        error_report("warning: TUNGETFEATURES failed: %s", strerror(errn=
o));
> +        warn_report("TUNGETFEATURES failed: %s", strerror(errno));
>          features =3D 0;
>      }
> =20
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index c57177278b..da942d91c7 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2060,15 +2060,15 @@ static void x86_cpu_parse_featurestr(const char *=
typename, char *features,
>          name =3D featurestr;
> =20
>          if (g_list_find_custom(plus_features, name, compare_string)) {
> -            error_report("warning: Ambiguous CPU model string. "
> -                         "Don't mix both \"+%s\" and \"%s=3D%s\"",
> -                         name, name, val);
> +            warn_report("Ambiguous CPU model string. "
> +                        "Don't mix both \"+%s\" and \"%s=3D%s\"",
> +                        name, name, val);
>              ambiguous =3D true;
>          }
>          if (g_list_find_custom(minus_features, name, compare_string)) {
> -            error_report("warning: Ambiguous CPU model string. "
> -                         "Don't mix both \"-%s\" and \"%s=3D%s\"",
> -                         name, name, val);
> +            warn_report("Ambiguous CPU model string. "
> +                        "Don't mix both \"-%s\" and \"%s=3D%s\"",
> +                        name, name, val);
>              ambiguous =3D true;
>          }
> =20
> @@ -2096,8 +2096,8 @@ static void x86_cpu_parse_featurestr(const char *ty=
pename, char *features,
>      }
> =20
>      if (ambiguous) {
> -        error_report("warning: Compatibility of ambiguous CPU model "
> -                     "strings won't be kept on future QEMU versions");
> +        warn_report("Compatibility of ambiguous CPU model "
> +                    "strings won't be kept on future QEMU versions");
>      }
>  }
> =20
> @@ -3547,9 +3547,9 @@ static void x86_cpu_realizefn(DeviceState *dev, Err=
or **errp)
>               */
>              if (cpu->phys_bits !=3D host_phys_bits && cpu->phys_bits !=
=3D 0 &&
>                  !warned) {
> -                error_report("Warning: Host physical bits (%u)"
> -                                 " does not match phys-bits property (%u=
)",
> -                                 host_phys_bits, cpu->phys_bits);
> +                warn_report("Host physical bits (%u)"
> +                            " does not match phys-bits property (%u)",
> +                            host_phys_bits, cpu->phys_bits);
>                  warned =3D true;
>              }
> =20
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index f84a49d366..3b29f5a758 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -600,10 +600,10 @@ static int kvm_arch_set_tsc_khz(CPUState *cs)
>                         kvm_vcpu_ioctl(cs, KVM_GET_TSC_KHZ) :
>                         -ENOTSUP;
>          if (cur_freq <=3D 0 || cur_freq !=3D env->tsc_khz) {
> -            error_report("warning: TSC frequency mismatch between "
> -                         "VM (%" PRId64 " kHz) and host (%d kHz), "
> -                         "and TSC scaling unavailable",
> -                         env->tsc_khz, cur_freq);
> +            warn_report("TSC frequency mismatch between "
> +                        "VM (%" PRId64 " kHz) and host (%d kHz), "
> +                        "and TSC scaling unavailable",
> +                        env->tsc_khz, cur_freq);
>              return r;
>          }
>      }
> @@ -919,7 +919,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>                  error_report("kvm: LMCE not supported");
>                  return -ENOTSUP;
>              }
> -            error_report("warning: Unsupported MCG_CAP bits: 0x%" PRIx64,
> +            warn_report(" Unsupported MCG_CAP bits: 0x%" PRIx64,
>                           unsupported_caps);
>          }
> =20
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 7cb55dc7e3..f56d57b8c2 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -677,9 +677,9 @@ static void check_consistency(const S390CPUModel *mod=
el)
>      for (i =3D 0; i < ARRAY_SIZE(dep); i++) {
>          if (test_bit(dep[i][0], model->features) &&
>              !test_bit(dep[i][1], model->features)) {
> -            error_report("Warning: \'%s\' requires \'%s\'.",
> -                         s390_feat_def(dep[i][0])->name,
> -                         s390_feat_def(dep[i][1])->name);
> +            warn_report("\'%s\' requires \'%s\'.",
> +                        s390_feat_def(dep[i][0])->name,
> +                        s390_feat_def(dep[i][1])->name);
>          }
>      }
>  }
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index a3d00196f4..271bd6581f 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -2675,8 +2675,8 @@ void kvm_s390_apply_cpu_model(const S390CPUModel *m=
odel, Error **errp)
>      /* enable CMM via CMMA - disable on hugetlbfs */
>      if (test_bit(S390_FEAT_CMM, model->features)) {
>          if (mem_path) {
> -            error_report("Warning: CMM will not be enabled because it is=
 not "
> -                         "compatible to hugetlbfs.");
> +            warn_report("CMM will not be enabled because it is not "
> +                        "compatible to hugetlbfs.");
>          } else {
>              kvm_s390_enable_cmma();
>          }
> diff --git a/tests/test-qdev-global-props.c b/tests/test-qdev-global-prop=
s.c
> index 48e5b7315f..b25fe892ed 100644
> --- a/tests/test-qdev-global-props.c
> +++ b/tests/test-qdev-global-props.c
> @@ -232,10 +232,10 @@ static void test_dynamic_globalprop(void)
>      g_test_trap_assert_passed();
>      g_test_trap_assert_stderr_unmatched("*prop1*");
>      g_test_trap_assert_stderr_unmatched("*prop2*");
> -    g_test_trap_assert_stderr("*Warning: global dynamic-prop-type-bad.pr=
op3 has invalid class name\n*");
> +    g_test_trap_assert_stderr("*warning: global dynamic-prop-type-bad.pr=
op3 has invalid class name\n*");
>      g_test_trap_assert_stderr_unmatched("*prop4*");
> -    g_test_trap_assert_stderr("*Warning: global nohotplug-type.prop5=3D1=
05 not used\n*");
> -    g_test_trap_assert_stderr("*Warning: global nondevice-type.prop6 has=
 invalid class name\n*");
> +    g_test_trap_assert_stderr("*warning: global nohotplug-type.prop5=3D1=
05 not used\n*");
> +    g_test_trap_assert_stderr("*warning: global nondevice-type.prop6 has=
 invalid class name\n*");
>      g_test_trap_assert_stdout("");
>  }
> =20
> diff --git a/trace/control.c b/trace/control.c
> index 9b157b0ca7..f5fb11d280 100644
> --- a/trace/control.c
> +++ b/trace/control.c
> @@ -171,8 +171,8 @@ static void do_trace_enable_events(const char *line_b=
uf)
>      while ((ev =3D trace_event_iter_next(&iter)) !=3D NULL) {
>          if (!trace_event_get_state_static(ev)) {
>              if (!is_pattern) {
> -                error_report("WARNING: trace event '%s' is not traceable=
",
> -                             line_ptr);
> +                warn_report("trace event '%s' is not traceable",
> +                            line_ptr);
>                  return;
>              }
>              continue;
> @@ -186,8 +186,8 @@ static void do_trace_enable_events(const char *line_b=
uf)
>      }
> =20
>      if (!is_pattern) {
> -        error_report("WARNING: trace event '%s' does not exist",
> -                     line_ptr);
> +        warn_report("trace event '%s' does not exist",
> +                    line_ptr);
>      }
>  }
> =20
> diff --git a/vl.c b/vl.c
> index d17c863409..d5342fe816 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -952,8 +952,8 @@ static void bt_vhci_add(int vlan_id)
>      struct bt_scatternet_s *vlan =3D qemu_find_bt_vlan(vlan_id);
> =20
>      if (!vlan->slave)
> -        error_report("warning: adding a VHCI to an empty scatternet %i",
> -                     vlan_id);
> +        warn_report("adding a VHCI to an empty scatternet %i",
> +                    vlan_id);
> =20
>      bt_vhci_init(bt_new_hci(vlan));
>  }
> @@ -979,8 +979,8 @@ static struct bt_device_s *bt_device_add(const char *=
opt)
>      vlan =3D qemu_find_bt_vlan(vlan_id);
> =20
>      if (!vlan->slave)
> -        error_report("warning: adding a slave device to an empty scatter=
net %i",
> -                     vlan_id);
> +        warn_report("adding a slave device to an empty scatternet %i",
> +                    vlan_id);
> =20
>      if (!strcmp(devname, "keyboard"))
>          return bt_keyboard_init(vlan);
> @@ -2302,8 +2302,8 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opt=
s, Error **errp)
>          return -1;
>      }
>      if (strncmp(name, "opt/", 4) !=3D 0) {
> -        error_report("warning: externally provided fw_cfg item names "
> -                     "should be prefixed with \"opt/\"");
> +        warn_report("externally provided fw_cfg item names "
> +                    "should be prefixed with \"opt/\"");
>      }
>      if (nonempty_str(str)) {
>          size =3D strlen(str); /* NUL terminator NOT included in fw_cfg b=
lob */
> @@ -3760,7 +3760,7 @@ int main(int argc, char **argv, char **envp)
>                  qemu_opts_parse_noisily(olist, "accel=3Dtcg", false);
>                  break;
>              case QEMU_OPTION_no_kvm_pit: {
> -                error_report("warning: ignoring deprecated option");
> +                warn_report("ignoring deprecated option");
>                  break;
>              }
>              case QEMU_OPTION_no_kvm_pit_reinjection: {
> @@ -3770,8 +3770,8 @@ int main(int argc, char **argv, char **envp)
>                      .value    =3D "discard",
>                  };
> =20
> -                error_report("warning: deprecated, replaced by "
> -                             "-global kvm-pit.lost_tick_policy=3Ddiscard=
");
> +                warn_report("deprecated, replaced by "
> +                            "-global kvm-pit.lost_tick_policy=3Ddiscard"=
);
>                  qdev_prop_register_global(&kvm_pit_lost_tick_policy);
>                  break;
>              }
> @@ -3896,7 +3896,7 @@ int main(int argc, char **argv, char **envp)
>                  }
>                  break;
>              case QEMU_OPTION_tdf:
> -                error_report("warning: ignoring deprecated option");
> +                warn_report("ignoring deprecated option");
>                  break;
>              case QEMU_OPTION_name:
>                  opts =3D qemu_opts_parse_noisily(qemu_find_opts("name"),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RpDyejMaDGJhP2PU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZXt8uAAoJEGw4ysog2bOSfikP/2Rm0tFG6n+F5DG77ZfJk/pf
J6vs8V6BQYM69/PIS8X488lYB7nWHaBbWi8rfJx1VWkJPst4XuytEXQiUnofy1Pq
hXpZN0mj+t7WAoMH/FfremOm+r/pccIJmhoe9/Oryn968i86rQiuiXsr6FZ2ALyq
SxRkoz0nVQM7qT0KWaEU+CZSQV5m892DEg6DNVCpphrI1g0+u41Ojaf8KN4QZH4s
bqyOXMfYJxZLsRyVLjI1T3CXMfDagT6y1utPsHTuFh582H7E6NbomzubLSWppTi1
SHr6CBGJ5+cdlmsnjvbGxkffhDTiuGJfQiU0z+K1hr6g47TxABzZznkfMZMddHoe
y5+OExEfdWzDTX7hripECT8tSiBXxj1fypkdu+HYMvqvxssm9A8cndxerpLgrtXj
RTbWNBXqOWhuatoKbxjr+tg0B9lqAK8JSwy0Mj9PgQj+9KHgpiDQjgahvxTMCDxc
wnnB5m3OrrF6xqaZegnrJvA+8wZp3xAgctO3VSGAG6fL6zOBdFJq7rp3rsNZ5fW3
6B6Rr1MaZ/S/vCtFVLYEEZB8tEVKkOmiQVi9i/kBRZfcBkbmZkcBt2NA8x83YlrC
6Yl9Slk1zq84RrRuL3vrEqbLrksNjoe2eyv251QdRfe0GBMM/4qj88Ly2rzN4p4A
nemkJUTU7SKoJ2+6tbC0
=CoRX
-----END PGP SIGNATURE-----

--RpDyejMaDGJhP2PU--

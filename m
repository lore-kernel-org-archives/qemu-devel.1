Received: from eggs.gnu.org ([2001:4830:134:3::10]:35658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e5LaZ-0004jx-4T
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 20:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e5LaW-00029k-RZ
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 20:55:02 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:43203)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1e5LaW-00028d-4F
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 20:55:00 -0400
Date: Fri, 20 Oct 2017 10:50:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171019235055.GD13245@umbus>
References: <cover.1508390588.git.alistair.francis@xilinx.com>
	<5d68af196a5b6386f66e6461d1c65b6a935b6ea0.1508390588.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BI5RvnYi6R4T2M87"
Content-Disposition: inline
In-Reply-To: <5d68af196a5b6386f66e6461d1c65b6a935b6ea0.1508390588.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH v3 33/46] hw/scsi: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, armbru@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>


--BI5RvnYi6R4T2M87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2017 at 09:17:40AM -0700, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
>=20
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|erro=
r_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_=
report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_repo=
rt("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report=
("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("=
\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1=
"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\=
2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2)=
;|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|=
Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig=
}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}'=
 \
>     {} +
>=20
> Some lines where then manually tweaked to pass checkpatch.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alexander Graf <agraf@suse.de>
> ---
> V2:
>  - Split hw patch into individual directories
>=20
>  hw/scsi/lsi53c895a.c            |  4 ++--
>  hw/scsi/spapr_vscsi.c           | 49 +++++++++++++++++++++--------------=
------
>  hw/scsi/virtio-scsi-dataplane.c |  6 ++---
>  3 files changed, 30 insertions(+), 29 deletions(-)

virtio_scsi part

Acked-by: David Gibson <david@gibson.dropbear.id.au>

>=20
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index 191505df5b..7c9a930e2f 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -14,7 +14,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> -
> +#include "qemu/error-report.h"
>  #include "hw/hw.h"
>  #include "hw/pci/pci.h"
>  #include "hw/scsi/scsi.h"
> @@ -1501,7 +1501,7 @@ again:
>             This is apparently sufficient to beat the drivers into submis=
sion.
>           */
>          if (!(s->sien0 & LSI_SIST0_UDC))
> -            fprintf(stderr, "inf. loop with UDC masked\n");
> +            error_report("inf. loop with UDC masked");
>          lsi_script_scsi_interrupt(s, LSI_SIST0_UDC, 0);
>          lsi_disconnect(s);
>      } else if (s->istat1 & LSI_ISTAT1_SRUN && !s->waiting) {
> diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
> index 360db53ac8..8c4eabcf3d 100644
> --- a/hw/scsi/spapr_vscsi.c
> +++ b/hw/scsi/spapr_vscsi.c
> @@ -32,6 +32,7 @@
>   *  - Maybe do autosense (PAPR seems to mandate it, linux doesn't care)
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "qemu-common.h"
>  #include "cpu.h"
>  #include "hw/hw.h"
> @@ -179,7 +180,7 @@ static int vscsi_send_iu(VSCSIState *s, vscsi_req *re=
q,
>      rc =3D spapr_vio_dma_write(&s->vdev, req->crq.s.IU_data_ptr,
>                               &req->iu, length);
>      if (rc) {
> -        fprintf(stderr, "vscsi_send_iu: DMA write failure !\n");
> +        error_report("vscsi_send_iu: DMA write failure !");
>      }
> =20
>      req->crq.s.valid =3D 0x80;
> @@ -197,7 +198,7 @@ static int vscsi_send_iu(VSCSIState *s, vscsi_req *re=
q,
> =20
>      rc1 =3D spapr_vio_send_crq(&s->vdev, req->crq.raw);
>      if (rc1) {
> -        fprintf(stderr, "vscsi_send_iu: Error sending response\n");
> +        error_report("vscsi_send_iu: Error sending response");
>          return rc1;
>      }
> =20
> @@ -330,7 +331,7 @@ static int vscsi_fetch_desc(VSCSIState *s, struct vsc=
si_req *req,
>          break;
>      }
>      default:
> -        fprintf(stderr, "VSCSI:   Unknown format %x\n", req->dma_fmt);
> +        error_report("VSCSI:   Unknown format %x", req->dma_fmt);
>          return -1;
>      }
> =20
> @@ -518,7 +519,7 @@ static void vscsi_transfer_data(SCSIRequest *sreq, ui=
nt32_t len)
> =20
>      trace_spapr_vscsi_transfer_data(sreq->tag, len, req);
>      if (req =3D=3D NULL) {
> -        fprintf(stderr, "VSCSI: Can't find request for tag 0x%x\n", sreq=
->tag);
> +        error_report("VSCSI: Can't find request for tag 0x%x", sreq->tag=
);
>          return;
>      }
> =20
> @@ -527,7 +528,7 @@ static void vscsi_transfer_data(SCSIRequest *sreq, ui=
nt32_t len)
>          rc =3D vscsi_srp_transfer_data(s, req, req->writing, buf, len);
>      }
>      if (rc < 0) {
> -        fprintf(stderr, "VSCSI: RDMA error rc=3D%d!\n", rc);
> +        error_report("VSCSI: RDMA error rc=3D%d!", rc);
>          req->dma_error =3D true;
>          scsi_req_cancel(req->sreq);
>          return;
> @@ -547,7 +548,7 @@ static void vscsi_command_complete(SCSIRequest *sreq,=
 uint32_t status, size_t re
> =20
>      trace_spapr_vscsi_command_complete(sreq->tag, status, req);
>      if (req =3D=3D NULL) {
> -        fprintf(stderr, "VSCSI: Can't find request for tag 0x%x\n", sreq=
->tag);
> +        error_report("VSCSI: Can't find request for tag 0x%x", sreq->tag=
);
>          return;
>      }
> =20
> @@ -639,7 +640,7 @@ static void *vscsi_load_request(QEMUFile *f, SCSIRequ=
est *sreq)
>      memset(req, 0, sizeof(*req));
>      rc =3D vmstate_load_state(f, &vmstate_spapr_vscsi_req, req, 1);
>      if (rc) {
> -        fprintf(stderr, "VSCSI: failed loading request tag#%u\n", sreq->=
tag);
> +        error_report("VSCSI: failed loading request tag#%u", sreq->tag);
>          return NULL;
>      }
>      assert(req->active);
> @@ -827,7 +828,7 @@ static int vscsi_process_tsk_mgmt(VSCSIState *s, vscs=
i_req *req)
>      uint64_t tag =3D iu->srp.rsp.tag;
>      uint8_t sol_not =3D iu->srp.cmd.sol_not;
> =20
> -    fprintf(stderr, "vscsi_process_tsk_mgmt %02x\n",
> +    error_report("vscsi_process_tsk_mgmt %02x",
>              iu->srp.tsk_mgmt.tsk_mgmt_func);
> =20
>      d =3D vscsi_device_find(&s->bus, be64_to_cpu(req->iu.srp.tsk_mgmt.lu=
n), &lun);
> @@ -932,10 +933,10 @@ static int vscsi_handle_srp_req(VSCSIState *s, vscs=
i_req *req)
>      case SRP_CRED_RSP:
>      case SRP_AER_REQ:
>      case SRP_AER_RSP:
> -        fprintf(stderr, "VSCSI: Unsupported opcode %02x\n", opcode);
> +        error_report("VSCSI: Unsupported opcode %02x", opcode);
>          break;
>      default:
> -        fprintf(stderr, "VSCSI: Unknown type %02x\n", opcode);
> +        error_report("VSCSI: Unknown type %02x", opcode);
>      }
> =20
>      return done;
> @@ -953,7 +954,7 @@ static int vscsi_send_adapter_info(VSCSIState *s, vsc=
si_req *req)
>      rc =3D spapr_vio_dma_read(&s->vdev, be64_to_cpu(sinfo->buffer),
>                              &info, be16_to_cpu(sinfo->common.length));
>      if (rc) {
> -        fprintf(stderr, "vscsi_send_adapter_info: DMA read failure !\n");
> +        error_report("vscsi_send_adapter_info: DMA read failure !");
>      }
>  #endif
>      memset(&info, 0, sizeof(info));
> @@ -967,7 +968,7 @@ static int vscsi_send_adapter_info(VSCSIState *s, vsc=
si_req *req)
>      rc =3D spapr_vio_dma_write(&s->vdev, be64_to_cpu(sinfo->buffer),
>                               &info, be16_to_cpu(sinfo->common.length));
>      if (rc)  {
> -        fprintf(stderr, "vscsi_send_adapter_info: DMA write failure !\n"=
);
> +        error_report("vscsi_send_adapter_info: DMA write failure !");
>      }
> =20
>      sinfo->common.status =3D rc ? cpu_to_be32(1) : 0;
> @@ -987,7 +988,7 @@ static int vscsi_send_capabilities(VSCSIState *s, vsc=
si_req *req)
>      req_len =3D len =3D be16_to_cpu(vcap->common.length);
>      buffer =3D be64_to_cpu(vcap->buffer);
>      if (len > sizeof(cap)) {
> -        fprintf(stderr, "vscsi_send_capabilities: capabilities size mism=
atch !\n");
> +        error_report("vscsi_send_capabilities: capabilities size mismatc=
h !");
> =20
>          /*
>           * Just read and populate the structure that is known.
> @@ -997,7 +998,7 @@ static int vscsi_send_capabilities(VSCSIState *s, vsc=
si_req *req)
>      }
>      rc =3D spapr_vio_dma_read(&s->vdev, buffer, &cap, len);
>      if (rc)  {
> -        fprintf(stderr, "vscsi_send_capabilities: DMA read failure !\n");
> +        error_report("vscsi_send_capabilities: DMA read failure !");
>      }
> =20
>      /*
> @@ -1013,7 +1014,7 @@ static int vscsi_send_capabilities(VSCSIState *s, v=
scsi_req *req)
> =20
>      rc =3D spapr_vio_dma_write(&s->vdev, buffer, &cap, len);
>      if (rc)  {
> -        fprintf(stderr, "vscsi_send_capabilities: DMA write failure !\n"=
);
> +        error_report("vscsi_send_capabilities: DMA write failure !");
>      }
>      if (req_len > len) {
>          /*
> @@ -1034,11 +1035,11 @@ static int vscsi_handle_mad_req(VSCSIState *s, vs=
csi_req *req)
> =20
>      switch (be32_to_cpu(mad->empty_iu.common.type)) {
>      case VIOSRP_EMPTY_IU_TYPE:
> -        fprintf(stderr, "Unsupported EMPTY MAD IU\n");
> +        error_report("Unsupported EMPTY MAD IU");
>          retlen =3D sizeof(mad->empty_iu);
>          break;
>      case VIOSRP_ERROR_LOG_TYPE:
> -        fprintf(stderr, "Unsupported ERROR LOG MAD IU\n");
> +        error_report("Unsupported ERROR LOG MAD IU");
>          retlen =3D sizeof(mad->error_log);
>          break;
>      case VIOSRP_ADAPTER_INFO_TYPE:
> @@ -1053,7 +1054,7 @@ static int vscsi_handle_mad_req(VSCSIState *s, vscs=
i_req *req)
>          request_handled =3D true;
>          break;
>      default:
> -        fprintf(stderr, "VSCSI: Unknown MAD type %02x\n",
> +        error_report("VSCSI: Unknown MAD type %02x",
>                  be32_to_cpu(mad->empty_iu.common.type));
>          /*
>           * PAPR+ says that "The length field is set to the length
> @@ -1078,7 +1079,7 @@ static void vscsi_got_payload(VSCSIState *s, vscsi_=
crq *crq)
> =20
>      req =3D vscsi_get_req(s);
>      if (req =3D=3D NULL) {
> -        fprintf(stderr, "VSCSI: Failed to get a request !\n");
> +        error_report("VSCSI: Failed to get a request !");
>          return;
>      }
> =20
> @@ -1088,7 +1089,7 @@ static void vscsi_got_payload(VSCSIState *s, vscsi_=
crq *crq)
>       * of the structure.
>       */
>      if (crq->s.IU_length > sizeof(union viosrp_iu)) {
> -        fprintf(stderr, "VSCSI: SRP IU too long (%d bytes) !\n",
> +        error_report("VSCSI: SRP IU too long (%d bytes) !",
>                  crq->s.IU_length);
>          vscsi_put_req(req);
>          return;
> @@ -1097,7 +1098,7 @@ static void vscsi_got_payload(VSCSIState *s, vscsi_=
crq *crq)
>      /* XXX Handle failure differently ? */
>      if (spapr_vio_dma_read(&s->vdev, crq->s.IU_data_ptr, &req->iu,
>                             crq->s.IU_length)) {
> -        fprintf(stderr, "vscsi_got_payload: DMA read failure !\n");
> +        error_report("vscsi_got_payload: DMA read failure !");
>          vscsi_put_req(req);
>          return;
>      }
> @@ -1158,16 +1159,16 @@ static int vscsi_do_crq(struct VIOsPAPRDevice *de=
v, uint8_t *crq_data)
>          case VIOSRP_AIX_FORMAT:
>          case VIOSRP_LINUX_FORMAT:
>          case VIOSRP_INLINE_FORMAT:
> -            fprintf(stderr, "vscsi_do_srq: Unsupported payload format %0=
2x\n",
> +            error_report("vscsi_do_srq: Unsupported payload format %02x",
>                      crq.s.format);
>              break;
>          default:
> -            fprintf(stderr, "vscsi_do_srq: Unknown payload format %02x\n=
",
> +            error_report("vscsi_do_srq: Unknown payload format %02x",
>                      crq.s.format);
>          }
>          break;
>      default:
> -        fprintf(stderr, "vscsi_do_crq: unknown CRQ %02x %02x ...\n",
> +        error_report("vscsi_do_crq: unknown CRQ %02x %02x ...",
>                  crq.raw[0], crq.raw[1]);
>      };
> =20
> diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-datapl=
ane.c
> index add4b3f4a4..e047361310 100644
> --- a/hw/scsi/virtio-scsi-dataplane.c
> +++ b/hw/scsi/virtio-scsi-dataplane.c
> @@ -97,7 +97,7 @@ static int virtio_scsi_vring_init(VirtIOSCSI *s, VirtQu=
eue *vq, int n,
>      /* Set up virtqueue notify */
>      rc =3D virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), n, true);
>      if (rc !=3D 0) {
> -        fprintf(stderr, "virtio-scsi: Failed to set host notifier (%d)\n=
",
> +        error_report("virtio-scsi: Failed to set host notifier (%d)",
>                  rc);
>          s->dataplane_fenced =3D true;
>          return rc;
> @@ -141,8 +141,8 @@ int virtio_scsi_dataplane_start(VirtIODevice *vdev)
>      /* Set up guest notifier (irq) */
>      rc =3D k->set_guest_notifiers(qbus->parent, vs->conf.num_queues + 2,=
 true);
>      if (rc !=3D 0) {
> -        fprintf(stderr, "virtio-scsi: Failed to set guest notifiers (%d)=
, "
> -                "ensure -enable-kvm is set\n", rc);
> +        error_report("virtio-scsi: Failed to set guest notifiers (%d), "
> +                "ensure -enable-kvm is set", rc);
>          goto fail_guest_notifiers;
>      }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BI5RvnYi6R4T2M87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnpOl0ACgkQbDjKyiDZ
s5La/xAAlfoHUds5i/05RiU8sFs6jxNqDCrsniflCr5SPw21twVVyoS5MA5yM3Nj
79DbnDCIQ9Zc9Dg295dR48r8ez/ry4F3Pcl8uruW3PwX8ScwQ8VL+MhUqrNPAgEV
KM/h54KbhTAFqs3/r944QLPx8yfC1nJlI09Cm1b+teyA/vkGacpr2y3MeOr6ogWq
mFnNBRe2dmRoi9YpdUeVEXPreTcINTfTjOPy087yHp4wtnwUbYfZ6fDIGf3VWQ4c
GR/TrNXTyIyWwTVajtb8u5WaGiWkKSCdbAO3hdfpzv9XZZ49GpGt4L3UGXzI1KX0
4l4vQluu8DOQ+CBeyYa/EPMMJ8J0Kp+ejbGV3qEAfgQpCfTlhNg5DOy5hkjoJRVq
cqlxWMdq4K91B+YJzfTCXHuN7cdBJCyEbsGdTSXQ5/q0ebubdCONBHOiO/2KLL4B
jccFozzKtbK1FlopxlDtJ/6SoJP5Ugj8xqoqbszelxJWB0MStqQfLmPYrkq87d1g
ijpz9t6MzopX/LNjeRZ5u3Rwr57Wc4qY12Q7KYUwpdO1w7mDiWvyzL/ylNrms7jQ
eij886PspAxaEoeuYuj6MKxCFoFcXB4al9bWKuUyuyEp6Ay2vKrUNOV55rINsFOv
ZUvYC8+W6W/MLFEmP81tz7Qlbwg9j0jev7oqCgVTU5t926hshX4=
=uvr4
-----END PGP SIGNATURE-----

--BI5RvnYi6R4T2M87--

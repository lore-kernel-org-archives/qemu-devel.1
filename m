Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8681FC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 01:46:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55F1D20828
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 01:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hU3WGyzM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F1D20828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9faT-0005SF-J2
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 20:46:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45883)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j9fXz-0000NG-W1
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 20:43:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j9fXy-0006oA-EP
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 20:43:35 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:35747)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j9fXx-0006k7-EW; Wed, 04 Mar 2020 20:43:34 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48XtnF42Plz9sSM; Thu,  5 Mar 2020 12:43:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1583372609;
 bh=eIwB4lok6oOuG1riE75swfTEU80fm36Idoblllst06g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hU3WGyzMI9YbFPEmWvegM2mFYOGwhsTSwQB569kI1wVgVyxw5YArv5/IOgHYxtnox
 1D6RH0cgeHRKk+C6plpb80Dm0w2LaeVBwty6rMxxecuDVTx89kBbShk7xQm598CSIJ
 vgMb/9Dx9Q/LCk/fMqYuO0C/pUAdtIFMtjznvPOA=
Date: Thu, 5 Mar 2020 11:41:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 4/5] hw/scsi/spapr_vscsi: Introduce req_ui() helper
Message-ID: <20200305004137.GJ593957@umbus.fritz.box>
References: <20200304153311.22959-1-philmd@redhat.com>
 <20200304153311.22959-5-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="poJSiGMzRSvrLGLs"
Content-Disposition: inline
In-Reply-To: <20200304153311.22959-5-philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--poJSiGMzRSvrLGLs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2020 at 04:33:10PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Introduce the req_ui() helper which returns a pointer to
> the viosrp_iu union held in the vscsi_req structure.
> This simplifies the next patch.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  hw/scsi/spapr_vscsi.c | 40 ++++++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
>=20
> diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
> index 3cb5a38181..f1a0bbdc31 100644
> --- a/hw/scsi/spapr_vscsi.c
> +++ b/hw/scsi/spapr_vscsi.c
> @@ -97,6 +97,12 @@ typedef struct {
>      vscsi_req reqs[VSCSI_REQ_LIMIT];
>  } VSCSIState;
> =20
> +static union viosrp_iu *req_iu(vscsi_req *req)
> +{
> +    return (union viosrp_iu *)req->iu.srp.reserved;

I guess it doesn't really matter since you remove it in the next
patch, but this seems a really weird way of expressing
	return &req->iu;

> +}
> +
> +
>  static struct vscsi_req *vscsi_get_req(VSCSIState *s)
>  {
>      vscsi_req *req;
> @@ -121,7 +127,7 @@ static struct vscsi_req *vscsi_find_req(VSCSIState *s=
, uint64_t srp_tag)
> =20
>      for (i =3D 0; i < VSCSI_REQ_LIMIT; i++) {
>          req =3D &s->reqs[i];
> -        if (req->iu.srp.cmd.tag =3D=3D srp_tag) {
> +        if (req_iu(req)->srp.cmd.tag =3D=3D srp_tag) {
>              return req;
>          }
>      }
> @@ -188,7 +194,7 @@ static int vscsi_send_iu(VSCSIState *s, vscsi_req *re=
q,
>      req->crq.s.reserved =3D 0x00;
>      req->crq.s.timeout =3D cpu_to_be16(0x0000);
>      req->crq.s.IU_length =3D cpu_to_be16(length);
> -    req->crq.s.IU_data_ptr =3D req->iu.srp.rsp.tag; /* right byte order =
*/
> +    req->crq.s.IU_data_ptr =3D req_iu(req)->srp.rsp.tag; /* right byte o=
rder */
> =20
>      if (rc =3D=3D 0) {
>          req->crq.s.status =3D VIOSRP_OK;
> @@ -224,7 +230,7 @@ static void vscsi_makeup_sense(VSCSIState *s, vscsi_r=
eq *req,
>  static int vscsi_send_rsp(VSCSIState *s, vscsi_req *req,
>                            uint8_t status, int32_t res_in, int32_t res_ou=
t)
>  {
> -    union viosrp_iu *iu =3D &req->iu;
> +    union viosrp_iu *iu =3D req_iu(req);
>      uint64_t tag =3D iu->srp.rsp.tag;
>      int total_len =3D sizeof(iu->srp.rsp);
>      uint8_t sol_not =3D iu->srp.cmd.sol_not;
> @@ -285,7 +291,7 @@ static int vscsi_fetch_desc(VSCSIState *s, struct vsc=
si_req *req,
>                              unsigned n, unsigned buf_offset,
>                              struct srp_direct_buf *ret)
>  {
> -    struct srp_cmd *cmd =3D &req->iu.srp.cmd;
> +    struct srp_cmd *cmd =3D &req_iu(req)->srp.cmd;
> =20
>      switch (req->dma_fmt) {
>      case SRP_NO_DATA_DESC: {
> @@ -473,7 +479,7 @@ static int data_out_desc_size(struct srp_cmd *cmd)
> =20
>  static int vscsi_preprocess_desc(vscsi_req *req)
>  {
> -    struct srp_cmd *cmd =3D &req->iu.srp.cmd;
> +    struct srp_cmd *cmd =3D &req_iu(req)->srp.cmd;
> =20
>      req->cdb_offset =3D cmd->add_cdb_len & ~3;
> =20
> @@ -655,7 +661,7 @@ static void *vscsi_load_request(QEMUFile *f, SCSIRequ=
est *sreq)
> =20
>  static void vscsi_process_login(VSCSIState *s, vscsi_req *req)
>  {
> -    union viosrp_iu *iu =3D &req->iu;
> +    union viosrp_iu *iu =3D req_iu(req);
>      struct srp_login_rsp *rsp =3D &iu->srp.login_rsp;
>      uint64_t tag =3D iu->srp.rsp.tag;
> =20
> @@ -681,7 +687,7 @@ static void vscsi_process_login(VSCSIState *s, vscsi_=
req *req)
> =20
>  static void vscsi_inquiry_no_target(VSCSIState *s, vscsi_req *req)
>  {
> -    uint8_t *cdb =3D req->iu.srp.cmd.cdb;
> +    uint8_t *cdb =3D req_iu(req)->srp.cmd.cdb;
>      uint8_t resp_data[36];
>      int rc, len, alen;
> =20
> @@ -770,7 +776,7 @@ static void vscsi_report_luns(VSCSIState *s, vscsi_re=
q *req)
> =20
>  static int vscsi_queue_cmd(VSCSIState *s, vscsi_req *req)
>  {
> -    union srp_iu *srp =3D &req->iu.srp;
> +    union srp_iu *srp =3D &req_iu(req)->srp;
>      SCSIDevice *sdev;
>      int n, lun;
> =20
> @@ -821,7 +827,7 @@ static int vscsi_queue_cmd(VSCSIState *s, vscsi_req *=
req)
> =20
>  static int vscsi_process_tsk_mgmt(VSCSIState *s, vscsi_req *req)
>  {
> -    union viosrp_iu *iu =3D &req->iu;
> +    union viosrp_iu *iu =3D req_iu(req);
>      vscsi_req *tmpreq;
>      int i, lun =3D 0, resp =3D SRP_TSK_MGMT_COMPLETE;
>      SCSIDevice *d;
> @@ -831,7 +837,8 @@ static int vscsi_process_tsk_mgmt(VSCSIState *s, vscs=
i_req *req)
>      fprintf(stderr, "vscsi_process_tsk_mgmt %02x\n",
>              iu->srp.tsk_mgmt.tsk_mgmt_func);
> =20
> -    d =3D vscsi_device_find(&s->bus, be64_to_cpu(req->iu.srp.tsk_mgmt.lu=
n), &lun);
> +    d =3D vscsi_device_find(&s->bus,
> +                          be64_to_cpu(req_iu(req)->srp.tsk_mgmt.lun), &l=
un);
>      if (!d) {
>          resp =3D SRP_TSK_MGMT_FIELDS_INVALID;
>      } else {
> @@ -842,7 +849,7 @@ static int vscsi_process_tsk_mgmt(VSCSIState *s, vscs=
i_req *req)
>                  break;
>              }
> =20
> -            tmpreq =3D vscsi_find_req(s, req->iu.srp.tsk_mgmt.task_tag);
> +            tmpreq =3D vscsi_find_req(s, req_iu(req)->srp.tsk_mgmt.task_=
tag);
>              if (tmpreq && tmpreq->sreq) {
>                  assert(tmpreq->sreq->hba_private);
>                  scsi_req_cancel(tmpreq->sreq);
> @@ -867,7 +874,8 @@ static int vscsi_process_tsk_mgmt(VSCSIState *s, vscs=
i_req *req)
> =20
>              for (i =3D 0; i < VSCSI_REQ_LIMIT; i++) {
>                  tmpreq =3D &s->reqs[i];
> -                if (tmpreq->iu.srp.cmd.lun !=3D req->iu.srp.tsk_mgmt.lun=
) {
> +                if (req_iu(tmpreq)->srp.cmd.lun
> +                        !=3D req_iu(req)->srp.tsk_mgmt.lun) {
>                      continue;
>                  }
>                  if (!tmpreq->active || !tmpreq->sreq) {
> @@ -911,7 +919,7 @@ static int vscsi_process_tsk_mgmt(VSCSIState *s, vscs=
i_req *req)
> =20
>  static int vscsi_handle_srp_req(VSCSIState *s, vscsi_req *req)
>  {
> -    union srp_iu *srp =3D &req->iu.srp;
> +    union srp_iu *srp =3D &req_iu(req)->srp;
>      int done =3D 1;
>      uint8_t opcode =3D srp->rsp.opcode;
> =20
> @@ -948,7 +956,7 @@ static int vscsi_send_adapter_info(VSCSIState *s, vsc=
si_req *req)
>      struct mad_adapter_info_data info;
>      int rc;
> =20
> -    sinfo =3D &req->iu.mad.adapter_info;
> +    sinfo =3D &req_iu(req)->mad.adapter_info;
> =20
>  #if 0 /* What for ? */
>      rc =3D spapr_vio_dma_read(&s->vdev, be64_to_cpu(sinfo->buffer),
> @@ -984,7 +992,7 @@ static int vscsi_send_capabilities(VSCSIState *s, vsc=
si_req *req)
>      uint64_t buffer;
>      int rc;
> =20
> -    vcap =3D &req->iu.mad.capabilities;
> +    vcap =3D &req_iu(req)->mad.capabilities;
>      req_len =3D len =3D be16_to_cpu(vcap->common.length);
>      buffer =3D be64_to_cpu(vcap->buffer);
>      if (len > sizeof(cap)) {
> @@ -1029,7 +1037,7 @@ static int vscsi_send_capabilities(VSCSIState *s, v=
scsi_req *req)
> =20
>  static int vscsi_handle_mad_req(VSCSIState *s, vscsi_req *req)
>  {
> -    union mad_iu *mad =3D &req->iu.mad;
> +    union mad_iu *mad =3D &req_iu(req)->mad;
>      bool request_handled =3D false;
>      uint64_t retlen =3D 0;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--poJSiGMzRSvrLGLs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5gSsAACgkQbDjKyiDZ
s5Khxw/+LzJkL+TE4M0NE2V/uFFT18DLWpQ9qpCQIj4QOQrtnHPSa8Da5nnIR1xY
gWW+sbk0SJDgkuP0rlC4uhOM2WB9vMWuC4TQBAB1QDwDTMpIxVpBK3iIy1UJJwPM
zMzxt+y+9Vw8OR9C7N2jmV6bp8HVCdkp7P9JLDuBdzwD3osL+/c7BTiBU7rhY12R
BHyzHIxIiGfWFdXHm/+0irYvlEDjIVhxsDvoMHL+NASDbJJcIeJSE8AGlHrDpFKt
PdEQE3X3UFgKceQ5oIbaEoBrKSiW/sgInA8JS4J/Sr8w+xZbgib9ch9snzmOQRbH
dA3osrVo495NVI8ZL/zDPgHjI/ygV7LRRg85xcr2PcEtl4mwcLTYBPfnpbhR4Gni
s/Zo5RY3afZcdKTfHnbpAE5aieqjBwIxzROs+8Kb+WNIdxTGgiacolzBZlSxsCIp
dSUwgEp9LPfMpSxowZFPqD0sT06lgjUbL1M1JSzGdhfF3ZgYyDNphI4rgiFuxJ1v
s/WwCTBJwZ5k9i9rpDSErXs54TLDOJ9Boak2G1YAY3XdrBGzEeuOyc0M9jrbWePX
4f+be9l2sf5M6Bomzotr28e35yZjQcTWbJVkgAkXG/nCBPKX8dSgMBvMuvKAVGL2
5hz+i+3bP8frRCAJTHdF1ofjSDz3F8vk0TSxGMFAe+E2TLk7Mwc=
=n/D7
-----END PGP SIGNATURE-----

--poJSiGMzRSvrLGLs--


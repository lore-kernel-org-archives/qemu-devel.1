Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81BCC3F2CE
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 01:44:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 855B120828
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 01:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mLCA9faN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855B120828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9fZG-0002lC-K7
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 20:44:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j9fY0-0000NH-3M
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 20:43:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j9fXy-0006ng-Bz
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 20:43:36 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:57503 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j9fXx-0006jL-Cr; Wed, 04 Mar 2020 20:43:34 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48XtnF4ZPCz9sSN; Thu,  5 Mar 2020 12:43:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1583372609;
 bh=Xg7K+Zfd9YAb83FAV7jKUnMcOMXRc+iDxiMRNzAeGUA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mLCA9faNkEc/Gw8udAIPl4eqExZhdwJwkT4aG49NmEdSL8SYMOb3SVwjIJLQN2CVf
 r+HFy7hQT9peaxk8FB7mizH+64jmwzPGG2O2YDZxGupTqy1eDxpIYK9/dwlz92Sg5C
 zn08rAYmAI/W9eSw5k9/ZnXmUIXZrPdyVG+yCKCY=
Date: Thu, 5 Mar 2020 11:42:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 4/5] hw/scsi/spapr_vscsi: Introduce req_ui() helper
Message-ID: <20200305004207.GK593957@umbus.fritz.box>
References: <20200304153311.22959-1-philmd@redhat.com>
 <20200304153311.22959-5-philmd@redhat.com>
 <20200305004137.GJ593957@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DesjdUuHQDwS2t4N"
Content-Disposition: inline
In-Reply-To: <20200305004137.GJ593957@umbus.fritz.box>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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


--DesjdUuHQDwS2t4N
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2020 at 11:41:37AM +1100, David Gibson wrote:
> On Wed, Mar 04, 2020 at 04:33:10PM +0100, Philippe Mathieu-Daud=E9 wrote:
> > Introduce the req_ui() helper which returns a pointer to
> > the viosrp_iu union held in the vscsi_req structure.
> > This simplifies the next patch.
> >=20
> > Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > ---
> >  hw/scsi/spapr_vscsi.c | 40 ++++++++++++++++++++++++----------------
> >  1 file changed, 24 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
> > index 3cb5a38181..f1a0bbdc31 100644
> > --- a/hw/scsi/spapr_vscsi.c
> > +++ b/hw/scsi/spapr_vscsi.c
> > @@ -97,6 +97,12 @@ typedef struct {
> >      vscsi_req reqs[VSCSI_REQ_LIMIT];
> >  } VSCSIState;
> > =20
> > +static union viosrp_iu *req_iu(vscsi_req *req)
> > +{
> > +    return (union viosrp_iu *)req->iu.srp.reserved;
>=20
> I guess it doesn't really matter since you remove it in the next
> patch, but this seems a really weird way of expressing
> 	return &req->iu;

Oh, also s/req_ui/req_iu/g in the commit message.

>=20
> > +}
> > +
> > +
> >  static struct vscsi_req *vscsi_get_req(VSCSIState *s)
> >  {
> >      vscsi_req *req;
> > @@ -121,7 +127,7 @@ static struct vscsi_req *vscsi_find_req(VSCSIState =
*s, uint64_t srp_tag)
> > =20
> >      for (i =3D 0; i < VSCSI_REQ_LIMIT; i++) {
> >          req =3D &s->reqs[i];
> > -        if (req->iu.srp.cmd.tag =3D=3D srp_tag) {
> > +        if (req_iu(req)->srp.cmd.tag =3D=3D srp_tag) {
> >              return req;
> >          }
> >      }
> > @@ -188,7 +194,7 @@ static int vscsi_send_iu(VSCSIState *s, vscsi_req *=
req,
> >      req->crq.s.reserved =3D 0x00;
> >      req->crq.s.timeout =3D cpu_to_be16(0x0000);
> >      req->crq.s.IU_length =3D cpu_to_be16(length);
> > -    req->crq.s.IU_data_ptr =3D req->iu.srp.rsp.tag; /* right byte orde=
r */
> > +    req->crq.s.IU_data_ptr =3D req_iu(req)->srp.rsp.tag; /* right byte=
 order */
> > =20
> >      if (rc =3D=3D 0) {
> >          req->crq.s.status =3D VIOSRP_OK;
> > @@ -224,7 +230,7 @@ static void vscsi_makeup_sense(VSCSIState *s, vscsi=
_req *req,
> >  static int vscsi_send_rsp(VSCSIState *s, vscsi_req *req,
> >                            uint8_t status, int32_t res_in, int32_t res_=
out)
> >  {
> > -    union viosrp_iu *iu =3D &req->iu;
> > +    union viosrp_iu *iu =3D req_iu(req);
> >      uint64_t tag =3D iu->srp.rsp.tag;
> >      int total_len =3D sizeof(iu->srp.rsp);
> >      uint8_t sol_not =3D iu->srp.cmd.sol_not;
> > @@ -285,7 +291,7 @@ static int vscsi_fetch_desc(VSCSIState *s, struct v=
scsi_req *req,
> >                              unsigned n, unsigned buf_offset,
> >                              struct srp_direct_buf *ret)
> >  {
> > -    struct srp_cmd *cmd =3D &req->iu.srp.cmd;
> > +    struct srp_cmd *cmd =3D &req_iu(req)->srp.cmd;
> > =20
> >      switch (req->dma_fmt) {
> >      case SRP_NO_DATA_DESC: {
> > @@ -473,7 +479,7 @@ static int data_out_desc_size(struct srp_cmd *cmd)
> > =20
> >  static int vscsi_preprocess_desc(vscsi_req *req)
> >  {
> > -    struct srp_cmd *cmd =3D &req->iu.srp.cmd;
> > +    struct srp_cmd *cmd =3D &req_iu(req)->srp.cmd;
> > =20
> >      req->cdb_offset =3D cmd->add_cdb_len & ~3;
> > =20
> > @@ -655,7 +661,7 @@ static void *vscsi_load_request(QEMUFile *f, SCSIRe=
quest *sreq)
> > =20
> >  static void vscsi_process_login(VSCSIState *s, vscsi_req *req)
> >  {
> > -    union viosrp_iu *iu =3D &req->iu;
> > +    union viosrp_iu *iu =3D req_iu(req);
> >      struct srp_login_rsp *rsp =3D &iu->srp.login_rsp;
> >      uint64_t tag =3D iu->srp.rsp.tag;
> > =20
> > @@ -681,7 +687,7 @@ static void vscsi_process_login(VSCSIState *s, vscs=
i_req *req)
> > =20
> >  static void vscsi_inquiry_no_target(VSCSIState *s, vscsi_req *req)
> >  {
> > -    uint8_t *cdb =3D req->iu.srp.cmd.cdb;
> > +    uint8_t *cdb =3D req_iu(req)->srp.cmd.cdb;
> >      uint8_t resp_data[36];
> >      int rc, len, alen;
> > =20
> > @@ -770,7 +776,7 @@ static void vscsi_report_luns(VSCSIState *s, vscsi_=
req *req)
> > =20
> >  static int vscsi_queue_cmd(VSCSIState *s, vscsi_req *req)
> >  {
> > -    union srp_iu *srp =3D &req->iu.srp;
> > +    union srp_iu *srp =3D &req_iu(req)->srp;
> >      SCSIDevice *sdev;
> >      int n, lun;
> > =20
> > @@ -821,7 +827,7 @@ static int vscsi_queue_cmd(VSCSIState *s, vscsi_req=
 *req)
> > =20
> >  static int vscsi_process_tsk_mgmt(VSCSIState *s, vscsi_req *req)
> >  {
> > -    union viosrp_iu *iu =3D &req->iu;
> > +    union viosrp_iu *iu =3D req_iu(req);
> >      vscsi_req *tmpreq;
> >      int i, lun =3D 0, resp =3D SRP_TSK_MGMT_COMPLETE;
> >      SCSIDevice *d;
> > @@ -831,7 +837,8 @@ static int vscsi_process_tsk_mgmt(VSCSIState *s, vs=
csi_req *req)
> >      fprintf(stderr, "vscsi_process_tsk_mgmt %02x\n",
> >              iu->srp.tsk_mgmt.tsk_mgmt_func);
> > =20
> > -    d =3D vscsi_device_find(&s->bus, be64_to_cpu(req->iu.srp.tsk_mgmt.=
lun), &lun);
> > +    d =3D vscsi_device_find(&s->bus,
> > +                          be64_to_cpu(req_iu(req)->srp.tsk_mgmt.lun), =
&lun);
> >      if (!d) {
> >          resp =3D SRP_TSK_MGMT_FIELDS_INVALID;
> >      } else {
> > @@ -842,7 +849,7 @@ static int vscsi_process_tsk_mgmt(VSCSIState *s, vs=
csi_req *req)
> >                  break;
> >              }
> > =20
> > -            tmpreq =3D vscsi_find_req(s, req->iu.srp.tsk_mgmt.task_tag=
);
> > +            tmpreq =3D vscsi_find_req(s, req_iu(req)->srp.tsk_mgmt.tas=
k_tag);
> >              if (tmpreq && tmpreq->sreq) {
> >                  assert(tmpreq->sreq->hba_private);
> >                  scsi_req_cancel(tmpreq->sreq);
> > @@ -867,7 +874,8 @@ static int vscsi_process_tsk_mgmt(VSCSIState *s, vs=
csi_req *req)
> > =20
> >              for (i =3D 0; i < VSCSI_REQ_LIMIT; i++) {
> >                  tmpreq =3D &s->reqs[i];
> > -                if (tmpreq->iu.srp.cmd.lun !=3D req->iu.srp.tsk_mgmt.l=
un) {
> > +                if (req_iu(tmpreq)->srp.cmd.lun
> > +                        !=3D req_iu(req)->srp.tsk_mgmt.lun) {
> >                      continue;
> >                  }
> >                  if (!tmpreq->active || !tmpreq->sreq) {
> > @@ -911,7 +919,7 @@ static int vscsi_process_tsk_mgmt(VSCSIState *s, vs=
csi_req *req)
> > =20
> >  static int vscsi_handle_srp_req(VSCSIState *s, vscsi_req *req)
> >  {
> > -    union srp_iu *srp =3D &req->iu.srp;
> > +    union srp_iu *srp =3D &req_iu(req)->srp;
> >      int done =3D 1;
> >      uint8_t opcode =3D srp->rsp.opcode;
> > =20
> > @@ -948,7 +956,7 @@ static int vscsi_send_adapter_info(VSCSIState *s, v=
scsi_req *req)
> >      struct mad_adapter_info_data info;
> >      int rc;
> > =20
> > -    sinfo =3D &req->iu.mad.adapter_info;
> > +    sinfo =3D &req_iu(req)->mad.adapter_info;
> > =20
> >  #if 0 /* What for ? */
> >      rc =3D spapr_vio_dma_read(&s->vdev, be64_to_cpu(sinfo->buffer),
> > @@ -984,7 +992,7 @@ static int vscsi_send_capabilities(VSCSIState *s, v=
scsi_req *req)
> >      uint64_t buffer;
> >      int rc;
> > =20
> > -    vcap =3D &req->iu.mad.capabilities;
> > +    vcap =3D &req_iu(req)->mad.capabilities;
> >      req_len =3D len =3D be16_to_cpu(vcap->common.length);
> >      buffer =3D be64_to_cpu(vcap->buffer);
> >      if (len > sizeof(cap)) {
> > @@ -1029,7 +1037,7 @@ static int vscsi_send_capabilities(VSCSIState *s,=
 vscsi_req *req)
> > =20
> >  static int vscsi_handle_mad_req(VSCSIState *s, vscsi_req *req)
> >  {
> > -    union mad_iu *mad =3D &req->iu.mad;
> > +    union mad_iu *mad =3D &req_iu(req)->mad;
> >      bool request_handled =3D false;
> >      uint64_t retlen =3D 0;
> > =20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DesjdUuHQDwS2t4N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5gSt8ACgkQbDjKyiDZ
s5JmVhAA1X+dkWg6vP16J0f8NZHu1hnPdmpUZIAB91Ak4frHhKhD0GiTK5XgK4s8
XE1vlH/U47MIZQyk1PuK9KaYlLfUMzlywjsia/NWz2z9uWi5MqYjnybBDPfdSES7
ILxEJ60WxYICPnbz+cJnGIJP2x8ZSPGG0gaw+rxf13h3lQT5jl1TIHb1zUabgXEh
eaJ2gxKsb6PByiNP336se+wqszKNRf6If1BypfQHWyGdRWetaDu4showzHAg+J4u
WWoEx6w5cMp1h0TlA7oWIdpS9DabC9bkRiKwQLj3uzSIL+KYAf1+nW8lbXNOBnbh
Hy/zjvmweutDgfv/asDRYo69bu/eOGm1cWRduDj/IhMrq5PKDaSgGXkHVKvAkMp9
wQNeaO7xQuBWNdgMg7sImN/yoNNCA47D6HaHsW0m2DBuDeDDxOtlYmBYBqjNX+P0
w7xSgXYUKbt7Ya5n8EzcBqjQyzpj44iCCgX7AP9O9pq0HHlXl5/Es0U0JUxdaWzZ
nsR6hGZ2A3yqanz9WleMm6XFbejcgdmP5dtnZbQ7CXsgIAfKMLwyluulXPHvYrvz
o61249voKIDQomfeL+S9Ra9MxAKjnwXy9wr5UIOJLSpJGuCyjRMMv55zj+5DbwtB
WRcdndvinin84jOhv7IZJ2JKwc7UCuYSGzcEIjjTeo2+DAAZbsc=
=HlNI
-----END PGP SIGNATURE-----

--DesjdUuHQDwS2t4N--


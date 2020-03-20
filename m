Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62101C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 12:31:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17FD020732
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 12:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHCLfQkg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17FD020732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFGnu-0001wz-5Z
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 08:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jFGn0-0001PC-Rk
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 08:30:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jFGmy-0007lf-Sa
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 08:30:14 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43714)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuval.shaia.ml@gmail.com>)
 id 1jFGmy-0007kZ-Ky
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 08:30:12 -0400
Received: by mail-oi1-x241.google.com with SMTP id p125so6239729oif.10
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 05:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fuw56tPkjr0PSpFd7ZkHGMHGukF7uLbq0YD1RTxdCFA=;
 b=cHCLfQkgWPZ7NcMSkE2/Zyhy28AxE/Ev5HUoVsCandDseQE0KlD9BskpruYDo99AqI
 DOq+PUub+M4rTCxHGXkojmhhfQ4weqgtGNZIBs3j4QtKQAe3mV9xKsZyUUaHbZ1gKn2K
 l8GMEYwNygtxIXsMMDF10xK2LLhwcavY8b0DqSB/NJftOt2/O5ygI6jbpKArxmhiYgJC
 CGKRGQ6jRoxhumxRN/9DCeww9fpEe3GNxsCxkH5riHBaSmQUrEaQgrTJ4lXoMyV2VdAc
 7GGTADFOq7AHlp5Z020UY5poyvmd+P29vrUqnFt4kAwRNwA7it/mP09cxx4AirV0bALe
 fMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fuw56tPkjr0PSpFd7ZkHGMHGukF7uLbq0YD1RTxdCFA=;
 b=sjhvx/q1oVUxVtPENWti1SRILFJxls4F7UcSKwpEtydphR/R7IN6tGuMGSzsyoM7W7
 gm3nwxH7rPxSwKiPe5kMtgk1R7OIHRLblWZGGafaKVOXXT6irMJreC8W9sK9YzjFbadc
 j8vLKX0Txe9TCblns3rTjQJzOTtmeg/GK/Yf9Wusy2gO/sXBr+uWW3+3lAEhpmCPhETG
 E2o2NbxnGMaC6MT9zE0RFYysnzoPpH2JKiaesSz2jDLJ03ELVX3VHAEILVlsbTeGGG74
 aBGR5iI9Ktsx1qiUVyB5KDbJtpYwyxcTu7cez+MuFDnLxU7aeIjdAKFlFDmPFIxLzuI3
 btuw==
X-Gm-Message-State: ANhLgQ2b6TANwjoL2HR04+e2uItGmgU3vXSk21yxZLC3DnuYfgAQYqt9
 6v//GpLfRdL7+dixI7/Dr9R1ZUo8pTDLprw9pLA=
X-Google-Smtp-Source: ADFU+vskTBU1ND0i7D1jJRuxt7f5fQFMlTGSZgSHrnad/69PonCYVR2FkClFmSyFE58REFocBrwRAAC0uMs+JMwRh94=
X-Received: by 2002:aca:56c2:: with SMTP id k185mr5878396oib.141.1584707411744; 
 Fri, 20 Mar 2020 05:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200307125608.2476-1-yuval.shaia.ml@gmail.com>
 <20200307125608.2476-2-yuval.shaia.ml@gmail.com>
 <0f105874-c15f-406e-c4e9-fd752f95aa96@gmail.com>
In-Reply-To: <0f105874-c15f-406e-c4e9-fd752f95aa96@gmail.com>
From: Yuval Shaia <yuval.shaia.ml@gmail.com>
Date: Fri, 20 Mar 2020 14:30:00 +0200
Message-ID: <CAMPkWoMcGw5csPN+UAtCYHF8BBiojhFECJORJERDm48WwqWZGA@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/rdma: Cosmetic change - no need for two sge arrays
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000059b07d05a14872a5"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000059b07d05a14872a5
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Mar 2020 at 15:30, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
wrote:

> Hi Yuval,
>
> On 3/7/20 2:56 PM, Yuval Shaia wrote:
> > The function build_host_sge_array uses two sge arrays, one for input and
> > one for output.
> > Since the size of the two arrays is the same, the function can write
> > directly to the given source array (i.e. input/output argument).
> >
> > Signed-off-by: Yuval Shaia <yuval.shaia.ml@gmail.com>
> > ---
> >   hw/rdma/rdma_backend.c | 40 +++++++++++++++++-----------------------
> >   1 file changed, 17 insertions(+), 23 deletions(-)
> >
> > diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> > index c346407cd3..79b9cfb487 100644
> > --- a/hw/rdma/rdma_backend.c
> > +++ b/hw/rdma/rdma_backend.c
> > @@ -378,30 +378,27 @@ static void ah_cache_init(void)
> >   }
> >
> >   static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
> > -                                struct ibv_sge *dsge, struct ibv_sge
> *ssge,
> > -                                uint8_t num_sge, uint64_t *total_length)
> > +                                struct ibv_sge *sge, uint8_t num_sge,
> > +                                uint64_t *total_length)
> >   {
> >       RdmaRmMR *mr;
> > -    int ssge_idx;
> > +    int idx;
> >
> > -    for (ssge_idx = 0; ssge_idx < num_sge; ssge_idx++) {
> > -        mr = rdma_rm_get_mr(rdma_dev_res, ssge[ssge_idx].lkey);
> > +    for (idx = 0; idx < num_sge; idx++) {
> > +        mr = rdma_rm_get_mr(rdma_dev_res, sge[idx].lkey);
> >           if (unlikely(!mr)) {
> > -            rdma_error_report("Invalid lkey 0x%x", ssge[ssge_idx].lkey);
> > -            return VENDOR_ERR_INVLKEY | ssge[ssge_idx].lkey;
> > +            rdma_error_report("Invalid lkey 0x%x", sge[idx].lkey);
> > +            return VENDOR_ERR_INVLKEY | sge[idx].lkey;
> >           }
> >
> >   #ifdef LEGACY_RDMA_REG_MR
> > -        dsge->addr = (uintptr_t)mr->virt + ssge[ssge_idx].addr -
> mr->start;
> > +        sge[idx].addr = (uintptr_t)mr->virt + sge[idx].addr - mr->start;
> >   #else
> > -        dsge->addr = ssge[ssge_idx].addr;
> > +        sge[idx].addr = sge[idx].addr;
>
> It seems we don't need the above line.
> Other than that it looks good to me.
>

Yeah, thanks.
It is fixed in the next patch but better be fixed here.
Will fix and post new set.


>
> Thanks,
> Marcel
>
> >   #endif
> > -        dsge->length = ssge[ssge_idx].length;
> > -        dsge->lkey = rdma_backend_mr_lkey(&mr->backend_mr);
> > +        sge[idx].lkey = rdma_backend_mr_lkey(&mr->backend_mr);
> >
> > -        *total_length += dsge->length;
> > -
> > -        dsge++;
> > +        *total_length += sge[idx].length;
> >       }
> >
> >       return 0;
> > @@ -484,7 +481,6 @@ void rdma_backend_post_send(RdmaBackendDev
> *backend_dev,
> >                               void *ctx)
> >   {
> >       BackendCtx *bctx;
> > -    struct ibv_sge new_sge[MAX_SGE];
> >       uint32_t bctx_id;
> >       int rc;
> >       struct ibv_send_wr wr = {}, *bad_wr;
> > @@ -518,7 +514,7 @@ void rdma_backend_post_send(RdmaBackendDev
> *backend_dev,
> >
> >       rdma_protected_gslist_append_int32(&qp->cqe_ctx_list, bctx_id);
> >
> > -    rc = build_host_sge_array(backend_dev->rdma_dev_res, new_sge, sge,
> num_sge,
> > +    rc = build_host_sge_array(backend_dev->rdma_dev_res, sge, num_sge,
> >
>  &backend_dev->rdma_dev_res->stats.tx_len);
> >       if (rc) {
> >           complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
> > @@ -538,7 +534,7 @@ void rdma_backend_post_send(RdmaBackendDev
> *backend_dev,
> >       wr.num_sge = num_sge;
> >       wr.opcode = IBV_WR_SEND;
> >       wr.send_flags = IBV_SEND_SIGNALED;
> > -    wr.sg_list = new_sge;
> > +    wr.sg_list = sge;
> >       wr.wr_id = bctx_id;
> >
> >       rc = ibv_post_send(qp->ibqp, &wr, &bad_wr);
> > @@ -601,7 +597,6 @@ void rdma_backend_post_recv(RdmaBackendDev
> *backend_dev,
> >                               struct ibv_sge *sge, uint32_t num_sge,
> void *ctx)
> >   {
> >       BackendCtx *bctx;
> > -    struct ibv_sge new_sge[MAX_SGE];
> >       uint32_t bctx_id;
> >       int rc;
> >       struct ibv_recv_wr wr = {}, *bad_wr;
> > @@ -635,7 +630,7 @@ void rdma_backend_post_recv(RdmaBackendDev
> *backend_dev,
> >
> >       rdma_protected_gslist_append_int32(&qp->cqe_ctx_list, bctx_id);
> >
> > -    rc = build_host_sge_array(backend_dev->rdma_dev_res, new_sge, sge,
> num_sge,
> > +    rc = build_host_sge_array(backend_dev->rdma_dev_res, sge, num_sge,
> >
>  &backend_dev->rdma_dev_res->stats.rx_bufs_len);
> >       if (rc) {
> >           complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
> > @@ -643,7 +638,7 @@ void rdma_backend_post_recv(RdmaBackendDev
> *backend_dev,
> >       }
> >
> >       wr.num_sge = num_sge;
> > -    wr.sg_list = new_sge;
> > +    wr.sg_list = sge;
> >       wr.wr_id = bctx_id;
> >       rc = ibv_post_recv(qp->ibqp, &wr, &bad_wr);
> >       if (rc) {
> > @@ -671,7 +666,6 @@ void rdma_backend_post_srq_recv(RdmaBackendDev
> *backend_dev,
> >                                   uint32_t num_sge, void *ctx)
> >   {
> >       BackendCtx *bctx;
> > -    struct ibv_sge new_sge[MAX_SGE];
> >       uint32_t bctx_id;
> >       int rc;
> >       struct ibv_recv_wr wr = {}, *bad_wr;
> > @@ -688,7 +682,7 @@ void rdma_backend_post_srq_recv(RdmaBackendDev
> *backend_dev,
> >
> >       rdma_protected_gslist_append_int32(&srq->cqe_ctx_list, bctx_id);
> >
> > -    rc = build_host_sge_array(backend_dev->rdma_dev_res, new_sge, sge,
> num_sge,
> > +    rc = build_host_sge_array(backend_dev->rdma_dev_res, sge, num_sge,
> >
>  &backend_dev->rdma_dev_res->stats.rx_bufs_len);
> >       if (rc) {
> >           complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
> > @@ -696,7 +690,7 @@ void rdma_backend_post_srq_recv(RdmaBackendDev
> *backend_dev,
> >       }
> >
> >       wr.num_sge = num_sge;
> > -    wr.sg_list = new_sge;
> > +    wr.sg_list = sge;
> >       wr.wr_id = bctx_id;
> >       rc = ibv_post_srq_recv(srq->ibsrq, &wr, &bad_wr);
> >       if (rc) {
>
>

--00000000000059b07d05a14872a5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, 16 Mar 2020 at 15:30, Marcel =
Apfelbaum &lt;<a href=3D"mailto:marcel.apfelbaum@gmail.com">marcel.apfelbau=
m@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Hi Yuval,<br>
<br>
On 3/7/20 2:56 PM, Yuval Shaia wrote:<br>
&gt; The function build_host_sge_array uses two sge arrays, one for input a=
nd<br>
&gt; one for output.<br>
&gt; Since the size of the two arrays is the same, the function can write<b=
r>
&gt; directly to the given source array (i.e. input/output argument).<br>
&gt;<br>
&gt; Signed-off-by: Yuval Shaia &lt;<a href=3D"mailto:yuval.shaia.ml@gmail.=
com" target=3D"_blank">yuval.shaia.ml@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/rdma/rdma_backend.c | 40 +++++++++++++++++-------------=
----------<br>
&gt;=C2=A0 =C2=A01 file changed, 17 insertions(+), 23 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c<br>
&gt; index c346407cd3..79b9cfb487 100644<br>
&gt; --- a/hw/rdma/rdma_backend.c<br>
&gt; +++ b/hw/rdma/rdma_backend.c<br>
&gt; @@ -378,30 +378,27 @@ static void ah_cache_init(void)<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static int build_host_sge_array(RdmaDeviceResources *rdma_=
dev_res,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ibv_sge *dsge, struct ibv=
_sge *ssge,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t num_sge, uint64_t *total=
_length)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ibv_sge *sge, uint8_t num=
_sge,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t *total_length)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RdmaRmMR *mr;<br>
&gt; -=C2=A0 =C2=A0 int ssge_idx;<br>
&gt; +=C2=A0 =C2=A0 int idx;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 for (ssge_idx =3D 0; ssge_idx &lt; num_sge; ssge_idx++)=
 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 mr =3D rdma_rm_get_mr(rdma_dev_res, ssge[=
ssge_idx].lkey);<br>
&gt; +=C2=A0 =C2=A0 for (idx =3D 0; idx &lt; num_sge; idx++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mr =3D rdma_rm_get_mr(rdma_dev_res, sge[i=
dx].lkey);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(!mr)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rdma_error_report(&quot;Inv=
alid lkey 0x%x&quot;, ssge[ssge_idx].lkey);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return VENDOR_ERR_INVLKEY |=
 ssge[ssge_idx].lkey;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rdma_error_report(&quot;Inv=
alid lkey 0x%x&quot;, sge[idx].lkey);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return VENDOR_ERR_INVLKEY |=
 sge[idx].lkey;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#ifdef LEGACY_RDMA_REG_MR<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 dsge-&gt;addr =3D (uintptr_t)mr-&gt;virt =
+ ssge[ssge_idx].addr - mr-&gt;start;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sge[idx].addr =3D (uintptr_t)mr-&gt;virt =
+ sge[idx].addr - mr-&gt;start;<br>
&gt;=C2=A0 =C2=A0#else<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 dsge-&gt;addr =3D ssge[ssge_idx].addr;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sge[idx].addr =3D sge[idx].addr;<br>
<br>
It seems we don&#39;t need the above line.<br>
Other than that it looks good to me.<br></blockquote><div><br></div><div>Ye=
ah, thanks.</div><div>It is fixed in the next patch but better be fixed her=
e.</div><div>Will fix and post new set.</div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
<br>
Thanks,<br>
Marcel<br>
<br>
&gt;=C2=A0 =C2=A0#endif<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 dsge-&gt;length =3D ssge[ssge_idx].length=
;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 dsge-&gt;lkey =3D rdma_backend_mr_lkey(&a=
mp;mr-&gt;backend_mr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sge[idx].lkey =3D rdma_backend_mr_lkey(&a=
mp;mr-&gt;backend_mr);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 *total_length +=3D dsge-&gt;length;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 dsge++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *total_length +=3D sge[idx].length;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; @@ -484,7 +481,6 @@ void rdma_backend_post_send(RdmaBackendDev *backen=
d_dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *ctx)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0BackendCtx *bctx;<br>
&gt; -=C2=A0 =C2=A0 struct ibv_sge new_sge[MAX_SGE];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t bctx_id;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int rc;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ibv_send_wr wr =3D {}, *bad_wr;<br>
&gt; @@ -518,7 +514,7 @@ void rdma_backend_post_send(RdmaBackendDev *backen=
d_dev,<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rdma_protected_gslist_append_int32(&amp;qp-&=
gt;cqe_ctx_list, bctx_id);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 rc =3D build_host_sge_array(backend_dev-&gt;rdma_dev_re=
s, new_sge, sge, num_sge,<br>
&gt; +=C2=A0 =C2=A0 rc =3D build_host_sge_array(backend_dev-&gt;rdma_dev_re=
s, sge, num_sge,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;backend_dev-&gt;rdma_d=
ev_res-&gt;stats.tx_len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0complete_work(IBV_WC_GENERAL_E=
RR, rc, ctx);<br>
&gt; @@ -538,7 +534,7 @@ void rdma_backend_post_send(RdmaBackendDev *backen=
d_dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0wr.num_sge =3D num_sge;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0wr.opcode =3D IBV_WR_SEND;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0wr.send_flags =3D IBV_SEND_SIGNALED;<br>
&gt; -=C2=A0 =C2=A0 wr.sg_list =3D new_sge;<br>
&gt; +=C2=A0 =C2=A0 wr.sg_list =3D sge;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0wr.wr_id =3D bctx_id;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D ibv_post_send(qp-&gt;ibqp, &amp;wr, &=
amp;bad_wr);<br>
&gt; @@ -601,7 +597,6 @@ void rdma_backend_post_recv(RdmaBackendDev *backen=
d_dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ibv_sge *sge, uint32_t num_=
sge, void *ctx)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0BackendCtx *bctx;<br>
&gt; -=C2=A0 =C2=A0 struct ibv_sge new_sge[MAX_SGE];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t bctx_id;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int rc;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ibv_recv_wr wr =3D {}, *bad_wr;<br>
&gt; @@ -635,7 +630,7 @@ void rdma_backend_post_recv(RdmaBackendDev *backen=
d_dev,<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rdma_protected_gslist_append_int32(&amp;qp-&=
gt;cqe_ctx_list, bctx_id);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 rc =3D build_host_sge_array(backend_dev-&gt;rdma_dev_re=
s, new_sge, sge, num_sge,<br>
&gt; +=C2=A0 =C2=A0 rc =3D build_host_sge_array(backend_dev-&gt;rdma_dev_re=
s, sge, num_sge,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;backend_dev-&gt;rdma_d=
ev_res-&gt;stats.rx_bufs_len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0complete_work(IBV_WC_GENERAL_E=
RR, rc, ctx);<br>
&gt; @@ -643,7 +638,7 @@ void rdma_backend_post_recv(RdmaBackendDev *backen=
d_dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0wr.num_sge =3D num_sge;<br>
&gt; -=C2=A0 =C2=A0 wr.sg_list =3D new_sge;<br>
&gt; +=C2=A0 =C2=A0 wr.sg_list =3D sge;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0wr.wr_id =3D bctx_id;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D ibv_post_recv(qp-&gt;ibqp, &amp;wr, &=
amp;bad_wr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc) {<br>
&gt; @@ -671,7 +666,6 @@ void rdma_backend_post_srq_recv(RdmaBackendDev *ba=
ckend_dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t num_sge, vo=
id *ctx)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0BackendCtx *bctx;<br>
&gt; -=C2=A0 =C2=A0 struct ibv_sge new_sge[MAX_SGE];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t bctx_id;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int rc;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ibv_recv_wr wr =3D {}, *bad_wr;<br>
&gt; @@ -688,7 +682,7 @@ void rdma_backend_post_srq_recv(RdmaBackendDev *ba=
ckend_dev,<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rdma_protected_gslist_append_int32(&amp;srq-=
&gt;cqe_ctx_list, bctx_id);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 rc =3D build_host_sge_array(backend_dev-&gt;rdma_dev_re=
s, new_sge, sge, num_sge,<br>
&gt; +=C2=A0 =C2=A0 rc =3D build_host_sge_array(backend_dev-&gt;rdma_dev_re=
s, sge, num_sge,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;backend_dev-&gt;rdma_d=
ev_res-&gt;stats.rx_bufs_len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0complete_work(IBV_WC_GENERAL_E=
RR, rc, ctx);<br>
&gt; @@ -696,7 +690,7 @@ void rdma_backend_post_srq_recv(RdmaBackendDev *ba=
ckend_dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0wr.num_sge =3D num_sge;<br>
&gt; -=C2=A0 =C2=A0 wr.sg_list =3D new_sge;<br>
&gt; +=C2=A0 =C2=A0 wr.sg_list =3D sge;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0wr.wr_id =3D bctx_id;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D ibv_post_srq_recv(srq-&gt;ibsrq, &amp=
;wr, &amp;bad_wr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc) {<br>
<br>
</blockquote></div></div>

--00000000000059b07d05a14872a5--


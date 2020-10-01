Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CB5C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:39:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A4620796
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A4620796
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO3UU-0005oc-2a
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 14:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kO3PG-0002HQ-KJ; Thu, 01 Oct 2020 14:34:20 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:51333)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kO3PB-0004f1-09; Thu, 01 Oct 2020 14:34:18 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 3ED57580350;
 Thu,  1 Oct 2020 14:34:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Thu, 01 Oct 2020 14:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=ZtS1FCTdFkhV1Mkh0zH0GD6ZHgH
 xpBsii6MwKJKn9Lw=; b=J8x0h2RJahM6LCfRdeEYQLsLaNSwzS2HTaG+l36zhF1
 PnHH0Szotn0dtAQB2Zl8Zi0tX0lHxYGNAnOyL3DJdi+HPb90pfk+uU5pFKSsFNx7
 A1WZVnH7y5Y8mZEj8fS6O3lIFqDCrFTTPTVX0y8c1Z2G1i59enoLsGxhrcs77onp
 lUK7A6dTjoa+sgZOV3rtJMZY3wa/yYlQB7qD78gPEmXddYXoADWZJ8dPPMF2Lw9z
 plKNlzPpIHfr3LkMD01waxL0PATCJwn5GpA73W44kM2XXkChq94TvgVPD1FFI93R
 9C9SU0sJVOm/bERGd9remuJoyWPgEbr92EUb+QYWdQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ZtS1FC
 TdFkhV1Mkh0zH0GD6ZHgHxpBsii6MwKJKn9Lw=; b=j9a94uJlPtiyw3h8BL3Qqj
 lYLcbjIMQq/OitpW01La+a6Curd6FrlNdy02J82A5FED+jo1jSW6PfVadXjtKgFJ
 FWZMFbjMlXu/F4WDwPjpeVlyFz3lSZW4DzuQM3dZpdMFMSQWpG5eqJdG8cAv8oyJ
 OBooBW2ZDW8wCbxzoICTd+OTEBrLdGhm/TCSbAjmO0D7pHrsOwMjbQM4JwkV5m5u
 16i+yQLiksGqwY2cycsWaVnu75Dmb6bpQy5wmuOUa7TCqzHV+RHQb3JVdg8PlL2/
 OjY7KkgCLTAO8ZDEd0ja++ZXIjmdjPvcOPEr+xHh0+O8s8M7yyH1b4PxKSyglVvQ
 ==
X-ME-Sender: <xms:HSF2X5qConrH3TM2uYLQFd-vNFOdi9awgTVTGnJ4v83myHGG2dfUMw>
 <xme:HSF2X7oTdnJIT5v549NTDa7sENIlsMDklzuA9oQ35_7P5yoto_4rnc_MOuQWbY56d
 v_oaKMa75Lec8xW-qs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeeggdduvdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:HSF2X2Pa10SP6ELwhk0mJs94t_OmyY36KxoP7LDQKoh3dhLrRKucBw>
 <xmx:HSF2X05aRLAmKTKU6eZbgduQq6jlyTHXnsjH-ZoEaQsv9Byps78-7Q>
 <xmx:HSF2X45LaJaJkwlonZqJyxaJ8L7q1ByDgbRTO8Lp9Lmoynv_PgWi_A>
 <xmx:HiF2XyQaHBH0N1WmLLuBkr9DJupuLTP6v_7JGKLXPnpWrcxrsaWwpg>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id BF2533064674;
 Thu,  1 Oct 2020 14:34:03 -0400 (EDT)
Date: Thu, 1 Oct 2020 20:34:01 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/9] hw/block/nvme: remove pointless rw indirection
Message-ID: <20201001183401.GC792691@apples.localdomain>
References: <20200930220414.562527-1-kbusch@kernel.org>
 <20200930220414.562527-2-kbusch@kernel.org>
 <20201001040508.GA681387@apples.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="eRtJSFbw+EEWtPj3"
Content-Disposition: inline
In-Reply-To: <20201001040508.GA681387@apples.localdomain>
Received-SPF: pass client-ip=66.111.4.221; envelope-from=its@irrelevant.dk;
 helo=new1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 13:18:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct  1 06:05, Klaus Jensen wrote:
> On Sep 30 15:04, Keith Busch wrote:
> > The code switches on the opcode to invoke a function specific to that
> > opcode. There's no point in consolidating back to a common function that
> > just switches on that same opcode without any actual common code.
> > Restore the opcode specific behavior without going back through another
> > level of switches.
> >=20
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
>=20
> Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
>=20
> Point taken. I could've sweared I had a better reason for this.
>=20
> > ---
> >  hw/block/nvme.c | 91 ++++++++++++++++---------------------------------
> >  1 file changed, 29 insertions(+), 62 deletions(-)
> >=20
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index da8344f196..db52ea0db9 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -927,68 +927,12 @@ static void nvme_rw_cb(void *opaque, int ret)
> >      nvme_enqueue_req_completion(nvme_cq(req), req);
> >  }
> > =20
> > -static uint16_t nvme_do_aio(BlockBackend *blk, int64_t offset, size_t =
len,
> > -                            NvmeRequest *req)
> > -{
> > -    BlockAcctCookie *acct =3D &req->acct;
> > -    BlockAcctStats *stats =3D blk_get_stats(blk);
> > -
> > -    bool is_write =3D false;
> > -
> > -    trace_pci_nvme_do_aio(nvme_cid(req), req->cmd.opcode,
> > -                          nvme_io_opc_str(req->cmd.opcode), blk_name(b=
lk),
> > -                          offset, len);
> > -
> > -    switch (req->cmd.opcode) {
> > -    case NVME_CMD_FLUSH:
> > -        block_acct_start(stats, acct, 0, BLOCK_ACCT_FLUSH);
> > -        req->aiocb =3D blk_aio_flush(blk, nvme_rw_cb, req);
> > -        break;
> > -
> > -    case NVME_CMD_WRITE_ZEROES:
> > -        block_acct_start(stats, acct, len, BLOCK_ACCT_WRITE);
> > -        req->aiocb =3D blk_aio_pwrite_zeroes(blk, offset, len,
> > -                                           BDRV_REQ_MAY_UNMAP, nvme_rw=
_cb,
> > -                                           req);
> > -        break;
> > -
> > -    case NVME_CMD_WRITE:
> > -        is_write =3D true;
> > -
> > -        /* fallthrough */
> > -
> > -    case NVME_CMD_READ:
> > -        block_acct_start(stats, acct, len,
> > -                         is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ=
);
> > -
> > -        if (req->qsg.sg) {
> > -            if (is_write) {
> > -                req->aiocb =3D dma_blk_write(blk, &req->qsg, offset,
> > -                                           BDRV_SECTOR_SIZE, nvme_rw_c=
b, req);
> > -            } else {
> > -                req->aiocb =3D dma_blk_read(blk, &req->qsg, offset,
> > -                                          BDRV_SECTOR_SIZE, nvme_rw_cb=
, req);
> > -            }
> > -        } else {
> > -            if (is_write) {
> > -                req->aiocb =3D blk_aio_pwritev(blk, offset, &req->iov,=
 0,
> > -                                             nvme_rw_cb, req);
> > -            } else {
> > -                req->aiocb =3D blk_aio_preadv(blk, offset, &req->iov, =
0,
> > -                                            nvme_rw_cb, req);
> > -            }
> > -        }
> > -
> > -        break;
> > -    }
> > -
> > -    return NVME_NO_COMPLETE;
> > -}
> > -
> >  static uint16_t nvme_flush(NvmeCtrl *n, NvmeRequest *req)
> >  {
> > -    NvmeNamespace *ns =3D req->ns;
> > -    return nvme_do_aio(ns->blkconf.blk, 0, 0, req);
> > +    block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,

Uh, ouch!

This and the rest needs to be changed to ns->blkconf.blk and not
n->conf.blk.

> > +                     BLOCK_ACCT_FLUSH);
> > +    req->aiocb =3D blk_aio_flush(n->conf.blk, nvme_rw_cb, req);
> > +    return NVME_NO_COMPLETE;
> >  }
> > =20
> >  static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
> > @@ -1009,7 +953,11 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, Nv=
meRequest *req)
> >          return status;
> >      }
> > =20
> > -    return nvme_do_aio(ns->blkconf.blk, offset, count, req);
> > +    block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
> > +                     BLOCK_ACCT_WRITE);
> > +    req->aiocb =3D blk_aio_pwrite_zeroes(n->conf.blk, offset, count,
> > +                                       BDRV_REQ_MAY_UNMAP, nvme_rw_cb,=
 req);
> > +    return NVME_NO_COMPLETE;
> >  }
> > =20
> >  static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
> > @@ -1023,6 +971,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *=
req)
> >      uint64_t data_offset =3D nvme_l2b(ns, slba);
> >      enum BlockAcctType acct =3D req->cmd.opcode =3D=3D NVME_CMD_WRITE ?
> >          BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
> > +    BlockBackend *blk =3D ns->blkconf.blk;
> >      uint16_t status;
> > =20
> >      trace_pci_nvme_rw(nvme_cid(req), nvme_io_opc_str(rw->opcode),
> > @@ -1045,7 +994,25 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest =
*req)
> >          goto invalid;
> >      }
> > =20
> > -    return nvme_do_aio(ns->blkconf.blk, data_offset, data_size, req);
> > +    block_acct_start(blk_get_stats(blk), &req->acct, data_size, acct);
> > +    if (req->qsg.sg) {
> > +        if (acct =3D=3D BLOCK_ACCT_WRITE) {
> > +            req->aiocb =3D dma_blk_write(blk, &req->qsg, data_offset,
> > +                                       BDRV_SECTOR_SIZE, nvme_rw_cb, r=
eq);
> > +        } else {
> > +            req->aiocb =3D dma_blk_read(blk, &req->qsg, data_offset,
> > +                                      BDRV_SECTOR_SIZE, nvme_rw_cb, re=
q);
> > +        }
> > +    } else {
> > +        if (acct =3D=3D BLOCK_ACCT_WRITE) {
> > +            req->aiocb =3D blk_aio_pwritev(blk, data_offset, &req->iov=
, 0,
> > +                                         nvme_rw_cb, req);
> > +        } else {
> > +            req->aiocb =3D blk_aio_preadv(blk, data_offset, &req->iov,=
 0,
> > +                                        nvme_rw_cb, req);
> > +        }
> > +    }
> > +    return NVME_NO_COMPLETE;
> > =20
> >  invalid:
> >      block_acct_invalid(blk_get_stats(ns->blkconf.blk), acct);
> > --=20
> > 2.24.1
> >=20
> >=20
>=20
> --=20
> One of us - No more doubt, silence or taboo about mental illness.



--=20
One of us - No more doubt, silence or taboo about mental illness.

--eRtJSFbw+EEWtPj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl92IRcACgkQTeGvMW1P
DembhQgAh5gBHGX1ArmMrnYcgsSLGWyV4Z6GZee+MKubT2gBYQwUDvGk93YoY/dc
nm/RtDuYGdwcYLMD6UU/c5BQ6NOZXIzx7dO4EmtGVtf7ag1KQtcbsUn1ao5h3CNX
NBZrsc824GIwPWscbzj8tOOIKJGtxDMKnUtfutffBIDcMqZWLKKpVXYZmu080TzK
QnY6eLw0cHaa9/ZWF/2c/w1ukU9IAlY/ukzD7+QlzX7tuUjES9AbhNbU4l1fcg6s
fbZpqmkxH5MpQMtE/Klb/vCMJhrMEFPkL1ONm1msa+HwLlyQ9DtwigSleZvdY0ZE
pH75e3d0fLmFkOZo7gK9gf8UURBL0w==
=Cx7L
-----END PGP SIGNATURE-----

--eRtJSFbw+EEWtPj3--


Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC7CC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 07:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA87621707
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 07:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA87621707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVVBq-0007Wz-6d
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 03:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVV7Y-00065S-1j; Thu, 22 Oct 2020 03:34:48 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:46113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVV7W-00045U-2Y; Thu, 22 Oct 2020 03:34:47 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id EABAB6C2;
 Thu, 22 Oct 2020 03:34:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Thu, 22 Oct 2020 03:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=ZTXo9tB8qQCrSOV5LnjFFbgDxUh
 lyS5JI1MvteoluRk=; b=x3KdpYG/m8NG0gXQKzRvfpoeYCGkYnVEAqZHUd2LJYC
 9EbWelMvfN6nuDYqrO//2joSAzVTa+Kzx7Wye8Pvd3C1oTPyjIhUrfkhr3heF9At
 bmPP3mx30mXOnMhExTAJi9opj4Sr0ycNZ8/sK0cURHBS8F7qCGUY+rldsLCRzk5N
 HtZEdxWZHRnwK81L+ha+dvQSGVAe9uLyoR2MLMZKmD0magiWsI9kdf/3qFLHMc7o
 NVn1ahN7S6EyfyUhSu4nriaYpwQGn++u/7p1zvU93RF4AAgPls2Quw3z15u/WS22
 YJ2BYL1L5J2hwa/W2wzPPlceL4lqTR95FParL9gm6mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ZTXo9t
 B8qQCrSOV5LnjFFbgDxUhlyS5JI1MvteoluRk=; b=YYD3CEZUbdyBKHD7P25Ohm
 DkTChanrHgVbQv/m1d3SHQV+uQCwxAaCeKNEmxqOPG5Y97/FwdZ21VQIKRKQXFT7
 9uMbY/oLKWW4ieC4Ki4GhvLru5ZeLv8UYxSmlnUBClKPbOK1ZWZMVHqp3VNMVbaS
 yVkmmjga5tA57OZ3FL36cZTSv34jluWtbD7EpyUL/L6DuGg2UXiWRXnRkixJmlnX
 C1k6OWSm3VIf+BhEv40J8t5OhQ0/WLaX8tSVbHF2cDEbZ1fyHXPqAgGqmS1lKkx+
 HjMO8IPsioGwWOE3N4Vo4IGujmoqHtr+iXb6AkpjL4wYdgwcT4nTJ/B3in+1nASw
 ==
X-ME-Sender: <xms:EjaRX6bhIuWPmnip9ELQ466Ya44WXAZKuBol7NP0TwtCR7gzax9-JQ>
 <xme:EjaRX9ZTkyeMdqJ4guHQgbYsf7JfkbnOsya4cONsMKIxSgTNWGq4bRTarGaHUsHbE
 2f49kauwN7XVyCeiDc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeeigdduudelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:EjaRX09OtQva-0AwAaonSz1-FU3G_cTbHdAOszLrOvVmA5VeBd0PPg>
 <xmx:EjaRX8q9RNhY4Y2I8sCbCll988VC8GNPsQIGiGUoLHY0T1JzM_4GnA>
 <xmx:EjaRX1oPRDbPHkQZvIQ_W4r1_XkeaaLQKgTdntYnE8b2Xripjxh0_A>
 <xmx:EzaRX2mcns4hp4a20wMDdEImPwYd9MVNNAc0aOCJZ6qpB3QMMWX3EQ>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id CDB843280064;
 Thu, 22 Oct 2020 03:34:41 -0400 (EDT)
Date: Thu, 22 Oct 2020 09:34:40 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3 2/2] hw/block/nvme: add the dataset management command
Message-ID: <20201022073440.GA104633@apples.localdomain>
References: <20201021221736.100779-1-its@irrelevant.dk>
 <20201021221736.100779-3-its@irrelevant.dk>
 <20201022005941.GB1663557@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <20201022005941.GB1663557@dhcp-10-100-145-180.wdc.com>
Received-SPF: pass client-ip=64.147.123.24; envelope-from=its@irrelevant.dk;
 helo=wout1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 03:33:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 21 17:59, Keith Busch wrote:
> On Thu, Oct 22, 2020 at 12:17:36AM +0200, Klaus Jensen wrote:
> > +static void nvme_aio_discard_cb(void *opaque, int ret)
> > +{
> > +    NvmeRequest *req =3D opaque;
> > +    int *discards =3D req->opaque;
> > +
> > +    trace_pci_nvme_aio_discard_cb(nvme_cid(req));
> > +
> > +    if (ret) {
> > +        req->status =3D NVME_INTERNAL_DEV_ERROR;
> > +        trace_pci_nvme_err_aio(nvme_cid(req), strerror(ret),
> > +                               req->status);
> > +    }
> > +
> > +    if (discards && --(*discards) > 0) {
> > +        return;
> > +    }
> > +
> > +    g_free(req->opaque);
> > +    req->opaque =3D NULL;
> > +
> > +    nvme_enqueue_req_completion(nvme_cq(req), req);
> > +}
> > +
> > +static uint16_t nvme_dsm(NvmeCtrl *n, NvmeRequest *req)
> > +{
> > +    NvmeNamespace *ns =3D req->ns;
> > +    NvmeDsmCmd *dsm =3D (NvmeDsmCmd *) &req->cmd;
> > +    NvmeDsmRange *range =3D NULL;
> > +    int *discards =3D NULL;
> > +
> > +    uint32_t attr =3D le32_to_cpu(dsm->attributes);
> > +    uint32_t nr =3D (le32_to_cpu(dsm->nr) & 0xff) + 1;
> > +
> > +    uint16_t status =3D NVME_SUCCESS;
> > +
> > +    trace_pci_nvme_dsm(nvme_cid(req), nvme_nsid(ns), nr, attr);
> > +
> > +    if (attr & NVME_DSMGMT_AD) {
> > +        int64_t offset;
> > +        size_t len;
> > +
> > +        range =3D g_new(NvmeDsmRange, nr);
> > +
> > +        status =3D nvme_dma(n, (uint8_t *)range, nr * sizeof(NvmeDsmRa=
nge),
> > +                          DMA_DIRECTION_TO_DEVICE, req);
> > +        if (status) {
> > +            goto out;
> > +        }
> > +
> > +        discards =3D g_new0(int, 1);
> > +        req->opaque =3D discards;
>=20
> I think you need to initialize discards to 1 so that this function is
> holding a reference on it while the asynchronous part is running.
> Otherwise, the callback may see 'discards' at 0 and free it while we're
> trying to discard the next range.
>=20

Yes - you are right. The callback might actually get called immediately
in some cases.

> > +
> > +        for (int i =3D 0; i < nr; i++) {
> > +            uint64_t slba =3D le64_to_cpu(range[i].slba);
> > +            uint32_t nlb =3D le32_to_cpu(range[i].nlb);
> > +
> > +            if (nvme_check_bounds(n, ns, slba, nlb)) {
> > +                trace_pci_nvme_err_invalid_lba_range(slba, nlb,
> > +                                                     ns->id_ns.nsze);
> > +                continue;
> > +            }
> > +
> > +            trace_pci_nvme_dsm_deallocate(nvme_cid(req), nvme_nsid(ns)=
, slba,
> > +                                          nlb);
> > +
> > +            offset =3D nvme_l2b(ns, slba);
> > +            len =3D nvme_l2b(ns, nlb);
> > +
> > +            while (len) {
> > +                size_t bytes =3D MIN(BDRV_REQUEST_MAX_BYTES, len);
> > +
> > +                blk_aio_pdiscard(ns->blkconf.blk, offset, bytes,
> > +                                 nvme_aio_discard_cb, req);
> > +
> > +                (*discards)++;
>=20
> The increment ought to be before the aio call so that the _cb can't see
> the value before it's accounted for.=20
>=20

Right. Same issue as above.

> > +
> > +                offset +=3D bytes;
> > +                len -=3D bytes;
> > +            }
> > +        }
> > +
> > +        if (*discards) {

And then we decrement here before checking for 0.

Thanks, looks better now.

> > +            status =3D NVME_NO_COMPLETE;
> > +        } else {
> > +            g_free(discards);
> > +            req->opaque =3D NULL;
> > +        }
> > +    }
> > +
> > +out:
> > +    g_free(range);
> > +
> > +    return status;
> > +}
> > +
> >  static uint16_t nvme_flush(NvmeCtrl *n, NvmeRequest *req)
> >  {
> >      block_acct_start(blk_get_stats(req->ns->blkconf.blk), &req->acct, =
0,
> > @@ -1088,6 +1183,8 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequ=
est *req)
> >      case NVME_CMD_WRITE:
> >      case NVME_CMD_READ:
> >          return nvme_rw(n, req);
> > +    case NVME_CMD_DSM:
> > +        return nvme_dsm(n, req);
> >      default:
> >          trace_pci_nvme_err_invalid_opc(req->cmd.opcode);
> >          return NVME_INVALID_OPCODE | NVME_DNR;
> > @@ -2810,7 +2907,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice=
 *pci_dev)
> >      id->cqes =3D (0x4 << 4) | 0x4;
> >      id->nn =3D cpu_to_le32(n->num_namespaces);
> >      id->oncs =3D cpu_to_le16(NVME_ONCS_WRITE_ZEROES | NVME_ONCS_TIMEST=
AMP |
> > -                           NVME_ONCS_FEATURES);
> > +                           NVME_ONCS_FEATURES | NVME_ONCS_DSM);
>=20
> I think we should set ID_NS.NDPG and NDPA since there really is a
> preferred granularity and alignment.
>=20

Yeah. I had some issues with doing this reliably. But I think I nailed
it, see my v4.

> > =20
> >      id->vwc =3D 0x1;
> >      id->sgls =3D cpu_to_le32(NVME_CTRL_SGLS_SUPPORT_NO_ALIGN |
> > --=20
> > 2.28.0
> >=20

--=20
One of us - No more doubt, silence or taboo about mental illness.

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+RNgsACgkQTeGvMW1P
DemNBQf+K6nuekK5BDgS2kGm9K394+rcHiN6pqxiBgs2yAII8QSc//yBSPTk/J46
Q93gpDxjBZweDDR99SdurJSOR7Lyr+jBUwrvOnpwDqKaXFIG5HwqHOcRJiNPBd9Z
bI0kana4D2Y3eVxRdn8WPvrLdz1kr9ujy7JLiGbjT4hCJXqcgiEt8TNQsEnJV5Xb
tDQlROrt1Z9FitmES+DB4neV/+jZRFhq8LjMmloAVCQe8hqBSXwMBHcvuHl/AusG
/NCi6TOl0A3nx+dfd0F/8amkLbEeBGuiC1W3c4PYKodIg9i7Fpnd292rcHqfanUT
ygvWI0UZF3uCL9DugbIstvIOqzKGAQ==
=EWBr
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--


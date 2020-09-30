Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA13C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 18:26:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C2CB2076A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 18:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C2CB2076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNgoH-0008Fz-VX
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 14:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNgl3-0006ei-JX; Wed, 30 Sep 2020 14:23:17 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:57747)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNgkz-0007pZ-3k; Wed, 30 Sep 2020 14:23:17 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id BEEFC58011B;
 Wed, 30 Sep 2020 14:23:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Wed, 30 Sep 2020 14:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=RmvVbLqkpqecrwNMAU60OZYGT1N
 O9SBAzxAou03hDvc=; b=eSlXl66L2UIYgI6MXTy3zcaC+K1nGdT7/3dQtp7+CS3
 oKksDZdQA4nQLDhKhQ0tDwOIYGQGu2Fp9iqHyqpJADbsr7EsVjvr9RDuTbzMrOXG
 0JU3Jkcaqk1X53bHQFVwAzsV/O/EfPhZy4LvSnWYnRnGPUkDP2cX1z8Ehoq6L/Jj
 LfExh3t/DTNFTocMl7yh1rkHXHm25QffRXhzeqLerWclFXEitPPMQGFM6Qd6blQE
 EBOPMYIjpfOKTmy3ItTVoHQ+He5vYcRsIZZiiBzAm8wS8NMs+wvk0f32ewPMdHnS
 QgAywgDewSe6pnsqWevK6isxpnuGzBn9QFf5HZMGDGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=RmvVbL
 qkpqecrwNMAU60OZYGT1NO9SBAzxAou03hDvc=; b=fDtVQT7y6pBkDglYLGaAf/
 OxiiCIG8h8mTVCXx6Vuyo8HiCXwhv65aEiM/3DPQzRiNiP/zVmiBt7yesEpTodjw
 cp/FTxHKlqAZ2H58yZUSruB86ZHCZBNCQIloXPaB4ntKVDJpOkgQU+m2xVVV9bSx
 vTRA5Si1nn17E23A1/S5YVEGbX9N3Hjyv5o7hM01YbFWQGHH5n2DvNSS3OFxQM/p
 XkwoTpTwaEOwQP/QQ2e7NDF34kpZXR8+7Vo+CUR1/FjeI2aqpT2w5y0ewfIbBeKu
 xRbpqQi7nZZVL0EsReQFMf0jwv8Y63bWdxrYxHF20YjCzXmz5iYKSZYJOngYj/Hg
 ==
X-ME-Sender: <xms:Cs10X2HMKtU1-7GEeRkPjuVFONhK88uaVfMGCW62DzdfSoK1pzEKBA>
 <xme:Cs10X3VHOga6sic6iO8x_xOpe6RyG0AhCwysYFEe0Gcrfr-djNmLKMCjYB4x5ajJl
 6hvNOPpGdNmiIM6iuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfedvgdduvdduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:Cs10XwLjP1AzSy_4rregOGqvWtrGOrPPxA6YK7UYU4vJ-mB_eNpXsA>
 <xmx:Cs10XwHg4tc8RudRKVq25AdIIA6LRKo-ypJjh_PbxzKdkEibVvQJSQ>
 <xmx:Cs10X8UKClyogpFwW1u1vV2OUslkpHe0UaWOb270F-UKO2FdmneBKg>
 <xmx:C810X1PYTMSftb2A6jyxFqwpxjvfDG3REqV6XQH-OyHPBijUa17b2hrr-X4>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 9ACE73280064;
 Wed, 30 Sep 2020 14:23:04 -0400 (EDT)
Date: Wed, 30 Sep 2020 20:23:02 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH v5 09/14] hw/block/nvme: Support Zoned Namespace Command
 Set
Message-ID: <20200930182302.GA566382@apples.localdomain>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
 <20200928023528.15260-10-dmitry.fomichev@wdc.com>
 <20200930145016.GB204568@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <20200930145016.GB204568@localhost.localdomain>
Received-SPF: pass client-ip=66.111.4.221; envelope-from=its@irrelevant.dk;
 helo=new1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 14:23:07
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 30 14:50, Niklas Cassel wrote:
> On Mon, Sep 28, 2020 at 11:35:23AM +0900, Dmitry Fomichev wrote:
> > The emulation code has been changed to advertise NVM Command Set when
> > "zoned" device property is not set (default) and Zoned Namespace
> > Command Set otherwise.
> >=20
> > Handlers for three new NVMe commands introduced in Zoned Namespace
> > Command Set specification are added, namely for Zone Management
> > Receive, Zone Management Send and Zone Append.
> >=20
> > Device initialization code has been extended to create a proper
> > configuration for zoned operation using device properties.
> >=20
> > Read/Write command handler is modified to only allow writes at the
> > write pointer if the namespace is zoned. For Zone Append command,
> > writes implicitly happen at the write pointer and the starting write
> > pointer value is returned as the result of the command. Write Zeroes
> > handler is modified to add zoned checks that are identical to those
> > done as a part of Write flow.
> >=20
> > The code to support for Zone Descriptor Extensions is not included in
> > this commit and ZDES 0 is always reported. A later commit in this
> > series will add ZDE support.
> >=20
> > This commit doesn't yet include checks for active and open zone
> > limits. It is assumed that there are no limits on either active or
> > open zones.
> >=20
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
> > Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
> > Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > Signed-off-by: Matias Bjorling <matias.bjorling@wdc.com>
> > Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
> > Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> > ---
> >  block/nvme.c         |   2 +-
> >  hw/block/nvme-ns.c   | 185 ++++++++-
> >  hw/block/nvme-ns.h   |   6 +-
> >  hw/block/nvme.c      | 872 +++++++++++++++++++++++++++++++++++++++++--
> >  include/block/nvme.h |   6 +-
> >  5 files changed, 1033 insertions(+), 38 deletions(-)
> >=20
> > diff --git a/block/nvme.c b/block/nvme.c
> > index 05485fdd11..7a513c9a17 100644
> > --- a/block/nvme.c
> > +++ b/block/nvme.c
> > @@ -333,7 +333,7 @@ static inline int nvme_translate_error(const NvmeCq=
e *c)
> >  {
> >      uint16_t status =3D (le16_to_cpu(c->status) >> 1) & 0xFF;
> >      if (status) {
> > -        trace_nvme_error(le32_to_cpu(c->result),
> > +        trace_nvme_error(le32_to_cpu(c->result32),
> >                           le16_to_cpu(c->sq_head),
> >                           le16_to_cpu(c->sq_id),
> >                           le16_to_cpu(c->cid),
> > diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
> > index 31b7f986c3..6d9dc9205b 100644
> > --- a/hw/block/nvme-ns.c
> > +++ b/hw/block/nvme-ns.c
> > @@ -33,14 +33,14 @@ static void nvme_ns_init(NvmeNamespace *ns)
> >      NvmeIdNs *id_ns =3D &ns->id_ns;
> > =20
> >      if (blk_get_flags(ns->blkconf.blk) & BDRV_O_UNMAP) {
> > -        ns->id_ns.dlfeat =3D 0x9;
> > +        ns->id_ns.dlfeat =3D 0x8;
>=20
> You seem to change something that is NVM namespace specific here, why?
> If it is indeed needed, I assume that this change should be in a separate
> patch.
>=20

Stood out to me as well - and I thought it was sound enough, but now I'm
not sure sure.

DLFEAT is set to 0x8, which only signifies that Deallocate in Write
Zeroes is supported. Previously, it would also signify that returned
values would be 0x00 (DLFEAT 0x8 | 0x1). But since Dmitry added the
fill_pattern parameter...


> > +static int nvme_zoned_init_ns(NvmeCtrl *n, NvmeNamespace *ns, int lba_=
index,
> > +                              Error **errp)
> > +{
> > +    NvmeIdNsZoned *id_ns_z;
> > +
> > +    if (n->params.fill_pattern =3D=3D 0) {
> > +        ns->id_ns.dlfeat |=3D 0x01;
> > +    } else if (n->params.fill_pattern =3D=3D 0xff) {
> > +        ns->id_ns.dlfeat |=3D 0x02;
> > +    }

=2E.. then, when initialized, we look at the fill_pattern and set DLFEAT
accordingly instead.

But since fill_pattern only works for ZNS namespaces, I think dlfeat
should still be 0x9 for NVM namespaces. For NVM namespaces, since
neither DULBE or DSM is not supported, there is really only Write Zeroes
that can explicitly "deallocate" a block, and since that *will* write
zeroes no matter if DEAC is set or not, 0x00 pattern is guaranteed.

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl90zQQACgkQTeGvMW1P
Denxxgf8CFNZl/Cj2qQJBpHFv1K615a8qmmWDatKwbFYSyNaX+4RU1OZljmoEn9S
6rD5GN3FkznB3NEUgjwd6xDN07qwmZwpFWHFHWcV8+F7Q1ApijtqXLQwtdnra7RF
WjzR8c6smFvZo5VNmOO5Ywzbs/7Vj1Rzd9YWHtaH89se8pRy/YPXH0ixOgjWymkv
bas+0aQPRo0Xs2quytZE+G3M53nm4cQfXUSfc4fafXFPjm6tXuaAIj+XYWzk/ltI
eXoU3+pqYu70ClJH6H731R/ZyE87uYJRu8mUJJMvyKqAwVqH35xHmJZ3lZYUZ31s
0xbHzFibnzgnEOGw7IMtqGpjB6MGPQ==
=Ayl5
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--


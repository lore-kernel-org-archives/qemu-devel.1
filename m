Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CE5C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 06:03:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39810206DC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 06:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39810206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNVDP-00037T-4O
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 02:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNV9W-0002N0-Gj; Wed, 30 Sep 2020 01:59:47 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:46251)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNV9U-00064i-7i; Wed, 30 Sep 2020 01:59:46 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id EB67A1276;
 Wed, 30 Sep 2020 01:59:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 30 Sep 2020 01:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=PFUEuS0AUHZaqMhYuViNKbh5Kwx
 oy57qZHNN3JYmbJA=; b=V/yn9Fwkt93RP3BWJFXvDqL3FW0TJLHaMsWf+d0Kt/S
 NeR3Z6kz5a3ddFi2nK2PAgVCmZl751Vnj+4VqH/WiN/j6o+DZCXiKdhHRaqqZfmm
 24u5NK2jA4QYzujfGeQ7tFax+f3vmz7aKLabNoMw4qXXmVsW4YjVWP9ovNQA2UWt
 sRqqY5GYQwucBgbdQz+m5ecs/XBG+NC7h32FUpr67tl6+ki9M77dVTk/OciWNhe5
 zZ4mQ293B1GEEuuDzc770r4dSZln83idvEQjZVR0cTXyeckl75Fw4C1z6V/IK7nO
 PyxduVLFsZK4bctQynOVkeVro27n+Hg42D7ogLMxW0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=PFUEuS
 0AUHZaqMhYuViNKbh5Kwxoy57qZHNN3JYmbJA=; b=bN/xGlFoH4awwkIy3kkRkl
 ZiVFQoWUbhwSnQOVvonVm4mYQzQQ2GANXnchnhIH8ziFAj8WWF5RaWY+9Jz3kKNH
 OV9HBfzdoPGSQMaaDVULeKFhQi6M8ZUk6Pq2PYZTHDBzgk/wg1t8rCV9Z8Y95Gz6
 DulFb94rXiHUPoG+awaPX7Jx2sjV67y8SGDRuvdDetdmgu072VteCyoy9LnMVHYy
 OIAQ2KH/1dOxXbcuyP/qelHQbVFHDBylM2gZoF+HJPXKQzzDi9rRV2uXCbUwGQgi
 V90spqMWfp4cFS5N4aTNy/ongnV6UxtQoyodncYRT51RFUE9S93OOyNbyp1iHiDQ
 ==
X-ME-Sender: <xms:yx50X3UwsaYnAK_gVyNXYju27_KrVTdCbw3-sNBl_m1My5sBuxA_0g>
 <xme:yx50X_nbzJQDbXhGMY3kd0wJrAIo4i3UlS-9KymUGe6uwVPFSwi_zYIwfIgMixF98
 7Nbg3wA_ntvU_EwQ4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfedtgddutddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:yx50Xza3xxdmGxE_4H97fcGH20EA8i7U9QaQt2PAFgKoQnQaq7Vg2g>
 <xmx:yx50XyXyTo1JWdbj8UN0fBErQNCVfd3BGvYDG7G3m1OdrHF-zXUO0A>
 <xmx:yx50XxkciqT5srKcILG7hMzaDofowxaMdCztATD0GzNap_v085X9FQ>
 <xmx:zB50X3dHVabNmHFrU328JvhmyC_L_9WHp7wFjIbniEjLis9EVgYm1erO1Ep3q23s>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 80D00306467D;
 Wed, 30 Sep 2020 01:59:37 -0400 (EDT)
Date: Wed, 30 Sep 2020 07:59:35 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v5 09/14] hw/block/nvme: Support Zoned Namespace Command
 Set
Message-ID: <20200930055935.GB436843@apples.localdomain>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
 <20200928023528.15260-10-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline
In-Reply-To: <20200928023528.15260-10-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=64.147.123.17; envelope-from=its@irrelevant.dk;
 helo=wnew3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 01:20:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 Niklas Cassel <niklas.cassel@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 28 11:35, Dmitry Fomichev wrote:
> The emulation code has been changed to advertise NVM Command Set when
> "zoned" device property is not set (default) and Zoned Namespace
> Command Set otherwise.
>=20
> Handlers for three new NVMe commands introduced in Zoned Namespace
> Command Set specification are added, namely for Zone Management
> Receive, Zone Management Send and Zone Append.
>=20
> Device initialization code has been extended to create a proper
> configuration for zoned operation using device properties.
>=20
> Read/Write command handler is modified to only allow writes at the
> write pointer if the namespace is zoned. For Zone Append command,
> writes implicitly happen at the write pointer and the starting write
> pointer value is returned as the result of the command. Write Zeroes
> handler is modified to add zoned checks that are identical to those
> done as a part of Write flow.
>=20
> The code to support for Zone Descriptor Extensions is not included in
> this commit and ZDES 0 is always reported. A later commit in this
> series will add ZDE support.
>=20
> This commit doesn't yet include checks for active and open zone
> limits. It is assumed that there are no limits on either active or
> open zones.
>=20
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
> Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Signed-off-by: Matias Bjorling <matias.bjorling@wdc.com>
> Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  block/nvme.c         |   2 +-
>  hw/block/nvme-ns.c   | 185 ++++++++-
>  hw/block/nvme-ns.h   |   6 +-
>  hw/block/nvme.c      | 872 +++++++++++++++++++++++++++++++++++++++++--
>  include/block/nvme.h |   6 +-
>  5 files changed, 1033 insertions(+), 38 deletions(-)
>=20
> diff --git a/block/nvme.c b/block/nvme.c
> index 05485fdd11..7a513c9a17 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> +static int nvme_calc_zone_geometry(NvmeNamespace *ns, Error **errp)
> +{
> +    uint64_t zone_size, zone_cap;
> +    uint32_t nz, lbasz =3D ns->blkconf.logical_block_size;
> +
> +    if (ns->params.zone_size_mb) {
> +        zone_size =3D ns->params.zone_size_mb;
> +    } else {
> +        zone_size =3D NVME_DEFAULT_ZONE_SIZE;
> +    }
> +    if (ns->params.zone_capacity_mb) {
> +        zone_cap =3D ns->params.zone_capacity_mb;
> +    } else {
> +        zone_cap =3D zone_size;
> +    }

I think a check that zone_capacity_mb is less than or equal to
zone_size_mb is missing earlier?

> +static int nvme_zoned_init_ns(NvmeCtrl *n, NvmeNamespace *ns, int lba_in=
dex,
> +                              Error **errp)
> +{
> +    NvmeIdNsZoned *id_ns_z;
> +
> +    if (n->params.fill_pattern =3D=3D 0) {
> +        ns->id_ns.dlfeat |=3D 0x01;
> +    } else if (n->params.fill_pattern =3D=3D 0xff) {
> +        ns->id_ns.dlfeat |=3D 0x02;
> +    }
> +
> +    if (nvme_calc_zone_geometry(ns, errp) !=3D 0) {
> +        return -1;
> +    }
> +
> +    nvme_init_zone_meta(ns);
> +
> +    id_ns_z =3D g_malloc0(sizeof(NvmeIdNsZoned));
> +
> +    /* MAR/MOR are zeroes-based, 0xffffffff means no limit */
> +    id_ns_z->mar =3D 0xffffffff;
> +    id_ns_z->mor =3D 0xffffffff;
> +    id_ns_z->zoc =3D 0;
> +    id_ns_z->ozcs =3D ns->params.cross_zone_read ? 0x01 : 0x00;
> +
> +    id_ns_z->lbafe[lba_index].zsze =3D cpu_to_le64(ns->zone_size);
> +    id_ns_z->lbafe[lba_index].zdes =3D 0; /* FIXME make helper */
> +
> +    ns->csi =3D NVME_CSI_ZONED;
> +    ns->id_ns.ncap =3D cpu_to_le64(ns->zone_capacity * ns->num_zones);
> +    ns->id_ns.nuse =3D ns->id_ns.ncap;
> +    ns->id_ns.nsze =3D ns->id_ns.ncap;
> +

NSZE should be in terms of ZSZE. We *can* report NCAP < NSZE if zcap !=3D
zsze, but that requires bit 1 set in NSFEAT and proper reporting of
NUSE.

> @@ -133,6 +304,14 @@ static void nvme_ns_realize(DeviceState *dev, Error =
**errp)
>  static Property nvme_ns_props[] =3D {
>      DEFINE_BLOCK_PROPERTIES(NvmeNamespace, blkconf),
>      DEFINE_PROP_UINT32("nsid", NvmeNamespace, params.nsid, 0),
> +
> +    DEFINE_PROP_BOOL("zoned", NvmeNamespace, params.zoned, false),
> +    DEFINE_PROP_UINT64("zone_size", NvmeNamespace, params.zone_size_mb,
> +                       NVME_DEFAULT_ZONE_SIZE),
> +    DEFINE_PROP_UINT64("zone_capacity", NvmeNamespace,
> +                       params.zone_capacity_mb, 0),

There is a nice DEFINE_PROP_SIZE that handles sizes in a nice way (i.e.
1G, 1M).


--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl90HsUACgkQTeGvMW1P
DekGvwf9FnhFGL24nmDtdNxH5rQ9hdqg50QODYx3ru+lyvvLPL0EhCCEs11AIik+
GcSBb+rAOFBLfxaCiRm8tv/wZmlhGjSD/XuzxXYsPB48xoPM+che0Rpb9lfQoTj5
EpplUToB0tCb5iv5TYDy+CPJKpG2oututsqa8q575VgPtGD6aoLnMcxwMlUbei98
ovI77PP9xrDElSApcG6UZfJCOZx/7JljX+eAuk0/qf/n93yZGrKG3hprpOgUqT35
ZFlqxUad+ezMnkz4JO26f7WnNTjZWfnUzS6l5e8yNjYhcR2EJQfLmIGmzgkQoB4I
eqmVWzlJzxBIYqyDUbsiGWffCqFCCg==
=y8K4
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--


Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353C3C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 07:38:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2AD920EDD
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 07:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2AD920EDD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI5XW-0007ze-7H
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 03:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kI5U2-0005vK-49; Tue, 15 Sep 2020 03:34:34 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:59917)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kI5Ty-0005Mn-GN; Tue, 15 Sep 2020 03:34:32 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id C4B7F5802F0;
 Tue, 15 Sep 2020 03:34:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Tue, 15 Sep 2020 03:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=xpdyGkRwSe1JWAyRl7eIgZCLCrj
 u4VM1mI992ntlmpk=; b=X9RftKA6qQtBD/I7JaipdDDds7G85PA3QFMKR5phWR8
 ohHLNk9O04KYyjE1wIdjRNV53RV75sdM7z9DP4dFrbwn20w+HAOQW35cIqJx/MYL
 IWrKzR6GEyvSnsXYQSjy09QdbUL+kDifBOZY92+8v+GibHpAtRtcn/iOj45NoGFh
 bTRklmNvevJ71kCEL7KdFcSheDm+KpnLPy4rH2WYxPe1MrZ2kgMFJwVH/P4RyVeq
 en1onGl12BLa9SWohYQlXxvQUeHTTtcdcChz6YoChP3zMKIx5rTWFonjxFAO9UvX
 +wkvImgSSGlBQvNazUzCws/V3qwbAeLi8/kleP5PSaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=xpdyGk
 RwSe1JWAyRl7eIgZCLCrju4VM1mI992ntlmpk=; b=FA+xQG/ZNTaUDM3A8SfRuO
 b3YMh4oaBXDa9TG/Q7cnh/2JfBH1axkd16hwhPskTA8dq1CKfrsipW8tdpK2h8TM
 +7NWwPwmLjcYXpb+aOSRSrLnkxBzGdxpwmWplSE3lSRUDQMhS48p1sQ/FDeEqogX
 v2treZiipRlY3XCVn0eyyD74o5uQSD8hArw+ueimXut/XeIjFaC9qoPXqdubqm9A
 alyRiAp/nT2pD6Rs6gvoKpHx+EoLmj5uskH8zhm0jpaiHjjEdKxOJ5dTLQkJNrhx
 MbMNgCGmN4m2EqY8ALaYidmssgWqgfMnKdTiLFEzvBBT7beaktzfHBU5d/iwKLuw
 ==
X-ME-Sender: <xms:gW5gX_unMMNDr8XX0zy_CHzAYovJ5edxdfL_yeMZ5XoGLXcsnmGo3Q>
 <xme:gW5gXwck_Z8LsAcY7vDtamMU44sFQwokKzcwaGikZoBODitOyqCRzx7LyAOJFql4g
 AhluoHzZ4zlW3YnFHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudeijedguddujecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvddu
 ffeknecukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:gW5gXyz5-syDCrI-o-j69cJDWVnkK7uP0X-aAAUzmhzScLTxVpTIdA>
 <xmx:gW5gX-MLLeTYendGxUhaT7kFshX-EOKP5ic9KNs6n7TdYvnYzZTyMQ>
 <xmx:gW5gX__FY6v_WEXcQ_y-V6Wl1r7uq8YylTqcEV_XIOWoERcwQtvdpQ>
 <xmx:gm5gX-XZ-zGZw7-MlfO2lLDfRT_6M1qsaqwaoR62wf4grttK789Nq2h75qE>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 6B2A7328005A;
 Tue, 15 Sep 2020 03:34:23 -0400 (EDT)
Date: Tue, 15 Sep 2020 09:34:21 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v3 02/15] hw/block/nvme: Report actual LBA data shift in
 LBAF
Message-ID: <20200915073421.GA499689@apples.localdomain>
References: <20200913221436.22844-1-dmitry.fomichev@wdc.com>
 <20200913221436.22844-3-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <20200913221436.22844-3-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=66.111.4.224; envelope-from=its@irrelevant.dk;
 helo=new2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 03:34:26
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


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 14 07:14, Dmitry Fomichev wrote:
> Calculate the data shift value to report based on the set value of
> logical_block_size device property.
>=20
> In the process, use a local variable to calculate the LBA format
> index instead of the hardcoded value 0. This makes the code more
> readable and it will make it easier to add support for multiple LBA
> formats in the future.
>=20
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  hw/block/nvme.c |  4 +++-
>  hw/block/nvme.h | 11 +++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 3a90d80694..1cfc136042 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -2203,6 +2203,7 @@ static void nvme_init_namespace(NvmeCtrl *n, NvmeNa=
mespace *ns, Error **errp)
>  {
>      int64_t bs_size;
>      NvmeIdNs *id_ns =3D &ns->id_ns;
> +    int lba_index;
> =20
>      bs_size =3D blk_getlength(n->conf.blk);
>      if (bs_size < 0) {
> @@ -2212,7 +2213,8 @@ static void nvme_init_namespace(NvmeCtrl *n, NvmeNa=
mespace *ns, Error **errp)
> =20
>      n->ns_size =3D bs_size;
> =20
> -    id_ns->lbaf[0].ds =3D BDRV_SECTOR_BITS;
> +    lba_index =3D NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
> +    id_ns->lbaf[lba_index].ds =3D nvme_ilog2(n->conf.logical_block_size);

Instead of defining a new function, we can directly use clz32().

  31 - clz32(n->conf.logical_block_size)

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9gbngACgkQTeGvMW1P
Dembrgf+M/ZAP7pZidqagSyuJjlAjzdsVVCMwElffmlW3cFziDsxzNqwnTDAb64/
BMAyGDmPt9WWSI6fCIVbGQ/lY6uQD6S1LPWjnQrDz7y5kkpTwMFie7yWBw7bgSCT
tGTJWAz5lIGbCyJQz9/+tzpB6HCvVSGEn6Bao/j8z4Qbh1+5u6JRvuhqW3iodPas
tZK34r2v/aqnTJCEwJfSkfzbSE3NRYhJ8LOWpDyiluYwb8Ux9HvBmoAWgGO/vjvg
4oDPSE6Nc0ePH5m71W2u5BVp6hQUstqMptTdGhBAxPpTuaGbHHAYeLEUHIOorPN5
VYVfMSqW6TxZDNmaHCC1YMhvZHM1Nw==
=fR0V
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--


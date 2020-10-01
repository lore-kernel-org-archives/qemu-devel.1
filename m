Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947F1C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 09:51:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D30A520780
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 09:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30A520780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNvFW-0006Fn-Dr
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 05:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNvCD-00054W-Kt; Thu, 01 Oct 2020 05:48:18 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:40741)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNvCB-0004Uv-Nf; Thu, 01 Oct 2020 05:48:17 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 579BB580238;
 Thu,  1 Oct 2020 05:48:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Thu, 01 Oct 2020 05:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=eNGa8A0NWNLEK6/HKdb1Sns8cdp
 YNjNfnctkagm11gg=; b=b0ybLuTzH3GpQhfWzRjUFsJS9ND1fGYUGso5uBrGhzt
 AcPVRSR0rS9ZnnOHY8+NasWOwzK9bEb+UhQ4IRUwWSleG8y35VenuEUF365JcD1J
 R/BepEeO8yADhotU2kX27y6vrrA39I8ABaejSq8J5jC9PFvD2YwSxHyrrpa4a05q
 zBE2MNQGyxyIW9spoIABJgtovhIAXuJQ+MZkf5Zr0Foyzic3bPStHUCKcKL+pmuF
 O/clXxAD6Gv28YKll6ekuzgTG6I5n4Bh+E0UbCUSiCzZc39UxFMJjUUgCLSUb0Og
 Q/SjVvUl0qPEvbWcts3dTIrspGq6trLghYTayuFrZCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=eNGa8A
 0NWNLEK6/HKdb1Sns8cdpYNjNfnctkagm11gg=; b=pS3FYNIQRdsrCCz0NaGkCr
 ghJiUYmdc7tWUzM/lxm0hh0t41g508rYg/b1v1RGz3RiqMz3rSBEw646pV8y0WSP
 HAl+cVBCp7G23kruCa5ZLmLWUIoE1AVU+YcnxYszg6Jiyi3i4CfcnYM/xtUfv12M
 xdtD+GJvK5wumRZUVICd6XvMV1YV/hitoUiJXwjqYT5huj0OQtIj6r69lre/yu2b
 Bq/Vuyw9UwbOR9+vNWp0T2TmPBFtc6YzSsZeQLHEMCSFqlam8d9HiUhmRZTPCCRI
 V496hX8Cgoo0AYepxrbGS81CNHp4Nzk2eqVstVG3dGYe8/ON/EbeoY24g58ojD9Q
 ==
X-ME-Sender: <xms:3aV1X-_rl1IqlmHbj_1v-lLNp5A0I1wPgMU096XWIyErYCvn93pH-w>
 <xme:3aV1X-tK8rL5_lYxGKw135eUnjM1iiW8LPoRqqR09zgZbSJJgwwu4UX2vEYeCqXUM
 jO7oq5mvQyS-89Puz8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeeggddvtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeduleegrdeivddrvddujedrheejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:3aV1X0BgfbKhi0lt7OXgE5ileamLEK-up2oRfwxz7NzWhwrtO2C9bQ>
 <xmx:3aV1X2fnviPembLmPSylEsioqkdP6rvYmW4KEWxQLpn_3aJTbfXFYQ>
 <xmx:3aV1XzPVZp3Y0dHVO9DQfwfYmM1sG8T1lJH73pCoGxaLexEaR-4dyQ>
 <xmx:3aV1X-1rrRNpyRAH92L66K8TNsPxo34Pu-PnqfGIm4UopwxJBFQcjA>
Received: from apples.localdomain (unknown [194.62.217.57])
 by mail.messagingengine.com (Postfix) with ESMTPA id DF3AF306467E;
 Thu,  1 Oct 2020 05:48:11 -0400 (EDT)
Date: Thu, 1 Oct 2020 11:48:09 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 9/9] hw/block/nvme: report actual LBA data shift in LBAF
Message-ID: <20201001094809.GB688151@apples.localdomain>
References: <20200930220414.562527-1-kbusch@kernel.org>
 <20200930220414.562527-10-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
In-Reply-To: <20200930220414.562527-10-kbusch@kernel.org>
Received-SPF: pass client-ip=66.111.4.229; envelope-from=its@irrelevant.dk;
 helo=new3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 04:48:07
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
Cc: Kevin Wolf <kwolf@redhat.com>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 30 15:04, Keith Busch wrote:
> From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
>=20
> Calculate the data shift value to report based on the set value of
> logical_block_size device property.
>=20
> In the process, use a local variable to calculate the LBA format
> index instead of the hardcoded value 0. This makes the code more
> readable and it will make it easier to add support for multiple LBA
> formats in the future.
>=20
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  hw/block/nvme-ns.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
> index 2ba0263dda..a85e5fdb42 100644
> --- a/hw/block/nvme-ns.c
> +++ b/hw/block/nvme-ns.c
> @@ -47,6 +47,8 @@ static void nvme_ns_init(NvmeNamespace *ns)
> =20
>  static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
>  {
> +    int lba_index;
> +
>      if (!blkconf_blocksizes(&ns->blkconf, errp)) {
>          return -1;
>      }
> @@ -67,6 +69,9 @@ static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespace =
*ns, Error **errp)
>          n->features.vwc =3D 0x1;
>      }
> =20
> +    lba_index =3D NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
> +    ns->id_ns.lbaf[lba_index].ds =3D 31 - clz32(ns->blkconf.logical_bloc=
k_size);
> +
>      return 0;
>  }
> =20

I think that back when I reviewed this, it was before the
multi-namespace patch.

I believe this setup should move to the nvme_ns_init() function instead.

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl91pdYACgkQTeGvMW1P
DeliEggAq7pYW6SF6HydoKpQNjKR7s7uEwKAvmiTS1HlR3KKpcve7+2Xe1r7FRF4
2OMivj/TnlyF7KWVJs3q/UUHPNGCErDeYRpq6Dpe0li0A1MHTThUGGxy/VZiFWDd
UhYbZz+dxhI3Hh3D88Y3iJR2hCRFMZvzZS27gNQiPJuN/hm+H5r0qPqA1nUOqclK
7X6igWURawc0uE3ULMpb3ZASek1gnB5X5Gz1xm4SKZOZzZu7xWE3PJkd8e9YS3lz
F8r1ifrobjZll7+vopnq/9vR0kP5isX7/OWqAeP9ojKLXZ1X6X6GkVUHUrwK2098
fXQmI1FhGxxeCnBKb3GXGzjeqeMijA==
=j8XE
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--


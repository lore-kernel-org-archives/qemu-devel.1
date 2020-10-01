Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB26C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 04:21:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0506C21D92
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 04:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0506C21D92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNq6C-0002D9-Tw
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 00:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNq2Z-0000K1-DD; Thu, 01 Oct 2020 00:17:59 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:57339)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNq2X-0006Sj-Nf; Thu, 01 Oct 2020 00:17:59 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 9B6B1968;
 Thu,  1 Oct 2020 00:17:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Thu, 01 Oct 2020 00:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=WsOOW4BA06PDuvC3ZKJmoleJhNS
 vnoq4f5fbWmn6mLY=; b=VPpd1+raEHC1zv8/elHTjTXw+5kW2cjfT7p38hVKGgg
 13TGowjsE81gTRIqhQPpJf1S+3ow9I1FFY827yo07f/lMoQdjxAGnTTBVxT+cWNB
 L1TaGTaid4aoOigK88JV2P675xN4h94lFGnr+h0u83mMV21abOSypT3AILkS/Dw4
 1yqucHDfExkm4HDIm4eeOw3MLelFT9dzmsI5RmMkwAv04cBY5O3Ef/95OYqxTAZJ
 Az4MxE5BzaVWOS2bjl6hzKaEZB+S6Dfr1uugKGsoWrh+RPh81s1T1JQe2+TesTXG
 QJ3se7qwNa76QH0kWZhRfr231YZEhxKoj7bm75AlZHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=WsOOW4
 BA06PDuvC3ZKJmoleJhNSvnoq4f5fbWmn6mLY=; b=gxPoGFaXl+HgGVf3CaM43S
 Erm6ivpUpxFmm/Ylt6H1Pcq4YSVRDeth4ZSwu0gmsefPuX//nlPYRZif2ZTqW6nn
 xZbocAjaaG7pesVix0vKuII7of+PiHqPniwMLEGWPid777O19Amc4ZM+cqDXlHTb
 lKCGiF5rBKoRmHtNPNX2nT+/2zymCygw9KkqwWdQwj7SzTFwDVmXzHnhG5NLW1dA
 ERq5UCjHuWFmK1CSbL1xpTJhjTelKSSj3eMIu81yQjLn/18PGKQT8nUEtJE8SPCp
 5tTz6+XEdQbCqFK2NacURYzlnNRTnOLETCoV/PfYhRq3lgHt9APgtzoinyTWBubg
 ==
X-ME-Sender: <xms:clh1X9Ieo9hb7Cmt577c0HGdQjMyj-dOmP4v733DNOc9p7Vmx3b7wg>
 <xme:clh1X5LnspjjviA8v1XbqJxWD1hKiPFgXYH4aj1x-gg5Ln1GpXz5dBibQsI2ZW6Bj
 FnudIfE0aE3ZWmyQl8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgdekgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:clh1X1sdMs7zAu9c-1_ld-1aBUUzZjSBUCYBYvoe38pYLNGWWgLTFQ>
 <xmx:clh1X-atfRDDE_L_3JxQ6KGHdK8XSuFqw9rkoI70eWwFRFDp4gmNGg>
 <xmx:clh1X0ZzC_B2CPr05jkpKWPYIOtYyYL_ghM6NtmEmlya48NYi1AhBg>
 <xmx:c1h1XzyaQJngNi8AqbZgKikOiWIz7JE8j4h6TvAl_JaeoiyqkCsKpsBvpX4>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id AC5503280059;
 Thu,  1 Oct 2020 00:17:53 -0400 (EDT)
Date: Thu, 1 Oct 2020 06:17:51 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 5/9] hw/block/nvme: support for admin-only command set
Message-ID: <20201001041751.GE681387@apples.localdomain>
References: <20200930220414.562527-1-kbusch@kernel.org>
 <20200930220414.562527-6-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
Content-Disposition: inline
In-Reply-To: <20200930220414.562527-6-kbusch@kernel.org>
Received-SPF: pass client-ip=64.147.123.17; envelope-from=its@irrelevant.dk;
 helo=wnew3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 00:05:15
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
Cc: Kevin Wolf <kwolf@redhat.com>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 30 15:04, Keith Busch wrote:
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

>  hw/block/nvme.c      | 1 +
>  include/block/nvme.h | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 6c582e6874..ec7363ea40 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -2755,6 +2755,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *=
pci_dev)
>      NVME_CAP_SET_CQR(n->bar.cap, 1);
>      NVME_CAP_SET_TO(n->bar.cap, 0xf);
>      NVME_CAP_SET_CSS(n->bar.cap, NVME_CAP_CSS_NVM);
> +    NVME_CAP_SET_CSS(n->bar.cap, NVME_CAP_CSS_ADMIN_ONLY);
>      NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
> =20
>      n->bar.vs =3D NVME_SPEC_VER;
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index bc20a2ba5e..521533fd2a 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -83,7 +83,8 @@ enum NvmeCapMask {
>                                                              << CAP_PMR_S=
HIFT)
> =20
>  enum NvmeCapCss {
> -    NVME_CAP_CSS_NVM =3D 1 << 0,
> +    NVME_CAP_CSS_NVM        =3D 1 << 0,
> +    NVME_CAP_CSS_ADMIN_ONLY =3D 1 << 7,
>  };
> =20
>  enum NvmeCcShift {
> --=20
> 2.24.1
>=20
>=20

--=20
One of us - No more doubt, silence or taboo about mental illness.

--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl91WG0ACgkQTeGvMW1P
DekzcAgAou+0TEfLzjh7RegpXjf9/DM65jauqYxhlA6zIFRzFNhK3UoMDpZZMVsl
r2t+L/gqr+hfd4xZGOTbqIsYs/WUXO61f52CgffMi1oB1XVlB8S7UxfFWk2nfr0y
iitLiUzhKmFQjy07mXL1aZNL1zsHW4routey1crH0b6KV3Yg/4t5EWHzVdVkH6Ui
TTK1HzIXM3SVmfAOxCK9xsAg5B8PxU2rigxT5l8EI3hVjNbF4Yh299Op0pvSEZDh
q4mYW4kDjMBjS9iywmy0maKvEUgW8DCWawsV+PWBga6sDINkTN6/E7vaF4bJU22B
tjx68LSx8XfizuaMoktL7mU2E5o3ZQ==
=1UVF
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--


Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518BDC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 08:11:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC4B7206C3
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 08:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4B7206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNXD3-0006bW-KX
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 04:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNX9o-0004mC-O1; Wed, 30 Sep 2020 04:08:12 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:36745)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNX9m-0005hc-7d; Wed, 30 Sep 2020 04:08:12 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id D4590127F;
 Wed, 30 Sep 2020 04:08:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 30 Sep 2020 04:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=+chTE+w9LCifXi4C319MWuGz1J5
 Xqzizkao5TEbrelI=; b=Zw8jMHNc/xMoO0+TmKCowEDaFQEqu5ejRYEiBVYlqG0
 pzXWO5N9A7Jgwt90UPBsdSBcvEAFqCpMZmdmL/8W6yyveSG6sJeiGpileM05Pn2a
 D55RCPH5T7EarRuUNf+mCdDmQhGRakv9YLeQ15EyWDh1DyxzQdUZe1QkpN4RRB7t
 ngt0WGO9tx8v/EmMjyszD5mPCFwVrGjzkzhw0f9VZE5ETQ5vb6V66DoKVawG9qBl
 oMha1jUMeJOkN/dw9AUqGPRPAtdf6f4AxMRdY6dxQGMjd9cTTAe17adxBIuZEnNk
 HERDD86BCCjemN5rgPMX234ceYVulRbUEodjFra/hTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=+chTE+
 w9LCifXi4C319MWuGz1J5Xqzizkao5TEbrelI=; b=k4Kg2GunAwIYPxlW22tGws
 xG0D4hdK3rDm+I9JxVFK+J3O2fy4J+xP189ZLxIpELHOYtccwbT2ob9POPJmp1w/
 CkIadSeK57j04pPhPZoUQLDxhBRokUEtpvygn79dN6M/Z954oV+WL2htVLo+A9ae
 VgQnnzPcBYs4eMf8/75ily4/7PQzQuuGwUI5e36ETQya1gk9gPl1kDWDQuBjYvTD
 Kufl1EDiwz66xgsSD3fmKA/tt8LDVpIOPwOM5mB/tJCXO+GuLjrPA9Ofs9VTiayx
 psXFppew6vGEf0p+wmUDj3XBInXo2kSNIGDoladxHKLQPAOTnW1wn+xJA2+++Klg
 ==
X-ME-Sender: <xms:5Dx0X6uOaGA3iFjlWQspKkghPU5g6qDJxBGTm9eAgwmfbxa5usZtzw>
 <xme:5Dx0X_d8TBTjL2w6JjcyNJ1MbiaWlFGCz_qSd_X8Hriqus9NUaYF7Tg5sBeU1LQCD
 rziMdRes_wHOnGrk8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfedtgdduvdejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:5Dx0X1x367nXkjQfbvHZv-BL_z5Z-U1kly57vfygwV3P-ZdLtfsA2Q>
 <xmx:5Dx0X1PmMcwFCITBE_OPLzzLVywKIb4eY5u5J1xyLGbG-fnrsKm-NQ>
 <xmx:5Dx0X69n9VBgZ0s0zU6ZCY3FooqkgLD6z9PqAw-EvLmxuxWUZ82WMQ>
 <xmx:5jx0X9Wtr7xhEFXdaNg2L4aFdYb2U1APsMzgvMqJXqUY4sOR86jeFybWd3KwMfbY>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 2188F3064610;
 Wed, 30 Sep 2020 04:08:03 -0400 (EDT)
Date: Wed, 30 Sep 2020 10:08:01 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v5 03/14] hw/block/nvme: Introduce the Namespace Types
 definitions
Message-ID: <20200930080801.GC436843@apples.localdomain>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
 <20200928023528.15260-4-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Content-Disposition: inline
In-Reply-To: <20200928023528.15260-4-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=64.147.123.26; envelope-from=its@irrelevant.dk;
 helo=wnew1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 04:08:08
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


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 28 11:35, Dmitry Fomichev wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
>=20
> Define the structures and constants required to implement
> Namespace Types support.
>=20
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  hw/block/nvme-ns.h   |  2 ++
>  hw/block/nvme.c      |  2 +-
>  include/block/nvme.h | 74 +++++++++++++++++++++++++++++++++++---------
>  3 files changed, 63 insertions(+), 15 deletions(-)
>=20
> diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
> index 83734f4606..cca23bc0b3 100644
> --- a/hw/block/nvme-ns.h
> +++ b/hw/block/nvme-ns.h
> @@ -21,6 +21,8 @@
> =20
>  typedef struct NvmeNamespaceParams {
>      uint32_t nsid;
> +    uint8_t  csi;
> +    QemuUUID uuid;
>  } NvmeNamespaceParams;

The motivation behind the NvmeNamespaceParams was to only keep user
visible parameters in this struct.

Can we move csi/uuid to the NvmeNamespace struct?

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl90PN8ACgkQTeGvMW1P
Dem3UAgAvv8oVpvgw6sGD5xy6+XXn+lfmGneLSOzYZvW5j0K/JSv66vjBcNCJ0Uf
KhdQKsVeHThrNL3lVP/ihX/y8OIpM7ISiLixeeMKYsb352zpObPyy4pJVaeK2r0f
Yaa3vpDtA3+EKHRL0rg5CDXYeYQrrUhhPiNkDWgj64KClEIX8EPYr1YUC1MTXhOG
prBIlCPq0jxcB+aMX8Sl1phOYs8rXpeAt7gAS99bLdn5s6iCx/SCyNpfQIQlkqqj
xVAP0lgtP52cPCmAf00v03gyzC7o5jq8Yff5E0px7clgOAFmSiboe3ys0L/cIN19
UYU9G9KO3VErVXKrgnRuBcW5AX4Gjw==
=79CQ
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--


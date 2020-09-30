Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FD4C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 05:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3196820659
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 05:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3196820659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNUa4-0003iS-NU
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 01:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNUXK-00033v-If; Wed, 30 Sep 2020 01:20:18 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:52363)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNUXH-0003u6-Dv; Wed, 30 Sep 2020 01:20:18 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 3E273FBE;
 Wed, 30 Sep 2020 01:20:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 30 Sep 2020 01:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=C/zWVrHC30R/bCgWTYh7te3fcBv
 7ghHQsN7+soORE9M=; b=PeDj/HsEkKPOuJA/hjy7OMhuurtBpQHSVAW98h4NDZ4
 hs24Hx3cDVTkW/eo0sAaLXplrBcs4gKJvtEVu6TLo1hh8cwi5Gz2J8yvSOipQxJl
 pLpGDa1wrAcG4GNTmFV7U+Ql021QyEhAUUWPg2AR4eU6DnYNH64JZShe3WC9mRgF
 wWjdAioejlJQpygJq/+GkXoRAlt4o8fvHooDO9AqQdRJvfs0cG45Jals1K7NGTbR
 VYk80ap3St9AsI83J+mlYCn4WNcRuTkU0I06lwXIr3r91FZAW4vlieek2H5zVQbQ
 smLOLVrd0P6w1IxDp3YgHiORabP3Maj7CP01Yq3bvTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=C/zWVr
 HC30R/bCgWTYh7te3fcBv7ghHQsN7+soORE9M=; b=oaZZBzvVaEePF3+/hVnvk5
 V6gGq4m/b3QYF/C1WCp3vbzC23jNdbV7OqpzCCvw03MBCJCesJMlXcdHtHaha1CI
 Lss528FOjadyZd3Mvkdy+BNurFemI0Setp0Uk/HnVb46Au7nDwnhVhH0/rjwhrOq
 nryN/4A9leguMBOEyMmYxVsPNazURsNemUIl+ZnVwJt27ca9YQWH3/vbhKqkfmu7
 1gowiQ71yOPUakG703Bas9g7+6Uxj1yxs8pUFb7/CSKJbiVIgHsLxaspcL03LPNC
 eVpq5B+mqpqNQ57FXVrgjOkHrUD/MgR0oOOzgLu2eNxPQFSvZnZCFKx4gM0LO7Ew
 ==
X-ME-Sender: <xms:ihV0X9TgyhkEI2lU2GOb8QvTvmuA0fR_3zaFbgF_j8l76fP5TV7Ngw>
 <xme:ihV0X2xOxqRVhzaFf9s4XeLed9zn8oaEGS6EwONQNiUPsNxs8S3-wVPNYZgOFjf15
 MyL9ZhlJSyFPgIkYtE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfedtgdelvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:ihV0Xy3E1D1ImbviPz8Bsd15zX1elx-RaiFPBfutCL1sJOO2ZT7ruQ>
 <xmx:ihV0X1BhN6CohzWsiZzZgbqiLbQe33m9MU37iMB3hTzePVieNWiFvA>
 <xmx:ihV0X2gTBkt1IFNvtcUiRkY5zGmKk69ZgcXq0snyTSzCfkSx21kb2w>
 <xmx:ixV0X7ZPOHT81K5TbJlZFvS1NXyfePPUDGJEJklMkBoidtHsaLJgHSL34id42dvt>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 83C563064674;
 Wed, 30 Sep 2020 01:20:08 -0400 (EDT)
Date: Wed, 30 Sep 2020 07:20:06 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v5 09/14] hw/block/nvme: Support Zoned Namespace Command
 Set
Message-ID: <20200930052006.GA436843@apples.localdomain>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
 <20200928023528.15260-10-dmitry.fomichev@wdc.com>
 <20200928104258.GB33043@apples.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <20200928104258.GB33043@apples.localdomain>
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
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Keith Busch <kbusch@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 28 12:42, Klaus Jensen wrote:
> On Sep 28 11:35, Dmitry Fomichev wrote:
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
>=20
> I think the fill_pattern feature stands separate, so it would be nice to
> extract that to a patch on its own.
>=20

Please disregard this.

Since the fill_pattern feature is tightly bound to reading in zones, it
doesnt really make sense to extract it.

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl90FYIACgkQTeGvMW1P
DekMBQgAll3OmjIJ4+hJNXHULUf0dSBsZ1mjXHJoLG4sujMlKYIRDDahLXpy5hf+
1rjyJpYYZgzuQOgF9OQCt1A8J3oEKfA4PkNjNZJEXLj5/z33NEvObH0SCBlUTuyu
uWXGhM4E+eqgf+L1ny8ezeto+yf9mT1JMB1Rn46Um6VR0Q4gzdzwSX+5X3QI4MCF
ezENlQecyFtt+ZVnS3T4wGtYyqOgp1vWTN4J0/95SgkuL9tp0d2g6dmwGpIEaR/P
PTlzljC2+YxF2bR4CtdFPqw8dviSQzgBESyUjCwcib51jnwt9Oo23YIbG0IZ/Cpn
RxaNtGeCUvA2NIlk8iqL5XAkdQuXhQ==
=WrBO
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--


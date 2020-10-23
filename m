Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E09CC5517A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 06:33:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7966E2192A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 06:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7966E2192A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVqdm-0003es-2x
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 02:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVqYE-0001Ge-TK; Fri, 23 Oct 2020 02:27:47 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:53183)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVqYC-0005js-QL; Fri, 23 Oct 2020 02:27:46 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id B081E5C011A;
 Fri, 23 Oct 2020 02:27:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Fri, 23 Oct 2020 02:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=wOiyt0fayA+Y90X43JezYjrFEIg
 b1/zX/gAUssD97/c=; b=jsQaV8KlLqrz7MdLlPU+R4/aka5lKAA6g5Irsk7QaSo
 WNOXNsTdQwbwwa1Buiz0NCRNvF4Vc3w1yIJFjakjvp9YLkrD38Q+hqkT7QNMaJoO
 9iS2xQJRxxMSPJAEzOXiyrZzXGrruCDIXfeDCq1cneGVjEJIXlq11grbgp4vCP3u
 aX1saD8mfoYzD/sAx2np4toql6lWxItXyWSDhP0d5cc7i2lw9JgaPSbLNeGHYtTX
 FnMS+lHccLw0eUfYqONnG5ooCbo7eZ5OZb61lNv30V4m4cF2B2mSDgWDTZFqwRb6
 7waVruRAAzCDYbGlXjlskCMzAEYZr7V4nJrXKDZh1kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=wOiyt0
 fayA+Y90X43JezYjrFEIgb1/zX/gAUssD97/c=; b=a0NMsdI4vY7p+tBe3r+DCZ
 r8HhqoU49xcMljkmVDWu5zG2k98cWrHdnNoivaTnRzIIbOzdHc+l0SdwrSoUbQGr
 uINH+rou+huHDDDVGV40wOUCOu9ebrI+HYxIpBSw4+MLl07KmIjjSGp9lSJChSND
 uMOvoC5583B5K+AL4YSBiyuof40uKys1N9UcLh+VW3jFTzXhCuX1+lHUUCqwF9G4
 qGPyS6sGKaksRhZ6r0Es5GqfWAvBTAH1ZUdjdfHxKKY1qceJKdRt8g3jBYG01XnN
 Tbd8+BjPWktQU8DtIoI0SLIyrgz8fFTZ/aEWLT4Uws1qW0PObfKzgq5POQ2MpOaQ
 ==
X-ME-Sender: <xms:3neSXxVq8qrHWg4w7C6sHQwmLUjrgYBayXiDmkR5UQSHd7et-sHaXg>
 <xme:3neSXxkl2N2COkyTsJ2yGyXhThRF-vQXnB0f7uc0qRG9IHb0puID8-qesZvKBT9Cv
 sZyAD-hrdVtnbT4sfE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeelgdduuddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:3neSX9aZyH6_uhhfXEiOdtKOnVp97PT-Y1nfjBNzBDQqSIWqIgASjg>
 <xmx:3neSX0Uwy98NqRFqJp8mfPCyqqlIpRzK8GtuQWFG3_FIspPuR3IAfA>
 <xmx:3neSX7lPwWhJkU9zWHBmLcy_k3tb_x84g3KltBxLAkOxGlD99Thk_A>
 <xmx:33eSX5Un6SUPnsVW8eiPo348h5qdVXBMULGpu6OriJYVybLSNEBIKg>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 800963064610;
 Fri, 23 Oct 2020 02:27:41 -0400 (EDT)
Date: Fri, 23 Oct 2020 08:27:39 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 12/17] hw/block/nvme: add support for scatter gather
 lists
Message-ID: <20201023062739.GC244769@apples.localdomain>
References: <20200922084533.1273962-1-its@irrelevant.dk>
 <20200922084533.1273962-13-its@irrelevant.dk>
 <473d4fd5-62d9-3856-5bbe-edba1ac5040f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KN5l+BnMqAQyZLvT"
Content-Disposition: inline
In-Reply-To: <473d4fd5-62d9-3856-5bbe-edba1ac5040f@redhat.com>
Received-SPF: pass client-ip=66.111.4.28; envelope-from=its@irrelevant.dk;
 helo=out4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:25:16
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 22 22:51, Philippe Mathieu-Daud=C3=A9 wrote:
> On 9/22/20 10:45 AM, Klaus Jensen wrote:
> > +static uint16_t nvme_dma(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
>=20
> Using a 'void *ptr' would simplify your API, avoiding the callers
> to cast.
>=20

You are correct, but there is a bunch of work being done on top of
nvme-next right now - so even though it is not in master yet, I'd rather
not make too many fixups that trickles down like this.

But I will queue something up for this.

--KN5l+BnMqAQyZLvT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+Sd9kACgkQTeGvMW1P
DelERgf8Dvif9Tu3foS6CVQWV+jLNRO2gSAN0x6NUrzLCM+Yerif4/z93xUvFz3O
VjuUyiEL+kNKAOzsdEuvTtlFd/zNnFZBGLAvJRu4JyYWNwguoo+/oEGSPz0b+OSu
WBFWjY0pP3SM14pgdxzQ21DbiLZczmTzlcysKhlFJgf++uRwxQq7W0hn90zC+nhk
hE/14gw0iMQ2vNbv87bORMkE1TLEskTD96PRybmviQQXVzW9SgGtY5UTBbJaG7BN
n1Gw+D5tg+QQXwCu90xKs9NYL+qR8W/fIevT75v2gE25CrWSPQYxqTLdXb0HHQ1H
/QUDMBzoe0itcU+LwTcwMwL1iJsRmA==
=xP+G
-----END PGP SIGNATURE-----

--KN5l+BnMqAQyZLvT--


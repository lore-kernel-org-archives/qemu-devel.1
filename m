Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE76EC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:50:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D934320878
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D934320878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO3ev-0004vO-Bw
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 14:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kO3bO-0003pN-4T; Thu, 01 Oct 2020 14:46:50 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:52289)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kO3bL-0006LJ-Pj; Thu, 01 Oct 2020 14:46:49 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id A8D535801B3;
 Thu,  1 Oct 2020 14:46:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Thu, 01 Oct 2020 14:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=t+5KMWSTj7vILxkHj0YZ749J4vP
 mZlFqFeIjZWa/+18=; b=qxBW9TTzRi+ytAN+es4XVAoTaTPIJ+V80PxOCMhRVNf
 6rXDWEljQtJxYI3KTg42+OqPaQ9qQLbOvzUUiZeM06KW8FGGNNBcnabf9u5EEOxW
 GRW28CcT+u66MxpqdkSrnV/q/b0DQbbKIVmtES9MdDt4YlRO5OC6xR2U2AGq2iSu
 +woNVeM0NiVGOPb7p55Ia0Gkq+Sw7HdQHmPOCeuwzK401KpI/aI5XNCYiKqEa6eM
 EfTJ7M4HE5i4fPJ2S5zQXeB4TwevgKG5f/VLQWM+KT1MxXyQds93CBj9+ABWcNek
 /+XziVym6VlSUtUEL11yyga7uOO15gapzrquJn+93gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=t+5KMW
 STj7vILxkHj0YZ749J4vPmZlFqFeIjZWa/+18=; b=eMikyW49zudW2uMitQQjXJ
 ds1LGbKc2vNq3AmOMieJLo7zyAjUkpvlspXcG9L8i3CZrrIilvlkplsE7aXUy4mG
 DPt2q59RwX0UQNjvN4ZCJl2GarHzZPP5RnTgBnKQnlxtPak5n3g/bTiEDExgH0qC
 uEAwV40kVKuT03+OH+IhxR3T/pxKJFxGGVtc5CJCy4ZWJyUHo/4X8K9tDbrwAS+s
 ZtreFIhgQWXwyHPUOVcFCTqRkIRvYQiaoBZkBqHdFk98FuvFnyJIjQJd2LJMPEJ0
 2Q6LKxWJfdrVPmzAGiRKxdb7At2qdJrkNI3fH04HHVs43oM1DsTwcSaNjv+ihEKQ
 ==
X-ME-Sender: <xms:FCR2Xydok3M-RBsm1FTfY406CngUCYr8aYeF1EFAsLgNcWz_OIJJ7Q>
 <xme:FCR2X8N-QMOYWOefNVXxq93ZUQom4Easze2jyNcOocuVJcgPgwQ1_P0JgUPP1GeOT
 X43rD379ZTNKWGfSec>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeeggddufedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpedtffelfeeitddviedtuedvueevhfejtdeuvefgfeejueelfeehueduueetuddt
 geenucffohhmrghinhepihhnfhhrrgguvggrugdrohhrghdpihhrrhgvlhgvvhgrnhhtrd
 gukhenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedt
 necurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:FCR2XziDfQGn_INjz5Hy1y0hi7jbTLk2YAEye7tVo2AGKmPDh-OmQg>
 <xmx:FCR2X_-a2DLK6GDz6OG-YPZHdcTD5kNMP4Vl1V6K3Dp4yPfhlayP8A>
 <xmx:FCR2X-vc0oLtzCbf5NqJr-cophlnuKyWh2ClpBfOUtFviZqpJMt8Sg>
 <xmx:FiR2XwVMxGJ2WBJwcwPbxfhVybfnKWVZU3HYKENBtjl42rueWAOEgg>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id E21373064680;
 Thu,  1 Oct 2020 14:46:42 -0400 (EDT)
Date: Thu, 1 Oct 2020 20:46:40 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 0/9] nvme qemu cleanups and fixes
Message-ID: <20201001184640.GD792691@apples.localdomain>
References: <20200930220414.562527-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="d01dLTUuW90fS44H"
Content-Disposition: inline
In-Reply-To: <20200930220414.562527-1-kbusch@kernel.org>
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


--d01dLTUuW90fS44H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 30 15:04, Keith Busch wrote:
> After going through the zns enabling, I notice the controller enabling
> is not correct. Then I just continued maked more stuff. The series, I
> think, contains some of the less controversial patches from the two
> conflicting zns series, preceeded by some cleanups and fixes from me.
>=20
> If this is all fine, I took the liberty of porting the zns enabling to
> it and made a public branch for consideration here:
>=20
>  http://git.infradead.org/qemu-nvme.git/shortlog/refs/heads/kb-zns=20
>=20

I rebased my patches on top of Keith's fixups as well. And in compliance
with the concensus, I removed persistence.

https://irrelevant.dk/g/pci-nvme.git/log/?h=3Dzns

--d01dLTUuW90fS44H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl92JAwACgkQTeGvMW1P
DenrDAgAi7Y64CmV3vfG0EID/jPb0QXOjFgVyxipVUV8eTJ6L/UnzOJWkC/qmlPL
1kQ9ko3ZawjzOW+18w7MF0JaDhsUI8t7wetBtXs1ZdC3SkxkZ46tcWsv72ccTC/l
UOIcSPLg/UVwuPOXT+Hs8VEmhEskhLfRCuOXs2GplTszteAi6d4eUNVCaMLx7Iso
i8KwbfdSGp/WyU+R9mTo9A7BsUT0LIcXxCQlMfkJXs/Pk3vCf8x/xlmBJrcdEOFF
HQ9lFSnJqyxcLMhBYzusxV1T+udaeM+57DIveTovGAAm046RBLd07bg63EjC7IXr
UY74fxKKJ2+7H7pOWLMMSytoJ8Q2dQ==
=dig8
-----END PGP SIGNATURE-----

--d01dLTUuW90fS44H--


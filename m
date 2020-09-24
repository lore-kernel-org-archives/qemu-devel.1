Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C83C4727D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:19:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3B4B235FD
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B4B235FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLYej-00073R-SO
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 17:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLYYK-0004l8-TZ; Thu, 24 Sep 2020 17:13:22 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:51923)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLYYI-0002r7-KG; Thu, 24 Sep 2020 17:13:20 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 902575803D1;
 Thu, 24 Sep 2020 17:13:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Thu, 24 Sep 2020 17:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=kVIicvHNw6WeBgRS+aZbSjnxie6
 kGBE/c7aiZMgEX7Y=; b=Pnakh8RJLTYJUbnBfeQZ6AlidyM4vuL6bAMzRpI2A7n
 DRbjYm1ePaLHjDTtuFlqJ8Z6v5eyrBcG72Ym68w7TIiivnOf0yqPa2AwJOIdxC+6
 g3r+r36xMfi7LlwgvgeCQ4CxHgEhfskYQnappEYhbdraEIC7JNttzs8LScIODVHS
 iOOLw+ghc0CLMwguCRoDi/wiWtWacv7Ijd8Ii4iTFx26o6m8K30NmNHH7Pagl5E6
 vjufv72XXH4PQ9B1QblWN7lrUBtt9hSFOLjwlpfL1zFMiW5LXYo2u+vBlODhMJB5
 ec7oW9Upv2tcPPavksXfeWr8PySuthqtXo0WvLsp18w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=kVIicv
 HNw6WeBgRS+aZbSjnxie6kGBE/c7aiZMgEX7Y=; b=nA40jh+rvZYasZywuewUCY
 lnXBa2uA9/fHW243XvIqXvIYtYzWZc8ZtKLqSLRLmketcVjJ9kTtkfIqTFTpSESz
 Sfc9adMcrs1XTHpSAd8T2K3DM4nT0pg5kV7BLuBJ+6I+wqOjBfRGiFNzMTCOUNVv
 k+RLmRpaKCxTZuaS8oFSI0Ya++F+cdtL5M4bl+Jn91H/3yEALKXagXA5sTZSlioX
 nj5QVM4fSWGT6BLZ1VGcaZitWFcARchlGyRfe3NHltHmOBbqucX9TPhK1g4EoBbj
 WCE+eFBNbBMinxHyl7dUoJ3m7qKNr2ZY2rDEt6grMHcFzSbLtIFg+UyiMF7XmkTQ
 ==
X-ME-Sender: <xms:6gttX_rFBiVFRbJEysIgUMqNgkLhBWvqfku7pNzObJ_jvtt0YrhJxQ>
 <xme:6gttX5oDL3ANG6uVKDCKrqeX7L78QgxeIoUJx2_T-Pr9Yl8X0maYUgAmWq0wWAKc4
 dzmAQW-dPSsFR95qcI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekgdduheejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:6gttX8M8mdZAT8W_4Wxot3i1DAth7tH7EEd1fOYKMomLFQKLvrq2pw>
 <xmx:6gttXy59fW54P8sw1XDdctDlSU4EL5lGM0yBwAFjd_1CBDiYjZ51BQ>
 <xmx:6gttX-5kkVCJHefnUkEhTHOoQJptZkm2Q0YO0pX8UlwBazWp7vgPtQ>
 <xmx:6wttX7ud-ZQbO7McmZScQh_LVF_h-3m9Tt3Wa-7rLD1Ark95dJ1LDg>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 933CA328005D;
 Thu, 24 Sep 2020 17:13:13 -0400 (EDT)
Date: Thu, 24 Sep 2020 23:13:11 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 03/16] hw/block/nvme: make lba data size configurable
Message-ID: <20200924211311.GA1884142@apples.localdomain>
References: <20200924204516.1881843-1-its@irrelevant.dk>
 <20200924204516.1881843-4-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <20200924204516.1881843-4-its@irrelevant.dk>
Received-SPF: pass client-ip=66.111.4.230; envelope-from=its@irrelevant.dk;
 helo=new4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 17:13:16
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
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 24 22:45, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> Allos the LBA data size (lbads) to be set between 9 and 12.
>=20

The patch from Dmitry that uses the common logical_block_size BlockConf
parameter is probably better than this.

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9tC+UACgkQTeGvMW1P
DellwwgArvWhs7tykFDzZhJFisF/RBjbcylH3uijyzYfTukqmATEMojrWnex1ynr
ry5AntB/pliIin05uv5uIJfuKpWNYuo5TvSy0NYDZ4MPJ+Mk83vODj/T6ba4tllQ
TLIfM4q2HMkKyl9GE2cyvwTrkwEiFPPykA4j59d9v7PGoD6xJPxFZDKeENlHaJgS
IGHO2Y22jwXAnnwMnKs2M0C2vwE43bQnppb/lQeSazgo1uvP3YP/QoauWyovcOtH
W95vhcyKR3T3kRpbVyejuurVqYAemXqEubI/LCtNVoJkD93Rmi4fCZWv7T94bNl8
0lYC41p+8JGlJ8zENOfvuetFshYftA==
=U//k
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--


Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8ABC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:10:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7897223600
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7897223600
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLWd3-0004vZ-3j
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLWP2-0001zT-48; Thu, 24 Sep 2020 14:55:36 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:34203)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLWOx-0002Z1-00; Thu, 24 Sep 2020 14:55:35 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 94A685804C1;
 Thu, 24 Sep 2020 14:55:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Thu, 24 Sep 2020 14:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=qCIoQrisYKxm01fcEvXZIhRX9GD
 2Ro8BlPv6NVRbYMk=; b=PZhe+6IWgx36lM9/A+a0syyPJGX/DAdAjv4ZwaAt/SE
 o0N0FL00a57aT8CeJX32tGGprOErSSXh2X1XJQHo2dqMdGq8KWVFl7n6QSCNNqHa
 +Jo4foBUlD15dj4oheIxff6Nlr8QxV1hDnbUtp/ii2re4doq/RXcUP0iRtHXX7Jc
 vHzQL5c3RA12dlcHbU4BmSEdlkiYP7MEy1DxlL8Kxawz/41h66rHuS6OzQZK2V9+
 Jbh7el9jEUziraoBa9ShCmDXbFTcWxqPKNkio4H/4QomfNo7m4bynmsfGKE9UlVH
 h9xc6pS4AKrWOKcq0aruOAEBKFb8ZXuBTbdWbVCRE9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=qCIoQr
 isYKxm01fcEvXZIhRX9GD2Ro8BlPv6NVRbYMk=; b=FIQm6XEdTN23iymksg+U6g
 lfcMhvZ6EwEyLm9/ZYfORB+3mHcgulDy1S/VivOQwQFqXClPtzNctDGqM3krcnNj
 Q14EMekqaCqMbq/C2EUpWnc9ivAMXHk3icXyhl98uDOVd3UvVQ3Zkja3D4JC6tXv
 W3hVNYh9gzroTH65hnvia05Os4s3nh2cR2WHYm05Dj2DXi+XakkLXj5fOfliiQVV
 44KkDkQYJoGw0MNDdPO9zfVEzh+ZqnPWuzzQpMOilHf6ZxgUbjf4wEoEvM4WtnyI
 ITHHkUycTXgBAvqh1rq3oLFS/niiExBH/L75VFi2P1ItkXkoaSYTTW2ovklZZE7Q
 ==
X-ME-Sender: <xms:oOtsX3vwXUBgQAM2nw4a821_n1S1ArKd9fh_BP8N8LfvoKZzxpkIIA>
 <xme:oOtsX4cCaHFqD_pmNmrhuGP_AmRHXwfVVZGIU3gfxAbM1YfnAGSQ7vw8cgaA084Gh
 Gf_qDUW919JFcF4DyE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekgdduvdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:oOtsX6y1YhlZrss8QCu9HNvL3wDNffoQkRhdDNlEg2_bhCGFR2A5Hg>
 <xmx:oOtsX2NOs2XOhUnURrTNoq6lrPpNwd9n4XnqqR56Shte5h7KqBW-pA>
 <xmx:oOtsX38WTb87lbM3D62cMvCgJoUm0Cz1_B4tRuCUzqFZGdbyMFuckA>
 <xmx:oetsX-bNFPsnQ3dnNo-s_ipQMlAJIuBEcgK-eQhFlg36vVEFqFv5HPutjQ4>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 6EE9A3064610;
 Thu, 24 Sep 2020 14:55:26 -0400 (EDT)
Date: Thu, 24 Sep 2020 20:55:24 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH v4 06/14] hw/block/nvme: Add support for active/inactive
 namespaces
Message-ID: <20200924185524.GC1738917@apples.localdomain>
References: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
 <20200923182021.3724-7-dmitry.fomichev@wdc.com>
 <20200924121203.GA1738917@apples.localdomain>
 <20200924181721.GA5376@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Content-Disposition: inline
In-Reply-To: <20200924181721.GA5376@localhost.localdomain>
Received-SPF: pass client-ip=66.111.4.224; envelope-from=its@irrelevant.dk;
 helo=new2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 14:55:29
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 24 18:17, Niklas Cassel wrote:
> On Thu, Sep 24, 2020 at 02:12:03PM +0200, Klaus Jensen wrote:
> > On Sep 24 03:20, Dmitry Fomichev wrote:
> > > From: Niklas Cassel <niklas.cassel@wdc.com>
> > >=20
> > > E.g., if the user sets CC.CSS to Admin Only, NVM namespaces should be
> > > marked as inactive.
> > >=20
> >=20
> > Hmm. I'm not convinced that this is correct. Can you reference the spec?
> >=20
>=20
> CC.CSS can only be changed when the controller is disabled.

Right. I think I see you point. While the controller is disabled, the
host obviously cannot even see what namespaces are available, so the
controller is free to only expose (aka, attach) the namespaces that
makes sense for the value of CC.CSS.

OK then, the patch is good :)

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9s65oACgkQTeGvMW1P
DemLxQf/R/+CIhci8+iL8bUaZ4h5p4d5Z1gC0YosOqDP3sKdDxqWCZSnN7LSLrkg
zGAoZzaHW02NC02bDn4ZsLK3149ZYx9d7rxqLeLYksOEYzqeGPJP4yC2HNmwDOg6
prpIhR/aDova70dZCAcIX48uHsrZz5ZzAzbL1pW8V6W5C7vNP3XRYfhDp1E5ADZr
LP/jrAi7WEk2OdEFaKeB7a1i40n00sWpueopxoH9suT3iCCZHA/em0wydyge3q1A
ZjNGvlUzrmattGgMZUULjinurs3pbSFKUNwHkGKz6rZLsrCMMrEg+1ERvdVu6CeL
U5GOVYHH8E03N4fHwjS+0PqE8S5Ttw==
=Eces
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--


Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60200C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 22:19:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6CDC2053B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 22:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="gn61h7Xj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GBKwuY7n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6CDC2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ienr6-00015u-0C
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 17:19:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1ienp9-0000BR-9L
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 17:17:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1ienp8-00066r-8Y
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 17:17:43 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:46001)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1ienp6-00063i-Ap; Tue, 10 Dec 2019 17:17:40 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 07B15ED3;
 Tue, 10 Dec 2019 17:17:38 -0500 (EST)
Received: from imap2 ([10.202.2.52])
 by compute4.internal (MEProxy); Tue, 10 Dec 2019 17:17:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type:content-transfer-encoding; s=fm1; bh=3kGtz
 jp6D7Ka8D3pEkJj4zEeNC+L5CcFXQR/+ho4LW8=; b=gn61h7XjJ+L+CZjx1+Wtf
 khaU/OmeECCNZaZuWkHfmuhuW6SeZMF8CluM1xwV+29ttGJMEjXyn+yIS6U9NN0g
 m2rarxcxDZwx6P/aRq25+ieTGKrk4VsvaMwOMDq7C3bW2XYnH0J9okWMuL5oC3IV
 KHVlCoRIU+/KLwvJS0D1zQJMDlraP3q7rMGgfELjQuk6lb4vBUZLmPq049s0SOck
 OKYGYGMUvOJlmfJkkmerORjGWvGIwGAfF1hilcutXAtsZT8C0u5DhcX7j+bJlpyv
 YhbyjovObBd4l354iDu+0jom552crXsqVqpENBSo+b9DwuSUVWyLCKpL1lB+n0kX
 A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=3kGtzjp6D7Ka8D3pEkJj4zEeNC+L5CcFXQR/+ho4L
 W8=; b=GBKwuY7ncsqFIc0lMp09ceJUEAC9nNLQl9QV4ic2xD3ADI/mu8P0jS+Cs
 A9rS8ByOdKKFTvT3FbcIfiIQ74NaQcSa6vuAPEM2/vlvJC7Kc8RL54WidcXsC+SH
 cyuhbriRAMTjAEMBpdJBX5PUJ/nflUzUUTy9a4A4E8fr9l/yTA0TR/nw1Nkm7f/4
 JLkx+2STDwE3hPuZwvSg7rDI+Mfnrqg7ZNOap06mdu0Zeel4VStY+vezl5uyArRF
 x+4EA2/0Lkle6RdMeMXKbazPKWN174vrRTc+7kUZrUB+VgqsVI7IEWUoojnrWQ6g
 Qg1/8RfA4Az5tr0LsS6GkgdTKNSLg==
X-ME-Sender: <xms:ghnwXV39J3kQfVAeH3xRdkJqy_gzIdIC4EFQgoKF6r42Nn8HvajoBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudelfedgudehlecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdet
 nhgurhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurf
 grrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhs
 thgvrhfuihiivgeptd
X-ME-Proxy: <xmx:ghnwXWi9pO5FSTUZdq0kLU_RbJwnX2zfsN0WVobiivr8aCOyBcYGIQ>
 <xmx:ghnwXWVDWYtjiRZmr8tr2qXckh6y1Kq-C11JR7c3AXKlcH9jM46OCg>
 <xmx:ghnwXVAq83K8ssw-y_N0dYNwt-vH1FHTdo76kGPAFLAMGfQ9NmNrSg>
 <xmx:ghnwXcAFMzV2YRIKL9fk3mcx4lrLaCaidGJ232BWPR-71jTEdTvOcw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 2E52EE00A5; Tue, 10 Dec 2019 17:17:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-679-g1f7ccac-fmstable-20191210v1
Mime-Version: 1.0
Message-Id: <94dbdf58-399b-49ca-b644-87f54795a7a1@www.fastmail.com>
In-Reply-To: <378a875a-17c8-3b35-9753-2158e86c5412@kaod.org>
References: <cover.da2612e7c1835c563b20851f0ac26c7b175428fc.1575938234.git-series.andrew@aj.id.au>
 <378a875a-17c8-3b35-9753-2158e86c5412@kaod.org>
Date: Wed, 11 Dec 2019 08:49:16 +1030
From: "Andrew Jeffery" <andrew@aj.id.au>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org
Subject: Re: [PATCH 0/2] hw/arm: ast2600: Wire up eMMC controller
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 64.147.123.24
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Tue, 10 Dec 2019, at 19:23, C=C3=A9dric Le Goater wrote:
> On 10/12/2019 01:52, Andrew Jeffery wrote:
> > Hello,
> >=20
> > The AST2600 has an additional SDHCI intended for use as an eMMC boot=
 source.
>=20
> Have you also considered booting the QEMU Aspeed AST2600 machine=20
> from the eMMC device ?
>=20

I hadn't got that far. I was surprised we hadn't yet wired up the eMMC c=
ontroller at
all, so I solved that problem first :)

Andrew


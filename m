Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11480C35240
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 04:21:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C73A622314
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 04:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="GOMa7viZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MKMEv4Bm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73A622314
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itl35-00082M-Rc
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 23:21:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1itl27-0007QU-5J
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 23:20:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1itl26-000214-9a
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 23:20:55 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:50027)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1itl23-0001yU-Kf; Mon, 20 Jan 2020 23:20:52 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id ADF792205E;
 Mon, 20 Jan 2020 23:20:49 -0500 (EST)
Received: from imap2 ([10.202.2.52])
 by compute4.internal (MEProxy); Mon, 20 Jan 2020 23:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type; s=fm1; bh=VBrbv77ECOPhybIGyD94COf/XRVeLbz
 9ixNwM2zHyKo=; b=GOMa7viZ2vx01W5FbOYki/Gij3d5eS5xbFDAzbjdZ44bd4g
 x9sgBB1tIWA9VPNXtxnYAgpXmR/U/xd29UPTCoikmGbCX7P5JosGxWqJWwO2sGys
 AkCNpoPRwmYdYUKn5HL8yphVJISNFtUY87o9I9VzeDT6ItPTqGp3FVnmG7Lson54
 KzRrMR9UPChdFcQWrz8U23NWFDj8aD72gEJ8pWOiAnqHE+QNbO+IOt97IjLmq5Js
 vFM9CJ2iAOEs+u6L+Nj89nix+EmmAH2fli3ij9A9MPtNhRSfDcl7zIrKGC+VTr9b
 NVD+l/3dGB96917HB6BbKi+AwiSjA2arf9hxzQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=VBrbv7
 7ECOPhybIGyD94COf/XRVeLbz9ixNwM2zHyKo=; b=MKMEv4Bm9KcPsIwbl29Ut3
 3T1vRJjcaZCMdh8sEhcqBDqWXN0vTZbk4vuF2T9vwFqbziBJwJJ907cgejfeTKw8
 opBTGCThyKE4anDBYgoKytGQYdWlk8MWCZM+ltYw3/IYUa1EIrdXsTHi2DS26T+l
 3sisCeML9mNXZx3ScERiFgTF5PN3w5XT+Tp/g84lgT3wZe1gIwqzEmfNKAMWmy9R
 OyzrXPpuoCFCVbfmhDuUVCCdmypkp9VIoXwMNQCF0o5Swyf4P2AmY0zCA9G24Rsh
 IIa+bAJ7X+Kj3tRHRWnV+Qb5KQWuy+83YtWKSOZ+xamD8JYT8m+4P2ZPNImQW+Iw
 ==
X-ME-Sender: <xms:IHwmXsoG6vmlFbtWWfuJTLcQg4OHm3onwHhVuSVpt3ZmL0pHO4X8kQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudejgdeijecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
 vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucevlhhush
 htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghj
 rdhiugdrrghu
X-ME-Proxy: <xmx:IXwmXubJeDNjSzP7hqA3GwzjaJ3KJXlB0deUZkDviG5B5vIdeiBNqQ>
 <xmx:IXwmXpwaCQT-xl2cmpZWp-wWT89kMjMbLpG7zX7i8siWN06a5HFEgg>
 <xmx:IXwmXlCyJrJFMuhcIM6foYjaWi1PSc-HnJSabdAiLD5vKZlQocffBg>
 <xmx:IXwmXpTGKO5UqIwEkKsffNOEMgogh4rJiGTEFduder48SpQdMgXfrA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id D9FF5E00A2; Mon, 20 Jan 2020 23:20:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-754-g09d1619-fmstable-20200113v1
Mime-Version: 1.0
Message-Id: <bd9b60c0-6785-4499-a454-a97940177cee@www.fastmail.com>
In-Reply-To: <20200121013302.43839-2-joel@jms.id.au>
References: <20200121013302.43839-1-joel@jms.id.au>
 <20200121013302.43839-2-joel@jms.id.au>
Date: Tue, 21 Jan 2020 14:50:27 +1030
From: "Andrew Jeffery" <andrew@aj.id.au>
To: "Joel Stanley" <joel@jms.id.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "Peter Maydell" <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/2] aspeed/scu: Create separate write callbacks
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 66.111.4.27
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Tue, 21 Jan 2020, at 12:03, Joel Stanley wrote:
> This splits the common write callback into separate ast2400 and ast2500
> implementations. This makes it clearer when implementing differing
> behaviour.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>


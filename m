Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0412CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 00:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C157525316
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 00:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="m0T1ZftP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pt8Ps6kH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C157525316
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnAF4-0007io-Tl
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 20:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@aj.id.au>)
 id 1jnAEG-00077d-QP; Sun, 21 Jun 2020 20:22:28 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:33923)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@aj.id.au>)
 id 1jnAED-00086o-Jl; Sun, 21 Jun 2020 20:22:28 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.west.internal (Postfix) with ESMTP id 216D1EAB;
 Sun, 21 Jun 2020 20:22:21 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
 by compute3.internal (MEProxy); Sun, 21 Jun 2020 20:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type:content-transfer-encoding; s=fm3; bh=UHjoZ
 VSptmZeW7Iv3wHXv/kUrx8mc/l/hhgIMRlYZwc=; b=m0T1ZftPWC8OkRf0yRToP
 Cdy7FRqjW0ei00CLFuKaGuOCuMhMbOz+GbZ6YfFETbRBN9PVTpfC6LRerW8t0KYy
 X6i+QU4ghwOrSCULgyAAfyL9xIy3X203NDc/XuYKCmrHQiZy02VaXSvLvaGFlMCi
 QxTqMQBZ99HQ7CaEc0pj0XPgJ4hHnSfluNANJTeJFzegk6Hi3CLNo2R7TKSQSIvC
 mxiG0LBungS0OMpVpjBMQIzOXvJNAZuYThxkwS1ft16VW70tBomYUytJ0k9TQv6M
 YDK2aRynK+S+/f46JbdUEydU0VlxxkmALWzBhX7r3ARMeTCsJl4v687H84qZORnJ
 g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=UHjoZVSptmZeW7Iv3wHXv/kUrx8mc/l/hhgIMRlYZ
 wc=; b=pt8Ps6kH8FX5P6kelQrVvP6DfExKjVqbNWEC8D21Ju1MEFGpj0nA1wa+N
 iYImxggik4Hp5X/Mcxid2qnPSQ+I9yjasQjFyehkV/6fbi4mk8T9YkXAwdJ5LGX7
 MeDb2L5Xaz2ESJSEqf9EmRj/0QvdpiDQA0nL6E95qMS2Reb4oaqctw2xiTVfDZaG
 Vbn6Nt090z9R1grlcX8fSHk1HVy5aO5CkSOxRNGe1SPaKS3RKcsloPbn8oaLIt7a
 Bnco7L3T+oOrpzJi8Yl1geOSuv0DriSu2AHGP26/7PeZygxO3lu8mo32fPZyt0w1
 tJiWKYDKqjChQ3gaQjSpUREY/FKaA==
X-ME-Sender: <xms:u_nvXuFM-buPK4PZidbUsn90L2D7M_1AwXn3KTC46EECDPZ2rXvAiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudekuddgfeegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
 ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
 frrghtthgvrhhnpedvgeekheegfedvhfethefhudetteegueeggfeiieegueehkedugedt
 kefglefgheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:u_nvXvX9mUmYfq9AQcbKHgrSlvKIITzH_qfG2x5RJp3OG8kUoxV1XA>
 <xmx:u_nvXoKX9zvlC-Re0sBHdMouW9b7HXzU136u2bxH43KEOYwOV7PrDw>
 <xmx:u_nvXoG6RaeVwx1IyPLofsVyu6gerikbbheP2i5NpnUYLa82f7r2kQ>
 <xmx:vPnvXtMARs_FUoJU4upAA_zzHwVKdKtjG7pZtp7CLmLaYin9s7E9ka_bxjg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id CC33CE00C5; Sun, 21 Jun 2020 20:22:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-543-gda70334-fm-20200618.004-gda703345
Mime-Version: 1.0
Message-Id: <1acc89c9-8a5c-4ba5-9201-2f0124cd7969@www.fastmail.com>
In-Reply-To: <ad812821-8b06-bb82-d336-ffb1e7c14839@amsat.org>
References: <20200616075121.12837-1-f4bug@amsat.org>
 <20200616075121.12837-8-f4bug@amsat.org>
 <914f089d-e81e-4b01-bd70-4702d8b39724@www.fastmail.com>
 <ad812821-8b06-bb82-d336-ffb1e7c14839@amsat.org>
Date: Mon, 22 Jun 2020 09:51:59 +0930
From: "Andrew Jeffery" <andrew@aj.id.au>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Cameron Esfahani via" <qemu-devel@nongnu.org>
Subject: =?UTF-8?Q?Re:_[PATCH_7/7]_hw/watchdog/wdt=5Faspeed:_Reduce_timer_precisi?=
 =?UTF-8?Q?on_to_micro-second?=
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=64.147.123.17; envelope-from=andrew@aj.id.au;
 helo=wnew3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/21 20:22:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Corey Minyard <minyard@acm.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Wed, 17 Jun 2020, at 13:11, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Andrew,
>=20
> On 6/17/20 3:18 AM, Andrew Jeffery wrote:
> > On Tue, 16 Jun 2020, at 17:21, Philippe Mathieu-Daud=C3=A9 wrote:
> >> The current implementation uses nano-second precision, while
> >> the watchdog can not be more precise than a micro-second.
> >=20
> > What's the basis for this assertion? It's true for the AST2500 and A=
ST2600, but=20
> > the AST2400 can run the watchdog from either a 1MHz clock source or =
the APB=20
> > clock (which must be at least 16.5MHz on palmetto). The reset state =
on the
> > AST2400 configures the watchdog for the APB clock rate.
> >=20
> > The Linux driver will eventually configure the watchdog for 1MHz mod=
e
> > regardless so perhaps the AST2400 reset state is a bit of a corner c=
ase, but
> > I feel the assertion should be watered down a bit?
>=20
> What about this description?
>=20
> "The current implementation uses nano-second precision, but
>  is not more precise than micro-second precision.
>  Simplify by using a micro-second based timer.
>  Rename the timer 'timer_us' to have the unit explicit."

So is this a limitation of QEMUTimer? I was establishing that the hardwa=
re can=20
operate at greater than 1 micro-second precision.

Andrew


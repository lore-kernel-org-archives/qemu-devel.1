Return-Path: <SRS0=nktx=5V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42777C2D0E8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 07:02:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F39A5206F5
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 07:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="u7auybRu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0BdjAwQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39A5206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKzIA-00043O-1U
	for qemu-devel@archiver.kernel.org; Sun, 05 Apr 2020 03:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1jKzH5-0003Vu-VE
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 03:00:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1jKzH4-0003Ns-Sz
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 03:00:55 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39055)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1jKzH2-0003Kb-9Q; Sun, 05 Apr 2020 03:00:52 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id D17055C0196;
 Sun,  5 Apr 2020 03:00:48 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
 by compute3.internal (MEProxy); Sun, 05 Apr 2020 03:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type; s=fm2; bh=6o54JLuDUZrJXC+5y05bmXhlK98pnAz
 3JDhw7aClEng=; b=u7auybRuhkN+8M/Yyfv6liTTSP3pB1s00mkhTjRUESmO9lX
 rAWag8xvet3XrkNLm67sLWNezudQj+pHVvBqk/DT8RgqUXgLGFT0i17FmDCbCIKr
 rhWnRDHMRdEKw8IMmRlMsxQugxCYG4bATfqEwkwPd9Sd4i0vxZQmaOwl/tvXWq7V
 AkX2/xq5NGWSNDyL43CIvJnMwpdEPzXzkhqx7gNq5ygUE6ebM8qzCvqlWNnX76Iz
 Nh4YZFW4KyIiF8TzPMlWfEg6tnwIOYKhElBNt8E57PBwThOk6pMj+wlrAnbyP+LM
 omBPDZmOujz+/DPT+Iz/AcypWAmuZCZsUC+qdgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=6o54JL
 uDUZrJXC+5y05bmXhlK98pnAz3JDhw7aClEng=; b=0BdjAwQBy5CCPygmfAF9RG
 unfmivmTXIv9o6vtAsHOKMHo/lVLSOpgbNdZYCeZOSXRp+kjttCNd/Ts4szQa+7B
 mG8lU1S21ORKfV+FdeF4rS2+3b5tXqemJpCreW9vixE3zmFuuZIXB9jKTS6jri1x
 Ou8TpykeGctaweyV2fNik1K+3+aVwNV+/Rm0ehPu3zaHC/HydGRCPoBU6AveZ6Jc
 NLiUVRsrn/b1JcC2opUdxilXC5SoGUwq1iz7ueLRA2zmVVcankcfhGFPFdLMeP3K
 QFbLeutWO5DIkLM1oBn6YOnJMpxeyMl3U8FrsL0F3rGGW8yEVvMNDxHHDQMWy+mA
 ==
X-ME-Sender: <xms:IIKJXpgu5189PM6vjk3lm1cKefeMiRfgXbF4ODTvB3PtNYQTqVItQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddtgddulecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedftehnughr
 vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucevlhhush
 htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghj
 rdhiugdrrghu
X-ME-Proxy: <xmx:IIKJXo1Rzu_1Jy8cdK4RnfGyCrJGK3CR-HCBd00p72_cW62z4Qy_LQ>
 <xmx:IIKJXussm32WHz8zHlLyZN24HWfQhqQyGApvxsUzAOqJeUULfOZbKA>
 <xmx:IIKJXjDZuLeBqav7fV6uBxVP48cJzCHFqS01t8E0EJJVAivFAk3lTw>
 <xmx:IIKJXoBpLyn1bcUTpzVvmnXAEW07gguoH85NmfQufZR0dMjKa1Ldfg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id DA2F5E00B1; Sun,  5 Apr 2020 03:00:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-1082-g13d7805-fmstable-20200403v1
Mime-Version: 1.0
Message-Id: <58494574-c378-4de9-85e1-4000a96ea53c@www.fastmail.com>
In-Reply-To: <20200403124712.24826-1-peter.maydell@linaro.org>
References: <20200403124712.24826-1-peter.maydell@linaro.org>
Date: Sun, 05 Apr 2020 16:31:08 +0930
From: "Andrew Jeffery" <andrew@aj.id.au>
To: "Peter Maydell" <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 "Cameron Esfahani via" <qemu-devel@nongnu.org>
Subject: =?UTF-8?Q?Re:_[PATCH_for-5.0]_hw/gpio/aspeed=5Fgpio.c:_Don't_directly_in?=
 =?UTF-8?Q?clude_assert.h?=
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 66.111.4.26
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
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Fri, 3 Apr 2020, at 23:17, Peter Maydell wrote:
> Remove a direct include of assert.h -- this is already
> provided by qemu/osdep.h, and it breaks our rule that the
> first include must always be osdep.h.
> 
> In particular we must get the assert() macro via osdep.h
> to avoid compile failures on mingw (see the comment in
> osdep.h where we redefine assert() for that platform).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Acked-by: Andrew Jeffery <andrew@aj.id.au>


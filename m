Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE1EC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 650E021655
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650E021655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVWn3-0007OB-HK
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 04:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jVWmA-0006Gp-EC; Mon, 04 May 2020 04:48:34 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:12737)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jVWm7-0000UO-F2; Mon, 04 May 2020 04:48:32 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 163E5746354;
 Mon,  4 May 2020 10:48:24 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id EC17C746353; Mon,  4 May 2020 10:48:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EA421746351;
 Mon,  4 May 2020 10:48:23 +0200 (CEST)
Date: Mon, 4 May 2020 10:48:23 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH] hw/usb: Make "hcd-ehci.h" header public
In-Reply-To: <20200504082238.16655-1-f4bug@amsat.org>
Message-ID: <alpine.BSF.2.22.395.2005041044550.59496@zero.eik.bme.hu>
References: <20200504082238.16655-1-f4bug@amsat.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1386598525-1588582103=:59496"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:48:24
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-devel@nongnu.org, Beniamino Galvani <b.galvani@gmail.com>,
 qemu-trivial@nongnu.org, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1386598525-1588582103=:59496
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 4 May 2020, Philippe Mathieu-Daudé wrote:
> As target-specific code use this header, move it to the publicly
> accessible include/ folder.
>
>  $ git grep hw/usb/hcd-ehci.h
>  hw/arm/allwinner-h3.c:31:#include "hw/usb/hcd-ehci.h"
>  hw/arm/exynos4210.c:38:#include "hw/usb/hcd-ehci.h"
>  hw/ppc/sam460ex.c:38:#include "hw/usb/hcd-ehci.h"
>  include/hw/arm/allwinner-a10.h:13:#include "hw/usb/hcd-ehci.h"
>  include/hw/arm/aspeed_soc.h:29:#include "hw/usb/hcd-ehci.h"

All of these only need either the type #define or EHCISysBusState so 
splitting only those off to a public header should be enough and better 
than making public all of ehci's internal header.

Regards,
BALATON Zoltan
--3866299591-1386598525-1588582103=:59496--


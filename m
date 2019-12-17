Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8E2C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:26:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D01672072D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PV10CPPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01672072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihEkI-0004Q3-2X
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 10:26:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ihEja-0003as-9r
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:26:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ihEjZ-00025v-2f
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:26:02 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39253)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ihEjY-00024p-V0
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:26:01 -0500
Received: by mail-oi1-x244.google.com with SMTP id a67so5646565oib.6
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 07:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8ZQpcmdFhoPYSXkvpwaIE1fkKiMdAPMiKMIsGUobd3g=;
 b=PV10CPPsYxW9zOszmgbucaI7wfLtUv0kHYU/nYgnM4Q0Zg1q8PC0QDf7jkJsu7thhP
 tjkM+QSQjOCpPxm3lWNo79Wx4NkYPq0OgkwrzD5EWpq+Ia6uV1wj6CGMAHamEnbeEwqm
 iktMkEuSnQhOrCWQ/wK8sQ5fE6MH2KxCfxk9Dz1H038tOrqVzS6wT7JMQ7EUlkeFBUmh
 mTUDN0tG6IMifNYcK1yzdbm9zF3SM1p97x23oRcEx47VGZdMu0vYjrlFRP84jk/4pyvv
 mZXO6lavmldyKHpVydkocdwEMY5wBlFZ9CR9XZwjfGAenIbwH+U1W54RtrI0qEVfCYnS
 Dc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8ZQpcmdFhoPYSXkvpwaIE1fkKiMdAPMiKMIsGUobd3g=;
 b=OQ/XacTI1ZKfKze8p6FJ7B7lBZh+DxhA1hswqE8iPIZ9YZtz0WVzS2FGOirtWGlIZE
 vRne0UxSLheDYizG7saiNN6wTsAP4fBOtKp9nI/AyjeWJ9fWNFNmBi98y5rcDRnFIEt4
 luv1JR/5+yWS8avwRvOPFhwRsYTTE23EM7Dqz3GWi94dfBoLXDxZJzeZvXhm0or21qUq
 zzFYFpGOjOuUvfFQEcjEtCy2d0CNbBxH4+E6CIwxGy/9CrJSn8AqigI6h2TOBfm81dXR
 990vxReACwqyxYNSKyEHKbjwZ+40GbiEo0JylGm202Blpdc7AcxTY9bDD5oZEyGmeArc
 gcsw==
X-Gm-Message-State: APjAAAULsEO80N5Ujv8bEMpeRdobf9yMoQWYZbsfG4IKOxRrpYXKTLyV
 vEe927oXDp9a0s6jdRiIMpOGWabR/ljDca4N/d9bog==
X-Google-Smtp-Source: APXvYqxYNd37Hpw4uovWW10bDgdN296lEMBikaqrj9beALKlzgcAiTaj8Vr2TZylbvQysub6fI10sIbEykjYYCnhAYo=
X-Received: by 2002:aca:edd5:: with SMTP id l204mr1888883oih.98.1576596360313; 
 Tue, 17 Dec 2019 07:26:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.ec85a2db47c3e10de70fba144e1bc75caf2f0a91.1576215453.git-series.andrew@aj.id.au>
In-Reply-To: <cover.ec85a2db47c3e10de70fba144e1bc75caf2f0a91.1576215453.git-series.andrew@aj.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Dec 2019 15:25:49 +0000
Message-ID: <CAFEAcA8BquhddybX8X4gsoTs=r+cwGJ6_ebno1_xPJLVVHhm9g@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Expose GT CNTFRQ as a CPU property to support
 AST2600
To: Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Dec 2019 at 05:48, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Hello,
>
> This is a v3 of the belated follow-up from a few of my earlier attempts to fix
> up the ARM generic timer for correct behaviour on the ASPEED AST2600 SoC. The
> AST2600 clocks the generic timer at the rate of HPLL, which is configured to
> 1125MHz.  This is significantly quicker than the currently hard-coded generic
> timer rate of 62.5MHz and so we see "sticky" behaviour in the guest.
>
> v2 can be found here:
>
> https://patchwork.ozlabs.org/cover/1203474/
>
> Changes since v2:
>
> * Address some minor review comments from Philippe and add tags
>
> Changes since v1:
>
> * Fix a user mode build failure from partial renaming of gt_cntfrq_period_ns()
> * Add tags from Cedric and Richard
>
> Please review.
>
> Andrew
>
> Andrew Jeffery (4):
>   target/arm: Remove redundant scaling of nexttick
>   target/arm: Abstract the generic timer frequency
>   target/arm: Prepare generic timer for per-platform CNTFRQ
>   ast2600: Configure CNTFRQ at 1125MHz




Applied to target-arm.next, thanks.

-- PMM


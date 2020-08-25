Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EB8C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:33:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 654FE2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kWhMZLU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 654FE2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAa1N-0005A0-M6
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 10:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAa0q-0004Zs-Pp
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:33:24 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d]:38543)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAa0p-0004z2-4K
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:33:24 -0400
Received: by mail-ed1-x52d.google.com with SMTP id b2so11464897edw.5
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 07:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BXoGBFSP/ozVQq2SgzK2VV9+jgrvoL5S6TxC14lIQb8=;
 b=kWhMZLU58Y1KtIhozTjEvBPXm0Eg9n9ln6SkD37fgYrGIiS64D3NPiDAo1deVi9eqX
 brJBAEBURlbdb/uI29FxmagMvLuwz+LmT0k/lFStHOjExdVBIVKfCDQZv4FjDAArPDyu
 nauVjG5iHK+1gO4vF4MCRbQgbOnuqspym5HL5QIbl6kwXIPcoYGqfDxX5lJ3mNp38yXG
 cBg+V9TDeKDJI3gZz8XyKd8kYLj5oxK682751its4mounewVmlO+NM5j+nHP60QxkoSS
 eS9cCDyvz+dtotT0BAZhy26VjCpHmHfNaVwkHwCXfBHL9jbGAthOhiGAeTADUwnrryay
 /wxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BXoGBFSP/ozVQq2SgzK2VV9+jgrvoL5S6TxC14lIQb8=;
 b=Xe3xoYm+o3Lx/ggkedCZOs7GE0c/dRlZyIAu4NSshE3sIOU9oWq4rI+uAcpr6n8k1z
 bDvMfiaG1Bj8NAApdWrX6p/VQLYKTI2GkP5C2++4Nxdf+T9NZVXzFWuW2q2YPvh+0l08
 L8XaexH0D3Gc2BPCbJIPgpU3PGH37c7P8dFOyzlfW2v6DJKw6x0R3S9o+l9SbIIg+85W
 GcxnDyqnKY4epS1VYZJLedDLpbaDVlV/NExcAwGnqP75mPjHumZLLE/6FwkY6sH5+3Xu
 syCBRGZZvwxsqW7FfJINwpAjl4hnETKFAGEZrpMZ1bvUcQ3aftJvdUCoG1UhEokN7Z6D
 YUnA==
X-Gm-Message-State: AOAM533EcjOIv8DEzQ7dRPgFwvvmhW4nsqS5WSONNWwNOxYJ3kmTO2Ph
 TRjIEQmNF0fq5FPmolBHdqk4uHmbKtTGtPt7qt1l2Q==
X-Google-Smtp-Source: ABdhPJwaZUwBBWh8BVI5oFEKrN/LpNbT9SUAIjm/wCl1/xKKGYfYewSwq9XrJ9HkgP+8ek/O/B7lRqG5w1p1do7v7pI=
X-Received: by 2002:aa7:d596:: with SMTP id r22mr10698381edq.204.1598366001478; 
 Tue, 25 Aug 2020 07:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200819100956.2216690-1-clg@kaod.org>
 <20200819100956.2216690-6-clg@kaod.org>
In-Reply-To: <20200819100956.2216690-6-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Aug 2020 15:33:10 +0100
Message-ID: <CAFEAcA_GwY5qqLFYcttobLRnt_b=HoMNHMXEZrDHyRZJ4mjGug@mail.gmail.com>
Subject: Re: [PATCH v2 05/21] hw/arm/aspeed: Add board model for Supermicro
 X11 BMC
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Andrew Jeffery <andrew@aj.id.au>, erik-smit <erik.lucas.smit@gmail.com>,
 qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 19 Aug 2020 at 11:10, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> From: erik-smit <erik.lucas.smit@gmail.com>
>
> The BMC Firmware can be downloaded from :
>
>   https://www.supermicro.com/en/products/motherboard/X11SSL-F
>
> Signed-off-by: erik-smit <erik.lucas.smit@gmail.com>

Should the name in the From and Signed-off-by: here be
"Erik Smit" rather than "erik-smit" ?

thanks
-- PMM


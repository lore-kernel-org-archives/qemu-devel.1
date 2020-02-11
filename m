Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C44AC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:25:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 695FC20708
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lxQlVmvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 695FC20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1YMB-0007o1-KS
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 11:25:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1YLS-00079W-K4
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:25:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1YLR-0007mt-Fu
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:25:06 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:32829)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1YLR-0007mI-8b
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:25:05 -0500
Received: by mail-oi1-x242.google.com with SMTP id q81so13358580oig.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 08:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YTN1aAmP6lc4kQg/pEPrAXI0XAGYx4yNSmOlFp4FG4w=;
 b=lxQlVmvVZcKdKIQTir0FJwH3pOsXoSn5/Q4tMLOxZHb6vh+J078303Z8U7gab4r+M/
 u0nOHQOoM55bwBkguDId7rDWaUhv466UTLUufW9bMy1B2UPv0baZR4jth9eVclXQQlwg
 ns/Bj2RA4Mc3yHj7MRF0DLHPNIGqXe1YZu0Bbbq1edR2+mU0MmkhgL1aOcldQsKwV8ed
 sESHd3hfq2IdjbPTIszOs4y0I8vABsJnNUzB0AebGS13LE3Z2FsIDc0KX5fJA00RYefp
 WIzcZYtT0DlJm4TAufNiRZ8Zw0u5RNE3PAR11A/fvqPnpk/HJkWZe4i1Wrf64W3IomhD
 S4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YTN1aAmP6lc4kQg/pEPrAXI0XAGYx4yNSmOlFp4FG4w=;
 b=d3AFLvq5xNfh7nwYlr7czBD44hZdpvAI2n+Vr7Sr/KP/mKwlIng1Qmb6fLB8SV/4cN
 DU5LgtjU83mvLHklspndlZgd82xA0q+zufF8Z1eSKrZY3kiZHCz1xo7dV5d6yWuRxmhB
 cpiIOIu0wVd21AXNNTUYlh7DXjfKxdP3SlCh/ZiiUdSK/C6jH1H5JqiyfyM9ltJSL8+c
 Pe1piKvmmI+o+Ov2SUARjK4F47LTOnty2c57OHSAhaODgsgQGCJwGa3PTXmVXH8ezfyn
 3qbIR+xCemBqdfl2B2opVC636yzqHDbpXsnaeb4j07LQL8T7M+dywFsPcdx/WS/h9IY7
 u1eg==
X-Gm-Message-State: APjAAAXoMt5vVVtHZWbaMTzJ7OIIbAnxl8IMzvI0f00I2YW5S4nm91i1
 msqlpGKPwyyfkCzj7swZ87ZhrI3eSuHw1UT9A6gP4w==
X-Google-Smtp-Source: APXvYqzv/UP3M8yZMmNDzyJRIaKXistg0kt67KZIdKfe9JVAoy6ZnLkvmh7xAXkvGMtm+bCKNIS/Rzvw8t5EaSXvOXI=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr3426415oid.98.1581438304306;
 Tue, 11 Feb 2020 08:25:04 -0800 (PST)
MIME-Version: 1.0
References: <20200130112510.15154-1-eric.auger@redhat.com>
 <20200130112510.15154-7-eric.auger@redhat.com>
In-Reply-To: <20200130112510.15154-7-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Feb 2020 16:24:52 +0000
Message-ID: <CAFEAcA_jfZKjey8komTt97Mu-oFjWyFNG2cY4-o8yFAP1oGiug@mail.gmail.com>
Subject: Re: [kvm-unit-tests PATCH v2 6/9] arm: pmu: Test chained counter
To: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Andrew Jones <drjones@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 Marc Zyngier <maz@kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Andre Przywara <andre.przywara@arm.com>,
 Andrew Murray <andrew.murray@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>, kvmarm@lists.cs.columbia.edu,
 Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Jan 2020 at 11:26, Eric Auger <eric.auger@redhat.com> wrote:
>
> Add 2 tests exercising chained counters. The first one uses
> CPU_CYCLES and the second one uses SW_INCR.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> +static void test_chained_sw_incr(void)
> +{
> +       uint32_t events[] = { 0x0 /* SW_INCR */, 0x0 /* SW_INCR */};

Cut-n-paste error? This test relies on the CHAIN event but it
isn't present in this list of events to pass to satisfy_prerequisites(),
so I suspect the second element should be "0x1e /* CHAIN */" ?

(This makes the test fail on QEMU TCG, because we don't implement
CHAIN.)

thanks
-- PMM


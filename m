Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D57C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18BEF2070A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A12v8O+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18BEF2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFJsD-0007Au-9i
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jFJqp-0005jK-DL
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:46:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jFJqn-0004LT-UH
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:46:22 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:43143)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jFJqn-0004J1-HN
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:46:21 -0400
Received: by mail-oi1-x22a.google.com with SMTP id p125so6918610oif.10
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 08:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=JBFp2aW9SlV0T2GARG5y2s9ZCQ1eddHpWaDsk1zrmkw=;
 b=A12v8O+L+9xAneRCttaCKykEktR61kdb5E0fA0B3JjypUcbjEo/2k4cgLMEnVgnB23
 CUy/TCAsSVdcFpZfIeSiA3KaM72c+ZhMteDEl+pZNqiJmCK7maz0fcI8tr2IiIaUCWpJ
 2EGxSLFZ7EPEJCwmHOEnD46HYNLXURG/arD1vDXztpuw1fkuszwKO6W9P7Mqg2r28h2X
 SPRlvsDuVPyVc6O+878JALdMSNPWyOfNq6WqljqH9zeB99FFIChXBw8zsg95ehgBMx6Q
 5cJM474SyS2h4W5EGwVmGI2q6ly54UxR8/1hPQPQv+/DR+vS2gdCUdx6QstSzl6hJ/4j
 vSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=JBFp2aW9SlV0T2GARG5y2s9ZCQ1eddHpWaDsk1zrmkw=;
 b=uc/t9lnmmEXdXZICp4v3kkuo9uIZI7k0r9pYx+5n5iMSkVx7K4pkwUxgrP39daNnDf
 JQVzyBRSTxxDHSWMRI8f+OJcTUSfzsScwTHALTwgu8MtZoWuA79wj81goIn8gq67Ah7X
 ELVB6d/Fv7npnZSejmVrEjhLgN7OEQ5a/yaHah/rKmBGCHxzSaAEpoIXmEWGWVIBlxem
 sgwhmB7c1k03PnKINcofa8eTJqp6FVOHKZeoHT5KwHOzAHO+9hrFfsKrtu6fiwHHbP+5
 Q2DwJWQA49Jiv+1slsblkwoS8E9CP7p+aCT+ykyrd7gvjQlWOoxtqaZVuDnnbMjyVPYd
 A2dQ==
X-Gm-Message-State: ANhLgQ2zsucqP3ogI5Y4KQhFed2lcq5yX7URuEPIOaekfMolwLAB7Fi0
 70PVzDirM0uFaUDGMDuzv6eBYdoogRyBdNJviQno4zKns0A=
X-Google-Smtp-Source: ADFU+vsPmAZscgoGRl1BkJmDqtrJQX18lxWqwE5STlLO4Xwvmzl6HE9FGTkcU4TaBFD2PfkSaRdskeceaNI8R6I7kcU=
X-Received: by 2002:aca:190f:: with SMTP id l15mr6720561oii.48.1584719180439; 
 Fri, 20 Mar 2020 08:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200312164459.25924-1-peter.maydell@linaro.org>
 <20200312164459.25924-23-peter.maydell@linaro.org>
In-Reply-To: <20200312164459.25924-23-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2020 15:46:08 +0000
Message-ID: <CAFEAcA8zWZO_eqQRq+=NRKfohmRUPOkE_4uHBDRbu-tO=mxB=w@mail.gmail.com>
Subject: Re: [PULL 22/36] hw/arm/allwinner-h3: add SDRAM controller device
To: QEMU Developers <qemu-devel@nongnu.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Mar 2020 at 16:45, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> From: Niek Linnenbank <nieklinnenbank@gmail.com>
>
> In the Allwinner H3 SoC the SDRAM controller is responsible
> for interfacing with the external Synchronous Dynamic Random
> Access Memory (SDRAM). Types of memory that the SDRAM controller
> supports are DDR2/DDR3 and capacities of up to 2GiB. This commit
> adds emulation support of the Allwinner H3 SDRAM controller.

Hi; Coverity has flagged a possible issue with this patch
(CID 1421912):

> +static void allwinner_h3_dramc_map_rows(AwH3DramCtlState *s, uint8_t row_bits,
> +                                        uint8_t bank_bits, uint16_t page_size)
> +{
> +    /*
> +     * This function simulates row addressing behavior when bootloader
> +     * software attempts to detect the amount of available SDRAM. In U-Boot
> +     * the controller is configured with the widest row addressing available.
> +     * Then a pattern is written to RAM at an offset on the row boundary size.
> +     * If the value read back equals the value read back from the
> +     * start of RAM, the bootloader knows the amount of row bits.
> +     *
> +     * This function inserts a mirrored memory region when the configured row
> +     * bits are not matching the actual emulated memory, to simulate the
> +     * same behavior on hardware as expected by the bootloader.
> +     */
> +    uint8_t row_bits_actual = 0;
> +
> +    /* Calculate the actual row bits using the ram_size property */
> +    for (uint8_t i = 8; i < 12; i++) {
> +        if (1 << i == s->ram_size) {
> +            row_bits_actual = i + 3;
> +            break;
> +        }
> +    }
> +
> +    if (s->ram_size == (1 << (row_bits - 3))) {
> +        /* When row bits is the expected value, remove the mirror */
> +        memory_region_set_enabled(&s->row_mirror_alias, false);
> +        trace_allwinner_h3_dramc_rowmirror_disable();
> +
> +    } else if (row_bits_actual) {
> +        /* Row bits not matching ram_size, install the rows mirror */
> +        hwaddr row_mirror = s->ram_addr + ((1 << (row_bits_actual +
> +                                                  bank_bits)) * page_size);

In this calculation we do the multiply as a signed 32-bit operation,
which then gets sign-extended to 64 bits for the addition; that
means that if the multiply result is greater than 0x7fffffff then
the upper bits of the result will all be 1s. Is this a "can't happen"
situation, or should we be using "1ULL" to force a 64-bit multiply?

thanks
-- PMM


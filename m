Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31725C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 06:04:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE8D320706
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 06:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="WQJk9d25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8D320706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAS4R-0005kk-4b
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 02:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1kAS1y-00044T-Sb; Tue, 25 Aug 2020 02:02:02 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:45883)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1kAS1x-0000mN-24; Tue, 25 Aug 2020 02:02:02 -0400
Received: by mail-ej1-x644.google.com with SMTP id si26so14919594ejb.12;
 Mon, 24 Aug 2020 23:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vPTJ3sAAEiqA9wUq4uK0dAUKgABNFOJeNXtGLuHtuRU=;
 b=WQJk9d25p3tN5EUkg/v4qH5x86p5mycSxtB/z6LLjFCGzkv6uXBtqXMM09boMSaDI6
 PZTghHLBQn/0ZeSPfs+kR+CFEWWbJvW+BODj0UGhYe4mWMaRj15j2YC+V1WcMdY+xmJD
 CgRXWLFh3fBteaUFhAaTbm9MWOikPSmgk+xIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vPTJ3sAAEiqA9wUq4uK0dAUKgABNFOJeNXtGLuHtuRU=;
 b=erqTZTKI4AI8mkAnb5kzPmd6eA4arWYhJidqmo4aJ2MPhZwQWpBatLsxc/uC3qWp5U
 vFJVHr8zqorQ9J/5HRGj1nfJSSbVX+FL2EXgLRCABDFrpWduuua320caPVIdLyLQ87Sg
 HNPgbSD08beyqna2f0JQ+NBRIQj344RzJj5cy/vFzrrYHGn9AoWFzqVM5ojuqOtHrzAp
 EwbKOnpsjE9+j8NlzrGjX00lU/AIm/S0SQyPgZRU1eJyrWrDrt8Hc+QOBexVG63mhv+Q
 LYzqgAnFd2qq0wdgP2pSBIT0tHIulJ1dSo2Y3HPzZb5LFePVqxf2MzuV+qBWbIf8Jcxb
 534A==
X-Gm-Message-State: AOAM530K90brCA3AwFquzKmOp8baqKSkMvPv7UjxDJ0ZwiZf46aGmchF
 xOWVe08GjR+GRT1lkbQUeI9eu4nMO4rTCXwh5TE=
X-Google-Smtp-Source: ABdhPJx6m8iooBzcS9DYHP2sS0KDxiYNDhmmogwIKxaJbDuwfsK/TltV2Ta78LS/4rnzNwD4H7Iz/7ncpi+HrJiybhM=
X-Received: by 2002:a17:907:2805:: with SMTP id
 eb5mr9385565ejc.254.1598335318568; 
 Mon, 24 Aug 2020 23:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200819100956.2216690-1-clg@kaod.org>
In-Reply-To: <20200819100956.2216690-1-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 25 Aug 2020 06:01:46 +0000
Message-ID: <CACPK8XcHq6uhg87LO0Kyeqxky0+avTkvshgssRuNz6pcpyQi=Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] aspeed: cleanups and some extensions
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 19 Aug 2020 at 10:10, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Hello,
>
> This series includes various fixes improving the support of Aspeed
> machines. Extra attention was given to the robustness of the ftgmac100
> model. A small kernel module tester was created for this purpose :
>
>    https://github.com/legoater/ftgmac100-test/

I gave this a test and it successfully broke the machine for me
without your fixes.

I tried to test this series but the new build system stopped me from
being able to complete a build. It failed with:

Found ninjatool-1.8 at qemu/upstream/build/ninjatool
./ninjatool -t ninja2make --omit clean dist uninstall < build.ninja >
Makefile.ninja
/bin/sh: build.ninja: No such file or directory

:(

>
> Changes in v2 :
>
>  - definitions for some new flash models in m25p80 by Igor
>  - All Joel's comments should have been addressed
>  - A better fix of the integer overflow in ftgmac100_do_tx suggested
>    by Peter.
>
>
> This needs a couple more reviewed-by before I can send a PR.

I have read through all the patches and I have no objections.

Cheers,

Joel

>
> Thanks,
>
> C.
>
> C=C3=A9dric Le Goater (16):
>   m25p80: Return the JEDEC ID twice for mx25l25635e
>   m25p80: Add support for mx25l25635f
>   m25p80: Add support for n25q512ax3
>   aspeed/scu: Fix valid access size on AST2400
>   aspeed/smc: Fix MemoryRegionOps definition
>   aspeed/smc: Fix max_slaves of the legacy SMC device
>   aspeed/sdhci: Fix reset sequence
>   ftgmac100: Fix registers that can be read
>   ftgmac100: Fix interrupt status "Packet transmitted on ethernet"
>   ftgmac100: Fix interrupt status "Packet moved to RX FIFO"
>   ftgmac100: Change interrupt status when a DMA error occurs
>   ftgmac100: Check for invalid len and address before doing a DMA
>     transfer
>   ftgmac100: Fix integer overflow in ftgmac100_do_tx()
>   ftgmac100: Improve software reset
>   aspeed/sdmc: Simplify calculation of RAM bits
>   aspeed/smc: Open AHB window of the second chip of the AST2600 FMC
>     controller
>
> Igor Kononenko (2):
>   arm: aspeed: add strap define `25HZ` of AST2500
>   hw: add a number of SPI-flash's of m25p80 family
>
> Joel Stanley (2):
>   aspeed/sdmc: Perform memory training
>   aspeed/sdmc: Allow writes to unprotected registers
>
> erik-smit (1):
>   hw/arm/aspeed: Add board model for Supermicro X11 BMC
>
>  include/hw/misc/aspeed_scu.h  |   1 +
>  include/hw/misc/aspeed_sdmc.h |  13 +++-
>  hw/arm/aspeed.c               |  35 ++++++++++
>  hw/block/m25p80.c             |   6 +-
>  hw/misc/aspeed_scu.c          |   9 +--
>  hw/misc/aspeed_sdmc.c         | 125 +++++++++++++++++++---------------
>  hw/net/ftgmac100.c            |  95 ++++++++++++++++++--------
>  hw/sd/aspeed_sdhci.c          |  14 +++-
>  hw/ssi/aspeed_smc.c           |   6 +-
>  9 files changed, 209 insertions(+), 95 deletions(-)
>
> --
> 2.25.4
>


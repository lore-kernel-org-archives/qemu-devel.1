Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC2FC4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 01:47:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A26A20782
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 01:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="l4uo0kNk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A26A20782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPyXp-0000iO-H5
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 21:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1kPyUV-0008RZ-S3; Tue, 06 Oct 2020 21:43:39 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:41472)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1kPyUT-0005w9-9E; Tue, 06 Oct 2020 21:43:39 -0400
Received: by mail-qt1-x843.google.com with SMTP id j22so389125qtj.8;
 Tue, 06 Oct 2020 18:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=O2ia13iA/VWg8ac4lroqtP8V2PUkrUDWkCWkSXvC79w=;
 b=l4uo0kNkJE3ABoqeoWvzuVT9/GAjhogDq9ziYDWh5HUEfvaTwScRZsod5F/5iiWARp
 AcyZXzFN0g0Yl9fmKPI053dxY5YMFKPp9ulhJRF5+83iHRghZFa3VekvrBdyZHoNaonO
 WrdgY7uvhsC4K4pC5k5nFbr+WE3AQvP1cT6g0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=O2ia13iA/VWg8ac4lroqtP8V2PUkrUDWkCWkSXvC79w=;
 b=AM1sUoTeA1S+dhQmgOvIb1dYWR1nkG27e0bPNCY4KN1zIPPuIi8qoMcGX4pokrJAMi
 i/uga60dPUSj5QrZ3t5DmS+8Atim6Cf6luwlesxQW4Awz5Vz5t6op+YpekPD8M8XJyR0
 eK6jaB7JQ6ByYR6jLJqawSIXb8bpIvXGFLasNxi5u7S3TvyTm+gKOZP606XhaIhCpsQz
 Nw7l7KjiPSrXLLRqh5gl0yqtywgOujl2fDFJidTfpxQs54ayZF+rEaCLfV3/8or9BcBR
 bLSwz75UZq9wc87gjhebpbSz4DNf5orGJmyn0/7S2WuOMkxpEEL1+dirJso5bCZJaolc
 AbNA==
X-Gm-Message-State: AOAM533VbFJWl/L77kM1Occdh5zT2OLtDQjmX8yhC50sMLOccRv+y5ZI
 bPu4UheRFLsKllNqfA6s9f84mnWuDKRKeoD3fvI=
X-Google-Smtp-Source: ABdhPJzRjx+9vWi8JwiLzCi3qjyaT4FCBNHue7CAuf1phCLqljWgPjhCA7Nazb5ALehVSTxmFt/Rb2IkS91Idnh+NiM=
X-Received: by 2002:ac8:48ca:: with SMTP id l10mr1070830qtr.385.1602035015335; 
 Tue, 06 Oct 2020 18:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200902093107.608000-1-clg@kaod.org>
In-Reply-To: <20200902093107.608000-1-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 7 Oct 2020 01:43:22 +0000
Message-ID: <CACPK8XdsX1hfNTw+Eb-=u2AXc8Ww5wVwU0mRnRo=p=d_VBTA0A@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] 5p80: Add SFDP support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::843;
 envelope-from=joel.stan@gmail.com; helo=mail-qt1-x843.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2 Sep 2020 at 09:31, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Hello,
>
> JEDEC STANDARD JESD216 for Serial Flash Discovery Parameters (SFDP)
> provides a mean to describe the features of a serial flash device
> using a set of internal parameter tables. Support in Linux has been
> added some time ago and the spi-nor driver is using it more often
> to detect the flash settings and even flash models.
>
> This is the initial framework for the RDSFDP command giving access to
> a private SFDP area under the flash.
>
> The patches available here :
>
>   https://github.com/legoater/qemu/commits/aspeed-5.2

Reviewed-by: Joel Stanley <joel@jms.id.au>
Tested-by: Joel Stanley <joel@jms.id.au>

Note that these need to be rebased on master; there are some minor conflict=
s.

These patches have proved essential in debugging a recent kernel
regression. Thanks for adding this support C=C3=A9dric.

Cheers,

Joel

>
> Thanks,
>
> C.
>
> Changes in v2:
>
>  - fixed dummy value
>  - replaced  'sfdp' table by a 'sfdp_read' handler
>  - more SFDP tables
>  - fixed Aspeed SMC support
>  - introduced mx25l25635f chip model for test under Linux.
>
> C=C3=A9dric Le Goater (9):
>   m25p80: Add basic support for the SFDP command
>   m25p80: Add the n25q256a SFDP table
>   m25p80: Add the mx25l25635e SFPD table
>   m25p80: Add the mx25l25635f SFPD table
>   m25p80: Add the mx66l1g45g SFDP table
>   m25p80: Add the w25q256 SFPD table
>   m25p80: Add the w25q512jv SFPD table
>   arm/aspeed: Replace mx25l25635e chip model
>   aspeed/smc: Add support for RDSFDP command
>
>  hw/block/m25p80_sfdp.h      |  27 ++++
>  include/hw/ssi/aspeed_smc.h |   1 +
>  hw/arm/aspeed.c             |   6 +-
>  hw/block/m25p80.c           |  47 +++++-
>  hw/block/m25p80_sfdp.c      | 296 ++++++++++++++++++++++++++++++++++++
>  hw/ssi/aspeed_smc.c         |  21 ++-
>  MAINTAINERS                 |   2 +-
>  hw/block/meson.build        |   1 +
>  hw/block/trace-events       |   1 +
>  9 files changed, 385 insertions(+), 17 deletions(-)
>  create mode 100644 hw/block/m25p80_sfdp.h
>  create mode 100644 hw/block/m25p80_sfdp.c
>
> --
> 2.25.4
>


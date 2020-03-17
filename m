Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE6EC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:38:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB1A62073E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pI7gq1jh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1A62073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEFEa-0007j5-4l
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEEyb-0004cI-5j
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:21:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEEyY-000487-Pg
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:21:56 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:42244)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEEyY-0003o4-GS
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:21:54 -0400
Received: by mail-oi1-x22a.google.com with SMTP id 13so13446237oiy.9
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 09:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=3rUBekSJABdKNYXJ2gLD7EyBY5FL3lEPELfIVGgu10I=;
 b=pI7gq1jhorytSC495CV2eQcYFzjttSqM/AUeStkaFoYhPeqdEAptycYkwLQEG5w+Ik
 8a0PlRy0HloP0zo9LoSdvPvwxh/Gr4FK6LgKwKethIy9S2OhDoArn5y0fLnuqTOKV7oz
 ln/DbNHh3gBD+tcKdmc1C37xlX+qNR+YRjcW0GjbNJwYsXbkRbNv4IStRUeDhhyco9pg
 WF1pL/47yiMKT+WnkVlArhIisR5eXveqd1gxo7TvSKTkfqL1FnBVSiqcImXLYcDTWwFe
 Lcj7KcMNiJDgaoq/2hvpAe1Dy1e00igApJXv/TyAipS+lz/+vw0OnFizvouL63e/2190
 AL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=3rUBekSJABdKNYXJ2gLD7EyBY5FL3lEPELfIVGgu10I=;
 b=hmjaOZEbP4VhCJicpM1H3mgCcCZu8Tr7B6LDQpdwyAHn80aB6Ca1IHHIBGBfjc0TWD
 ej/HeNWHEne3f5mDOD1Ke+C75DDnk5LNCz7YNlrHK7LR33wEARF58kUaDG1pHeizuypL
 JBaSXJ/6jm3Ft9H4s3PYBiY37Jtg/+Tl6MURHTFJyyFx8o7SuSpGuR3Pf/ZfMYd9c5K8
 U5SJ8Tf4Yl69Rn9fh4thbyoHaYTpNiOuOGSTgar7XZI3j7Ggh0S+F2whRH5+5jem9Zm4
 movl1Uf3SDI873VKg2vo3l8XeKNNHdb+Wgum25PrIuf47qh9YXRkPcm8wSk7bZlfXmf2
 KLOg==
X-Gm-Message-State: ANhLgQ2gPgZhzTY1Y8415ufNurO1ZNStmWPfLalYx5QLNPBrkdL5x6TX
 N5+wJdZ40FpFJYI9pceQEQHSMqo8M2LkbchlXdCtuC2bXyA=
X-Google-Smtp-Source: ADFU+vuAZCuHy+9QAaEOkz70Wedp5yumSimtZbcmeSIv9gpBb2t0Nwzmtwujpy+y/JEs4POsyKyiiI1xbZyE2v0bjII=
X-Received: by 2002:aca:c608:: with SMTP id w8mr58642oif.163.1584462111962;
 Tue, 17 Mar 2020 09:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200317114039.26914-1-peter.maydell@linaro.org>
In-Reply-To: <20200317114039.26914-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Mar 2020 16:21:40 +0000
Message-ID: <CAFEAcA8ztgg6FRPodf0zU2otr14duJwTWUXbiAgz+nxDK0-xhw@mail.gmail.com>
Subject: Re: [PULL 00/11] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
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

On Tue, 17 Mar 2020 at 11:40, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Last handful of arm patches before softfreeze...
>
> The following changes since commit a98135f727595382e200d04c2996e868b7925a01:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200316-pull-request' into staging (2020-03-16 14:55:59 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200317
>
> for you to fetch changes up to e88d3671e3bbd59d385838a4101ea19cdcf47309:
>
>   hw/arm/pxa2xx: Do not wire up OHCI for PXA255 (2020-03-17 11:36:48 +0000)
>
> ----------------------------------------------------------------
> target-arm:
>  * hw/arm/pxa2xx: Do not wire up OHCI for PXA255
>  * aspeed/smc: Fix number of dummy cycles for FAST_READ_4 command
>  * m25p80: Improve command handling for Jedec and unsupported commands
>  * hw/net/imx_fec: write TGSR and TCSR3 in imx_enet_write()
>  * hw/arm/fsl-imx6, imx6ul: Wire up USB controllers
>  * hw/arm/fsl-imx6ul: Instantiate unimplemented pwm and can devices
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM


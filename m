Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD5BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 10:10:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE6AD20672
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 10:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ht0GlYYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6AD20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxSkv-0004Rp-6c
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 06:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxShM-0000f5-W1
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 06:07:05 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxShL-0008UP-AJ
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 06:07:04 -0400
Received: by mail-oi1-x244.google.com with SMTP id e4so13981933oib.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 03:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BvDMHNbDRjvwqT8FF/HAsnszdl1KrqPTdTfCC2mnrYI=;
 b=Ht0GlYYw7lhd7RJD1JayxniWrxLSw76trUm01ePPfZGHabntSD/15gWA4Ln/PVMqBs
 4D4ovbPllTWLk5pPQPFuS5k0b1egPpE/xs5s3KdKsdPzIqatHkgKbuubJDNf6/VEOqMU
 vSMremEmYbGn9jpCzo8pMx9axO56CtFP7gGjBsDpmC7k+iC+3AvSIWXCDTAECbnkyosJ
 NwGepqXFzRyur10dZmha515RX+13mAlbgcX1zfex0MaD2IghXpnhz5TAYGsKrA+7mOdZ
 Uqms+PnEbwV3bYT496kqFUuzqWMjYbq1ELucO+EDyYYZe7Jqm1RzeNiJl38il25OUEIS
 9cXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BvDMHNbDRjvwqT8FF/HAsnszdl1KrqPTdTfCC2mnrYI=;
 b=BLwQjnm/E/rrPKN++vsQYpIeNQmsyCsvEieDhFZlG0mggylObn2Nof+8cMFyHbHoHz
 KVjVDPzlSVHceDPmuWofRNe2CEha9Vl890+3zu068KIZhZpQ5zolnv7/fOFdOQdQVLlO
 dL1WXjaKnoDR0ljmUamGgBdnZyhapFLWIoIk2dw0XA4DmAUOhQcfNldI+gzzqITOnaRR
 H/wshuprRHg/A66Q+DH+mhMDqp009RKVOTaV+2FTwipVOD2mYGPxR0c63qZMBSoCDtBo
 wGU/uRrZa6Dk3yM9FbBU7fsKGjtaguNBaIX0aat9aFR1awUM53CP40epMLlf9b/mlKls
 v6Mw==
X-Gm-Message-State: AOAM532s10WQOS7lv0B3guR93lK1K6eZNv7jS4063wLr5U3xWoZ7u88f
 LXERQEkfwRKWMQqx25gP/r8MPHOUMoiG/HddFAK/Fw==
X-Google-Smtp-Source: ABdhPJzj4GfEy1qxTBc2bH5bzzeaRNI40FeTPVU2j4N1HJ7r72y5TiC9W+T+yIOlM+ZGA+6/x6gKJ7Y8wOeooydMLG0=
X-Received: by 2002:aca:54c9:: with SMTP id
 i192mr17113011oib.163.1595239621800; 
 Mon, 20 Jul 2020 03:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200716174900.GL3235@minyard.net>
In-Reply-To: <20200716174900.GL3235@minyard.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jul 2020 11:06:51 +0100
Message-ID: <CAFEAcA80A5tc_G44QPwgcam3VNaR+M7pqJUjNpVzd2QDPQvBhQ@mail.gmail.com>
Subject: Re: [GIT PULL] I2C updates
To: Corey Minyard <minyard@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jul 2020 at 18:49, Corey Minyard <minyard@acm.org> wrote:
>
> The following changes since commit 45db94cc90c286a9965a285ba19450f448760a=
09:
>
>   Merge remote-tracking branch 'remotes/mcayland/tags/qemu-openbios-20200=
707' into staging (2020-07-10 16:43:40 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cminyard/qemu.git tags/for-qemu-i2c-5
>
> for you to fetch changes up to 73d5f22ecbb76dfc785876779d47787084ff0f42:
>
>   hw/i2c: Document the I2C qdev helpers (2020-07-16 12:30:54 -0500)
>
> ----------------------------------------------------------------
> Minor changes to:
>
> Add an SMBus config entry
>
> Cleanup/simplify/document some I2C interfaces
>
> ----------------------------------------------------------------
> Philippe Mathieu-Daud=C3=A9 (6):
>       hw/i2c/Kconfig: Add an entry for the SMBus
>       hw/i2c/aspeed_i2c: Simplify aspeed_i2c_get_bus()
>       hw/i2c: Rename i2c_try_create_slave() as i2c_slave_new()
>       hw/i2c: Rename i2c_realize_and_unref() as i2c_slave_realize_and_unr=
ef()
>       hw/i2c: Rename i2c_create_slave() as i2c_slave_create_simple()
>       hw/i2c: Document the I2C qdev helpers

I've applied the Makefile fix and then this merges OK to master.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM


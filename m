Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4205C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:04:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B30A22077D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w8IbJiPg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30A22077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeegs-00072g-Ic
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 09:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jeeg7-0006Tm-Al
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:04:03 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46025)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jeeg6-0002Eb-4W
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:04:03 -0400
Received: by mail-oi1-x244.google.com with SMTP id d191so2434040oib.12
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 06:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iC5m7M0pMiRfhlYPJA7LJN22SuRDWQ/dAo6Ln1ruTyo=;
 b=w8IbJiPg/KmlmEW0ot5jPvBi55SiLra+fXU08XVvdTQPFM86Ovgqg3siEs6b53Cnu8
 xOomPEFEL+H33MaqbLNyUVlfk69T6mNqQ2badjpORCwjbY1MNm16U5P7OhGF50k2MoHj
 uC5onHQwmCOA6Kiiv7Z8qlUUClLyfJ0MbdHX6W+sPQfJugBWRqzdZ72B+GrW5uSDaMgL
 SRu1qt6qQlcAz5Xy19NfbvYjtQeISg2kUyKJGEq15kjOtAC8lX0ZoyT19qFwTOHW/0G5
 CUWdD58xnkW/gsKCzIM3HQ5fOkbvKDXZkreC8QDKpJ4l/OKmstuu8s+MCPeHDsnUdA40
 h6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iC5m7M0pMiRfhlYPJA7LJN22SuRDWQ/dAo6Ln1ruTyo=;
 b=RtBllF7WBdt0/beNHz6e+VPQbrqAShTcv5c464W2MsvfiIzMV/6tToH5o2V3qumBcd
 vZ1wijmrdu23D0qCPZCMq8q7wTi5EppDNMSTpkI94oKb9kBqVjeRt8+W+NB/IPVgNm78
 /d55hZVHCa9GzE3uDcKGMbfEN6mj4cZemvMoEXmFnilHA3JAjX3CRUikaZyAHHtanLKb
 1gmYL1Q/JSG4j2ei0/8P7cIwVDIsUohxOmUXZ47pkl6GjcqyY1nTRuA/DtxzI7IkMv3R
 rz1+LbIvX0ZoUw//oqJEwjfFR5j2gg+b8YmO57IQLY2F3iBvX8gtADQUZV4P1IrBCQw4
 z56w==
X-Gm-Message-State: AOAM533ZsqvhjWHZ0P95VoQSlP+VzyLyB9dBEohV1/UD4aKYRe/R+P6k
 mDfIsz67IOd1SCVkD7dC0E6IviBqjjtQzDhI5Fv0Uw==
X-Google-Smtp-Source: ABdhPJxwk9JDts+7nF2avf2lzAsAKmlrMBDYBXqIA8prIS1XtXIDeKcMsjQiKRBSHB5TiTF4GrMaVFLuBZMSVybuYLo=
X-Received: by 2002:aca:ed16:: with SMTP id l22mr5378325oih.146.1590757440595; 
 Fri, 29 May 2020 06:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8FFc_Vf-UQO9f_3qoXiCJf9N1uWh7qB-WXrEWTzKBu8Q@mail.gmail.com>
 <20200522115036.31516-1-e.mikitas@gmail.com>
In-Reply-To: <20200522115036.31516-1-e.mikitas@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 May 2020 14:03:49 +0100
Message-ID: <CAFEAcA8uRypZhccZ=ce6u28ii8ZBE1qEKC7OnmJfCLM351pD2g@mail.gmail.com>
Subject: Re: [PATCH 0/2] hw/ssi/imx_spi: 2 Fixes to flush txfifo function in
 imx_spi
To: Eden Mikitas <e.mikitas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Jean-Christophe DUBOIS <jcd@tribudubois.net>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 22 May 2020 at 12:50, Eden Mikitas <e.mikitas@gmail.com> wrote:
>
>
> This patch series contains 2 fixes to the imx_spi_flush_txfifo function.
>
> The first fix prevents a case in which calling imx_spi_flush_txfifo while the
> controller is configured (by the guest driver) to use a burst length that isn't
> a multiple of 8 will cause an infinite loop.
>
> The second fix makes the spi controller compatible with slaves + guest drivers
> that expect to make transaction larger than 8 bits by removing an unnecessary
> cast.



Applied to target-arm.next, thanks.

-- PMM


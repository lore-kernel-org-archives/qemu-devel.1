Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45189C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 18:40:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 163CB20663
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 18:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ydRCscm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 163CB20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvPqk-0002VF-Cv
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 14:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvPps-000223-OM
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 14:39:25 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:43251)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvPpq-00089C-4x
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 14:39:24 -0400
Received: by mail-oi1-x232.google.com with SMTP id x83so14704361oif.10
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 11:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3gDZkOV8v0R2+B84H5Bt7ia4jXAXioXHxG9MV/gdKYo=;
 b=ydRCscm9b6oDG6Sn+uO+gLbr201zUjihXRE5Wob2u9/ipDVwZV6v0TyLyGXXxey31U
 SPHcdj6KaWMrlA6kSHczygOh+4+yMZ5TXNb59+2tyGFqE1N6h5wPd4XMu0F+5xlILEEo
 5MLDkQdyXn76cMr+Vnqs8u8S+aiUdhkr1GFtlQcaBrLoHvZIm4eLSMD+myTSb0VjMUrV
 2SDIakPdZLl+PvhIVrmCLcYXFWAfvZ7Wq8RS0Jw6tfr+X0bJ+rf7U10cYC1/7Hs+9K9B
 oLEgj4o32+NxBkgo+mGojdLi+I6WWYnoBc1SI4XI6UfUDGkXY3arTYvUG0mbKfiACvwk
 4QQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3gDZkOV8v0R2+B84H5Bt7ia4jXAXioXHxG9MV/gdKYo=;
 b=av0Vps/VDgo7lbHXVdjcQ02sQgdug0xxA6DpscJ/qSI8yVND8MrTEAPjj4CQvK8TOA
 US82AqLFHccCrBnbhsQ4NuqdO6l6dMIOaJ8NmVHv3tATK2KZNFWvZucqt/yxUEfyi77B
 5fNHAS4GQjZNhaqfstIO1n5ORAK3lOCCra51pJkK9H6dbvS8wcHOvIc9Ckim99h0qWoY
 YMijwRnOsLqsmtC8pZYJhQvoOd1JqlQqxHBdSSd+yf19IrT9z1Xq8KWZVuAIsZFRqIrG
 kK8Sprm5JCcoVLp+6/PHHnW53Umuf/veyRK/WXx8g/HyPa29ci1SXSPnow7eeZPN2eTf
 1xAA==
X-Gm-Message-State: AOAM531l6oxBPZoZuV+iIVVpN/SKc2I6IC2MCxJfgmdszLH0e7fZaDru
 T/pXJrVGfXqVxJPkIPpHxzUYUa0o2txwXlugAw8DfQ==
X-Google-Smtp-Source: ABdhPJxyVXm6Wd6uglJuhe/P9bTMFma9z3AV6T/eu1rgRUbhwIcImsWcCgGP5WeqYnYhVW7WbTQHQyyc/JwnYzAPuCw=
X-Received: by 2002:aca:1706:: with SMTP id j6mr4639163oii.146.1594751960724; 
 Tue, 14 Jul 2020 11:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200714003254.4044149-1-alistair.francis@wdc.com>
In-Reply-To: <20200714003254.4044149-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Jul 2020 19:39:09 +0100
Message-ID: <CAFEAcA9g8OyH8z-s2Ct+ad7DcriWCZ6SDPJUfzNrBdrRQJgSWA@mail.gmail.com>
Subject: Re: [PULL 00/15] riscv-to-apply queue
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x232.google.com
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

On Tue, 14 Jul 2020 at 01:44, Alistair Francis <alistair.francis@wdc.com> wrote:
>
> The following changes since commit 20c1df5476e1e9b5d3f5b94f9f3ce01d21f14c46:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/fixes-20200713-pull-request' into staging (2020-07-13 16:58:44 +0100)
>
> are available in the Git repository at:
>
>   git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200713
>
> for you to fetch changes up to cfad709bceb629a4ebeb5d8a3acd1871b9a6436b:
>
>   target/riscv: Fix pmp NA4 implementation (2020-07-13 17:25:37 -0700)
>
> ----------------------------------------------------------------
> This is a colection of bug fixes and small imrprovements for RISC-V.
>
> This includes some vector extensions fixes, a PMP bug fix, OpenTitan
> UART bug fix and support for OpenSBI dynamic firmware.
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM


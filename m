Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1E0C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 15:23:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88E8720848
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 15:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JvQ9vm5m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E8720848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8mvG-0001hq-Lq
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 10:23:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j8muW-00013A-VN
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:23:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j8muV-00014p-06
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:23:12 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39007)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j8muU-00014Y-Pe
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:23:10 -0500
Received: by mail-ot1-x342.google.com with SMTP id x97so10057845ota.6
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 07:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ar178Ow+M8KlrfAPmtxPZRxPSqC9pr2DuMH2dk+bRAk=;
 b=JvQ9vm5mGlLl6qYV3GJFvBe/CZpSYz4om4vmCQUeExiUqDmff18Bfb/KkrUt/H6sK4
 8nN7VLZ4TMS48+EdkoxakG0/PkrUyLQ0XosW6uEuk0jHpT5wRJTmQlQGCXrnd1Bo7uk5
 +Iacu6DoioUUCad/fHgeR5KIj3UGaaLtCENKnSHPV0GnFvlwkEJi/vG3+i0P8dh8cvfO
 4ZlqX2iRz5o9vWY6t4Z2sz5/4rX2c4rSctA/fi0mpKXCAes4RsUva0BDuAR5RCgzG+/A
 S1I/WjvQY5E0I3WBuBfqKrm0FGM7B3Fon6JNCRsi7sICLaWihfZ5yU/6HQupDqAfQKLQ
 +Sjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ar178Ow+M8KlrfAPmtxPZRxPSqC9pr2DuMH2dk+bRAk=;
 b=V1tYzmo0TxDzbdIDJe6r6+0wBnFUiokVPirZJBoD2FziJv9Ap9QtMNsPyu6cNa8rjy
 RF9+NbYgbsivkJMdA9VSWKaHLZFLA8NMe5hwMz7l+N6Z5xYi/ANzLujxxhkybwEv8n0c
 CqkTro/GHY5aEFElMKDJYA6ISxyCyUPy/C0k9Be5bmtJ2OH3v7aWGkfcpvFKM362FKQ3
 I9xZWswl9N52sRjL9glzNxRNC0sfmeLgkbq8SzrsSOGfHIBgA//jbi87Rw6d2oJBkPUM
 zwj1c3yn+JWU5svYY1ATXFh6PDgKRrmmKE84y7KbDO2PXULM6QosZAseTgFc7gNIigyw
 vHMA==
X-Gm-Message-State: ANhLgQ102vIofNZRP9U+GVeJrvZ+/xLBm73CTdR1CwsWAcwtFHhAZbXz
 DMEKS6Oxh9gblC99HBuze6jxRrKddaShfk7PpUI5aQ==
X-Google-Smtp-Source: ADFU+vvBZaOQoRaJitbvXmTfBH+5ARxrnZ/kCPdnfdHf5nx4qS/oenXEPO1COJwAOqcI7wID6otJh5MKiUbM7t8cMn4=
X-Received: by 2002:a9d:6f88:: with SMTP id h8mr5316509otq.91.1583162589997;
 Mon, 02 Mar 2020 07:23:09 -0800 (PST)
MIME-Version: 1.0
References: <20200229012811.24129-1-richard.henderson@linaro.org>
In-Reply-To: <20200229012811.24129-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2020 15:22:59 +0000
Message-ID: <CAFEAcA9nk7T34TGLiiET-nVNOOzCZYsO1VU-zm25XMvifpavoA@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] target/arm: Honor more HCR_EL2 traps
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 29 Feb 2020 at 01:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Changes for v5:
>   * Patch 1 was broken for aa32.  Not just the masking vs the "other"
>     32-bit register that Peter noticed, but more explicitly in that
>     "ri" was dereferenced as NULL -- hcr_write{high,low} did not pass
>     along the structure.  Oops.
>
>     Break out a new helper that is passed a starting mask, which is
>     used to preserve bits from the "other" 32-bit register.
>
>     Check the aa64 isar registers only if aarch64 is enabled.
>
>   * Add HCR bits from armv8.6.
>   * Remove EL2 & EL3 from user-only.
>
>   * Mask hcr_el2 bits that are res0 in aa32.
>     This didn't work at first because we weren't configuring SCR_RW
>     for user-only, so aarch64-linux-user thought EL2 was aa32, which
>     disabled pauth.  Rather than find other corner cases like this,
>     I think it makes more sense for user-only to only contend with EL1.
>
> Patches 1-5, 12 require review.

Applied to target-arm.next, thanks.

-- PMM


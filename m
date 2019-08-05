Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3FFC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:45:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FCD82086D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WiMCEUiX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FCD82086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hufAq-0006WG-Ng
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 11:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55148)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hufAL-00066U-4m
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hufAJ-0002gj-8E
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:44:53 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36597)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hufAH-0002ZA-Fg
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:44:50 -0400
Received: by mail-oi1-x242.google.com with SMTP id c15so6963629oic.3
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 08:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Cmpr037zZdqrGbQDYy6TyQP+T3AEBIQBH0/WDKEh4SA=;
 b=WiMCEUiXn1mDQxUW5y2ECW2h7RIVHFyMesQ53egZ77/f80ZwlHHBN2hLE0XqziD7Z9
 OOgislZIm+OLUDSdDr2LwWzaazDKzbax77C843xCu4Av4+kQXH+lYBhR2vpIb4mfYD8Q
 LaMgNnekuS21xy5hRv9Ok6/KJvJaD1cdvPx7Kf7lDS7ITz5Ua8EB+iusehgGWdGVZSV+
 6R8maZ+E8ZqSU4sxn/OFCK69LlR5ERm+ch/6XBWG+6rRNOAkXwIPvIxYx0KJYtjnBZva
 pY9C1MfgBc+oltIJp2rc0wI+5Mrb8rC4Fs9BMzvVwGxGCKayiGEDQuS2xADoW4i6tdj7
 gbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Cmpr037zZdqrGbQDYy6TyQP+T3AEBIQBH0/WDKEh4SA=;
 b=n8BoswgN32fmjQ/RUTYqKoc2oYmdoYmkiZ/GCQU43+1KMmp1aCR07XaaruU9lLFLrt
 DNetVfKU0AiyXsm+z4L/vbpyRgTMVk6LORY/dAhRmKyOr+Io4p99Y0MdlhAlw51FqCSv
 +Wv9nxJ3ys0okA933sFZNNPi9IArvYbm6IPnMASUI4A6l7Tegjrh+1SThRFgQ6ax/Lnt
 6sLGbuUbGlp0ac5xcpC4EuB5lK+aHcQLavE6vw3dFzOnotGGwIsK5Sw4Q5wkKC3X8u1Z
 rM+fOLS95X/t6GHRE6gyQjSSgCgarWruF6n83NMvFT8a5CwppXPhQT35DihlnVx/zOyW
 F81Q==
X-Gm-Message-State: APjAAAXUfK7X3ioKy15x45TqHCqzd8xtkapS6ISnUfdpplUrqOHyHl1f
 mQYzkl2gYxf4Vi0NVwp3Aj+l1c4pJqTO+dtl90Uaag==
X-Google-Smtp-Source: APXvYqzaPguh6H/Zb1GXEA2z7Sn69wZJXA5IJpfXVIEtvYRmhHNlM6mLuZkZTONbUq3Y1zJtf0wsmDbYVpG5ph0lb/Q=
X-Received: by 2002:aca:4bcc:: with SMTP id
 y195mr10633477oia.146.1565019887841; 
 Mon, 05 Aug 2019 08:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190726175032.6769-1-richard.henderson@linaro.org>
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Aug 2019 16:44:37 +0100
Message-ID: <CAFEAcA_JDfN+Njo8J0EhbtECWEW5_LcCVehbxmpY6AX3BLbOsA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH 00/67] target/arm: Convert aa32 base isa to
 decodetree
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jul 2019 at 18:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This unifies the implementation of the actual instructions
> for a32, t32, and t16.  In order to make this happen, we
> need several preliminary cleanups.  Most importantly to how
> we handle the architectural representation of PC.

I'd be happy to take the preliminary-cleanups part (subject
to the various review comments) without waiting for the
rest of the series to get respun.

thanks
-- PMM


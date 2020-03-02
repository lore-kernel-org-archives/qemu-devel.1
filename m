Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10687C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE51D2173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PKMca0e9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE51D2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8jvC-0002gm-0D
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 07:11:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j8juF-0001hX-Kc
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:10:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j8juE-0008W0-Lf
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:10:43 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37519)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j8juE-0008Vt-Gs
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:10:42 -0500
Received: by mail-oi1-x242.google.com with SMTP id 5so4437538oiy.4
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 04:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SCelQRkW/MNs3atRFB1eiHCWTOUYJHUrrzCTFuJ/69I=;
 b=PKMca0e9Re/OUdl79qiey/A4PzvjTMd6eoA4oesnMMKjlWuPODR+ODVmlAS9qX54Ag
 X7ARuZPJ/k//vU3GQhtC9K36+Is0qj2zUJfSbbVTKRu6y4zEBwbL59oQ3DApbIebQ7iy
 9HLiWKUc+GoHqUxgtqdDapANawdhzBUzKWGUZzrrQ3YK2sNjFMGq1DpB7hmhyqUdKeiP
 45jqCYtVzbTa1etTyPvJlT+4EPWattYIChjZwZDfIHbeeEsxqJqMMBmz98rcGxOmOlmt
 JsWoDFWfMDRfl8IHQIynJ/3vk9SsV1d6KttYaCr14mIh+W7wNR4E2JoRnceoH1eLB6Ym
 shng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SCelQRkW/MNs3atRFB1eiHCWTOUYJHUrrzCTFuJ/69I=;
 b=B4bA/2UtRMgcCb7gmPxRwGlRMYoxdm4s87SgQaQZBxYP2SyudWp+wprmlcILQ0z67z
 cN9gFyK7ZRNsUasGyGZXKhBxei0smHTx8TGbm+2CLjkc0DuYo5ijfcAOqc0UySY9BSFf
 bD7hg7qBrf5tgErx8ELl0a2ZIXKyyhPQyMS80mmgywgzT4Xeix207GG2+kKYvLyLTNpR
 OSvV5YF+exwZh2RUGS9oeMk8GWncVYn9HwA+CTGVcLj04jvave1T1SE5y1I2gjhMTukz
 5P1SN2GD73W5+A7G18uLRYLwjQ+kWMcoC8pdWrEeyF3/jIk5LFyMB3EKu2mfXrFjkORX
 QBwQ==
X-Gm-Message-State: APjAAAWarYqXUyJe5rMAYpu9rxaEm0/D8VpV4FbRRgwP1Lldj+/ktJSa
 D017l7fvh3wt2w80YcTvDGHyCJgXZhcyDR7f8134R0yL
X-Google-Smtp-Source: APXvYqyX+ywdh7kmT/FBu2MYDtM5aVxV/S4s4aUUNq8TyTh7DhL0NKTHoxtsj6J6TEfr2wyaaczNkt3iTseSYIh01sw=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr10896357oic.48.1583151041871; 
 Mon, 02 Mar 2020 04:10:41 -0800 (PST)
MIME-Version: 1.0
References: <20200225031222.15434-1-richard.henderson@linaro.org>
 <20200225031414.15649-1-richard.henderson@linaro.org>
 <20200225031414.15649-4-richard.henderson@linaro.org>
In-Reply-To: <20200225031414.15649-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2020 12:10:31 +0000
Message-ID: <CAFEAcA9nsymhev_+RBjhBX2zD8qNqOqJz-j0FGA1G44RGw_uGA@mail.gmail.com>
Subject: Re: [PATCH 5/8] target/arm: Use DEF_HELPER_FLAGS for helper_dc_zva
To: Richard Henderson <richard.henderson@linaro.org>
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 at 03:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The function does not write registers, and only reads them by
> implication via the exception path.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-a64.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
> index b1a5935f61..3df7c185aa 100644
> --- a/target/arm/helper-a64.h
> +++ b/target/arm/helper-a64.h
> @@ -90,7 +90,7 @@ DEF_HELPER_2(advsimd_f16touinth, i32, f16, ptr)
>  DEF_HELPER_2(sqrt_f16, f16, f16, ptr)
>
>  DEF_HELPER_2(exception_return, void, env, i64)
> -DEF_HELPER_2(dc_zva, void, env, i64)
> +DEF_HELPER_FLAGS_2(dc_zva, TCG_CALL_NO_WG, void, env, i64)
>
>  DEF_HELPER_FLAGS_3(pacia, TCG_CALL_NO_WG, i64, env, i64, i64)
>  DEF_HELPER_FLAGS_3(pacib, TCG_CALL_NO_WG, i64, env, i64, i64)
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


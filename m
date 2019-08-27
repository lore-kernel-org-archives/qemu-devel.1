Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D50EC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:43:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC0F42053B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E49CJOPT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0F42053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Y0l-0006Yq-4w
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 05:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i2XxP-0002pq-1v
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:40:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i2XxN-0005Dr-Vv
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:40:06 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34433)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i2XxN-0005CK-Qe
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:40:05 -0400
Received: by mail-oi1-x241.google.com with SMTP id g128so14471512oib.1
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 02:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=53esGyujJRuHZyT+DpRlIP9dK5qVt+dzLS4r6AGzimY=;
 b=E49CJOPT+Sr+e+FwXAssfLIxdPSYIRjmNBIf9H1Dfn53O6OFvPGCXDORLFuumqgNqp
 oIRXmEFqEMwWslupVoK6sdvlBdT4ooB9AwyU3SMzGtbj9xSzx2MxjuoAsIfPE8FItFt2
 CXr59dpaIX/9rxDGiUxnR1BQDXcbqbZhVNx3oUhxqejpkfkh8Sg4M2UY6ZEJ6jkgTpeO
 rLLXAsxeCSN+mMuhC2DMtPyL5oeUcIrRFkBLGTB5k2lbh3XIntsiw7hw98ju6dTBMD63
 4Dp/iMH0d+mjkhT+qh+7/Z5sCTe1KkDO70ExcBVSpDZjIeBiNny5JkFaG1qlJy/XegkS
 suHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=53esGyujJRuHZyT+DpRlIP9dK5qVt+dzLS4r6AGzimY=;
 b=alcumXieUIW0Jrdo7apf3tI6chSzVLwqctPXS47UuaBBUuzD3p2Wb0D8S97RtWT5Kv
 FhCywy78IDSHYDxai33/7Mvr0LNVDM5zUwbKPKFJa+7r4rlpt2zFs3AJl1l+Gl3sjrlf
 NxxJSxqr86H9WldtJ4OkNJNqpFBiftItnV0Yx7GJ3JoineAiR6gRV0PcDYL7QK3QDAp6
 YFn6t89jZjlslN65aCQrKrVaadSRgg5Pws8DmkiUuzn24U50WyTNB7zjy3KbSneDLB5s
 XDu5J7xBxXSkkA0zVtIgzb+1lIFqSxopXsjZTqvhEsfo541Bw4HhTzDPLfQRLXnzsg0r
 ig+w==
X-Gm-Message-State: APjAAAUrfZI6kXcxuER1AFCL2k9gOV8Tu4JIx2w8DvZ97XSzRyalZ/4D
 5Gh6n9yIUHlKqLn/yoYOJRE12OgzRT+Hk+PiklE1La6kDiU=
X-Google-Smtp-Source: APXvYqx2LKWTGjPhlfY8+woMScJDhz4yI+8PVa1Vnb3cH8hiJUyY2udhgqpJoVVh59XkP0IdUcmPWc5G7VV6TrVTF+Y=
X-Received: by 2002:aca:4b86:: with SMTP id
 y128mr15510966oia.163.1566898804926; 
 Tue, 27 Aug 2019 02:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-69-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-69-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Aug 2019 10:39:54 +0100
Message-ID: <CAFEAcA9dJ_5ZxXwoH3ngRGxzmrkrev1BgjpSz2zBzi23ABGCpg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v2 68/68] target/arm: Inline gen_bx_im into
 callers
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

On Mon, 19 Aug 2019 at 22:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> There are only two remaining uses of gen_bx_im.  In each case, we
> know the destination mode -- not changing in the case of gen_jmp
> or changing in the case of trans_BLX_i.  Use this to simplify the
> surrounding code.
>
> For trans_BLX_i, use gen_jmp for the actual branch.  For gen_jmp,
> use gen_set_pc_im to set up the single-step.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7718CC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:10:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 429D8206BF
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q4YUWOOt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429D8206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2XUp-0005uE-CJ
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 05:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i2XU4-0005IM-1o
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i2XU2-00057Q-Vm
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:09:47 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44485)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i2XU2-000576-Pa
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:09:46 -0400
Received: by mail-ot1-x344.google.com with SMTP id w4so17947973ote.11
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 02:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1EWzAyIKULK5KhKTiy84VfjQK0O/wqhL/kLuA3rc5CQ=;
 b=Q4YUWOOtUe1EzhbaovL27cKlTWizNJYuP0lvqyyW8einsmRSbQQLfFvZbRYZNHxc5L
 StXNfGBSYpeTy0Rr7gMkY4DQ1ICYx4b6qK18aUK1LnNr8BWZH5jQOWew3Gmzv+Z7pI+o
 srynq13RYWXuGsu/qdSJhdtI55op3W3z7xCgSr8VFND1lrAZSoCxf0CxnBuevDUCRH7z
 S/onNiaa2+Kc8sTk/Q+GX+moMTdFbFdKlEydttjztGnT4/ILyQhfVNhRU2V8Av7ysAkH
 QUnMBzUScXpFn70zEdUsM72LgGqrZD9/b5oakSn9z5Js6OM0UnZA+J0iK1vivJWxoXAC
 yiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1EWzAyIKULK5KhKTiy84VfjQK0O/wqhL/kLuA3rc5CQ=;
 b=BH8rrN5BW9BaP0cPM2U2iRxbDGfGa1PEt4p92+BdK+5L/u25d2ccGQkHRC0mcH6Lps
 wMSVgJul78thfPPoOv3RUPJxf8gfPcH0P0wyY9prwtcbS5V6fWxZPfcVW2dJchNIvKKs
 bCtTwPuEhL09qqmHBP+XqkjHrn51DkI5H6lO/XBBBNRNO+GmsR1nlqRhpZymSSHvV3Tg
 CFhlq558qEMiuw6WzwUcZ5q3I2epm98H5F1vLBhRYA4KeaByfAixiaEahqHHZUEVzU0z
 d2FWKgFz2pa2mGESTo7rGbFQRM+z4cCdCtbcsT9i0xt/Y8bB0SZaphvVTuUrp6anGYNz
 RBhQ==
X-Gm-Message-State: APjAAAUY9JMb6lljPbT3H2OIks5jSHgFpil0JHFX5a53Jf1xhFpjrlod
 SoiM9Mo3fwzQe3j0eMTzKCQVW0Dz2nwJfAS8OTj3Eg==
X-Google-Smtp-Source: APXvYqxqQO2yIrCE513U+bSunhHsDtchS5+CfaX1z/YBLyXtz79GqDjW6GASy1Gxro4bPgL9VIQDDPCw/DjL2Vyp9iM=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr8101541oti.135.1566896985947; 
 Tue, 27 Aug 2019 02:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-64-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-64-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Aug 2019 10:09:34 +0100
Message-ID: <CAFEAcA_0QCVTzyDcSHLg0Ce9Z2S+CQMikWxGZAvVt2D1o7gizA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v2 63/68] target/arm: Convert T16,
 shift immediate
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 26 ++------------------------
>  target/arm/t16.decode  |  8 ++++++++
>  2 files changed, 10 insertions(+), 24 deletions(-)


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


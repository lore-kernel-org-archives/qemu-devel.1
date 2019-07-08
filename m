Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AC6C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 08:43:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BFCF2064B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 08:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lpd3z7S3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BFCF2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkPF7-0004XI-TM
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 04:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35720)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hkPEV-0003sP-Uo
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 04:42:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hkPEU-00037n-56
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 04:42:47 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39752)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hkPET-000366-VZ
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 04:42:46 -0400
Received: by mail-ot1-x344.google.com with SMTP id r21so10660004otq.6
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 01:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uwbJ25+r35jJQL/3asJogy7vu9WA0Vrs0dGPAxruM9U=;
 b=lpd3z7S35JtzepOs1j8KunULl3POixSV7gXQSfxTdGn5nKiEGWRie0jsc7Z9Aujjen
 0swP17dymg5vI4q2IBPxp3+a4DHjyBc1f3156ACeK0EFwu3poQDg+CYTpPpX5SeWYksi
 IXxgDJWx1N3R0iHhDYZswddIhvTSy7nWRQ1kqS5Co6i7A6qNp+3syAg4SAHVk8LJbxWo
 am69AeaxqTCmrci2lMnMf4sK4WC73cc0k8Mi8HmUg5X42vN/L7OD1PJ/6WPrwOq6Wo36
 Gbg0Vj6qE4glKKTpWAZRt9ecUgKchniKRMzf47ey1bbHyR/9SmFITJN+j70QEcmLGUXW
 radg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uwbJ25+r35jJQL/3asJogy7vu9WA0Vrs0dGPAxruM9U=;
 b=lSSobUJMBMiJyBGHhjFw2AvHRcPkW0aHAvyVcRqfw/Z4cd+q2Qz8RipWs3I8H4HwIX
 TgW6yTPNzDN0GI23lvdKFNeiE49gre3VpqDQ4Tf41PixehtlnHPHzrFpGm/X3GYcfhk0
 ZqeBo3uWmiA/efnzDYSCyY6l3C9EX/bFk2516yT6d/65MLmWLtkEjpHJudxcA1sV3XpG
 18iJPkrIVWiINCLlRCPVwzN2qyYej0Vl9IS+KfIBf1qLV815DsbRS26/KsC4O0qOayiu
 +BIhRUbd09ObRN2S3EhjjD2qogHd1hTGUA+k5jEbk0Y+DnkhccRIxCSX0vsfsWX1pKpJ
 SB6A==
X-Gm-Message-State: APjAAAXOsx05NWVYhQ4kpTkT/PEz9hQu2czNQ99Zkl45sUBQ9QbKjPW7
 6T6U42jkvrHIHBP1DdzKE4UQrGklnX1IngtP1l8uiw==
X-Google-Smtp-Source: APXvYqyuh0upOb5TRMENgbSpFkcP/SqfchdDEGnGiIfUxFvwtqngcHmPxd8tiUWdWQpYKBC+RNXYrchCiFKea5HYcY0=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr13005198otk.221.1562575362321; 
 Mon, 08 Jul 2019 01:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1534182832-554-5-git-send-email-aleksandar.markovic@rt-rk.com>
 <4da49ffe-902f-2cf2-8a21-2bbd511b17a4@weilnetz.de>
In-Reply-To: <4da49ffe-902f-2cf2-8a21-2bbd511b17a4@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jul 2019 09:42:31 +0100
Message-ID: <CAFEAcA8fW0odS4pT9XNWoti7PM6TpdJ06o=43vmdRBArNM=iuw@mail.gmail.com>
To: Stefan Weil <sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] Handling of fall through code (was: [PATCH v8
 04/87] target/mips: Mark switch fallthroughs with interpretable comments
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Stefan Markovic <smarkovic@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe.mathieu.daude@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Petar Jovanovic <pjovanovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 7 Jul 2019 at 21:26, Stefan Weil <sw@weilnetz.de> wrote:
> This is a general problem all over the QEMU code. I usually compile with
> nearly all warnings enabled and get now lots of errors with the latest
> code and after updating to gcc-8.3.0 (Debian buster). It should be
> reproducible by enabling -Werror=implicit-fallthrough.

Coverity warns about implicit fallthroughs, and we are
currently warning-free in that department, so I think
our remaining problems are largely down to perhaps
using idioms which the compiler doesn't spot.
Being able to enable gcc implicit-fallthrough errors would
definitely be better than spotting them only after the
fact with Coverity.

> I suggest to enable -Werror=implicit-fallthrough by default and add a
> new macro to mark all fallthrough locations which are correct, but not
> accepted by the compiler.

I'm not sure why we need a macro. Our standard way to
mark fallthrough is /* fall through */, which has hundreds
of uses in the codebase. -Wimplicit-fallthrough=2 will match this,
so it seems simpler to just use that rather than to rework
how we mark fallthroughs.

Since vixl is 3rd-party code it might be easier to just
add -Wno-implicit-fallthrough to the cflags that
disas/libvixl/Makefile.objs sets up for building those files.
(We should check also for newer libvixl and/or suggest
something upstream that works with gcc.)

thanks
-- PMM


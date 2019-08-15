Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA50DC433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 12:04:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3B972173E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 12:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SS5pI7aS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B972173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyEU3-00008o-UD
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 08:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyET4-0007We-Vm
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 08:02:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyET3-0005jZ-Op
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 08:02:58 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44636)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyET2-0005gS-DO
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 08:02:57 -0400
Received: by mail-oi1-x243.google.com with SMTP id k22so1567698oiw.11
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 05:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PKUnr/M5oGNx8UyDStGHIVSwFmorItLwHa5Q5q86s8k=;
 b=SS5pI7aSc2FDFB5Du2eyfXWc+iBZwvvd1nm01BlohJHP+X3BLtK/RWa+Obco4EKsX5
 c3aakMNrrBB/skr/7IXXiyx119UocyLTMTCRO2zdNNvP0+QRlpal4PVNlXWAI+l89Fl5
 J0r+4CxhCpciPN/fLBEKb9Kwa0impncpwPGMWQDm78SzX/qLHjZj6PoqwHyakWGMFwmK
 h8RTvqPWnRg5Ec0C0cxwEOQ9oS3vAysskyktjD4xi5sOLo1hVq5cFxUeRefiEz30RIUz
 czYmQNw5wig4M5md8SN/skXkxLWl8A8UaWb0LO+AkepYHR2GfpYX086wpjDL9LMxajJf
 ldsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PKUnr/M5oGNx8UyDStGHIVSwFmorItLwHa5Q5q86s8k=;
 b=OQnkdH7Ue/X6pb4YsopJfOOv7F4R0e0iYeMHZQCIxrZxpwjtiJG47SogYBzq34HHVj
 udWjiZodt8T5ofHb17+MJCIEcsPy6azTAytTKxt/flkUpTE5++mwmluk5CM5fJmOHgwW
 EVnSk4fs2nKIdVSc2fb7SYdH6TzIeVQEa4gGN5g8W9bIYEeDKxybmvjfqqaaDkHhhBhn
 AVyw8YAyLRNqhHb7BF6AzRXzYTyL01sMMugPDZ6oep549oT9AUpS2sPxOPX+eyrsZnvB
 QG4VULwCwGr63jmeayqe2oTL7/bn+KWe2BEhmFXzPONPo3lSHpMoCmMISRZJdb8BkNAm
 l1ug==
X-Gm-Message-State: APjAAAUCoeP+ageUr4FcxzGuwDf3yI+6UObdB39zhOyvHCnAYmvJxUoe
 D8kIgD9JwJww0R0vfdaN1pe4yjsx6h/sLr9EKutQhQ==
X-Google-Smtp-Source: APXvYqy7Bb5G0DfZpI+ylyTWDJyth598QPUrS7Dx2RtFQhyJxOQ1kkpRBhxiczcxXP1S4X+mFRIz2nqJ4ph9R5romRY=
X-Received: by 2002:a54:4718:: with SMTP id k24mr1155459oik.146.1565870573506; 
 Thu, 15 Aug 2019 05:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190808202616.13782-1-richard.henderson@linaro.org>
 <20190808202616.13782-8-richard.henderson@linaro.org>
 <CAFEAcA8exvd3khkNhw2JnJWHdkFH5O=ut7LvN9Tz5H0ZTg95Sw@mail.gmail.com>
 <0F6CB102-2C02-4A7B-84FF-52CC3E6593FE@linaro.org>
In-Reply-To: <0F6CB102-2C02-4A7B-84FF-52CC3E6593FE@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Aug 2019 13:02:41 +0100
Message-ID: <CAFEAcA9kVDa6ssbcqSin6QM-Ujf3iYe6VVjoaDrjtjzeHehdtw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH 7/7] target/arm: Use tcg_gen_extrh_i64_i32
 to extract the high word
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

On Thu, 15 Aug 2019 at 12:56, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
>
>
>
> >
> >This patch is fine, but I noticed while reviewing it that tcg/README
> >labels both the extrl_i64_i32 and extrh_i64_i32 operations as
> >"for 64-bit hosts only". Presumably that's a documentation error,
> >since we're not guarding the existing uses of the extrl_i64_i32
> >here with any kind of ifdeffery to restrict them to 64-bit hosts ?
> >
>
>
> A documentation unclarity in that the opcodes are for 64-bit hosts. The tcg_gen_* functions are always available, and expand to INDEX_op_mov_i32 on 32-bit hosts.

Oh, I see. We should probably split that document out properly
into a primary "what you need to know to generate TCG code as
a target" (which is the main audience) and "what you need to
implement for a TCG backend (which I guess is relevant to fewer
people).

thanks
-- PMM


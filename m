Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6AEC4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:25:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D525D20836
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yYZIB20K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D525D20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUWc1-0004at-Uq
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 10:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUWb4-0003lW-EV
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:25:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUWZv-00088k-PF
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:24:58 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46808)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUWZv-00085d-DN
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:23:47 -0400
Received: by mail-ot1-x341.google.com with SMTP id z25so2617431otq.13
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 07:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kthQaBAqwyqn4UX9Xg4B95+4pb5naLZASIAFDxXig8o=;
 b=yYZIB20KtdDL/dhOnYyBRoSAutM1jX4gUZ36g3IqyCUPKnoyeuooNPSfu+Gtu3kqtK
 sSeo9WmoP90F2R3bkK2/AyCeSQj/PYO9wYCLba54TPp34fbGVZTNUDNfMca2njHLqWgS
 BBCs85KkqjqbcmgwytzCDckzN29rKZxu7/ukS8ZR254w1BHaixjkI0gZAz7c7vtGFRkU
 jQ2NL5MbUTYqMiVcy9+3idRO5Vy6YZKcoUzhY9Uczss6TGeMOTFZHrj4s2YOwVqlYC4L
 VsnNBD9TCfTS7DHT71UWjBKcRs+Kcc99nqhsNPHyNa5s5QFUwJuk4CtHsqsg4TLirVXg
 b3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kthQaBAqwyqn4UX9Xg4B95+4pb5naLZASIAFDxXig8o=;
 b=jVAZP7HBtMObsqVzJigM3I1j2uZH5ZSF99WyC2P2TP9o24kyedalyLQ8leICmYa5CT
 aTDwyiT3+LnqAhsKY6p1JM2GzddCiX/q9hIRXlQd47iPuCTST2gpE5IwHTzjAXGbsbI1
 hqdBG7DwKi/EH4F0Ob+m0KmPl1Acnjnxx9vjZEujU8MugCon6JVvvM6KLiFv4rQ/fVgj
 wN67j0dvNT/0RZmkg2C9uGu9U+T8Da3JtRwJuphNt8xIyUhGOgEQlgHEsWeJcAnfsq/0
 H8UM0k+ro+/nwqAFdxTWwGoWHFIGUzLlR/KaWHbRCFWzhqJSUWVUE+iKXxRKp+5d81xb
 N3eQ==
X-Gm-Message-State: AGi0PuacN/DFzMO9A4xI0D+gsNHgZdgiF7Ed9VfjfwBLGrtKP2wsB8Dx
 CM+3F93J2cqrFIfXGsIOr1UYsHkKNs413zwNBgs3ug==
X-Google-Smtp-Source: APiQypK5OkugpZclIzZNZask9knvkAqcCdrJZxPp1MwEYw2muPp/9BuURNogAy1zaxGGmWlVe55E07mvzoxxO0tb/fU=
X-Received: by 2002:a05:6830:22dc:: with SMTP id
 q28mr3585617otc.221.1588343026033; 
 Fri, 01 May 2020 07:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-21-peter.maydell@linaro.org>
 <7c8d148d-8980-ad8b-da32-008a0e6f81be@linaro.org>
In-Reply-To: <7c8d148d-8980-ad8b-da32-008a0e6f81be@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 May 2020 15:23:35 +0100
Message-ID: <CAFEAcA_7fxa2WtwNgAMC1jGf030sQ_wX=s9_Oj=t=QqW232vfg@mail.gmail.com>
Subject: Re: [PATCH 20/36] target/arm: Convert Neon 3-reg-same
 VQRDMLAH/VQRDMLSH to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::341
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

On Thu, 30 Apr 2020 at 21:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/30/20 11:09 AM, Peter Maydell wrote:
> > These don't use do_3same() because they want to
> > operate on VFP double registers, whose offsets are different from the
> > neon_reg_offset() calculations do_3same does.
>
> Actually, no, it's an around the bush way of computing the same register offset.

So it is. I could have sworn I'd written this using
do_3same first time around and found it didn't work,
but maybe I'm misremembering a change I had to make to
some other patch.

thanks
-- PMM


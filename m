Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35FACA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:42:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADA0E205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gj/9ClAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA0E205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNcRc-0001v3-8W
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNbUf-00067N-85
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:41:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNbUd-0004Vv-Q4
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:41:28 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37785)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNbUd-0004Vl-JN
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:41:27 -0400
Received: by mail-oi1-x244.google.com with SMTP id i16so20304209oie.4
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 04:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BJIN4H2esPOlYHkrD4Fg+pRVtEv/m/K1uo9Tg8DRzj4=;
 b=Gj/9ClAazeNbD0xLH3fnGdmaeeS7YeresvdjSiZmux1MzRluM12PVj/S5Bm9A+8mLq
 mRua7+cIpmlmMU5agM4+leBP7hU5ryFWtYwvrRQmM5P0PAbXyOSc/yMqgKkFRzIrofpr
 Ta3qO6GRQSmQC+a1hyI7jLoLn/AoQtBEBWEu8QWL8k/NVkqHvrjeC4bmuKNUcQsFrnz4
 zQkstsUfY2FoP8HPpBZyR63QdXXFN1z94H/9c6OQjbhTTdYSAQtpR/9pRER0M+bgd1xH
 Ys877Dl6shHPsf17E3BHTeAa8UcHpTuxQbPetZuaWwioGJ0JtORer4fB7w4vxhY1Ju58
 5VrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BJIN4H2esPOlYHkrD4Fg+pRVtEv/m/K1uo9Tg8DRzj4=;
 b=Vzju0CXRNEU2uT9gohOy/wmyT4lSJi7vRedQdkAHTwtUyrZC/11Ny6FsLdWiVo69Bm
 qJHNssbLQ+fGnupapy4CytD4nlLJ1InRGaaGZngRDKYsahm4iL/VbdBj65cmiRU6uQMI
 wq2IQNzkSszQxvDEaZ9Or89xUm6Ze43XtVWTJEQKjEtsOaZStm7CFZwFYbF2THLEVm0P
 9LAL0aju2cGzUrtykJ2hlNw17SticaU72mWCNwJeucwAOBMLsWXwjl8jpDyGGF0uVa0M
 aPgVObGFw7+AeiUCGu6nyMqukQ+zbveNDIESyr8QA/XZFpbhC4QKLu4u4n+BQxEY/QmW
 wxog==
X-Gm-Message-State: APjAAAUNgFQ4jXMFgSCeNiq7QTKCka9/JKOfKVnbSIo2eNaQ8d1bZ0jc
 MH9H+OBywcNufMl7gw3lMTMJ0mQTSdNtoqYRJsBsFw==
X-Google-Smtp-Source: APXvYqzrq1FM/pOW0z3KRB6qujFBp5rwFUoSeaUsruT4tIMn/27J77oz7TDv5w6Tk7NRhe/GJ1f2kde6JWdPvuNQIOw=
X-Received: by 2002:aca:49c2:: with SMTP id w185mr4235052oia.163.1571917286204; 
 Thu, 24 Oct 2019 04:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191023150057.25731-1-richard.henderson@linaro.org>
In-Reply-To: <20191023150057.25731-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Oct 2019 12:41:15 +0100
Message-ID: <CAFEAcA_qAo3+4oO+bLY=m-vCdSAxHSRiLBe4xDUxztofmTw21A@mail.gmail.com>
Subject: Re: [PATCH v9 00/24] target/arm: Reduce overhead of
 cpu_get_tb_cpu_state
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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

On Wed, 23 Oct 2019 at 16:01, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Changes since v8:
>   * Rebuild hflags in linux-user/*/cpu_loop.c, after changing to big-endian.
>     This allows the armeb busybox ls to pass.  I don't have a test image for
>     aarch64_eb, but the code looks the same.
>
> Changes since v7:
>   * Rebuild hflags for all successful nvic writes (Peter).
>   * Rebuild hflags for Xscale sctlr writes (Peter).
>
> Changes since v6:
>   * Regen hflags in two more places for m-profile (patch 19).
> ...


Applied to target-arm.next; planning a pullreq tomorrow.

thanks
-- PMM


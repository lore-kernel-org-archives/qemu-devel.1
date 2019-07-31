Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8D5C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 14:21:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA28B20679
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 14:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vE4msU4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA28B20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hspUI-0001KO-2P
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 10:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37306)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hspSz-0007Um-QD
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hspSx-0006sL-Pr
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:20:32 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33627)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hspSx-0006qs-Hn
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:20:31 -0400
Received: by mail-wr1-x441.google.com with SMTP id n9so69996419wru.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 07:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=YNMAh/h25kREKRaRaE0oa+NhZH19museodvyjtaoZgw=;
 b=vE4msU4znjgOmNkZ2y22B9sVUn13HONCRk8BsKNvqt10qzrEfESnysJiOPwxpzOwt0
 xYVAaTaAUdrKkhOVM3nwYEl42Une5VOQbKwyz3xjSegCa6hcTyNg9TmF3S4dPCoLe7yD
 axqb3k1MgY32/+9p3578bgEuExtoJNDpp3UOgmy1pInPa2ceNhzBLl4Xj9aJOJXW69iY
 bg/dMDImE8f/uRloVyVAuRVT1X2Lz9PFF2sJqCJj4Ai6S6xk/86q1nNQ89IQYuAZJudT
 LlBLzMWdj82CDDcx2SmpMI3IsXRRqgQYtOuyfE5PuUgJwVy66T2+nd0uHVVNFAgw8o0E
 xFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=YNMAh/h25kREKRaRaE0oa+NhZH19museodvyjtaoZgw=;
 b=SqocPYchWO2m2uyCYF3z8LREh8HwSvfOi/NauHQT6OjxslCZw3sWk3Kz9U0gfFk+rE
 4qti6fQ5X8UbTjg4qgrNVa/v3zGbzy8jKQvhU3fm2TgKL9GgZ8zxXsOWpmAm3JWE1QPQ
 MAcTXWy4GPJ9dAR1ZdPtF8eQKTF1gfB7T3qfUVhbW5xZgiDGOIVCGoWznxBXVBhsWCMd
 VnY1vNpw4t8dsehxLIypgd/lYSGHPkqwfvt+9LcMg49dTd8uV3WRC1wPjipEveIDwEj6
 0b6gzZQ3vLubAgt5G0x37TUwDSodCLIcVp52Bta5aAwymJMKfuQB9Hy0yIrEasY3lm0M
 oG6w==
X-Gm-Message-State: APjAAAVXmEvXEdm7EGktEfCswQc+Dl64PZzZYQOsKsWRMTNXtHUbG0Gj
 Kv65pRz5gTDW/AWhvxx1lG5QSg==
X-Google-Smtp-Source: APXvYqzmeTu9nL00rC3Sa2YkbCYlBNotrG+0L0QFo9BPNeNj6KwhTYjdb563xtMQPvue7Fgr3WYHTA==
X-Received: by 2002:adf:b195:: with SMTP id q21mr129384544wra.2.1564582830066; 
 Wed, 31 Jul 2019 07:20:30 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id u186sm122218452wmu.26.2019.07.31.07.20.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 07:20:28 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 945121FF87;
 Wed, 31 Jul 2019 15:20:28 +0100 (BST)
References: <2aaac4eafedb4aec979657993d00b8cd@tpw09926dag18e.domain1.systemhost.net>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <2aaac4eafedb4aec979657993d00b8cd@tpw09926dag18e.domain1.systemhost.net>
Date: Wed, 31 Jul 2019 15:20:28 +0100
Message-ID: <878ssei8ur.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v4 0/1] configure: Define target access
 alignment in configure
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
Cc: ehabkost@redhat.com, arikalo@wavecomp.com, mark.cave-ayland@ilande.co.uk,
 jcmvbkbc@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com,
 atar4qemu@gmail.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


tony.nguyen@bt.com writes:

> Move the define of target access alignment earlier from
> target/foo/cpu.h to configure.
>
> Suggested in Richard Henderson's reply to "[PATCH 1/4] tcg: TCGMemOp
> is now accelerator independent MemOp"
>
> Analysed target/foo/cpu.h for more candidates to define earlier but
> did not spot any other straight forward predicates.
>
> Possible future clean ups:
> - TCG_GUEST_DEFAULT_MO and TCG_TARGET_DEFAULT_MO seems like duplicates

These aren't duplicates. This is used to work out if the host memory
order is compatible with running the guest under TCG with multiple
threads (MTTCG). See check_tcg_memory_orders_compatible.

> - TARGET_INSN_START_EXTRA_WORDS 1 seems redundant as ifndef value is 1
>
> v2:
> - split cosmetic changes into separate patch
> - cc corresponding maintainers
>
> v3:
> - dropped cosmetic changes
> - improved commit message
>
> v4:
> - further improved commit message
>
> Tony Nguyen (1):
>   configure: Define TARGET_ALIGNED_ONLY in configure
>
>  configure             | 10 +++++++++-
>  include/exec/poison.h |  1 +
>  include/qom/cpu.h     |  2 +-
>  target/alpha/cpu.h    |  2 --
>  target/hppa/cpu.h     |  1 -
>  target/mips/cpu.h     |  2 --
>  target/sh4/cpu.h      |  2 --
>  target/sparc/cpu.h    |  2 --
>  target/xtensa/cpu.h   |  2 --
>  tcg/tcg.c             |  2 +-
>  tcg/tcg.h             |  8 +++++---
>  11 files changed, 17 insertions(+), 17 deletions(-)


--
Alex Benn=C3=A9e


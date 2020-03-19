Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5514C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 10:18:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7348C206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 10:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rYmySzkU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7348C206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEsGD-0006NB-Jh
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 06:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEsFW-0005yb-SH
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 06:18:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEsFV-0006af-ID
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 06:18:02 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:42042)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEsFV-0006Zm-CS
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 06:18:01 -0400
Received: by mail-oi1-x232.google.com with SMTP id 13so2068835oiy.9
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 03:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OJAghR0kAYFOKQi+sL85e8DuAr0F2Wm82Ps/cO63jJc=;
 b=rYmySzkUbUffRtSVfHmopi27Vm9Dq5jhdmkllv0eodeERKhilW2yo77pswz041TNhq
 +VupznSooHyD5472zitMaFtMptM+IpgGjcqf3SDccyLc/TO8bzdeKAL1f8vM/alrUoIM
 LjJm67Oyu+7SmkFRHw5VVJ7B1F/XIe9nAdo/e9s2xgp/6Y2mrNlnAWIXosuXL3fVKVeN
 Ob+QlsjGt2vo9o0pgAIl9mpliD3vNn+u3DRu0UuCk5SLkEhAYcGT3ly5iqpdk85xyEdg
 A0vWZin1abjpYVL0BoB+lc3iANIv/Ey0xi1M3XjA2wCD9rZ9tckIFI7JXf54gpg8l2iO
 ouYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OJAghR0kAYFOKQi+sL85e8DuAr0F2Wm82Ps/cO63jJc=;
 b=drBBzWTHst5iFXOFY+IrM100/wouEnaR+GAG8YDjXXPlkmRsESV5JVtLmMq785GXtp
 DsBP5LFuyi/IJVEMOp9LxgxjuhtYrXQSXzxnDXWIo3Gxogx++YPYF/o3dnJouS02y/ng
 ForLH/mvh0O9HsAXH/GIOwM+wv3jz+DshZhylPJB5TwG/vVtOgTNmC90KAjdPfUIcghP
 qPTMJ+zDXzOqp+Gclf3sRZXAY97vwwtj8MnWSYtz2u/JqmXhccYf5fuZ52dKOgJTh5lE
 jaM4V7jmi5rhiWllw+JocQ+p6W1pzogisjS99IdENrimaBFsoFPI2aAMH+xjOYSAmzDZ
 O61w==
X-Gm-Message-State: ANhLgQ1z7ugm24SpZVq4vbiwpEgRXviB2U+PuChaqeSFTOUdHr//x33s
 ZBdSzpT2te9H4qhG+sp4J1/iAI2J4s6UBFiTqbvbvA==
X-Google-Smtp-Source: ADFU+vvR4ei80PtnrlX1IocG7yEoMUjbGat+8VHMFR3vthawX7kPULKKIILIwMofSMcz511Vg837Z14wGnJuE4wEYj0=
X-Received: by 2002:aca:47c8:: with SMTP id u191mr1817747oia.170.1584613080171; 
 Thu, 19 Mar 2020 03:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200317190013.25036-1-richard.henderson@linaro.org>
In-Reply-To: <20200317190013.25036-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Mar 2020 10:17:48 +0000
Message-ID: <CAFEAcA-guUrvGLQcW-dV_f4Yc3ODwRhfu3FwkFw=yKxo72eKVQ@mail.gmail.com>
Subject: Re: [PULL 0/5] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::232
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Mar 2020 at 19:00, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 40c67636f67c2a89745f2e698522fe917326a952:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20200317-pull-request' into staging (2020-03-17 14:00:56 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20200317
>
> for you to fetch changes up to 0270bd503e3699b7202200a2d693ad1feb57473f:
>
>   tcg: Remove tcg-runtime-gvec.c DO_CMP0 (2020-03-17 08:41:07 -0700)
>
> ----------------------------------------------------------------
> Fix tcg/i386 bug vs sari_vec.
> Fix tcg-runtime-gvec.c vs i386 without avx.
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM


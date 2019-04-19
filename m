Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB241C282E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 23:08:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E3B21736
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 23:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="USRU+FhY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E3B21736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34231 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHcca-0007ln-1V
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 19:08:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hHcb2-00074C-Ip
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hHcb1-00066v-IS
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:07:04 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:35347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hHcb1-00066H-Ak
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:07:03 -0400
Received: by mail-wm1-x32f.google.com with SMTP id y197so7714167wmd.0
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 16:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=X7oJuHkhiVT62dzyCiLpYMj48e2iJmTph67UyYwD2J4=;
	b=USRU+FhYWZK8bFjfzkscLfYa3P2XMoEbRTvBTmfit8vzW3taAaeqVK65zz16rSdirs
	BcDA1dtQsMPdb4laWIJjqRRJUza2PuAnMGbON3ZXLcFAOH1p74Y6yHleLUQxFUYDyi7D
	0b3rZz63Ad04FaWJYudXm/KpTaeM0PN0YGn6EL0/RLgxAgjXCVRflJWShUEnFtmMbmtF
	bcl6Rc1deeIx/7ULlV6H6JpFAZL94ql2V55uM/GpQukybSIJrw0objEs7uhXu1z7AHgz
	rKle11KXEJlmCalS6IwLAqVsSiHcddqV/VRU+Fd+FjLcsc/kRaXNMh+WTpmDBnUO0jau
	zl/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=X7oJuHkhiVT62dzyCiLpYMj48e2iJmTph67UyYwD2J4=;
	b=cOEcFM/+PN/ewCgwy9bxpBLke1KRR1T3em9pcdsN6BdIQlZ/HrA8ApYdY0q2N67W1x
	pHRytlukRcbeS4WvTGpR6Rq3+hCQPNiUo5pU2n0SRecFjhl2JXR0uOAvkb6K3XIyvL0+
	ppg5vFWIZYCC8spz+kpDfbOtqSzPYvBbtOBV3q0OLnOBJmgive+zxdgbizl1Qky/nNKT
	K6pxRqWpWGPgHbMFvF104tAo/15jtr2ifChP0qSYBJwkxuM2Lr08Fk1VNswVFxeldNSP
	eB0YegdNUt+C5ygHUDEXb6tXubQbqSFK1zanmYarfJ3ha+h5O33HMtLIELv8Pa6CBkvU
	AAxQ==
X-Gm-Message-State: APjAAAWgaxQv/rjd1Zb6wFsG1E1EJwfZJzKaOU0h9MqCs+PIeHj7oH73
	njyggZ/ythTpCQUXO/HAUnJ9Rg==
X-Google-Smtp-Source: APXvYqy0I7tzHyCA5940F3gKGxuUl5B4WYY1K7KEuE0FBuUhW6TsQGfmG9aV1rraqinzAH64bvnVzg==
X-Received: by 2002:a7b:c353:: with SMTP id l19mr3933892wmj.12.1555715222063; 
	Fri, 19 Apr 2019 16:07:02 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	h2sm11863060wro.11.2019.04.19.16.07.01
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 19 Apr 2019 16:07:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id CE22B1FF87;
	Fri, 19 Apr 2019 23:07:00 +0000 (UTC)
References: <20190416083150.19649-1-richard.henderson@linaro.org>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190416083150.19649-1-richard.henderson@linaro.org>
Date: Fri, 19 Apr 2019 23:07:00 +0000
Message-ID: <87zholfvcb.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::32f
Subject: Re: [Qemu-devel] [PATCH 0/2] tcg: Fix launchpad 1824853
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190419230700.N3dkbYpNEhqXZ4eEOHMD4-D02cQCYGPn3295Kv3lJfA@z>


Richard Henderson <richard.henderson@linaro.org> writes:

> This is a case where we generate more than 64k code for a mere 231
> guest instructions.

I would like to know more! Are these unrolled vector ops or something else?

> This hits some assertions within TCG that we're
> not overflowing the uint16_t that we use for representing our
> unwind info.
>
> Fix this by returning an error indication, rather than asserting.
> This lets us try again from tb_gen_code with a lower max_insns.
>
> This should resolve the problem for x86 as a host.  There are other
> failure modes wrt out-of-range relocations that might affect the
> RISC hosts.  I'm going to leave those for a different patch set.
>
>
> r~
>
>
> Richard Henderson (2):
>   tcg: Hoist max_insns computation to tb_gen_code
>   tcg: Restart after TB code generation overflow
>
>  include/exec/exec-all.h       |  4 +--
>  include/exec/translator.h     |  3 +-
>  accel/tcg/translate-all.c     | 54 +++++++++++++++++++++++++++++------
>  accel/tcg/translator.c        | 15 ++--------
>  target/alpha/translate.c      |  4 +--
>  target/arm/translate.c        |  4 +--
>  target/cris/translate.c       | 10 +------
>  target/hppa/translate.c       |  5 ++--
>  target/i386/translate.c       |  4 +--
>  target/lm32/translate.c       | 10 +------
>  target/m68k/translate.c       |  4 +--
>  target/microblaze/translate.c | 10 +------
>  target/mips/translate.c       |  4 +--
>  target/moxie/translate.c      | 11 ++-----
>  target/nios2/translate.c      | 14 ++-------
>  target/openrisc/translate.c   |  4 +--
>  target/ppc/translate.c        |  4 +--
>  target/riscv/translate.c      |  4 +--
>  target/s390x/translate.c      |  4 +--
>  target/sh4/translate.c        |  4 +--
>  target/sparc/translate.c      |  4 +--
>  target/tilegx/translate.c     | 12 +-------
>  target/tricore/translate.c    | 16 ++---------
>  target/unicore32/translate.c  | 10 +------
>  target/xtensa/translate.c     |  4 +--
>  tcg/tcg.c                     |  4 +++
>  26 files changed, 93 insertions(+), 133 deletions(-)


--
Alex Benn=C3=A9e


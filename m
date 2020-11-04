Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194AFC388F7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:25:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65EC2221F8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LSqsePDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65EC2221F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaGvD-000086-0n
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 06:25:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kaGtz-00080c-EF
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:24:31 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629]:37389)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kaGtx-0001G4-T5
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:24:31 -0500
Received: by mail-ej1-x629.google.com with SMTP id gn41so11951449ejc.4
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 03:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OkvQ5G8SkdyaVdk8bvqozgt0G3435vTBHsmdY7TnYR0=;
 b=LSqsePDnSePlwPrs8AJqhnfOQhQm42r4Ygn9lfOXqfJl8hycSeUPniPASt+DJaZQ7h
 3j3+dgkmVQoXJG8+iL63kxa0rIHxN7/iQ1yPNwGFL4RHMflsyz5V9OPtbHZvcYzDmjF9
 VPhrvQ/LLBngxNTLXulV7lYXILNQAyZSU27tRkSjUEaBsc5b/kOLnhiJd66PidLsFxtB
 a3uyj8sNUIvRqwI0w6RZCNJbzauerP8gDsNpYEp89MxVDbWi54EgIXfdRs92q5O1utum
 ojwfsw+TkMNpEo/ahwvOkTh6VvSnEsL+HYubJW/WFM3c0SRK+WV6epQ7AM4Ud2+SXxeK
 U7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OkvQ5G8SkdyaVdk8bvqozgt0G3435vTBHsmdY7TnYR0=;
 b=otHDniJI69zERRJNH8bqRbQaVaG+fhtNGzPVRMLJ8mXB698NkoiWxiWLeB2idaAVxY
 1p55102vr401ozt/nbT0byq0utQZB9BxY1EtryIWSGJ8FijFcuAYxE4kwDd2xWyIsI6A
 g7ePSZabAj0xOpb9P0cv33uIaBHsgspnyv8CFLAdZBFsz0Pl5T8Mk9ktVNW5PNaz1tUy
 evaxMZAkF5EvK9X5tr4whGdxxwApPVoaqpEPVOnI4KCh8gqPY7DoP9J9zPeX1MNKnk06
 XEjA9EWzPEQ7N05pRb90z/patTM+3sO3yC4cjAWbm8Njuflum/LydTM9I4F37cvOi9ba
 3GZg==
X-Gm-Message-State: AOAM5339WAUqlVQJdap7FBh191Pd0fAq4n4gkhXTCzLumK6ptmzDOJCc
 DsrD+JVNBtC6Fph2jj0WJMTOaMW9FUPRioK+X/7QHQ==
X-Google-Smtp-Source: ABdhPJwkt9N7WVUmqQNZxqpSeqHNACb1FiuP+s/nVRoQdAYwqchr3BcS+E6s+dUnp/hL+tyPaSWUDp34Jn2yHN24ESc=
X-Received: by 2002:a17:906:3a97:: with SMTP id
 y23mr24470471ejd.250.1604489067251; 
 Wed, 04 Nov 2020 03:24:27 -0800 (PST)
MIME-Version: 1.0
References: <20201103173127.2704256-1-f4bug@amsat.org>
In-Reply-To: <20201103173127.2704256-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Nov 2020 11:24:16 +0000
Message-ID: <CAFEAcA-sNFi_dfFbxzBXYCxvUrxuhY2G0DTAHHMnLd-kwhq7LA@mail.gmail.com>
Subject: Re: [PULL 0/6] Mips fixes patches
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, Paul Burton <paulburton@kernel.org>,
 Libvirt <libvir-list@redhat.com>, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Nov 2020 at 17:33, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> The following changes since commit 83851c7c60c90e9fb6a23ff48076387a77bc33=
cd:
>
>   Merge remote-tracking branch 'remotes/mdroth/tags/qga-pull-2020-10-27-v=
3-ta=3D
> g' into staging (2020-11-03 12:47:58 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/mips-fixes-20201103
>
> for you to fetch changes up to 8a805609d126ff2be9ad9ec118185dfc52633d6f:
>
>   target/mips: Add unaligned access support for MIPS64R6 and Loongson-3 (=
2020=3D
> -11-03 16:51:13 +0100)
>
> ----------------------------------------------------------------
> MIPS patches queue
>
> - Removal of the 'r4k' machine (deprecated before 5.0)
> - Fix LGPL license text (Chetan Pant)
> - Support unaligned accesses on Loongson-3 (Huacai Chen)
> - Fix out-of-bound access in Loongson-3 embedded I/O interrupt
>   controller (Alex Chen)
>
> CI jobs results:
> . https://cirrus-ci.com/build/6324890389184512
> . https://gitlab.com/philmd/qemu/-/pipelines/211275262
> . https://travis-ci.org/github/philmd/qemu/builds/741188958


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM


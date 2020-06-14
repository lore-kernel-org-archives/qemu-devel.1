Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6043C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 09:42:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FAAD206D7
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 09:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AR/N7aQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FAAD206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkPAI-0004Ua-Oq
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 05:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkP9f-00042j-9W
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 05:42:19 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41384)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkP9d-0004y2-Dn
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 05:42:18 -0400
Received: by mail-wr1-x444.google.com with SMTP id j10so14094805wrw.8
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2020 02:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KPv0YbfF+zF3FBuojCuzKw7jMdnq6/gvZecM0LjHR+A=;
 b=AR/N7aQ9beXFU8CWKAIG5ItmKzBNINUY9y49oIYoeN/ExG/FK11jEElsUr1Z3Dhrxz
 WhyHUsuKtGlB+3tYp+iUv6UUXEKK7eM3gbCfkmSL8GWFH9FvkhaLRUDrbaWjJ04RNB+C
 yruY8/fwjZBBNlNM9lvArreWTbtNT7hcoTZ7mJOXQA6RiNExvXQKaD8IuMKVNUN7MO06
 k2Q6h4WGcsE58klK/yTb464XnLcMQJMQfPScuUCrRioBDkugcS7XtUBshsHycfDjlZhq
 W3nKHmZ84imRR6D1+K3aaZtv3bjVSgLcT+q/5Hn2Gew5P5+nUBbJJqrF6aOegODUnzg2
 u7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KPv0YbfF+zF3FBuojCuzKw7jMdnq6/gvZecM0LjHR+A=;
 b=qlFV2g1+kLA5LAf/LxPM2890kzhHIRxqsDUs6LFSo1KpmzB7/SbXFGnZy+++4fHHol
 NbECuQg8GnPJrqGoIoN1JeqGaCfbMOeIwnfAZ5iYGrIiNoOmt3sPC4GlNJ6yvH/f3Cmn
 Rlctu+gsrN5SQmeExEKkvEbUOdIah8uaB2ZbQQDsk85hi1VfKgjJ1qBbrhrBb2SBYYcm
 F1B3J+HTuTTQ5y+VXrPp5AoNuvnSmiBn15dg9urSpjGLZa6j/HzAiWGY7d/EN3L04w3u
 m2LF5O5rFu7rmJOqbnXTUFkP9QTTq/wXLHC6dngKwA4+vfyw1GGKBH/xJHwHElMi9EDr
 2LyA==
X-Gm-Message-State: AOAM5311jw06pzBZn24blGO93xQSM6J54eEJxtioy1/hE9QdGjzZRofi
 +ST8bkt+hqRgoijy/lVWbwcvZOKpA3vImBOmytA=
X-Google-Smtp-Source: ABdhPJwnq8Ac97Tt4MLlkYOWfSXLSctNWTh2fw7CC1bxY1qwrn3mU5GT2Lur+Yw2uB4Ru9mVy1kW1YXP6VaqETAdrLY=
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr22964566wrv.162.1592127729849; 
 Sun, 14 Jun 2020 02:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200614080049.31134-1-jiaxun.yang@flygoat.com>
In-Reply-To: <20200614080049.31134-1-jiaxun.yang@flygoat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sun, 14 Jun 2020 11:41:57 +0200
Message-ID: <CAHiYmc5m4-ZoMai48OLipMRg8LRbrbNzX2MRZhHHn1WY+iZ7Yg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Basic TCG Loongson-3A1000 Support
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BD=D0=B5=D0=B4, 14. =D1=98=D1=83=D0=BD 2020. =D1=83 10:03 Jiaxun Yang <=
jiaxun.yang@flygoat.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=BE/=D0=BB=D0=B0:
>
> This series is the sucessor of
> "target/mips: Add loongson gs464 core" [1].
>

For some reason, patch 4/4 didn't manage to get to the list, and
neither through email. It happens from time to time virtually to
anybody. I guess 4/4 is in a similar form as 3/4. Everything I said
for 3/4 applies to 4/4 as well.

1/4 and 2/4 were applied ti the next mips queue, planned to be sent on
Monday (tomorrow).

Kind regards, and thanks for continuing your contributions!

Aleksandar

> Based on Huacai's CPU define.
> Boot test have been performed with Huacai's KVM series.
>
> Note: This series only adds instructions that can be generated by GCC,
> as we're relying on toolchain for documents of these instructions.
>
> [1]: https://patchwork.kernel.org/cover/11457385/
>
> Thanks.
>
> Jiaxun Yang (4):
>   target/mips: Legalize Loongson insn flags
>   target/mips: Add comments for vendor-specific ASEs
>   target/mips: Add loongson ext lsdc2 instrustions
>   target/mips: Add loongson ext lswc2 instrustions
>
>  target/mips/mips-defs.h |   8 +-
>  target/mips/translate.c | 442 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 442 insertions(+), 8 deletions(-)
>
> --
> 2.27.0


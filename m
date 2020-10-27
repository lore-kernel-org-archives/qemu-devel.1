Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835E3C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:55:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE2420679
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LCrCh74r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE2420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQNx-0006rx-PM
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXQ1v-00031p-N1
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 10:32:57 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c]:35574)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXQ1q-0001Jr-VD
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 10:32:55 -0400
Received: by mail-ej1-x62c.google.com with SMTP id p5so2561636ejj.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 07:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=w132epp37UIPQOBdAVfm7gs0UUgaHhJwk1cX9NNdpsI=;
 b=LCrCh74rzdIP4Fy3Wh4DI13EXPBvaPwtPJD3zwuA7OBfyZaBa1VZvUjEZDrPv4ylb5
 CLzjsyDXp2p3QiU8Joy2mPPKKSvMn/R2hJSj9P1uDHmxKbCMvzqqkpL/1FKdWQwbfRsD
 ziLLH2LMPt9J/CoyM8gMd9ocG7+AbUjDsdVagVaD1ytEcLUYGyk5MNQaBI/Ml56jyWDH
 s1WG1ESKjxbuRpF+gFGmswfup2dG+hvPlG1lPLpWp6QDjIwPbDztOTteGjJUI1QqTSGf
 77Q8sXyKuW04Bbys5Mo4Zrkb048/sBMjivQWVMzU1hQkdYY98SbINHuxp2Ahsbv0boMl
 A2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w132epp37UIPQOBdAVfm7gs0UUgaHhJwk1cX9NNdpsI=;
 b=c1FcyW6ityU/J7SQVnLxbL6Am9rF2IpvmCnRzEhTj/m9NtJGhy7cdk0FwU4BuF0FDW
 XyK9JLc8Tep/X/WbVA1Dktf30I5IS7hOnL3D/WxV8JcLkeT30T3Pfp+YhYxqN3E/P3aP
 6HxgPUDVODT9bVZGVUfD0dl2vuZ+nOcEQsjJRgL1cT4Qv6K/u/P0hd3z9pXrz5GGgNXh
 Tg0tzpcGp7ai/CrkGDiTbJ3KFquv1yqNX4MwwnDWfMpadf8CXZgEN7jrbdGIuxQZIVh6
 P0gzlnDAtmeSvDhnkBysqpIse4ADulQlwaKjFfRMFBmextErdGHxCgKWYHr5VZMcnmsJ
 +lZg==
X-Gm-Message-State: AOAM530hks6jvEHMwnXUFQbGOBZogHGhJNcBBSVsiO2RUuoY5w6gGyoz
 TPmEL5HHhX1bJ0JZaj/A1eqA6Q41u2le/RX1bwVsFQ==
X-Google-Smtp-Source: ABdhPJwm2iXdPsyjIbgKkn9oqGMUptBponBEk2Znkj/jdUFSGBz2zT1tNKvsYWox7ZBPHTRiFZqJ2jW8AthRFzkRJWI=
X-Received: by 2002:a17:906:ce21:: with SMTP id
 sd1mr2741448ejb.4.1603809169200; 
 Tue, 27 Oct 2020 07:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <672b8aa0-2128-23e1-b778-01a4d96b209d@redhat.com>
 <CAFEAcA8OjeQ-utD56inorMk8dM6RNRzr-6Dv-YEW4n=qBi_MBQ@mail.gmail.com>
 <20201027140818.GC102411@stefanha-x1.localdomain>
In-Reply-To: <20201027140818.GC102411@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Oct 2020 14:32:37 +0000
Message-ID: <CAFEAcA_DrPBxFGQaitXxHT-bsviPYB1hyBrNzYM5ygbQNhuJ=g@mail.gmail.com>
Subject: Re: [RFC] Using gitlab for upstream qemu repo?
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Justin M. Forbes" <jforbes@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Andreas Faerber <afaerber@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Oct 2020 at 14:08, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> Here are the users with commit access to qemu.org repos:

> The people who need push access are:
>  * bonzini - qemu-web
>  * mdroth - qemu-stable
>  * pmaydell - qemu
>  * rth - qemu
>  * stefanha - qemu
>  * thuth - qemu-web
>
> Does this sound good?

All the qemu-stable-* are old and presumably no longer updated.
mdroth needs access also to 'qemu' I think so as to be able
to push to the stable branches/tags in that repo.

thanks
-- PMM


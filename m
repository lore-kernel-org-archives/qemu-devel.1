Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1ACC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 13:03:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D126E221FF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 13:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lya2sBi8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D126E221FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kREWj-0000XS-Mq
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 09:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRETo-0007e1-PV
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 09:00:09 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:40265)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRETk-0006BC-H1
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 09:00:08 -0400
Received: by mail-ej1-x641.google.com with SMTP id p15so16964003ejm.7
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 06:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wBlrNAswONeRvv0CvtvhYPYzGQlEuwxRYz5X8aq1u4U=;
 b=Lya2sBi8beJY40U2K2/M2lDUn297YapLBEdFHrmIDuyvqaC4Yo0sYN5Puw5IwsTMy8
 P6J9yf8UmDrJdcdvzKM7FXzZPki7G4mdvcLTqpJ4jfLT+BKQOiLhHm05XjlJSWL8h06g
 ZhakdiIHt54aAY9Q6Q/+e7gOEIrQAxC28vwuWvvdaJ40bjtdiKVgggF1Lmi+/LA9C80m
 1eTlVE9GmjNbqYTytBtPO/ejwg8+r8/xsdZ3IrAlHBXXQebX+nrZ0fmyaKm5JwlZlCkh
 4BKZuCxQg4QmNFNRSJob7favOJ869v7zYjNzB6/Mk95uw+bn/IHAKPf7iwKOUO/A1AF3
 IU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wBlrNAswONeRvv0CvtvhYPYzGQlEuwxRYz5X8aq1u4U=;
 b=pdExodRmyTg3x8zpSm8Skl7uvdsJ8KVEMDGhxTqxA8KYeWDhg3fwgsu14hEq+xuzdf
 cLmtnyDSFtHyoVJkri/OXAcWIdZk1t7jfGrkMi+lrL792bJe4SK0fEVsP2v09gH2fPzE
 Hbq43ldWap8gjfGarpxOdQ9DM3a7asqtVMXzwVnj9JWOKV5hlkR+hzA0SmlykoEH8ekg
 4JEiDmYpcJ8Fm1tO3Z84XAPpNavrTSpTgEHqgfB1YYc8plJBY9miDyffDOx/tcWaJ1ll
 8tERsEglJOyv05+BT744aMmSqeIb9P2u1fm6gBKRqMNKs0vC0ZnQEbvUIublLUHoKEiP
 1dlg==
X-Gm-Message-State: AOAM533/yjZp3F4KJqjG5apvhm6MWQbZuvGH3i16O7uSz2wc1rD6s5kG
 Hk/WF9XZkbskDoYwkd8meZBvCqmvil3hVOgFaUBaAQ==
X-Google-Smtp-Source: ABdhPJzLlWXvELHZKBCzFujHNvc5tiag2GcXjOT+jSIjtFfhKGs7AWrwQraU/VRR8+JQsxlSbLSrT6/Q+bHUXmaBlhQ=
X-Received: by 2002:a17:907:4365:: with SMTP id
 nd5mr19653846ejb.56.1602334802639; 
 Sat, 10 Oct 2020 06:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <1602059975-10115-1-git-send-email-chenhc@lemote.com>
 <1602059975-10115-2-git-send-email-chenhc@lemote.com>
In-Reply-To: <1602059975-10115-2-git-send-email-chenhc@lemote.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 10 Oct 2020 13:59:51 +0100
Message-ID: <CAFEAcA9fFN6+-FLwiYrFPaz+rtriZKDwwD1b1nSDzvhx-LYEvQ@mail.gmail.com>
Subject: Re: [PATCH V13 1/9] linux-headers: Update MIPS KVM type defintition
To: Huacai Chen <zltjiangshi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 7 Oct 2020 at 09:44, Huacai Chen <zltjiangshi@gmail.com> wrote:
>
> Update MIPS KVM type defintition from Linux 5.9-rc6.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---

Is this a sync using scripts/update-linux-headers.sh ?

(I vaguely had the idea of adding a --make-commit option to
that script so it would automatically create a git commit
with a header message saying it was a sync against the
kernel git commit, but I never got round to it.)

thanks
-- PMM


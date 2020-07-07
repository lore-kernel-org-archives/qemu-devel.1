Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F6BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:43:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21761206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BhOhQQRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21761206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jssYz-0003pP-Ej
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jssYO-0003PZ-R0
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:42:53 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43331)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jssYM-0006pH-Um
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:42:52 -0400
Received: by mail-ot1-x343.google.com with SMTP id 95so24461225otw.10
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 11:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BqAHWBd0R/KJjN66yjPLeC7VBJ+mckWekDw13lTah0Q=;
 b=BhOhQQRhQGvpkNVtVrti9+4FcVxGuw48Zlkvgbgh2Y3BQqzLUgh4wMdVEgQr9jeS0U
 BWzx2QkHBDh8lfVhHmNmML2qGHEKT+rhfL7dAK310ES/w0Em1eCwnN3SDUSABjPEnsOE
 s6K4HU3VL+Cl1G8oaz9Nr6Ozw1cftn1n9hHQuIBBuf2ozpcJW3oIZDqNNyrknzBKBrp5
 v/8UjQApg59/dNwdbYxj/3RzxmF+pydxY4hpXO8kif5jz5TG1WMsnq0jR9tkNXNhbYP9
 vKpUyFEgaj0PNil7+EMNQCqsQS2UlpXynEsFAVzzejvQ6EeIH3a/0EG5VcARGTCcR102
 OGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BqAHWBd0R/KJjN66yjPLeC7VBJ+mckWekDw13lTah0Q=;
 b=GZC518nWJBdoyBSPako8nsjSgedKiE9eBfHgPp+NNSktRGEtGNbgaMaUQyxJCM4LYw
 kXJZabqeJ2wOKpS3j7aD/zGKWUiSeDQJTd1MWiX5H6MIjg4rBxjaJswVmWJjOmLq5EVy
 Zgn5vD2sZ2fMM+oDNAlcpUdSqNukah8nI/ytvgppwjZzgs62/+Pzue1XvaCJfGvl3RnX
 uuqz9/Gx7RFJ0op7UndCHrgnEPcKu1DQhAp5rwImVv2Ya7oqJDng7ugGJLPfVJ3a+iYm
 TjUyp5Itx+33ohCBZWYs83R0hDGVl5gm8q1ZTEOD9utWAs+Af5HC5lcHJsyS1BrMMc9C
 /Euw==
X-Gm-Message-State: AOAM530SI1EyMbYzKMusaSkTD9p2cIhz8K6Qk76lONGeZz7GP9PdcHnV
 aK3WrPAptX8T97i1+I4bS52SIKazm8VB4sP5SUDZBQ==
X-Google-Smtp-Source: ABdhPJwBOBHZbc+Rrt04ssxqpHCdJIZsGpoXy5yAC3sVhh4JnRrsbllOkQdSGlM96cOaAqc9rlqMKryZHu2A+ObRBA8=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr39622943oto.135.1594147369566; 
 Tue, 07 Jul 2020 11:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200706164155.24696-1-pbonzini@redhat.com>
 <CAFEAcA-F1FGde+=c3iS3wcRWG+i0RgYj5-jwafn0sX6EEYEsWA@mail.gmail.com>
In-Reply-To: <CAFEAcA-F1FGde+=c3iS3wcRWG+i0RgYj5-jwafn0sX6EEYEsWA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jul 2020 19:42:38 +0100
Message-ID: <CAFEAcA_9Yh02ecxuYR0cGJHkf1dzNT7ain7Nv01a+QL2wnrQAA@mail.gmail.com>
Subject: Re: [PULL 00/53] Misc patches for QEMU 5.1 soft freeze
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Jul 2020 at 19:37, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 6 Jul 2020 at 17:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > The following changes since commit fc1bff958998910ec8d25db86cd2f53ff125f7ab:
> >
> >   hw/misc/pca9552: Add missing TypeInfo::class_size field (2020-06-29 21:16:10 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/bonzini/qemu.git tags/for-upstream
> >
> > for you to fetch changes up to 80270507070ec73ea82741ce24cb7909a9258ea3:
> >
> >   scripts: improve message when TAP based tests fail (2020-07-06 12:14:25 -0400)
> >
> > ----------------------------------------------------------------
> > * Make checkpatch say 'qemu' instead of 'kernel' (Aleksandar)
> > * Fix PSE guests with emulated NPT (Alexander B. #1)
> > * Fix leak (Alexander B. #2)
> > * HVF fixes (Roman, Cameron)
> > * New Sapphire Rapids CPUID bits (Cathy)
> > * cpus.c and softmmu/ cleanups (Claudio)
> > * TAP driver tweaks (Daniel, Havard)
> > * object-add bugfix and testcases (Eric A.)
> > * Fix Coverity MIN_CONST and MAX_CONST (Eric B.)
> > * SSE fixes (Joseph)
> > * "-msg guest-name" option (Mario)
> > * support for AMD nested live migration (myself)
> > * Small i386 TCG fixes (myself)
> > * improved error reporting for Xen (myself)
> > * fix "-cpu host -overcommit cpu-pm=on" (myself)
> > * Add accel/Kconfig (Philippe)
> > * KVM API cleanup (Philippe)
> > * iscsi sense handling fixes (Yongji)
> > * Misc bugfixes
>
> Hi; various build or test failures (5 total):

Also it broke my working tree, in the sense that when I
rolled back to current master incremental-rebuild didn't
work but instead failed with:

make: *** No rule to make target '/home/ubuntu/qemu/Kconfig', needed
by 'aarch64-softmmu/config-devices.mak'.  Stop.

thanks
-- PMM


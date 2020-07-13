Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67928C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:02:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35C9D20791
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r7gtQJE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C9D20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv2me-0000J8-EK
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 14:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jv2jI-0003qu-H3
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 13:59:04 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b]:36139)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jv2jG-0008AM-D6
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 13:59:04 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id z127so2544235ooa.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 10:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nOBge7l40fcMSdvSiB2dOZ8OByulorHZpXcGYQDD0fw=;
 b=r7gtQJE3trGn50yGhL/MTWin4WDkOKS47IdgOV4ru9XgEh5G6Q8rrfGvBWEi140uEl
 HsUm+SnT8bE93N+lQOiDCjtHdTLDz0eCyU8G3QZJFCTCRNY5n/HJHcwJvDSCDMCh5GyX
 YbAyCuTsBDWY3ZwMSAlyBzclpr+iDG3y8Yrwq+lFxWwiM3futXj9fe8r1vVjGkXGWQeN
 y/Tb7+W+ctBge3J4if37rf74kgIxQ0CdJGHeuE0goyZMQHZUFeyN47apdHgS9fLf9036
 W6hRo6KH2te4KWfthtXMlbD0uGEZV+pd+sPWGHKotwW6ZZAAteNWQQKN1L1bpGw0afWJ
 9PsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nOBge7l40fcMSdvSiB2dOZ8OByulorHZpXcGYQDD0fw=;
 b=iaLOD2meLiQNIQ3VmZRK7M0DA0cglYQmO09rklGk4JX9MPZjqf33MG0fx//3VOj1V2
 BHFvxTYRRDpb++u81Ho6aq97A/543Bb4Hy/IYiw9nojDekjkvj9egchZXhUzuHvSww+R
 5kaWza31NmyXnUGKY/ABMXwtK7zhGqsIVdkJ4DPsfObSCuS8lkbo6hlPP9L/BriLaqh2
 d1Lhx0n/d39uu53SPrIPYMtK3eVLPj7ot5pIi1/vcFNC2aNDy1Eu51XS6682Ma7D7oly
 1wQ9F51YvedfbQVRbBrV931vt6WKcnJbun9JF+mtbEdmtw2VqaKe3dd9dWytdZe+5OqE
 9QgA==
X-Gm-Message-State: AOAM531FmZjmYO7cNg4fQXZ87WWEXfJg/qFlIn2UePwV08ka+Eb1bUQE
 jStnKMBLmxF18dj/z29TzmpY5kAQQaTfJnb8FbO6ZQ==
X-Google-Smtp-Source: ABdhPJym3wyuZs+dZBA4oZ7fNIQWY2zW+S14Q/55oMXjQZ5Hchafh91gD6LuqltwFIrXNLs8+7OrEc6FJen8r3+eLKg=
X-Received: by 2002:a4a:2f15:: with SMTP id p21mr1076153oop.20.1594663140601; 
 Mon, 13 Jul 2020 10:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200713141049.2241-1-kraxel@redhat.com>
In-Reply-To: <20200713141049.2241-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2020 18:58:49 +0100
Message-ID: <CAFEAcA9rF-=sS=hqfe0g+poewAU7P028Hza=KsuZQjbr2ZLijQ@mail.gmail.com>
Subject: Re: [PULL 0/4] Fixes 20200713 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc2b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Jul 2020 at 15:12, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 9f526fce49c6ac48114ed04914b5a76e4db75785:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-and-misc-110720-2' into staging (2020-07-12 15:32:05 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/fixes-20200713-pull-request
>
> for you to fetch changes up to 631009e775a91018a62e2670b4473e99916f858f:
>
>   usb: fix usb-host build on windows. (2020-07-13 11:46:51 +0200)
>
> ----------------------------------------------------------------
> bugfixes for audio, usb, ui and docs.
>
> ----------------------------------------------------------------
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM


Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C0FC38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 18:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E881F2495B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 18:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D/eKfIKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E881F2495B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWlcO-0007VA-49
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 14:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jWlal-0006Mk-U6
 for qemu-devel@nongnu.org; Thu, 07 May 2020 14:49:59 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:32871)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jWlaj-0001dG-La
 for qemu-devel@nongnu.org; Thu, 07 May 2020 14:49:55 -0400
Received: by mail-oi1-x235.google.com with SMTP id o24so6178637oic.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 11:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ghWtJOh4FAnersHq1Gb3OA0xlAlZU28MGbdHQh1svEA=;
 b=D/eKfIKhfhj9AB1ean+2C22gHHKyKJNbAKcfXNliz4DzwNvQCGCJ6DRbIgE9PqcOqx
 cQkugkCnZNq8AWZV0ChrT0zDG4f7gl3LIUpP2WeylDAOOMiHwBNZ39rVqDC8Mnxqdb+X
 5cNPH9Rib43Vb/NttzYfEfiqFB7TZmD2WBUKxtKODLbRipClg0ynh8AYpkeAdtzC4CPH
 4ZTeJVWkgEbq9z2P69jk1hhQcQ8nFVpWE/i7GFjogAzTWIhRaqbphhehCVtfU/GcGMzu
 Wd3/hcdlKCm962odwQdRVMK0F2IaX2FKaD15JR+e7lCy70rExeM6RBgOLoI01nY66P2Q
 s8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ghWtJOh4FAnersHq1Gb3OA0xlAlZU28MGbdHQh1svEA=;
 b=UnPx+xjAiY5dS2srKSfYeHrgJE8xELzecMcrQ0sNk7IZ1q/Eo4/3T/MnXtbX4Jeeh8
 5hhnTbosFc8S2WKAXMyZN60TIWFgECW11WHvjlQAE/pMbpZGg6J0hWT7mygh+CcylqCK
 6hA+jHyku5Jq2WQEogkGkX+uRG91nJXo754IpnF9pD7uo2NlFvWcHToQofnMGlqLRc5j
 0Fya1ZH/uKszRRxjo75UZIsKDr63n2XUAm6Dcecb1Bs8iq4uBEqUNEgjNLex5YCx47MM
 7th3Y+J9JRL1BX67p6ILTI6LsVJI4B4k68oSNUHjHL/kB7IBO4gU4lbDOCU+gt7WN/5A
 NiXg==
X-Gm-Message-State: AGi0PuYsZEnyJqy9Z7zJdjfjq/46eNvFe1z2NyQFTm8QzVw699wmEPOT
 wvSGBn6Ssf3nuVOWslsowUb1YTQnUlCXj5Oyks9BPA==
X-Google-Smtp-Source: APiQypKQLEFKNJ3YNcs8p2PKxCyhpcTU35XITDUoGgZThOwQKFECSRRLd14qmN/QkP4pHTNHtfE/7AUJMvk8Eov54GI=
X-Received: by 2002:aca:895:: with SMTP id 143mr7638739oii.163.1588877392367; 
 Thu, 07 May 2020 11:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200507170211.238283-1-dgilbert@redhat.com>
In-Reply-To: <20200507170211.238283-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 May 2020 19:49:41 +0100
Message-ID: <CAFEAcA-BScq1SX38eUGSv2b8tFoDDBzw4XYX3yLPAfuVQ7kJTA@mail.gmail.com>
Subject: Re: [PULL 00/12] migration queue
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x235.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>,
 David Hildenbrand <david@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Pan Nengyuan <pannengyuan@huawei.com>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 wei.w.wang@intel.com,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Keqian Zhu <zhukeqian1@huawei.com>, yi.y.sun@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 7 May 2020 at 18:04, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 3c7adbc67d9a5c3e992a4dd13b8704464daaad5b:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/qcrypto-next-pull-request' into staging (2020-05-07 14:30:12 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20200507a
>
> for you to fetch changes up to 13f2cb21e5fb33e9f8d7db8eee48edc1c67b812f:
>
>   migration/multifd: Do error_free after migrate_set_error to avoid memleaks (2020-05-07 17:40:24 +0100)
>
> ----------------------------------------------------------------
> Migration pull 2020-05-07
>
> Mostly tidy-ups, but two new features:
>   cpu-throttle-tailslow for making a gentler throttle
>   xbzrle encoding rate measurement for getting a feal for xbzrle
> performance.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM


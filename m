Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66237C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 14:54:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 315E62086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 14:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w7J8dtNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315E62086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hydcJ-00073S-CN
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 10:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hydbX-0006IK-TS
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 10:53:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hydbW-0006Kw-9W
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 10:53:23 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:43129)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hydbW-0006JW-3p
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 10:53:22 -0400
Received: by mail-ot1-x330.google.com with SMTP id e12so9764247otp.10
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 07:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NEqUlxpyaD8tpHuIgkkHWvrjt5IjvUtkwHT3BLKMHfM=;
 b=w7J8dtNNaFYqHgE+3LKulJ8PRSf1H5RASCN+K5T+oCGwlp1pkND9vKm0td1iGRZ2ZO
 2GudG5t5DmvJwVVIuIbG0RGDswyE0Qd31GmEQTxit1UfnCIBcYSiQPzedDIBB6W1udsn
 gONaSeKDxXjMQrXFtdhRVPyqlTyAqfjN6UWqU8Lgo2VXXTZ+bFuCzveLuclXiw1728fJ
 rjurRUnnKWo3iOAtLbW76nfykptK0RRSM2Z6/XCByFrfMUFLA5qsajy+gAF34vvTBPzP
 YUaYvWU3onGtAYtSrSf/sEEePhDtruY+5U9nwvHXtA2d0OJ+vpEF8d1O60QL9rmgg4yE
 cKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NEqUlxpyaD8tpHuIgkkHWvrjt5IjvUtkwHT3BLKMHfM=;
 b=mEmEKoo0zra6igvbGaW9G/ZN3BKt6bYhgoqeSuq5JAxOcV+RwvwD1doGvlfY/IeuV5
 0DCfL12H5DlJPMT9xvKh9vRwvRVAbo6/RWr+KzPIMF6nOtYx0WDEmFV3vz7oX/9xJFfp
 ojC+7H9ql/v3GGEHiGpp1YBlnuXMlLSGguBC4hk2stDD+9RQ/YHFNtW5A5bZ+Zsl5P3m
 utpnLU8TR6swvX0L8zMK/TSu8NQSVZgiLgofExwh3vusu/49R8ywDJ8ow8/bF4XxuPTv
 UsFjRuKxwHl6Ssh5q84hf+Qn1Xioyd12ZUKTzGBpDqU7Z4qGNwUPEFZiJ7NQ1F09GcXV
 h+rA==
X-Gm-Message-State: APjAAAWgfL2OxJCHZynOYUbf2XwvPqCyNZ9MkY3pXltijzipt8OS/wzM
 BArjE6kygrk5rOIe0TC0/jhde/7fqhunJAHPRy/C1g==
X-Google-Smtp-Source: APXvYqyPgF5oTIBs3JjdXSuWMMsIe1huqUI+eEFkAPqkm2c/eKhj/Wop7yfIPj5WfyN5i8ARQFfZ5T2oyxTExWgn8cA=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr8353095oti.91.1565967201016; 
 Fri, 16 Aug 2019 07:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190816130450.2763-1-armbru@redhat.com>
In-Reply-To: <20190816130450.2763-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Aug 2019 15:53:09 +0100
Message-ID: <CAFEAcA9+c+7FBLHjGbWCUcTND=PTMHqEa=JwakDMbKNVNGtVsw@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::330
Subject: Re: [Qemu-devel] [PULL v2 00/29] Header cleanup patches for
 2019-08-13
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

On Fri, 16 Aug 2019 at 14:08, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit f8f2eac4e5de8ce8ef17591ee1b84904437be25b:
>
>   Open 4.2 development tree (2019-08-15 17:20:55 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-include-2019-08-13-v2
>
> for you to fetch changes up to 54d31236b906c8f03eb011717de7bc47000720c3:
>
>   sysemu: Split sysemu/runstate.h off sysemu/sysemu.h (2019-08-16 13:37:36 +0200)
>
> ----------------------------------------------------------------
> Header cleanup patches for 2019-08-13
>
> ----------------------------------------------------------------
> Markus Armbruster (29):
>       include: Make headers more self-contained
>       Include generated QAPI headers less
>       qapi: Split error.json off common.json
>       memory: Fix type of IOMMUMemoryRegionClass member @parent_class
>       queue: Drop superfluous #include qemu/atomic.h
>       trace: Eliminate use of TARGET_FMT_plx
>       trace: Do not include qom/cpu.h into generated trace.h
>       Include sysemu/reset.h a lot less
>       Include migration/qemu-file-types.h a lot less
>       ide: Include hw/ide/internal a bit less outside hw/ide/
>       typedefs: Separate incomplete types and function types
>       Include hw/irq.h a lot less
>       Clean up inclusion of exec/cpu-common.h
>       migration: Move the VMStateDescription typedef to typedefs.h
>       Include migration/vmstate.h less
>       Include exec/memory.h slightly less
>       Include qom/object.h slightly less
>       Include hw/hw.h exactly where needed
>       Include qemu/queue.h slightly less
>       Include qemu/main-loop.h less
>       Include hw/qdev-properties.h less
>       Include hw/boards.h a bit less
>       numa: Don't include hw/boards.h into sysemu/numa.h
>       Include sysemu/hostmem.h less
>       numa: Move remaining NUMA declarations from sysemu.h to numa.h
>       Clean up inclusion of sysemu/sysemu.h
>       Include sysemu/sysemu.h a lot less
>       sysemu: Move the VMChangeStateEntry typedef to qemu/typedefs.h
>       sysemu: Split sysemu/runstate.h off sysemu/sysemu.h



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM


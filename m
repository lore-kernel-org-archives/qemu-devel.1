Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94892C4CEC4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 18:57:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EB8020820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 18:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eOdgFx6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB8020820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCTWS-00006d-EH
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 14:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iCTTZ-0006QY-Cl
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:54:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iCTTX-00068X-51
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:54:20 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37284)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iCTTX-00067Y-03
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:54:19 -0400
Received: by mail-ot1-x344.google.com with SMTP id k32so13104820otc.4
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 11:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=20wMnS9sE7SkaDy4jeoxOwwRH46kamUBFHZzSrG8KCY=;
 b=eOdgFx6YfAwe3KCrOp+dGTbqYQEsYPFA9u4fl69CQ38e9oVe3Fa+KBeRpJsSkxb+Ot
 NrFSZiuIvSVldvNuuWez+UOkk4gsnSfn61Yks5cnzBZvWwyWM+ABAo0t4cdYQwALcLQ+
 9MXEQzjGeZ0FwEf6j8/O1wFAq3hajYxZGHXwsPREnV/+mhm7WDRIUdigN7wiSw66tlBW
 EdPebOZ/OXKyqXiosyJkthwEIKdAHp5bGAnyB+S3E6GrEfCipqGXp9/S0kdwRroImmfa
 1KFWeNOIwTtvNoYfH2PwYiKDUdMu86SjzaPULytWFn5WMuAMMPiekNjs/8XRBn9tZzku
 d/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=20wMnS9sE7SkaDy4jeoxOwwRH46kamUBFHZzSrG8KCY=;
 b=H4jkqCUzJka9FhYPZYLrOeOgIWp1uKXxLalVXcFH0+p5rVfpD0R2V3+tHFVBMc5SDK
 fUPvCl3nqfrgwVcdUu0DFP4HNJRR4LwE5cW/bnQaxP7K8OnoY8Wss82H95B0Zl1n0m0R
 d1i6U8FBSzxgXyt1i5R+6yvqgQfMdsczflf7AbKyEVmuZoy3EsBm6UnI1WQCfl71LDvL
 8gHVtz0Gxg+rkFRBPBTc+JGmG/wrATxlnGd8AZBhAYJfg8MplbhJfcP9Ztsc6buJbodn
 P0hVOkT4RHAzcOGGzepPwxKphxtOGVP0pkBPtC7hecslsANAI6ahIU4o/TVC62RHXEZh
 UKag==
X-Gm-Message-State: APjAAAUSCSzGGh0T5fmGiALvV2I13t0wad48wgUQbnkaqPACdxRlW7VT
 CsPuT1gN0ULkVakqGKIsiWC90Y1wQI9dpNzXgIyC/Q==
X-Google-Smtp-Source: APXvYqzLb9M8pa5490VU5GcmN3oMpF9/VREFxKkSeOiJ2I670SoP+0Hm6q2BeFwgtPSbq7aZUl5hXFQx5Q1ZB9MbKeE=
X-Received: by 2002:a9d:6d0a:: with SMTP id o10mr1043813otp.221.1569264857480; 
 Mon, 23 Sep 2019 11:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190921150420.30743-1-thuth@redhat.com>
 <20190921150420.30743-3-thuth@redhat.com>
 <bd6efd14-9200-98e2-4f76-dda101f85274@redhat.com>
 <8585b93b-e239-829b-d634-b89941f27aed@redhat.com>
 <CAFEAcA9k59CRG23qP-o5PF0mdXvXpszhuxx+GpbpWO+hFdHOOA@mail.gmail.com>
 <4841d83d-4d91-eef6-28aa-c920cb10d9c9@redhat.com>
In-Reply-To: <4841d83d-4d91-eef6-28aa-c920cb10d9c9@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Sep 2019 19:54:05 +0100
Message-ID: <CAFEAcA-YHQZptu+owoVZeoEFG9LC1g=L=ASbb6zEg=UJ+RbzMA@mail.gmail.com>
Subject: Re: [PATCH 2/4] target/arm: Move cortex-m related functions to new
 file v7m.c
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Auger Eric <eric.auger@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Sep 2019 at 19:51, Thomas Huth <thuth@redhat.com> wrote:
> It also sounds like CONFIG_ARM_V7M should rather be renamed to
> CONFIG_ARM_MPROFILE or something similar?

Depends whether it's visible to end-users or not. If it is,
a different name is probably more helpful; if it's just a
symbol used in the QEMU source code/makefiles/etc then you
might as well stick with the V7M naming convention we have
for consistency with the C files.

thanks
-- PMM


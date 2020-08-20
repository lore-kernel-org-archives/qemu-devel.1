Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40298C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 16:11:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A38A2072D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 16:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mKndZgTa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A38A2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8nA1-0003bx-BI
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 12:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k8n91-000348-Me
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 12:10:27 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630]:34821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k8n8s-0006tj-Pp
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 12:10:23 -0400
Received: by mail-ej1-x630.google.com with SMTP id a26so3198864ejc.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 09:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lEh0Sht20vd6COX0nKB/FZOTccKwDGdzCMfhsGuLF5s=;
 b=mKndZgTae7Zi9uyJxFQEUeRqsetnWvHDP/i/ZF2wAjdpb/sqEb3agU3M68wk25Y+w2
 hKAgpQQOhgpaPVGpimk/vhGNBltqI7/0YtDm7EjJ7hodoDoWQeS/B6S5MQ8HMOz9VJHe
 /YtLA0OemFGXhbHGZiQy7Y7aT2EoumCRry8TDTQNRNOMIsMYRt5UiBFWTLlsvWb7RL4K
 gUAe49aWQwyCVBPWK2Uds+3jNu6bfoWQnuQm3GLDiICtBnOh8WIiyTiCgFaETugINzTx
 vwMoM6z+HdtTl4eOY2Z1MKvJiTLPg9mrOUul+ns09RN0X66ocyPMJNsI2VbB24tMXD5C
 8rew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lEh0Sht20vd6COX0nKB/FZOTccKwDGdzCMfhsGuLF5s=;
 b=Yu1NKK8XHih9L+la4Dvcjp9dc177tcwRg9SX9av6F/k0T0Sn1EY6Lcd05q0R91407W
 6GCVf6ZcORTBqaUKDGqWwfRRXjzp2PN9I3dxsd2jIJNJe2ZPvLX8ALtLyhHhJHpsuacc
 a2MFBSKJY2xFVGm5SQRO77qizSqtpT6vTCGCNr0P7mQy2o5aje+UhUYQy4q+2lqguAuN
 IUYiZlkIKxeLmc+uC9SmjMoCl8eJ6/10PBSVSeP61Ooi1YyqUmVN7w3UIbFZbXLZ+ItV
 WGGkn3EgAFxXSP+nUCoDL8eEfZcz5oNabisrm4b3guQwxSTLYlClBXpWDbIIgfZVU/Cm
 VbaA==
X-Gm-Message-State: AOAM533OnQqtYwaisrg9o/DXHPXRc7Qld2kOjgvl/D84jMMrKhE0AYPn
 +wobbK7J56NYK0FLMudwiKvAxJfuinubc4Z/ooK1lA==
X-Google-Smtp-Source: ABdhPJxKDwW46fBYw7lthRsEzN0sFLdSAmTc075Kxk4mM3FcDlkpNe4pCAlFG0pnWfu6Xsc430q4ygNlVSTCU3/pFzg=
X-Received: by 2002:a17:906:2cc2:: with SMTP id
 r2mr3881975ejr.482.1597939817072; 
 Thu, 20 Aug 2020 09:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200819213203.17876-1-pbonzini@redhat.com>
 <CAFEAcA86m9N5ceYB+Nu965Se=qyZ_3W-Cn76Qc+Dd75hEApz=w@mail.gmail.com>
 <446a210a-7e88-ab9b-05f4-6b0ffabf97c6@redhat.com>
 <CAFEAcA8chPqS0keyGv0vBgNgacnMo95gA3LZDU2QfmteQ=4UZg@mail.gmail.com>
 <223cfebd-605c-20d0-f649-b462effaf04e@redhat.com>
In-Reply-To: <223cfebd-605c-20d0-f649-b462effaf04e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Aug 2020 17:10:05 +0100
Message-ID: <CAFEAcA_He0zGhzFDfF6+_S99AiFG2tOT42KWhM394=Gq4Y33yg@mail.gmail.com>
Subject: Re: [PULL v7 000/151] Meson-based build system
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Aug 2020 at 17:02, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Meson (just like configure before it) is looking for SDL and other
> dependencies even if you're not building system emulators.
>
> Because you don't have those dependencies installed as static libraries,
> Meson warns that library is marked as "not found" even though the
> library itself is there.

Looking at the old configure logic, I think what we do for a static
link is that we do a test compile, and if it succeeds then we enable
SDL, and if it doesn't we silently don't enable SDL (and I haven't
tested but I assume that this config without the dependencies
available as static libraries is going to fail that compile test).
Presumably Meson is complaining rather than just treating "don't have
a working static SDL and user didn't pass --enable-sdl" as
"silently don't enable SDL" ?

>  To suppress the warnings, it's enough to put
> an "if have_system" around the dependency check.  Let me know if you
> want me to do it now.

Don't need to fix this now; I guess we can do it later.

thanks
-- PMM


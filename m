Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E15C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 14:16:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48FAD2075A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 14:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BbXC69Pn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48FAD2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMtwm-0006k6-3u
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 10:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kMtvg-0005fq-Tr
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 10:15:01 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:33419)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kMtvf-0002Ei-48
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 10:15:00 -0400
Received: by mail-ej1-x643.google.com with SMTP id j11so8781621ejk.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 07:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=47emkVqGuyCmgjuNMwSyh17QQFo2mKLDDHDOsUAB/RA=;
 b=BbXC69PnFkb7458U3pQYI/IDGP8F4d1b9Hzl//pRn1FM4orqcOV88D6ss5Vcq4/UW0
 IUfFoQSO4ywtCm7YXGTHIuint7zVl7zTQEnFKMAByC/S1gU4jq1a53XrJAv0VGDNZn4L
 /Lfl0cAc54IwNpakwRZrnA0LN2HPmZlMqWs30abdPC7x4cIUQ7UYvaORihH+NPD6SpS+
 0veDsNGkrYHgXgYWbPkaQQD7GlT2acm/kaTumRM2lUKtDTsEF6wntRnWBLPOU90WofV/
 D6LPuqH8SjFCnc+ulSKlZz1tRcds9UoyIFCYvNpDrqiag8rAf6Eny0Jk8mmSoTprb6Ct
 HGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=47emkVqGuyCmgjuNMwSyh17QQFo2mKLDDHDOsUAB/RA=;
 b=DY6ook6aA/E2GPiwR263X5Kw+ZM0O/A1ob1IAbO+cp4CnW5SY2HPJdiZBvyqZyQuw2
 4JeKInrQnAGFVnG2gNFJi66neFeFq+/ABRotnl+Yjfew2T4fSG7xxzGbJbIt0o7E0daz
 oTs5aOiY4C09J15ig45jqBDVoB8bXV0FV5Zkz2mVuAoXzZVTgylwqLI2B0ZW138PbLwH
 rDXr9BiELjzRDK4EWBoPe1CWXv2omasuhWo4qccA1l3RGQHbC1WDVVx4cptOsmJNhyLl
 Jko+P5dtDxka2v2AWEmiN8ye3NS0QaaQeFwZvLlYwsuBpt5UD0GyZjY+3YLSGO2w1f2h
 m06A==
X-Gm-Message-State: AOAM532uZW9b0yBz7siIayi6XJEWuHZ7hgjlci//MmY/sTlJiR2NPGEi
 ZVRiHlwlm0/+Je3jjR54KeeN2H8GqrN9BEXNfKELLA==
X-Google-Smtp-Source: ABdhPJzS/dEfS6gUVQ5uqN/lFrfeuMtMrU4DKUBLC2Kc4AO89ugqwSncUShMwMnFltP2bYpfJNPtZmuI4m8CDOd33p4=
X-Received: by 2002:a17:906:24d6:: with SMTP id
 f22mr1800280ejb.85.1601302496616; 
 Mon, 28 Sep 2020 07:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200928125859.734287-1-philmd@redhat.com>
 <20200928125859.734287-2-philmd@redhat.com>
 <20200928140448.GH2230076@redhat.com>
In-Reply-To: <20200928140448.GH2230076@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2020 15:14:45 +0100
Message-ID: <CAFEAcA9THz32JdqVF8JykQebw=ub50vY1RMNV+zLuzSHmAcP0g@mail.gmail.com>
Subject: Re: [PATCH 1/3] qemu/compiler: Simplify as all compilers support
 attribute 'gnu_printf'
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 28 Sep 2020 at 15:06, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> I think this can be simplified even more by using GLib's macros
>
>   #define GCC_FMT_ATTR(n, m)  G_GNUC_PRINTF(n, m)

At least on my system G_GNUC_PRINTF() expands to
__format__(__printf__,...), not gnu_printf, so it is
not quite what we want. (The difference is that on Windows
hosts we still want to mark up our our logging functions as
taking the glibc style format handling, not whatever the
MS C library format escapes happen to be.)
At a minimum you'd need to keep in the "on Windows,
redefine __printf__ to __gnu_printf__" logic.

See also commit 95df51a4a02a853.

thanks
-- PMM


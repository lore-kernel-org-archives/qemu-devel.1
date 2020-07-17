Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC06FC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:39:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 947D82070E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BfFXRdWy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 947D82070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwMqB-0006SN-Rh
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 05:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwMpV-0005zg-Mh
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 05:38:58 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42065)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwMpT-00069Y-N3
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 05:38:57 -0400
Received: by mail-oi1-x242.google.com with SMTP id t4so7504422oij.9
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 02:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GSxYfl1Dn9DuIB/h90WXtw1jx920Dz5XjX9RAl4yjZU=;
 b=BfFXRdWyImR+gzPXggD+7mX8gKaJu/eSCQ//JYaTg05ei+Zgk4Y3Bk43D88QHVr7Zx
 ds4ViMJlWH8zS4h7lPKF2rvbdTm9i2z9rz5XdPlbgUtd90bBGmXTJINA2IEHmO2BZCs1
 CdTnuFf4Rt/AIjxgfY6ETasyeIN9ZK0fimocpEW9QvA9LCn4F8FUjiuQkw+r+Ha0vyr2
 NS8U6Ag/+bisPKhdTLIEeDPYI6w5JBTk4IXpEQvMFn2niZmZtAXq6/h5i4+NiYBr6Y8f
 14aEFMyqABWmbe0VuezJt8gEtDz3AHjccCdDJskzq3NJQUq+NkU7PHPDACs8bhFA+RPS
 /60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GSxYfl1Dn9DuIB/h90WXtw1jx920Dz5XjX9RAl4yjZU=;
 b=PKlrrpbn4L5YJtUcNGMKMG8+56eUsewQN+xyLSsm7s23kV8QY9dlnKaISTU+Q4oYX1
 Kgb8RKSG30iRTMWQWlZuYYJpe5fje33N5Q91sxt/vjECEq5i+tRpzp8OHb2zJ/Zghvh+
 s9THcJGEvCkoBPK810uzgeOI6Q0QGItK92kyYhlUR/1Txkz0IMIke9rnFIQkiFzNrxvU
 SZkdXVNFBczFq48bhCHYnpvkZwtSIcdxNy6gbwPGy8KajTuFQd5E0JyOd/Ux0Jr3Fk1c
 asXWsRyB7zi1XT+H+ouaQLjamACdDZUYwfjqIm8Ou7Ysit6ATqJgBsI09SzqiXvbNlxQ
 /zxQ==
X-Gm-Message-State: AOAM531ZnVAtkv0aeLwIx8vkjBLhJVdyYrDEEs1rIndFX3Kp3zCdrCLe
 /q6xI1fKRLnoB9BrpDWI6plPZoxO/kH2OJLDBkqDOw==
X-Google-Smtp-Source: ABdhPJzo7wPSvxHGwQsUAoAvdEeHc+L64u/++Ec6DpTN9eBZ6or0HvmGBkM7PnP2P3hqcx36Z9U0lmDPrXxSlmfqM0g=
X-Received: by 2002:aca:2819:: with SMTP id 25mr6383005oix.48.1594978734059;
 Fri, 17 Jul 2020 02:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200716181903.1895314-1-ehabkost@redhat.com>
In-Reply-To: <20200716181903.1895314-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jul 2020 10:38:43 +0100
Message-ID: <CAFEAcA9RFugiZzq9zcdUpSRiKYdf5H_cyReyYJYrSOD=wsieOg@mail.gmail.com>
Subject: Re: [PULL 0/6] x86 fixes for -rc1
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jul 2020 at 19:19, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit ee5128bb00f90dd301991d80d1db5224ce924c84:
>
>   Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2020-07-16 13:12:05 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-next-pull-request
>
> for you to fetch changes up to 818b9f111d64b40661d08f5e23236ac1ca5df505:
>
>   i386: hvf: Explicitly set CR4 guest/host mask (2020-07-16 14:15:13 -0400)
>
> ----------------------------------------------------------------
> x86 fixes for -rc1
>
> Fixes for x86 that missed hard freeze:
> * Don't trigger warnings for features set by
>   CPU model versions (Xiaoyao Li)
> * Missing features in Icelake-Server, Skylake-Server,
>   Cascadelake-Server CPU models (Chenyi Qiang)
> * Fix hvf x86_64 guest boot crash (Roman Bolshakov)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM


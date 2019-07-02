Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9225CC06511
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 14:12:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6329920665
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 14:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i3wGTlNk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6329920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiJWF-0007hf-MH
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 10:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44643)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiJTG-0005uF-Ax
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiJTE-0004BD-UA
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:09:22 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37988)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiJTC-0003zg-Q5
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:09:20 -0400
Received: by mail-ot1-x344.google.com with SMTP id d17so3358728oth.5
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 07:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LTF46dlc0fdDFj+3L9HfFQ+Er5FxSGY3PKYs9cDf+p8=;
 b=i3wGTlNkWJxrCEK797uUktKMffpYgMPgoluCUYhp3Wx9bvSCwNaOLI7KvRUIO6MfNc
 2NErLDrHhy3/RywlogXGblgKK7l/GoW7a8QZLtyW7D0xNIgHMAn+Gis3y2oEYyZNrmZx
 erBbOY+N4JtqVGMFgetkAZkjkLVPsP6dJvwpUaD4sKWBI2p99LSEZlMYrvxWWGEF0fBY
 L2Xv8hJCcwpF80dlVQ/D3+5Y6PbKGbpKE5+KUJEIh9+G/Ugy/WphhsE2LpUXoL40TngE
 j1h0xUlw2BK2Qk3YvTBGJEHqaB01RRkaOJ6IljddZL0HxkOIu8lz0MAxg0ftV4koTKdz
 s3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LTF46dlc0fdDFj+3L9HfFQ+Er5FxSGY3PKYs9cDf+p8=;
 b=uCyuIHfdRkrE6tbOHkuKjH8AgI8cAj7OBi8ZkkVEVxEGnQ6rGou5u92o2SbBhntObU
 YpNZ8RdUJJcz9A4lDAae97WmWUqF+pN2p+QQpbjgbsfiSYf2EXaRa7SqsRNDUdB7AFKe
 daXdmZlZ/u82p80oG5W3mQ6CNbtYgw87iaa0xZgraYK0yRkDiTcvQzLUxQOL53tMXo6Q
 aYep+rJMxGG+Cb2GFuZbRd+NTdjJWh39Z2ADd0cqHCm7BwZtsR50TvaQDp1ZDDHmjW/u
 f0c3eEckpJO1MSVRG0IuKYs0GIAvvxHZSBwtfrZxaALBvh7r4WuCfJYTawumdARvDnNV
 zswA==
X-Gm-Message-State: APjAAAXcO/DGAkb62LXq5I4pm8M7FPaJopWeFD2MvaWpm/Kr/3fm82Nt
 spRJoA29+yombnkerpLfQF2nFkqnL+s0Dl1pDww9BQ==
X-Google-Smtp-Source: APXvYqydQ3Hb0FNoifyjtVeG5EvJYroH5Qsh0uFNhtxG3ulY/ksuo6+MlP60gXY/nFYkFJnnDdP9bguD9c7iUGliGsU=
X-Received: by 2002:a9d:7245:: with SMTP id a5mr2867511otk.232.1562076547890; 
 Tue, 02 Jul 2019 07:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190701194942.10092-1-philmd@redhat.com>
In-Reply-To: <20190701194942.10092-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jul 2019 15:08:57 +0100
Message-ID: <CAFEAcA_bWHAe_aoaN1+1RFm3zEvAxmzQtVm1zbatJHG_+CgqmA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v4 0/8] Support disabling TCG on ARM
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
Cc: Yang Zhong <yang.zhong@intel.com>, Andrew Jones <drjones@redhat.com>,
 Samuel Ortiz <sameo@linux.intel.com>, Rob Bradford <robert.bradford@intel.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 1 Jul 2019 at 20:49, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> Paolo motived me to salvage this (other!) previous series fromi
> Samuel Ortiz (NEMU project).
>
> v1 cover from Samuel [1]:
>
>   This patchset allows for building and running ARM targets with TCG
>   disabled. It splits the target/arm/helper.c file into logical TCG and
>   non TCG dependent files so that one can build and run QEMU binaries wit=
h
>   or without TCG enabled.
>
>   The rationale behind this work comes from the NEMU project where we're
>   trying to only support x86 and ARM 64-bit architectures, without
>   including the TCG code base. We can only do so if we can build and run
>   ARM binaries with TCG disabled.
>
> v2: https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg03271.html
>
> Most of the patches from v1 got adapted, except the "Move all
> interrupt handlers" patch, because Peter disagreed with it.
> See threads:
>  https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg03908.html
>  https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg07304.html
> Anyway this is not a blocking issue, and can be done once this series
> get merged.
>
> v3: http://mid.mail-archive.com/20190701132516.26392-1-philmd@redhat.com
> - Addressed Alex's review comments from v2.
> - added RFC patches to remove (pre-v7, M-profile, R-profile) from KVM-onl=
y build
>
> v4:
> - patches 1-12, 14-17, 19-21 accepted, rebased on target-arm.next
> - addressed Peter's comment (described in each patch).
> Based-on: target-arm.next
>
> $ git backport-diff -u v3 -r target-arm.next..v4
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream pat=
ch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively
>
> 001/8:[0048] [FC] 'target/arm: Move debug routines to debug_helper.c'
> 002/8:[0004] [FC] 'target/arm: Restrict semi-hosting to TCG'
> 003/8:[0027] [FC] 'target/arm/helper: Move M profile routines to m_helper=
.c'
> 004/8:[----] [--] 'RFC target/arm: Restrict pre-ARMv7 cpus to TCG'
> 005/8:[----] [--] 'RFC target/arm: Do not build pre-ARMv7 cpus when using=
 KVM'
> 006/8:[----] [--] 'RFC target/arm: Restrict R and M profiles to TCG'
> 007/8:[----] [--] 'RFC target/arm: Do not build A/M-profile cpus when usi=
ng KVM'
> 008/8:[----] [--] 'target/arm: Do not build TCG objects when TCG is off'

I'm going to apply patches 1 and 2 to target-arm.next for rc0 (since
2 is helpful to redhat downstream and taking 1 now reduces the
amount of code-movement patches you'll need to rebase). Patch 3
doesn't compile and 4-8 are rfc.

thanks
-- PMM


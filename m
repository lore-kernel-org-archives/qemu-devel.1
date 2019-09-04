Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334A2C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 14:39:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F9D2168B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 14:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nqFqZbsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F9D2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5WRR-0006oW-5B
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 10:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5WQW-0006Jl-HH
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 10:38:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5WQU-00042D-TC
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 10:38:28 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33068)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5WQU-00041w-No
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 10:38:26 -0400
Received: by mail-ot1-x341.google.com with SMTP id p23so20844972oto.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 07:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hIf0yJwW/qXimxNl2cfwn41F+VLlgfCIXor0TJJpaGQ=;
 b=nqFqZbsqMr7dtgIdg0W9SqNiHQnHvMW0zl4Im7mSHU9pKNTVyLvi6spLSPE0HW3eVD
 ZuauxoOJGEdZsSboxKGJt/yfuSkScFOBEoYd+FvccBxSeI9PF6sI7M2fL02tUXiF8EWt
 hk2OXNesMFyRe9Yw1WdxBjPTYapQilio2h13k0OUo9QRT+upNt+NBJuwfwuMpHr+pr1C
 s6VcBXGkkatDiSkpE+kcwgIN90ZlUDy537ZtEDzxjUyuCWx3+DZNN9bXWhZhHXp0bQU+
 WJsrNRx6hjYzt/tuleK8dYF9Al1xHTIB/c3gEhCFlkaBP+1TC9ZLFBZX+n9f0HFLX0UR
 sDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hIf0yJwW/qXimxNl2cfwn41F+VLlgfCIXor0TJJpaGQ=;
 b=QL9YkkPhzj242hk+9NJ0ygPZWcVc39OxFyAS/YswsNAhpiMxQkJRgh8/fNyX0FWHgV
 xtwACTc/f8BG7k5NzgoUtZj86XnTEPLRl0qOF2V6yZmiqFvBE/ZedmtKtODcZ3PZs2MB
 1EwVqhmlkceAetLr/G/X3AP3SVl2xJ+32lZLuWNU6jD3/xOces+F0KnpOpleA1LZTzhr
 H+xEE83EZVEKOuYRSyHf3PZJnHvHGri4LnUYM+o6psNyCt6jlk9QbsupDuFBKr7uIcRm
 jGoibo2WoHCpN/GCv5U6qCGdhUrc9FbuiRI6m4BqkjoAzOs/yByyF+32L7Tvaqen/cmC
 HHiA==
X-Gm-Message-State: APjAAAVfyapPcL68TLsxmxaO/PfXRL2yYtH1Z3sn5IDln6Y9NgZkggjF
 3jJmRKIe4zMpXUWgprQaiZ0SM1Q0L77uNL46dG1wAw==
X-Google-Smtp-Source: APXvYqwaifg5k0G2fSBT+3jJsCLHOPy7cnE8curR+K8PPvcQbZafRYr1DMI0jOk7jlgogIT8xhfREvjyA1OO5e86++E=
X-Received: by 2002:a9d:7504:: with SMTP id r4mr15381066otk.221.1567607905751; 
 Wed, 04 Sep 2019 07:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190903210201.14627-1-ehabkost@redhat.com>
In-Reply-To: <20190903210201.14627-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Sep 2019 15:38:14 +0100
Message-ID: <CAFEAcA_gXqbxCw2HVJp3K10GJmkr5=BLdoRh8Kt-0=aBG16mnQ@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PULL v2 00/13] Machine + x86 queue, 2019-09-03
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Sep 2019 at 22:02, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> Changes v1 -> v2:
> * (v1 was incorrectly tagged "v6" on the subject line)
> * Removed patch that caused spurious warnings ("numa: Introduce
>   MachineClass::auto_enable_numa for implicit NUMA node")
> * New patches:
>   * Keep query-hotpluggable-cpus output compatible with older
>     QEMU if '-smp dies' is not set
>   * migration: Do not re-read the clock on pre_save in case of
>     paused guest
>
>
> The following changes since commit cc6613e244e86c66f83467eab5284825d7057c=
ea:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-reques=
t' into staging (2019-09-03 11:06:09 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to 417332494602e3edadfae3b759a29fa0bb96223f:
>
>   migration: Do not re-read the clock on pre_save in case of paused guest=
 (2019-09-03 14:39:46 -0300)
>
> ----------------------------------------------------------------
> Machine + x86 queue, 2019-09-03
>
> Bug fixes:
> * Fix die-id validation regression (Eduardo Habkost)
> * vmmouse: Properly reset state (Jan Kiszka)
> * hostmem-file: fix pmem file size check (Stefan Hajnoczi)
> * Keep query-hotpluggable-cpus output compatible with older QEMU
>   if '-smp dies' is not set (Igor Mammedov)
> * migration: Do not re-read the clock on pre_save in case of paused guest
>   (Maxiwell S. Garcia)
>
> Cleanups:
> * NUMA code cleanups (Tao Xu)
> * Remove stale externs from includes (Alex Benn=C3=A9e)
>
> Features:
> * qapi: report the default CPU type for each machine (Daniel P. Berrang=
=C3=A9)
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM


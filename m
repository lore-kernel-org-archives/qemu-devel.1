Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469D7C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:17:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A61020409
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tffrDhA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A61020409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEJal-00084o-5t
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 17:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEJOd-0007RZ-2b
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:05:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEJOb-0001v9-Lq
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:05:06 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46095)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEJOb-0001mA-DM
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:05:05 -0400
Received: by mail-oi1-x242.google.com with SMTP id x5so5639891oic.13
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 14:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aSojqioVRFKDbpv4f2MVXp5UIa+37kip+rbI87mQAz0=;
 b=tffrDhA9mTBv/u+h1H7qdj6/MFTLNie/tr4fH2XwVMS1+PLY5mnhRotrvtF8YinJRA
 GqVWHc3RjmEmsv5VPKpRSqPhlbQ3fvVNvBOi2kE6vwr+fuGyJCrCAVvjEcJSQcIURcBV
 vyOJJzwWXNu9dcNP4vaAqCgKt+p1yBcU2rmJ3fKkWfkXAry2IponbhTKSLA7YpOim2AM
 WtqohDWqAjv9lb10LvqIuRY2y/oTRgL/3fbqlzj0x0uyYqMC/ZkHjh2lVlQofJWtAS6k
 avyU/45NWAPA3NU8I3z3YUoNPkWrLuaFrwtzxNpWldrLpmYdd3k6lWzG2okyW+6ff3l7
 82MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aSojqioVRFKDbpv4f2MVXp5UIa+37kip+rbI87mQAz0=;
 b=nu+c2YV7hdJRq3GvMxq1I4aXXmh2uB9o3BdItrs9IT30X9xpxEaFsdtwZ8Y+awPNsR
 Ny9JQnYL7FC4wrPmj2PriUn57mQHtzoYYmQxGuHmih+frmp2/+YR4X/bF2EqR8YJcgCg
 kxKUdpDakTaENsybpm6l0O3Ghcnxmw6yrmHXs5pR0ckU1rqlddxpRWw4qzk+AgCH8G1G
 bO/YEwEcwrNVspHRuWWVHR4cl10fuZPUuOcDR0aTWv9Tp4pVOcJnsF4sh3quhmAb+5Sk
 4+DvnYAAY7dRgOdfspLwmFtB3oSY87HBKvd3LYjeP7yPJqAIIoi0eN9LZoi7bgrqYbHT
 RkuA==
X-Gm-Message-State: ANhLgQ2JxFX2C6GIqHCNmMP2s+eBzEBfApt8gz7fCfAYCiPf0/01V6SJ
 uxf+TbfmOtJ6cJ0Fk/VlRXTk5jaWB4+YdwoODGgp/Q==
X-Google-Smtp-Source: ADFU+vteUOHoFs4FB62KYlUQg9xQiYOiIDUQY1gAjGhPgjHDcl3Az1zt4lvhg4zonA4vdVfjQu7JbiyY3cKdTCWX+qM=
X-Received: by 2002:aca:5b07:: with SMTP id p7mr661643oib.146.1584479104341;
 Tue, 17 Mar 2020 14:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <1584458374-29068-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584458374-29068-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Mar 2020 21:04:53 +0000
Message-ID: <CAFEAcA_eRc7AbD0d2aT-zuHRjyHqRdwvAhZSqkRVMAPQXYvhdQ@mail.gmail.com>
Subject: Re: [PULL v3 00/62] Misc patches for soft freeze
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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

On Tue, 17 Mar 2020 at 15:30, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit a98135f727595382e200d04c2996e868b7925a01:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200316-pull-request' into staging (2020-03-16 14:55:59 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 32b9523ad5b44dea87792d5d8f71a87e8cc5803b:
>
>   hw/arm: Let devices own the MemoryRegion they create (2020-03-17 15:18:50 +0100)
>
> ----------------------------------------------------------------
> * Bugfixes all over the place
> * get/set_uint cleanups (Felipe)
> * Lock guard support (Stefan)
> * MemoryRegion ownership cleanup (Philippe)
> * AVX512 optimization for buffer_is_zero (Robert)
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM


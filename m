Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75326CA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 09:57:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FDCE222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 09:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fKUWO0Ed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FDCE222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLP0q-0005Xt-Eg
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 05:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iLOzt-0004zl-PN
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iLOzs-0000a5-D4
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:56:37 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:45964)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iLOzs-0000Zu-7Z
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:56:36 -0400
Received: by mail-oi1-x22b.google.com with SMTP id o205so4685460oib.12
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 02:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2paFg4WfWgTPk/MUgH/7PzGrdWXw7pPr96AoQIgxqv0=;
 b=fKUWO0Edpr+mPpoiPPc1Mnpv9ABxmbLen3yMRPAAA1FGn96GRktvzIwWHsgjrZqlqC
 dfO4Mv4Kt2GU+aLZWLDmxPG1jSWdIETOtFtfjKHo7bO09c6qVDunDPe6LCm3+c8Yl43D
 CETgI3Qf5R5mtlhQKyrGQAykLNO1y/ws3j5xVWdYrSDJue8XyN8il5qMPgn15spfQLHL
 GWWv1gHA+s72A5R5DPIiKoKoqC2Mm2cWFlb2nJQfnDYVjJFZROUCxlS/tpduQclNGlB7
 BKsFk3miH6NH/zOuQo/OS5hWz7Uqoyr2GINnWc/IC1GDWSpcD7F/S5p9lc+84mRq3u8b
 0KDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2paFg4WfWgTPk/MUgH/7PzGrdWXw7pPr96AoQIgxqv0=;
 b=kIs77EvvNeiqqHyVwdZIyoj2eM66KTsmAvuyNb1g25G3I23+7MQ/CwfmSx1tqM2mRd
 r2tVXas60q8kZMNaiFqdTpe+yMosqGqjM4ZWRSPak2gBhb4/xfJC+UZSp/OXeZpSpUc5
 JyakstUT9GalyOp8BNb6n+BlxLzTa8Nx0egi8olOwkdNy4qUpeoh502B9FEQ+Q7SeIGP
 8x3owXIycePCO/RiO0NTEvEXq42dzuIpjrFsy5w2Fnl75pq8cUY3NmAkQ4v1l35iSlhH
 4TbdNs4/dzRd6y9muLs0D/we800fCHtERqnOqmDcsI7kIWW5xqeC8KqIbljR3HaGzeeb
 YMlQ==
X-Gm-Message-State: APjAAAXUb3HnOX6UXV+vFH7hzfUXzvT00SXE2+HrpnuTtFrt065nNs2o
 4BSyo+B01rQ9ihlUVAC0M6voYc/WIoIIeFidpvPAxg==
X-Google-Smtp-Source: APXvYqw+qjWpGTYOzN6wI2m7Wm5xhFHKTcYNk2gKSEwVbAZV8T3AKGL2+hB2+tPOuHNquL+7MN5VNX1eN112rDQ/Ykw=
X-Received: by 2002:aca:2b08:: with SMTP id i8mr6891818oik.146.1571392595322; 
 Fri, 18 Oct 2019 02:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191015213745.22174-1-ehabkost@redhat.com>
In-Reply-To: <20191015213745.22174-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2019 10:56:23 +0100
Message-ID: <CAFEAcA_CQ52JOu64DkQMA2T_zC3RZxgovcunkgGCo6VnRhhJjw@mail.gmail.com>
Subject: Re: [PULL 00/18] x86 and machine queue, 2019-10-15
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22b
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

On Tue, 15 Oct 2019 at 22:37, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit 69b81893bc28feb678188fbcdce52eff1609bd=
ad:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
91015' into staging (2019-10-15 18:15:59 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to 69edb0f37a52053978de65a81241ef171a6f2396:
>
>   target/i386: Add Snowridge-v2 (no MPX) CPU model (2019-10-15 18:34:44 -=
0300)
>
> ----------------------------------------------------------------
> x86 and machine queue, 2019-10-15
>
> Features:
> * Snowridge-v2 (no MPX) CPU model (Xiaoyao Li)
>
> Bug fixes:
> * cpu-plug-test: fix device_add for pc/q35 machines (Igor Mammedov)
> * Fix legacy guest with xsave panic on older Linux kernel (Bingsong Si)
> * Omit all-zeroes entries from KVM CPUID table (Eduardo Habkost)
>
> Cleanups:
> * Convert reset handlers to DeviceReset (Philippe Mathieu-Daud=C3=A9)
> * MachineClass::auto_enable_numa field (Tao Xu)
> * target/i386/cpu.h cleanups (Tao Xu)
> * memory_device_get_free_addr() cleanups (Wei Yang)
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM


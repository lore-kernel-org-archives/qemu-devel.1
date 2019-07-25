Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDF9C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 16:15:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ADD322BED
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 16:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mUcHQBoP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ADD322BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqgP6-0006fn-Dw
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 12:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58750)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hqgOu-0006HM-4o
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:15:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hqgOt-0004gB-1t
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:15:28 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51835)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hqgOs-0004ft-Rw
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:15:27 -0400
Received: by mail-wm1-x341.google.com with SMTP id 207so45533880wma.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 09:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Av2iXGBeQGFngGjUlpVqKCUHSZsY2vid2iGjQEdgwlE=;
 b=mUcHQBoPVNXgmC82Cj2HJBwIl3dtHtQMSXaLz9o6OgxoyrgMw5JV+bja3tl+sAkgGa
 wKvDFbpZgwyotAzkTD2ZyaVF45ZWjCfXhJ/dBre74GaVecxs3kU04G6yCtUbc2JuXsfz
 aBuAYjcSHcTV8e6rka01S2ELZpccW4EDmJMpkCvtVWMHaWoSUKCxEPfzNxNXc9O9+KVq
 n9XiO008XcycoxmPhbycUnNnHoMZq5pQOWlKz00f7D0hVUeafadKsWod5RpN9VwmwFM5
 Wi3A/DAOhNdlr+ePuuoLgdGW6ftIrY5iMug4Ko2nfuQCrFGSk+5IVSMeE6s2iDZAnLX8
 yuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Av2iXGBeQGFngGjUlpVqKCUHSZsY2vid2iGjQEdgwlE=;
 b=B6Chx7Cqtry9r9plhGIKr4zTHrg/fnH3xXVtUfHqprxfSsCF8UczwNV3/0jzLU78tp
 pwmhd5SW7r2I3QYiOFmkrjrzLX3Ayxc6jPuqGfF701gYhdOJ2ShNGg2LLOH9FeO2E+dR
 i1icOQn2yYINea5+a1ZXZA4TNKB/qDJA3bvbnH3DEuQiEpJ2PMWvqJcgaNZZUwGnjE7N
 m4jkgW/72fae9Etr/QoXXN7ZYryTNuGfaM3PgwXLJi7eAs9Ti4apF8F8ixKQ7m6DdmLT
 jdc+d30UW6AXCKl1aqrTLN/2f7t0Yb2oVHV5uhFtt/CIBHFzLU80Zvr9yyIGulJK/5ZG
 bkZg==
X-Gm-Message-State: APjAAAWFwmXY6kexA1VTpZjHHpeWgDcPkxU71uuJHFTrK+2iQPaPSAl0
 dZlmLzZBYBuAq/BO1NRkc/sys7HTz98=
X-Google-Smtp-Source: APXvYqzf5eu9gEypNv6pQTa9cFDnB7CcQl6Y2J8k2v1eAvHkvIwXRtY6r/P8tEj4OIbOKF9b02YErg==
X-Received: by 2002:a1c:343:: with SMTP id 64mr77710168wmd.116.1564071325416; 
 Thu, 25 Jul 2019 09:15:25 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id 91sm102897365wrp.3.2019.07.25.09.15.24
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 09:15:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 33FFF1FF87;
 Thu, 25 Jul 2019 17:15:24 +0100 (BST)
References: <20190719210326.15466-1-richard.henderson@linaro.org>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190719210326.15466-1-richard.henderson@linaro.org>
Date: Thu, 25 Jul 2019 17:15:24 +0100
Message-ID: <87r26eytsz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH for-4.2 00/24] target/arm: Implement
 ARMv8.1-VHE
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> About half of this patch set is cleanup of the qemu tlb handling
> leading up to the actual implementation of VHE, and the biggest
> piece of that: The EL2&0 translation regime.
>
> Testing so far has been limited to booting a debian 9 system with
> a 4.9 kernel, and a fedora 30 system with a 5.1 kernel.  Both have
> KVM enabled, and both report enabling VHE is successful.

So you haven't booted a kernel via KVM inside the emulation yet? That
might explain why I was struggling to do so. For example single-stepping
through the guest kernel gets stuck. I suspect that means some state
machine doesn't quite work (or possibly that is an existing bug, I need
to check without VHE as well).

Anyway I've done my pass for now. I'll come back to the later patches
when more stuff is working.

>
>
> r~
>
>
> Richard Henderson (24):
>   cputlb: Add tlb_set_asid_for_mmuidx
>   cputlb: Add tlb_flush_asid_by_mmuidx and friends
>   target/arm: Install ASIDs for long-form from EL1
>   target/arm: Install ASIDs for short-form from EL1
>   target/arm: Install ASIDs for EL2
>   target/arm: Define isar_feature_aa64_vh
>   target/arm: Enable HCR_E2H for VHE
>   target/arm: Add CONTEXTIDR_EL2
>   target/arm: Add TTBR1_EL2
>   target/arm: Update CNTVCT_EL0 for VHE
>   target/arm: Add the hypervisor virtual counter
>   target/arm: Add VHE system register redirection and aliasing
>   target/arm: Split out vae1_tlbmask, vmalle1_tlbmask
>   target/arm: Simplify tlb_force_broadcast alternatives
>   target/arm: Reorganize ARMMMUIdx
>   target/arm: Add regime_has_2_ranges
>   target/arm: Update arm_mmu_idx for VHE
>   target/arm: Update arm_sctlr for VHE
>   target/arm: Install asids for E2&0 translation regime
>   target/arm: Flush tlbs for E2&0 translation regime
>   target/arm: Update arm_phys_excp_target_el for TGE
>   target/arm: Update regime_is_user for EL2&0
>   target/arm: Update {fp,sve}_exception_el for VHE
>   target/arm: Enable ARMv8.1-VHE in -cpu max
>
>  include/exec/cpu-all.h     |  11 +
>  include/exec/cpu-defs.h    |   2 +
>  include/exec/exec-all.h    |  35 ++
>  include/qom/cpu.h          |   1 +
>  target/arm/cpu-qom.h       |   1 +
>  target/arm/cpu.h           | 259 +++++-----
>  target/arm/internals.h     |  62 ++-
>  target/arm/translate.h     |   2 +-
>  accel/tcg/cputlb.c         |  77 +++
>  target/arm/arch_dump.c     |   2 +-
>  target/arm/cpu.c           |   2 +
>  target/arm/cpu64.c         |   1 +
>  target/arm/debug_helper.c  |  50 +-
>  target/arm/helper-a64.c    |   2 +-
>  target/arm/helper.c        | 985 ++++++++++++++++++++++++++-----------
>  target/arm/m_helper.c      |   6 +-
>  target/arm/pauth_helper.c  |   9 +-
>  target/arm/translate-a64.c |  14 +-
>  target/arm/translate.c     |  17 +-
>  19 files changed, 1058 insertions(+), 480 deletions(-)


--
Alex Benn=C3=A9e


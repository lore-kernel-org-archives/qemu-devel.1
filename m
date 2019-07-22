Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA04C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 09:38:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AA8820693
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 09:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gv17KIVq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA8820693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpUlf-0006Ya-A3
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 05:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46082)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hpUlV-0006AH-TD
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:37:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hpUlU-0002pV-QE
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:37:53 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51335)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hpUlU-0002o4-Hc
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:37:52 -0400
Received: by mail-wm1-x341.google.com with SMTP id 207so34444692wma.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 02:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=8O7SM2Lqdqi6MBheYq2a+PRzweupAXsn8BueWxr52uQ=;
 b=Gv17KIVqqDe7KpsYTjCxkA7GykB7Uqp/uEq+1Fh+e7/rrej1wALU+TjY/94XOZgZ/x
 3Bo7gI3FWNoO0Or2X1lxUc6AaTZpvvz1kvmxd5gkugThuEZNzBAk+CZ0C3hh13Uo1ilP
 BJ1HryhZ8ScvfaD0a1eB1C4ldhaZh5aD4OYn5Kr7exxzo59Fpizw4hlvlfJNd331PpOX
 mGz98BNMKA2aFUg+XoYBHNQ5BH0vaA5EK9yx4b2pJWOXQMvHS6wb9CCZySmQycLbKqbX
 E7BPkqOSlzGfORQrtzXOmFYqKlmEUWkb1qjg5UZ6dv84VyJIbuOU9BqbFS0UzcS6WvNz
 BdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=8O7SM2Lqdqi6MBheYq2a+PRzweupAXsn8BueWxr52uQ=;
 b=fSQ1xNRgAipaLWlNsLpTGcXdfxRqtQk1lUlNxBJJ0eBiff4oilZWV9ReS+AmlUAraE
 ZUqwrPO5F50wgZJSEnvZSc4xtfhW3RWbiWLNWp8SI/knzUU4pCEO15/SwIjMFzRoFQl1
 vvvUQtUZCbwzUsjHKA9Z0YEc5R3WlaL9WjLxwsDcvVuy1eec/XZCrQTJdrMbg4PgpWcD
 uZrr8fny2nvzUS2WE1O+H+IQb4PpaAmGg/n1qXEYaLXbRnerco1eWLGXXlVYiwGsnoF5
 GpmR4SfF8GAxMRApJo/fPMaWlEF4y+WQsX+PjFfGBLL0tqaIs84E7u6jTB1m6iw3xbGe
 4p1g==
X-Gm-Message-State: APjAAAXxRwwyIF8Vo0aJTV8m2b4ggfLU2xJtZ9wixEBqeAZ8YxPCC0lC
 PsI4E0QynewbVNevJ5MNBrdTkA==
X-Google-Smtp-Source: APXvYqyAfnByr714G3kTEiqrafyrs9jeZl7BTXJOzlp2uI9VkCV69bnOrpS3VV2/ESNkl9RpgqJZyQ==
X-Received: by 2002:a05:600c:2182:: with SMTP id
 e2mr19514224wme.104.1563788269405; 
 Mon, 22 Jul 2019 02:37:49 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id g10sm28665983wrw.60.2019.07.22.02.37.48
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 22 Jul 2019 02:37:48 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5A22A1FF87;
 Mon, 22 Jul 2019 10:37:48 +0100 (BST)
References: <20190719210326.15466-1-richard.henderson@linaro.org>
 <87k1cajzix.fsf@linaro.org>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <87k1cajzix.fsf@linaro.org>
Date: Mon, 22 Jul 2019 10:37:48 +0100
Message-ID: <87pnm2v28j.fsf@linaro.org>
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


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Richard Henderson <richard.henderson@linaro.org> writes:
>
>> About half of this patch set is cleanup of the qemu tlb handling
>> leading up to the actual implementation of VHE, and the biggest
>> piece of that: The EL2&0 translation regime.
>>
>> Testing so far has been limited to booting a debian 9 system with
>> a 4.9 kernel, and a fedora 30 system with a 5.1 kernel.  Both have
>> KVM enabled, and both report enabling VHE is successful.
>
> check-tcg is throwing up errors for ARM:
>
> ERROR:/home/alex/lsrc/qemu.git/target/arm/helper.c:5353:define_arm_vh_e2h=
_redirects_aliases:assertion
> failed: (src_reg !=3D NULL)

I'm going to go out on a limb and say this is because the aliases
registers are SoftMMU only. Do we even want to handle any re-directs for
linux-user?

>
>>
>>
>> r~
>>
>>
>> Richard Henderson (24):
>>   cputlb: Add tlb_set_asid_for_mmuidx
>>   cputlb: Add tlb_flush_asid_by_mmuidx and friends
>>   target/arm: Install ASIDs for long-form from EL1
>>   target/arm: Install ASIDs for short-form from EL1
>>   target/arm: Install ASIDs for EL2
>>   target/arm: Define isar_feature_aa64_vh
>>   target/arm: Enable HCR_E2H for VHE
>>   target/arm: Add CONTEXTIDR_EL2
>>   target/arm: Add TTBR1_EL2
>>   target/arm: Update CNTVCT_EL0 for VHE
>>   target/arm: Add the hypervisor virtual counter
>>   target/arm: Add VHE system register redirection and aliasing
>>   target/arm: Split out vae1_tlbmask, vmalle1_tlbmask
>>   target/arm: Simplify tlb_force_broadcast alternatives
>>   target/arm: Reorganize ARMMMUIdx
>>   target/arm: Add regime_has_2_ranges
>>   target/arm: Update arm_mmu_idx for VHE
>>   target/arm: Update arm_sctlr for VHE
>>   target/arm: Install asids for E2&0 translation regime
>>   target/arm: Flush tlbs for E2&0 translation regime
>>   target/arm: Update arm_phys_excp_target_el for TGE
>>   target/arm: Update regime_is_user for EL2&0
>>   target/arm: Update {fp,sve}_exception_el for VHE
>>   target/arm: Enable ARMv8.1-VHE in -cpu max
>>
>>  include/exec/cpu-all.h     |  11 +
>>  include/exec/cpu-defs.h    |   2 +
>>  include/exec/exec-all.h    |  35 ++
>>  include/qom/cpu.h          |   1 +
>>  target/arm/cpu-qom.h       |   1 +
>>  target/arm/cpu.h           | 259 +++++-----
>>  target/arm/internals.h     |  62 ++-
>>  target/arm/translate.h     |   2 +-
>>  accel/tcg/cputlb.c         |  77 +++
>>  target/arm/arch_dump.c     |   2 +-
>>  target/arm/cpu.c           |   2 +
>>  target/arm/cpu64.c         |   1 +
>>  target/arm/debug_helper.c  |  50 +-
>>  target/arm/helper-a64.c    |   2 +-
>>  target/arm/helper.c        | 985 ++++++++++++++++++++++++++-----------
>>  target/arm/m_helper.c      |   6 +-
>>  target/arm/pauth_helper.c  |   9 +-
>>  target/arm/translate-a64.c |  14 +-
>>  target/arm/translate.c     |  17 +-
>>  19 files changed, 1058 insertions(+), 480 deletions(-)


--
Alex Benn=C3=A9e


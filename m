Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30357C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:48:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF8672080C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qds+jLgE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8672080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyd1W-0008Dz-5m
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:48:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0S-0006ZO-IY
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0R-00031M-Bl
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:20 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:38644)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iyd0R-0002zy-5c
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:19 -0500
Received: by mail-wr1-x42b.google.com with SMTP id y17so18548844wrh.5
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 06:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=A6H1Cid9tIpqetkNA2EdrEtEmm2BUaO6m8mFbgP3a28=;
 b=qds+jLgECSa6qGSC6uc42QPDjHv8H9WTJHDc9k8cLERkRJFz26PNYxyUoMoednqPyk
 nzLB0kds+GU0mklXzcchT9SAKlZhnFsXjm/no22Lyk6GU1USSR5rJOyjDUr9w2uFuO/+
 MPyBhwyftwijaDnQKVK454uwxd0oMJPbpUosU2kTDle0p80LeGbFqXXoqHh2tEV0nZgL
 rNWOPrmYamPqK0CsL1LkKQAnQ6cMG86cyCpnzYsqvf3JOY8YaXoToSUDnZ0aEXa+QOD9
 o7qjRu1V5zt15YG4dJ+qmX9igQUUbcpcycEESClmAagLOqoKBAAurDcjlU2HRWHxg4eG
 TcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=A6H1Cid9tIpqetkNA2EdrEtEmm2BUaO6m8mFbgP3a28=;
 b=Nzr3dtqqUfszmOafBwkNZ42H8pr/+zC6Wwi7zmNxxjApSYyG/gj3bXXVtta1bvuwyF
 uVdzixsNTpwTb5N6Wce7KMI4kagYx2nrckUWwDVvfVCsdfpD9kCZtS+NvaZgf8bBR8Gn
 3Ln9Nu4Rs1SB5ZXaQoWupuwSp6rdREjj0c0UguLI6pfeBKtNuiKw2zdVWhZyRiftl2Ez
 2oAlt36g1WWBlvAMLC4FMjmCJZOyZPIaweMySg80pytNPn+1kNt7WQaUTUiJ1h0p5Rbc
 S1iXYbUMzdXZKYb7u51cW84Mics3bfbEd4LmzSB2J0fYxCyJTwNJQlXbbXgrbaF2Hmc+
 XMIw==
X-Gm-Message-State: APjAAAVPEcU9uYmpWmzfkSgdkOeIxhxWAhfRsfx5qNhuswN3mE6zfNRN
 kNqdA6+UVoX5RAM1VabwWzlUfA7YrYWG4w==
X-Google-Smtp-Source: APXvYqzsrOkzimuDMzJ7+jYeK7OXusKqJyJv3RKl2D2fivlYydZoPARgMhwPe5G1EmMrJleF/PBPsw==
X-Received: by 2002:adf:ff8c:: with SMTP id j12mr15846163wrr.354.1580741237692; 
 Mon, 03 Feb 2020 06:47:17 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id h2sm26429739wrt.45.2020.02.03.06.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 06:47:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/20] target/arm: Implement PAN, ATS1E1, UAO
Date: Mon,  3 Feb 2020 14:46:56 +0000
Message-Id: <20200203144716.32204-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: <20200201192916.31796-1-richard.henderson@linaro.org>
("[v6] target/arm: Implement ARMv8.1-VHE")

Version 3 cleans up masking values that go into PSTATE/CPSR,
adding 6 new patches for that purpose.


r~


Richard Henderson (20):
  target/arm: Add arm_mmu_idx_is_stage1_of_2
  target/arm: Add mmu_idx for EL1 and EL2 w/ PAN enabled
  target/arm: Add isar_feature tests for PAN + ATS1E1
  target/arm: Move LOR regdefs to file scope
  target/arm: Split out aarch32_cpsr_valid_mask
  target/arm: Replace CPSR_ERET_MASK with aarch32_cpsr_valid_mask
  target/arm: Use aarch32_cpsr_valid_mask in helper_exception_return
  target/arm: Remove CPSR_RESERVED
  target/arm: Tidy msr_mask
  target/arm: Introduce aarch64_pstate_valid_mask
  target/arm: Update MSR access for PAN
  target/arm: Update arm_mmu_idx_el for PAN
  target/arm: Enforce PAN semantics in get_S1prot
  target/arm: Set PAN bit as required on exception entry
  target/arm: Implement ATS1E1 system registers
  target/arm: Enable ARMv8.2-ATS1E1 in -cpu max
  target/arm: Add ID_AA64MMFR2_EL1
  target/arm: Update MSR access to UAO
  target/arm: Implement UAO semantics
  target/arm: Enable ARMv8.2-UAO in -cpu max

 target/arm/cpu-param.h     |   2 +-
 target/arm/cpu.h           |  95 ++++++++---
 target/arm/internals.h     |  85 ++++++++++
 target/arm/cpu.c           |   4 +
 target/arm/cpu64.c         |   9 ++
 target/arm/helper-a64.c    |   6 +-
 target/arm/helper.c        | 314 ++++++++++++++++++++++++++++---------
 target/arm/kvm64.c         |   2 +
 target/arm/op_helper.c     |  14 +-
 target/arm/translate-a64.c |  31 ++++
 target/arm/translate.c     |  49 +++---
 11 files changed, 490 insertions(+), 121 deletions(-)

-- 
2.20.1



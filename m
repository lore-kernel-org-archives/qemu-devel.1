Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F303EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 23:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDA62206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 23:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OJ88pG5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA62206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgGoX-00062d-VM
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 19:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgGnn-0004gh-G6
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 19:58:39 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:40721)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgGnm-00023p-J1
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 19:58:39 -0400
Received: by mail-pf1-x430.google.com with SMTP id v2so293877pfv.7
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 16:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FWcOqPbqeVUo1WtSodqWPo+nF/7NR0Mnyr2fqsiIjc0=;
 b=OJ88pG5Ym+xtgoYbmSGqSXey9q9zwb/norDgICgDFbCI3Ynz8Kv77NF8KOTjrs7VCg
 ZrE6LvDQRLlqxy3yc9GUmias7W11F08udcXN1eEMgsm1jdNZmkOnKkoIZJIUJALOlwlZ
 TtZf+opDGpeqVHUBJ+Z0I+OJhsmIm6Vr33Ea457mBlLkFN3GmWqIGptwsvZ5dsmomDuT
 Ab5XIxLw+Ears9IaA7AS3OcrQj0ZKWXp4zD8jAxMfG/Ukx5uEMy3Z5SuGertTlfZV5QM
 FsUv5QXvc/7kFr/TZrOki70EgZUih0fDLZaY47dPSaRtqrr5xJYfOssHjzYrhHb/ydfB
 FF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FWcOqPbqeVUo1WtSodqWPo+nF/7NR0Mnyr2fqsiIjc0=;
 b=qE4akcXhsvqcGg0SGPgymf8+I954wTov0NpYpmkv+lZ6oRuF4ukQzZeXxyee2t43yk
 NklrAr57O+io65CoRb57TDOZtDTQ3q5EBt04p0G6N5DRi5nFVdj/PJUlmPmd0okT38/b
 ac0itQ1XB6LJflTB4nFQNNMstg1ycfyys8Y1dR3pmn1Md86dkWyOvcW505SxNMtCYiJ6
 Blblw89bxBE485KwBXaQHLSGwUp8yTQuoXS051u2DkC0HBCn+VQpV0PsVsnekIzaPvjk
 JRNClK455HHQou1NqvBdlB8Fhan7FtcFpWJ4pdww6WA3ZmHVaYAWkJThatkQg3ycfr2T
 AWuA==
X-Gm-Message-State: AOAM531UyEfEc7DrikraAlFWAgJYfKNBD0M3exvK+1DwLMuRcqW5A5kV
 YklvoeqvuMaCJrpBjMSUo64iibPYa+8=
X-Google-Smtp-Source: ABdhPJxxfXH51hzkoMU1vsjByb9cmaMv9sWCIwjJT408ubvvWSQYjwk6TDJUA0DU7Ng8U70W1SoPYQ==
X-Received: by 2002:a17:90a:a897:: with SMTP id
 h23mr1985282pjq.90.1591142316362; 
 Tue, 02 Jun 2020 16:58:36 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id k101sm182201pjb.26.2020.06.02.16.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 16:58:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/8] decodetree: Add non-overlapping groups
Date: Tue,  2 Jun 2020 16:58:26 -0700
Message-Id: <20200602235834.470345-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a feature that Peter requested for completing the
neon decodetree conversion.

Changes for v2:
  - Rebase on master, which includes some generic python cleanups.
  - Indentation error message restored.
  - 4 new testcases

r~


Richard Henderson (8):
  decodetree: Tidy error_with_file
  decodetree: Rename MultiPattern to IncMultiPattern
  decodetree: Split out MultiPattern from IncMultiPattern
  decodetree: Allow group covering the entire insn space
  decodetree: Move semantic propagation into classes
  decodetree: Implement non-overlapping groups
  tests/decode: Test non-overlapping groups
  target/arm: Use a non-overlapping group for misc control

 target/arm/t32.decode                        |   4 +-
 tests/decode/err_pattern_group_nest1.decode  |  11 +-
 tests/decode/err_pattern_group_nest2.decode  |   6 +
 tests/decode/err_pattern_group_nest3.decode  |  14 +
 tests/decode/succ_pattern_group_nest2.decode |  13 +
 tests/decode/succ_pattern_group_nest3.decode |  11 +
 scripts/decodetree.py                        | 515 +++++++++++--------
 7 files changed, 349 insertions(+), 225 deletions(-)
 create mode 100644 tests/decode/err_pattern_group_nest2.decode
 create mode 100644 tests/decode/err_pattern_group_nest3.decode
 create mode 100644 tests/decode/succ_pattern_group_nest2.decode
 create mode 100644 tests/decode/succ_pattern_group_nest3.decode

-- 
2.25.1



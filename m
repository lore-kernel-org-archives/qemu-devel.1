Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC6EC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 23:03:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D2F206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 23:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JOB+HAtx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D2F206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHxVW-0002GL-8k
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 19:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHxUH-0000sx-67
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 19:02:17 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:40801)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHxUF-0006Zk-1Q
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 19:02:16 -0400
Received: by mail-pf1-x42f.google.com with SMTP id x123so788069pfc.7
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 16:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=b044IQlDRKwrZCBpWAifgPS5Su17ECHz8Bxv35VbyP0=;
 b=JOB+HAtx48jE2uZkhJcrkytG8xZJFmSs2jeoo5BRWTrqQLpgbzfasFFroqOY6dqR5N
 f2kvvB8FFACtvZE+wUYWnmZWC1HvjjrV+cq4GYIlGhHECt+yQdjdCARtb0e28AgmLyBi
 GjXMEnfXU96oc7t/TEjgoMve6M0jORLASaCLCdYM8JLsReaP2MQOJ9e4qdLZXFRiXFwg
 Vy1niVhnpqbYweFvfPIPYSQ26gdFyq0sJJhwmcG1Rsau0Vr/yW2zS4uczWubckrsqZYX
 w92w4xNUyX3vlhCWN3nmraSvvGvtlRHuM/SIBVQW+L3M6xDKQRhcTgPPXPF2ZtSulQXs
 hXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=b044IQlDRKwrZCBpWAifgPS5Su17ECHz8Bxv35VbyP0=;
 b=nR5Ga7ok1QGI872bowFX858L3jaP4tZT9kxT+vIhWklv8TbtzIHrXnEcb1ghrdddT3
 4TVrd8vEfvOThXT0Zv9nt7XN+1i6t9A3ts2pOcXc/fhMjrSHH7UO37nRWNwE7s1P0+wG
 oZ4wtzLLghaAMuzhmi8S3iTAzmjYmA66eWR5wg6UtX/legfVo974jAm9Vrbikx0ArWxL
 QkLXh3WsUgIYV2f/QQekg8Y2gZhLDg8h/X5rPWY8PX7kKIit27jydvi+RrzyeIM/qQQN
 pB6YbEk0CkL+jVdehn7W0WFX25Oc7syIzYhkSY7nGIApM5dOhMRji1h0nAYNcurcUn2W
 nvlg==
X-Gm-Message-State: AOAM531UNhFZsyQvMSSjV80Aa+T2fc0WR4plK4hvHO1vjXWauG8jpfKK
 iOqZb5N1snpRTXXSvM5xefWu6xzyX4C2CQ==
X-Google-Smtp-Source: ABdhPJyntEmKE4ihJ8n0hDtb7LwnpZ1ZTa9CFbxbszsNx26yi0uu/uo0AELHmTmascmH2wXdEG/10A==
X-Received: by 2002:a63:a4d:: with SMTP id z13mr5964085pgk.247.1600124533028; 
 Mon, 14 Sep 2020 16:02:13 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id l23sm9106076pgt.16.2020.09.14.16.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 16:02:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/10] capstone + disassembler patches
Date: Mon, 14 Sep 2020 16:02:00 -0700
Message-Id: <20200914230210.2185860-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
Cc: luoyonggang@gmail.com, alex.bennee@linaro.org, thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The primary change here is the update for capstone to meson.
This bypasses capstone's build system entirely.  There's more
commentary on that subject with the first patch.

Plus a collection of other fixes and cleanups in the area.

Changes for v2:
  * Several configury changes in patch 1, along the lines
    of that suggested by Paolo, but not exactly the same.
  * Drop sparc capstone enablement (I suddenly have a memory
    of doing the same thing last year).


r~


Richard Henderson (10):
  capstone: Convert Makefile bits to meson bits
  capstone: Update to upstream "next" branch
  disas: Move host asm annotations to tb_gen_code
  disas: Clean up CPUDebug initialization
  disas: Use qemu/bswap.h for bfd endian loads
  disas: Cleanup plugin_disas
  disas: Configure capstone for aarch64 host without libvixl
  disas: Split out capstone code to disas/capstone.c
  disas: Enable capstone disassembly for s390x
  disas/capstone: Add skipdata hook for s390x

 configure                 |  61 +---
 Makefile                  |  16 -
 include/disas/dis-asm.h   | 102 +++---
 include/disas/disas.h     |   2 +-
 include/exec/log.h        |   4 +-
 accel/tcg/translate-all.c |  24 +-
 disas.c                   | 703 +++++++++-----------------------------
 disas/capstone.c          | 326 ++++++++++++++++++
 target/s390x/cpu.c        |   4 +
 tcg/tcg.c                 |   4 +-
 capstone                  |   2 +-
 disas/meson.build         |   1 +
 meson.build               | 122 ++++++-
 meson_options.txt         |   4 +
 14 files changed, 676 insertions(+), 699 deletions(-)
 create mode 100644 disas/capstone.c

-- 
2.25.1



Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0F8C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:52:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C4E620719
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rvJdB1ga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4E620719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOOIE-0005nL-Bo
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 12:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOOHN-00050a-Bv
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 12:51:33 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:35350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOOHL-0006gL-6b
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 12:51:32 -0400
Received: by mail-ot1-x329.google.com with SMTP id s66so1994629otb.2
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 09:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CW3Ey0onlm4Xk08z20t/ERBGpBvjfhyUYyDRz6RrzbU=;
 b=rvJdB1ga95MDxFE6SoAudgkrEL3Uqccgpu1YQFFgAwEL49Sd3WZnO2hcV+hzXFjLEi
 9F5qyN5mgyQG63fGT2IWW2IJ4eLrj59CYtKN9z5xWb4LRDu5CNFKIncSjKmX4HQibwO+
 xxTdRagD06kox2WB5hzXp1VBF3/OCNssudJKU5kHosdEJavUAy7YbcxERJM21EJHlvVe
 Fuit00LyhUZgBTEUn57npH727nPJeNaGS0qkM6AoRYFg7pHTUQ9vbu69kg6HunJZ6cSx
 E0mvo/XN23p90JOMwEY23ihAvDBRCeeyr72lbIWLMK8oDb15gf9CaEzoFPYTmsN6Ua5V
 PNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CW3Ey0onlm4Xk08z20t/ERBGpBvjfhyUYyDRz6RrzbU=;
 b=NXQHzf7ibXx4P48xiwMbGLEmxJ3OPjxRrdAe0t5GQ8bKs+y8Ma74TRwZUQxpf5e5jz
 RiY5fpQi/V3Q8lT/9ivGu2KPCd0m8rWU9pQOF3kAQFH9z0ym+4n5B8kBvgE8bCA0b9O6
 CPmXnWBZULQ+zyugh4L2LCH2D50LKWPX4LFWMqvkuGK/u/nZK5ddq54b8LgKZnH300qa
 czzNJCBMKJs3FWoLYCceVy+8a4aMJLIPGeEe4VdkDNY1y54o0zyQUxfEzhZC4TTnjGy5
 q5sLftAmk8RXZ7/ipN5uDdRu3HvyLg82yvBVwc0erBzMpsxjssklNmtNFf1H1/MihGHN
 gMBw==
X-Gm-Message-State: AOAM530upRGqgA9L2ymB8cx1cJzRC4S/hWFbRJOq+9qHlQerpB6hQ/xJ
 rADw/uS2JTpQOIDLaN+roQC9TjEMzxs5qhI5
X-Google-Smtp-Source: ABdhPJxKaLfLaO7iqFfu8NVKNxcnVcjSoeo5Zs3D+/4bDy9Pq5dGwlf3D1lOjgTCbHcVv/yWiEPajA==
X-Received: by 2002:a05:6830:1d8a:: with SMTP id
 y10mr2444755oti.92.1601657489457; 
 Fri, 02 Oct 2020 09:51:29 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id 189sm367235oid.40.2020.10.02.09.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 09:51:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/11] capstone + disassembler patch queue
Date: Fri,  2 Oct 2020 11:51:26 -0500
Message-Id: <20201002165127.130369-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Version 2 retains a dummy capstone/all makefile target, to avoid
the build failure that Peter saw.


r~


The following changes since commit dd8c1e808f1ca311e1f50bff218c3ee3198b1f02:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20201002' into staging (2020-10-02 14:29:49 +0100)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-cap-20201002

for you to fetch changes up to 94816249a1e14f90f56a2f6e1d566e959e9bc26d:

  disas/capstone: Add skipdata hook for s390x (2020-10-02 11:05:07 -0500)

----------------------------------------------------------------
Update capstone submodule from v3.0.5 to v5 ("next").
Convert submodule build to meson.
Enable capstone disassembly for s390x.
Code cleanups in disas.c

----------------------------------------------------------------
Richard Henderson (11):
      capstone: Convert Makefile bits to meson bits
      capstone: Update to upstream "next" branch
      capstone: Require version 4.0 from a system library
      disas: Move host asm annotations to tb_gen_code
      disas: Clean up CPUDebug initialization
      disas: Use qemu/bswap.h for bfd endian loads
      disas: Cleanup plugin_disas
      disas: Configure capstone for aarch64 host without libvixl
      disas: Split out capstone code to disas/capstone.c
      disas: Enable capstone disassembly for s390x
      disas/capstone: Add skipdata hook for s390x

 configure                 |  68 +----
 Makefile                  |  18 +-
 meson.build               | 124 +++++++-
 include/disas/dis-asm.h   | 104 +++----
 include/disas/disas.h     |   2 +-
 include/exec/log.h        |   4 +-
 accel/tcg/translate-all.c |  24 +-
 disas.c                   | 707 +++++++++++-----------------------------------
 disas/capstone.c          | 326 +++++++++++++++++++++
 target/s390x/cpu.c        |   4 +
 tcg/tcg.c                 |   4 +-
 capstone                  |   2 +-
 disas/meson.build         |   1 +
 meson_options.txt         |   4 +
 14 files changed, 687 insertions(+), 705 deletions(-)
 create mode 100644 disas/capstone.c


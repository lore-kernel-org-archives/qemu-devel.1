Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD42C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:02:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 755042068D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vzO6GEI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755042068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgAJU-00076d-L8
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 13:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgAIW-0005UV-Ej
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:01:56 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f]:52145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgAIV-0007PH-3l
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:01:55 -0400
Received: by mail-pj1-x102f.google.com with SMTP id ga6so1662454pjb.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 10:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WpNPk30dfswCguztPvFh7hXMYXYUVfLJv8E5N/TiKnY=;
 b=vzO6GEI1SiEOgSeTHwv5hp/d8/MDyJitHadcZ4yHKCOCgjNF3cnJCc/SlkKCxoazhB
 wnIn7wMjfNpD4/+Bkw1ITzd2/oJ5miVxmW40BGT71dqPZJGpS5hkujo0As0gz+71ukDP
 kFHQm/wDXkKSeB/Al8VQDuHRrABNqhCz+NeyxClq8zi/mGQCAb4JhwvN++iQcrQ+/iCW
 23gtIwm33sUzq07kmBVB16tccPVQvM2SGi1Riv+QwkONTvw7Eyyyqw4lbZd5NvSqPA27
 TkzUgJzE5Pl3+0OXmIpulgwBciQ0FwjqLGOICaHhi5EMPz3TPQ3fVcnhC0uDVcruSh4v
 uCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WpNPk30dfswCguztPvFh7hXMYXYUVfLJv8E5N/TiKnY=;
 b=BaM+yG06Ro3G2gGv3Qa+RczfgW7shB9U91RGmtnevE6H1cEfE/v7QPfdvhPUfkzYew
 yxAom+oo0iaXI3V/M1UQ4MrxPZQnksRdIrr0xIUKOhbDP9VKq4dK81crBE2YUuWaLevd
 x8jD/F1HxMs75BXbUjmKbMWSHqsbJwq/ys525VGciXTpXeXOAQyZ9V7sPG/0u2TjmuoM
 dUxrrRMIpnS7uQfxGj3+CqdV6fsjDbE7eeEOhaWIJtJQ9Y/cb+CFf8pRoMH6YrX41Y7q
 E+NK5zN/UI905InyagCGgOKaA+p5b/IhKbPFYED+gV9H59K0VDhQfzLdRt9kJMEKaFnT
 L8kw==
X-Gm-Message-State: AOAM533HR7Rjy+MFSD7nAMTWrcww5i5VmLX8bymZtE3ndgpYKLWN30a1
 p2FdcKUnISVjfRO9a6KD3sm93EfzFqI=
X-Google-Smtp-Source: ABdhPJyqC90wKxZSlFykZQnhvSX7EWp+MxxiUXIY+f9dg1r0LnO9pSDSt/W8gOhaalKVzcH0IfENMg==
X-Received: by 2002:a17:90a:dd42:: with SMTP id u2mr122043pjv.65.1591117312805; 
 Tue, 02 Jun 2020 10:01:52 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h11sm2723630pjk.20.2020.06.02.10.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 10:01:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/12] tcg patch queue
Date: Tue,  2 Jun 2020 10:01:39 -0700
Message-Id: <20200602170151.321389-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


I have not been able to prod reviews of all of the rotate patches
in 4 weeks, but let's not let that block ARM work forever.


r~


The following changes since commit cccdd8c7971896c339d59c9c5d4647d4ffd9568a:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2020-06-02 10:25:55 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20200602

for you to fetch changes up to 71b04329c4f7d5824a289ca5225e1883a278cf3b:

  accel/tcg: Provide a NetBSD specific aarch64 cpu_signal_handler (2020-06-02 08:42:37 -0700)

----------------------------------------------------------------
Vector rotate support
Signal handling support for NetBSD arm/aarch64

----------------------------------------------------------------
Nick Hudson (2):
      accel/tcg: Adjust cpu_signal_handler for NetBSD/arm
      accel/tcg: Provide a NetBSD specific aarch64 cpu_signal_handler

Richard Henderson (10):
      tcg: Implement gvec support for rotate by immediate
      tcg: Implement gvec support for rotate by vector
      tcg: Remove expansion to shift by vector from do_shifts
      tcg: Implement gvec support for rotate by scalar
      tcg/i386: Implement INDEX_op_rotl{i,s,v}_vec
      tcg/aarch64: Implement INDEX_op_rotl{i,v}_vec
      tcg/ppc: Implement INDEX_op_rot[lr]v_vec
      target/ppc: Use tcg_gen_gvec_rotlv
      target/s390x: Use tcg_gen_gvec_rotl{i,s,v}
      tcg: Improve move ops in liveness_pass_2

 accel/tcg/tcg-runtime.h             |  15 +++
 include/tcg/tcg-op-gvec.h           |  12 ++
 include/tcg/tcg-op.h                |   5 +
 include/tcg/tcg-opc.h               |   4 +
 include/tcg/tcg.h                   |   3 +
 target/ppc/helper.h                 |   4 -
 target/s390x/helper.h               |   4 -
 tcg/aarch64/tcg-target.h            |   3 +
 tcg/aarch64/tcg-target.opc.h        |   1 +
 tcg/i386/tcg-target.h               |   3 +
 tcg/ppc/tcg-target.h                |   3 +
 tcg/ppc/tcg-target.opc.h            |   1 -
 accel/tcg/tcg-runtime-gvec.c        | 144 ++++++++++++++++++++++++
 accel/tcg/user-exec.c               |  43 +++++++-
 target/ppc/int_helper.c             |  17 ---
 target/ppc/translate/vmx-impl.inc.c |   8 +-
 target/s390x/translate_vx.inc.c     |  66 ++---------
 target/s390x/vec_int_helper.c       |  31 ------
 tcg/aarch64/tcg-target.inc.c        |  53 ++++++++-
 tcg/i386/tcg-target.inc.c           | 116 +++++++++++++++++---
 tcg/ppc/tcg-target.inc.c            |  23 +++-
 tcg/tcg-op-gvec.c                   | 212 ++++++++++++++++++++++++++++++++++++
 tcg/tcg-op-vec.c                    |  62 +++++++----
 tcg/tcg.c                           |  85 +++++++++++----
 target/s390x/insn-data.def          |   4 +-
 tcg/README                          |   7 +-
 26 files changed, 736 insertions(+), 193 deletions(-)


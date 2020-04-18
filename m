Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05333C38A29
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 15:05:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1AF22076A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 15:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CzrYleUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1AF22076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPp2F-0008UL-W8
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 11:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jPp0z-00074U-JD
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 11:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jPp0y-0002pF-CN
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 11:04:17 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035]:55224)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jPp0y-0002gs-1G
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 11:04:16 -0400
Received: by mail-pj1-x1035.google.com with SMTP id np9so2461377pjb.4
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2020 08:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zj7Xe5KhedYOrM0HTZGZ2+VwIj4DK41u2B9s2w/DIDY=;
 b=CzrYleUz0ht/FAZttPYk/caViD+pEDtyOC+4+aYWjCYoVxlutTALccu+24zyukbw/T
 oWHT6MRq2pjjKnwF2F0prVcd3/fafQGwPI20VmLCypVhUwGSPYwnXDIOWqMX3EayBezJ
 9YZvELpH1rj+u7sQmHf0zLKR2pK7BpOSxX/M3KVDv2duXTyVh9ydmDZeCP2Ka0nqYfzE
 1NY0ZHzz3k6AeqnfsQpR5r37Tkj2ZPqGp6PC7ulx+lkaVnd1yzpDL5Bhg5I+F6hAk8lF
 ghohNx8Wbvr9M7EBauo2dcYHj2sQJJ44M22T7/8tL3yAWq66Q55vooXneq6CtbXoozJn
 2YUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zj7Xe5KhedYOrM0HTZGZ2+VwIj4DK41u2B9s2w/DIDY=;
 b=rHfrwR7/Apd5rD7351QU5cPGwiJYxBI1ykVuxNh/aMCjQsmGhpjLswPrQDOntLl6je
 3XjEbJgv/X8/K4dtuCemHvl5hW3H2qk6qw8CLpUeh4fjXzs3PzqHkd+lZpJPyX8arXi0
 yC4mq32i4WmgQROY6LJExZiesITcw+3a1KZFDza131VRsJQZrwKmCrsvU/ariqQjwpP7
 iqKsdeA/d0uSCUH5AGlPV2aFVNzbIjhyQNU4XQNTi7taiutgiQu8MjYCFl38bU0j40lC
 SubxbDBq5aLjtC4qsugWKbNdRigqAIRcSQybmO0HlrVeuZ/8LMyvzeX5KrkeEpiQitdB
 r/WQ==
X-Gm-Message-State: AGi0PuYytPVXdGtu3GgMVpOkaScXrdzx6mwnQEHrqs+WmVMjKK8DowgZ
 f8Kmjx9fDN3VEE+yxI7dp+R7Tcrk3RY=
X-Google-Smtp-Source: APiQypJPNggQ54sXkpIUxJXYYS6LfWNDLAgQ/BubLkZ1H576Xvz6J3Qb/2XmIYykVPrSJvpNQqG/mw==
X-Received: by 2002:a17:90a:77cb:: with SMTP id
 e11mr11217062pjs.0.1587222254153; 
 Sat, 18 Apr 2020 08:04:14 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id t103sm8668601pjb.46.2020.04.18.08.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2020 08:04:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/7] tcg: Clean up tcg_gen_gvec_dupi interface
Date: Sat, 18 Apr 2020 08:04:04 -0700
Message-Id: <20200418150411.1831-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1035
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
Cc: peter.maydell@linaro.org, david@redhat.com, zhiwei_liu@c-sky.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace 4 separate routines with a single routine taking a vece
parameter.  This avoids several targets needing to create this
interface internally.

I noticed this in particular reviewing the riscv code; I'm not
sure why it took three targets to notice.  ;-)


r~


Richard Henderson (7):
  tcg: Add tcg_gen_gvec_dup_imm
  target/s390x: Use tcg_gen_gvec_dup_imm
  target/ppc: Use tcg_gen_gvec_dup_imm
  target/arm: Use tcg_gen_gvec_dup_imm
  tcg: Use tcg_gen_gvec_dup_imm in logical simplifications
  tcg: Remove tcg_gen_gvec_dup{8,16,32,64}i
  tcg: Add tcg_gen_gvec_dup_tl

 include/tcg/tcg-op-gvec.h           | 11 +++++---
 target/arm/translate-a64.c          | 10 +++----
 target/arm/translate-sve.c          | 12 ++++-----
 target/arm/translate.c              |  9 ++++---
 target/ppc/translate/vmx-impl.inc.c | 32 ++++++++++++----------
 target/ppc/translate/vsx-impl.inc.c |  2 +-
 target/s390x/translate_vx.inc.c     | 41 ++++++-----------------------
 tcg/tcg-op-gvec.c                   | 35 +++++-------------------
 8 files changed, 57 insertions(+), 95 deletions(-)

-- 
2.20.1



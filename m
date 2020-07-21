Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2DAC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A970206E3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GXw2ZRF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A970206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxrbv-0003so-Tj
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 08:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1jxra6-0001yf-2t
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:41:14 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031]:54114)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1jxra4-0004vh-1m
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:41:13 -0400
Received: by mail-pj1-x1031.google.com with SMTP id a9so1519422pjd.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 05:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OEVnCZhkWrQj+RRpuKVqY29A7QsD2Bci3YBFcgJ2+JI=;
 b=GXw2ZRF8PUQZ3ySczILQ9GifcbneUCW62LCyCZmx98TNN+VzJhBVJDFNQkDlJv+LJH
 sRK0CiCOZWP12zypNge4sX7+fQw+wq2YkzU59DQBNg3UlBzI+AqAMPoc1vkxERnXAH36
 0SZBG1OEhp9cWnYLgeCVEaj9/xfMVW7Re8japbmm7NU87nGdT9EED590VQA+EDf/w/b5
 0znSL/Wf8yla8iWfqzvAl8VNtMPI4Lh996wNuW1oJly4SAxADCbm+bIQEfa3UROVMcDH
 wUVMSN9FwZMaFCPLNbBS3O3H3NUJjShL2tJfCWUoPHvKYQoqPHJrdCs0ui3CYQ+fyb5E
 LfzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OEVnCZhkWrQj+RRpuKVqY29A7QsD2Bci3YBFcgJ2+JI=;
 b=NHUry54oKHUyOQ+K8Ua/n8pnePJe3/Pt9JI08zjDRX0GSYU8Ojo7d94q6xdxIwrAws
 uWSUjO0hAWN1MxsBHP22rgUYcz4is2XtIsyDkgf5dqP0R7plWGSSzYOQ7GuHPglOFRMy
 S5W3eapdLd/Tqq35Aix1bZE+Ysx3Qu3eFihzxOLGShIKLpb2EfUU2PbEfHobmWxNjKq1
 DA71bL2UUh9D9JB9B5LZbt5Y/CWdvH9NSWSSTy1DXcD7TK1g1VWTNJ3c63BIZjzaY/cX
 +xA2mN7tnQ9Ex3tE3tjgTb5m2NqdqmnpCP5Jth4sdkkfqyRFl3K/XitOGgF2Xh8Yp/WT
 2KwA==
X-Gm-Message-State: AOAM532Q2r6WRlGwayO1+6n/n5sIlMs1jrayQhnjrRleqFSDsvUd4NFE
 AhAb5JsI4WYnrv4JzvcQ2inWBA==
X-Google-Smtp-Source: ABdhPJy93bn39WhyMsgK4b+WiCLpmn63PvJeggfFhbqfMyQWflDJUKtM/7VabufybRDajHPXr8QD1g==
X-Received: by 2002:a17:90a:304d:: with SMTP id
 q13mr4555794pjl.73.1595335270206; 
 Tue, 21 Jul 2020 05:41:10 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id y20sm19819991pfo.170.2020.07.21.05.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 05:41:09 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 0/3] Fix some PMP implementation
Date: Tue, 21 Jul 2020 20:40:49 +0800
Message-Id: <cover.1595335112.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=zong.li@sifive.com; helo=mail-pj1-x1031.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Zong Li <zong.li@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch set contains the fixes for wrong index of pmpcfg CSR on rv64,
and the pmp range in CSR function table. After 3rd version of this patch
series, we also fix the PMP wrong checking problem.

Changed in v3:
 - Refine the implementation. Suggested by Bin Meng.
 - Add fix for PMP wrong checking

Changed in v2:
 - Move out the shifting operation from loop. Suggested by Bin Meng.

Zong Li (3):
  target/riscv: Fix the range of pmpcfg of CSR funcion table
  target/riscv/pmp.c: Fix the index offset on RV64
  target/riscv: Fix the translation of physical address

 target/riscv/cpu_helper.c | 3 ++-
 target/riscv/csr.c        | 2 +-
 target/riscv/pmp.c        | 8 ++++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.27.0



Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86285C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 15:05:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F52320674
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 15:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PMWOhQF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F52320674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzLjR-0004Hp-HW
	for qemu-devel@archiver.kernel.org; Sat, 25 Jul 2020 11:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1jzLi5-0002ez-Eh
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 11:03:37 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43894)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1jzLi3-00086B-Ka
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 11:03:37 -0400
Received: by mail-pg1-x542.google.com with SMTP id w2so6974265pgg.10
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2020 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HaSMpiNAE5XGFluxVENpTh1dzhrXk37EmhnlnzeEltM=;
 b=PMWOhQF+8VXZuvp+Yg95EkKAtodgXc5fCgJ2VecMzep+mT76n0iyQLlSqVwCtKMjZb
 wCUXiqVn8NSOBuOEJePmvbqG1I/lrgVAv/MyDLqDGH7yKR28/pCz/J/ZZVx67g9Tutv0
 RQHRpFapOsg8yEEpDJr20nLq7hPYbGrgkbbXmfcUEzBOrj05SloFh/e4aNTTb2KXSnYW
 /QbVl2mNRFODbfSFBlT/HLTsj3MWtP0+BzwDs/L9bdujFeeF7eU+yxWYwalhsFN0zMJO
 fBI/soN1VKjvvXjZFkaorGKISMejubo0AlciRZJbjQTPDw6BnFp+fAOcrxuBR2lM/0l9
 v5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HaSMpiNAE5XGFluxVENpTh1dzhrXk37EmhnlnzeEltM=;
 b=NP7W1vzRgIxr9tw0MQZGa3DZ8IX0M6Ycl1TY0uyAp419SnH82LVfnro8R0CkZ9kfzD
 Un1kpQgTL7pK75mZzVFrz/ZBZjh87YK69ZxGZgWSH948eMKhnpRQS0Tbl1aZy4hVtja2
 HQ6Eol+l2I+TsxghAPn2OvoQUoOUXiUypbauFMBZWnCFw43BylrMtl2YtgrsHT6VZp0J
 opPazRrDdLKK5X6onKPRzUdH6WKSMt+nVgGOgMqkzi1G6QXuvTNoNjvj/PRK7H8996ca
 hwvrXXP8SeKcXhDTIPv/+x9CgxxD5xmOh3/i45TXCjuXM6LI7MIHAvcGGB5tK1LpJu93
 DExg==
X-Gm-Message-State: AOAM533W4kDvmmQq8gUEPoudp0iUslncd8DYiiBxjkKij9ijJFe2F7ht
 g81AwolMSVWgRuBZwMvgj+maVg==
X-Google-Smtp-Source: ABdhPJxjJY7UVDpZ54xjReV6d6fHhTI3iYfdzY48yX+gAQrx7Z5OCHRlg6id4nfTZjtAeJkC4GdpBw==
X-Received: by 2002:a62:7653:: with SMTP id r80mr13367336pfc.236.1595689413689; 
 Sat, 25 Jul 2020 08:03:33 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id g22sm9059783pgb.82.2020.07.25.08.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2020 08:03:33 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v5 0/4] Fix some PMP implementations
Date: Sat, 25 Jul 2020 23:03:23 +0800
Message-Id: <cover.1595689201.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=zong.li@sifive.com; helo=mail-pg1-x542.google.com
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
series, we also fix the PMP issues such as wrong physical address
translation and ignoring PMP checking.

Changed in v5:
 - Pick the suggestion which was lost in last version.

Changed in v4:
 - Refine the implementation. Suggested by Bin Meng.
 - Add fix for PMP checking was ignored.

Changed in v3:
 - Refine the implementation. Suggested by Bin Meng.
 - Add fix for wrong pphysical address translation.

Changed in v2:
 - Move out the shifting operation from loop. Suggested by Bin Meng.

Zong Li (4):
  target/riscv: Fix the range of pmpcfg of CSR funcion table
  target/riscv/pmp.c: Fix the index offset on RV64
  target/riscv: Fix the translation of physical address
  target/riscv: Change the TLB page size depends on PMP entries.

 target/riscv/cpu_helper.c | 13 ++++++--
 target/riscv/csr.c        |  2 +-
 target/riscv/pmp.c        | 63 ++++++++++++++++++++++++++++++++++++++-
 target/riscv/pmp.h        |  2 ++
 4 files changed, 75 insertions(+), 5 deletions(-)

-- 
2.27.0



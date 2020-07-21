Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B63C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 06:04:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 258282080D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 06:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AqWM1L4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258282080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxlO6-0002I3-Co
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 02:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1jxlNI-00014U-AH
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 02:03:36 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:35351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1jxlNG-00006m-Q9
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 02:03:36 -0400
Received: by mail-pl1-x635.google.com with SMTP id x9so9795004plr.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 23:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1oJgumxJW9euJulVVhe0hfyyrmYeeSc/dhTCZ82IU9A=;
 b=AqWM1L4nVH4ahXFgl5rqP++GCiVASnr43qBgUdBAF8jWfwznwiOtRkt51fiEklU5uU
 jxC3TzwwC/a0qiTpmmaRSE6PDot35ggObusxHgCytctBod7ByQpSsJcCsnU4AaVQ4vAy
 OV1Z58TWoHH9DAtoQQPGuyB2+jCozXSgiPLDsKjixQtUBF3dcRX3tarQeLsy07mhT63B
 vD+r2elRWmMUjPcPdU2ddpVy8aAaKdjUC03c82pN0p1m3sP5osW7ztf0ZMTDaMc0TbFr
 Gu6iICCmyZfjSd1dk6+DFjdHtiMbvN4VytyaM3kpBg4xg0PfMPuyUWY/sCKrPKyJABAl
 njEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1oJgumxJW9euJulVVhe0hfyyrmYeeSc/dhTCZ82IU9A=;
 b=U7+cQ1plEWOxvxviXhlgPSOb2EVkYo4PXxWT4wbyEvJPeBxSb+qRKl0r30TE3AKwMU
 YEC9eS4e+Sc2WmJdr/ScNcvaB9FsLUzDzapQ0el6FzSqBG71MRbUuJhOaQf80Vz3x5qU
 URsvjcwZ0zN65QIz6VFfejVNGtZjc/zMWrC0IawEedTrPw6f1CG1FRnfp6ENbes1um3m
 bmRcpiI6yTzDarOf1h/c2QnnWCc/BEphmCrQE4SlZ04znxuy6q0cWjci2K3nCg7kUpdx
 uZZvt6aoSff7xSqm24GqDDW6ZVwRORgjLJ3nXP24snPKKkHW5l10gA3lTXLPuJkhrAVx
 KMIQ==
X-Gm-Message-State: AOAM533+Oq7F0xXBpANX2bLwrvkA4QhtDgwNU9Xkl1lXaHU3LjvJw9Hg
 C8hWNgySjlFbtYY3LYt3a6H75g==
X-Google-Smtp-Source: ABdhPJwnH1xjPj+9AQqwKCenuOQaJTbBeBJibl+HGMx6MPVi2qPUAfFOGxLdsPx4EH9pBxOg7HfP3w==
X-Received: by 2002:a17:902:be06:: with SMTP id
 r6mr19621523pls.143.1595311413216; 
 Mon, 20 Jul 2020 23:03:33 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id 66sm19724068pfa.92.2020.07.20.23.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 23:03:32 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] Fix some PMP implementation
Date: Tue, 21 Jul 2020 14:03:26 +0800
Message-Id: <cover.1595311277.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=zong.li@sifive.com; helo=mail-pl1-x635.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
and the pmp range in CSR function table.

Changed in v2:
 - Move out the shifting operation from loop. Suggested by Bin Meng.

Zong Li (2):
  target/riscv: Fix the range of pmpcfg of CSR funcion table
  target/riscv/pmp.c: Fix the index offset on RV64

 target/riscv/csr.c |  2 +-
 target/riscv/pmp.c | 19 ++++++++++++++++---
 2 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.27.0



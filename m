Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A75C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 01:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D5AB20758
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 01:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="renAPW6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5AB20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE0Al-0003aq-DP
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 21:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kE09w-0002Nu-5t; Thu, 03 Sep 2020 21:04:56 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:39237)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kE09u-0002jn-DC; Thu, 03 Sep 2020 21:04:55 -0400
Received: by mail-il1-x141.google.com with SMTP id e14so4948469ile.6;
 Thu, 03 Sep 2020 18:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DGpSewNxFZYA8FO6P3QT0TN71KdkYBZxzeY/8dXns7s=;
 b=renAPW6DVhcfx3O7M+OC+gUy44XpwcpK83oC8MkjQRoGg3WXT2MnYSjJ59kRPN7DPn
 brryHp5gjVgwGHO+pfO5eBTFNVDnuXTECDoEcyTrP7zDnRe6BGRkVYPUwFetExYHOKTd
 mLbtEB927pUhAeLgN8s2naa1+lxoLis2wQxghuferf9rrn2riXwkzMwyu3VBBIUTDAsS
 tPEbGGRIyAwMakg5jfTERxUm/dfuJnbz/jxgwrxb3g54Su3SDzf99nR4fI2gvOxAuKVY
 LzQyL03lYPTyi7LMZDmmqDw2xG94z7zrXxjfKNzeSJNAaEs90+nrVrB2hSXrWD2pMmJs
 RhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DGpSewNxFZYA8FO6P3QT0TN71KdkYBZxzeY/8dXns7s=;
 b=JQCZTSSQnsNrHdIiEZ3wtDfRR0BDe01h29b0ev4N5ragCHQ1dj35Qkkd7Xb+kVYi3b
 /tn8872/FxOatn68LsUT/cVL6s4r0o7vOYDap4Yxw/6DmVuxIt/ejzFQU4WZ9/ukTO7v
 i+JCc7vweatXI1AZ++6ZEqYNyh4m3DKL5uzwiT7mnuBjcIr+YnWYQCrW/S8RYCrNVDWF
 JrSqjr28y0CI28tWpuCf6byVHvFJqz+tllcvYNsHTyHvhDZ8D1TnyZC1frjIg1FMSpCk
 E5XqlHquAVm7w4+BPgtbw8mzsfezRCGNoE5PBMd54YrScaQeVrnHQqXQJpfQnR6dEhe+
 42lw==
X-Gm-Message-State: AOAM531R5pXkKq3VFL4IGkaFF1rkgIpVtkHt6YYRMyGDkj5WnbPB0rBL
 thNgQoVytiXZNVuZ/QRCAHh9G6B5GKs=
X-Google-Smtp-Source: ABdhPJxVPUg90GqXJKPCrtZAUTqVJqdRfbo4rFKHOXtYNi7GawA+4wopWkyP7a30Q+GCr7HBTyXLhQ==
X-Received: by 2002:a92:bad9:: with SMTP id t86mr5488385ill.308.1599181492728; 
 Thu, 03 Sep 2020 18:04:52 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca])
 by smtp.gmail.com with ESMTPSA id o18sm205907ilj.77.2020.09.03.18.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 18:04:52 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/3] pseries NUMA distance rework
Date: Thu,  3 Sep 2020 22:04:36 -0300
Message-Id: <20200904010439.581957-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=danielhb413@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Another spin for this rework of the existing NUMA support
for pSeries, prior to incoming changes in how we calculate
NUMA distance in the pseries machine. Changes here were
made based on David Gibson's review of v3.

This patches were rebased using David's ppc-for-5.2 tree.

changes from v3:
- patches 1 to 4 in v3 got pushed to ppc-for-5.2
- patch 1 (former 5):
    * moved spapr_register_hypercall() to spapr_numa.c, turning
h_home_node_associativity back to static
- patch 2 (former 6):
    * using memcpy as suggested in the review of patch 2 of v3
- patch 3 (former 7):
    * fixed typo, variable size
    * using G_STATIC_ASSERT() instead of g_assert()

v3 link: 
https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg01726.html


Daniel Henrique Barboza (3):
  spapr: move h_home_node_associativity to spapr_numa.c
  spapr_numa: create a vcpu associativity helper
  spapr_numa: use spapr_numa_get_vcpu_assoc() in home_node hcall

 hw/ppc/spapr_hcall.c | 40 -------------------
 hw/ppc/spapr_numa.c  | 92 +++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 82 insertions(+), 50 deletions(-)

-- 
2.26.2



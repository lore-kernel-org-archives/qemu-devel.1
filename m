Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9F0C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 17:31:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0FD72168B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 17:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrOG9s99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0FD72168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQDHI-0007qV-Mq
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 13:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kQDFO-0005wK-Ld; Wed, 07 Oct 2020 13:29:02 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:43200)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kQDFM-00006w-RK; Wed, 07 Oct 2020 13:29:02 -0400
Received: by mail-qk1-x744.google.com with SMTP id c2so3718096qkf.10;
 Wed, 07 Oct 2020 10:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dbk8D7k2SWsKtEykTFWEVgY+s+9kXbJHDz8Exp2s3BA=;
 b=mrOG9s99+1GIbWioGmhuCbSkKB2umUF56la4l2kAa2yE5+pRUrOJxifk7C5+1LOY4b
 3zJ2rn++qGgR6CHd1lxzZD5x+76bsElFcoBmTrElmdasfenoEycrGwv5N5KflUp7rGSw
 9gdwwFgv+6bJnGw+Lr9Xiqz2fdqMEPbXPt3+alR0rKoUmRaktQBsDxPNhYc/v0OCF03K
 b+e2awf2l2pzOyzD+krJlkEm5rd0+IRdD8ILw9hm0ydooKzwnhzBeMX2rwHlwTJLQaxa
 hP35sXohCSEFvm5Qk12QXXOsEEztwGNYotArip2X8QVgPo+T6oAS+JDKg0m8JGFXJM9X
 FPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dbk8D7k2SWsKtEykTFWEVgY+s+9kXbJHDz8Exp2s3BA=;
 b=TFzg0p3wv9ByZ5LfSf3WKQbtEe/u5aLMV5KKP+V59RX+fclxRV7JpfYp3r5tIRlxzs
 EUnxPg9Jc5wzdZvPvCJWu7VbBiLEhtdTk0VXmZn3xQKkyb28IBPvPZFG26BFz0ikoaO7
 52NM4DPHDghL6w9wu3i2MS6AF8YI6qzcXnCobr35w1D0/8TGwKnSPcwz8XJvQHLBqEAV
 vDaiztoaFw+MIF5hNAUud0SNbpBx3NzC/92/reIe0uVmPm4VHW2O1dw7h/AIaBNOVu/h
 MBEHG6cg1G4wFE7UlYRf4EqxxDZD2Sb6RNOdfoRWZBmLyEqLCBd/qT8WMBhFckZ3oBI/
 oDSw==
X-Gm-Message-State: AOAM5337sALygJ7D9l8N+h9S6c+Kemw4zkqsrluQAoHndim2t8e5ikaZ
 MbLAYtGJs5AHCNc5rXy6773eDpmCIU7M3Q==
X-Google-Smtp-Source: ABdhPJwDXH4mntZ07jKPkT67bV1LOz4OaFZDkwAUq+JYj4sYmIFAPI72bZTV/UEAC5C8AFn2ONo7/w==
X-Received: by 2002:a37:5042:: with SMTP id e63mr3897302qkb.453.1602091737486; 
 Wed, 07 Oct 2020 10:28:57 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:5a9b:54fc:df2a:8a5e:989b])
 by smtp.gmail.com with ESMTPSA id e39sm2080117qtk.32.2020.10.07.10.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 10:28:57 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/5] pseries NUMA distance calculation
Date: Wed,  7 Oct 2020 14:28:44 -0300
Message-Id: <20201007172849.302240-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::744;
 envelope-from=danielhb413@gmail.com; helo=mail-qk1-x744.google.com
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

This forth version is based on review comments and suggestion
from David in v3.

changes from v3:
- patch 4:
    * copied the explanation in spapr_numa_define_associativity_domains()
      to the commit message
    * return numa_level directly instead of calculating a temp
      value in spapr_numa_get_numa_level()
    * we're now setting assoc_src in all n_levels above it in 
      spapr_numa_define_associativity_domains()
- patch 5:
    * changed the documentation as suggested by David

v3 link: https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg10443.html

Daniel Henrique Barboza (5):
  spapr: add spapr_machine_using_legacy_numa() helper
  spapr_numa: forbid asymmetrical NUMA setups
  spapr_numa: change reference-points and maxdomain settings
  spapr_numa: consider user input when defining associativity
  specs/ppc-spapr-numa: update with new NUMA support

 capstone                      |   2 +-
 docs/specs/ppc-spapr-numa.rst | 235 ++++++++++++++++++++++++++++++++--
 hw/ppc/spapr.c                |  12 ++
 hw/ppc/spapr_numa.c           | 185 ++++++++++++++++++++++++--
 include/hw/ppc/spapr.h        |   2 +
 5 files changed, 419 insertions(+), 17 deletions(-)

-- 
2.26.2



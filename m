Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C859C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:53:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB33A2220C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRW4WWfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB33A2220C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLXJJ-0003ZH-0F
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLXGq-0001lg-1V; Thu, 24 Sep 2020 15:51:12 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833]:45690)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLXGo-00018H-9M; Thu, 24 Sep 2020 15:51:11 -0400
Received: by mail-qt1-x833.google.com with SMTP id z2so66675qtv.12;
 Thu, 24 Sep 2020 12:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7+pqakZ7m+4cihXKZ/mQE9/NSLZwL3jMxsyguq9Qt0Q=;
 b=MRW4WWfvBMM1+HQLbmlRB9nsMi037GWGn51TAMZe96I7yX1gk14uCEew9UOcL6OHvm
 jXDxZfmqa6PW2tW5I1opyA19TbPlNTvO7GjDbRfesZHDkD9pjAUS3AIni7amMltFgnf0
 7OGn/7GQmMMQn4wwUZkdjGwzWTyb3YIOSNGEhrPkAqXaJe0qlyc04pJc8GX2TR3+SkBe
 UDPYu2XDv2xplf9K6lPAb7+FTdpAO1KqHZYPZmHVNGIorxFcjHMdD1DMRoUzS5VSQMG5
 4zLvmGnLP8zdzYaAI7Fy10+/xYntdt45BHbM16gsgG+GJ7uvx8PWFl9BzREHLjwgLo2n
 20OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7+pqakZ7m+4cihXKZ/mQE9/NSLZwL3jMxsyguq9Qt0Q=;
 b=DON/sk7fWJlQdJFzdACiTDYTtGoIdb3+T1/KvqAeCgYG/AVxpMQhESGB06F/BqJp3f
 UkxiQljCG+cFtYxa9IYDbskwrFuHIcajvf6/pwzeDrsCW0NqMKSHsS4Fi5v2yQ1Wrs3C
 c6dC3kst5rQJp2oyYsBjncIdU6PPosUB1oS7f2w1O6/FVkTXpD5Xrrkw2AzU1w4r/+A5
 ZCut2aT1DgYN8gr72w4AFl1Urw5L6xKzDVDtL3H9XnarX25ZPGB0DPgUi4HU2wu8feZj
 QiCwYWNaP4nsirGqEgep24dBMjMfV5N0U9JkLSMO/HwZnPa7oMp3h5rDgH6q9/NRMTDZ
 YvAQ==
X-Gm-Message-State: AOAM53278CkUKu15QxsUKn8IrwueY6TBQYuVzIsML8HDUUG4JVSBdeni
 YjSR1If1u2SBLtKnClyX7HfKSXFQOJ6z4Q==
X-Google-Smtp-Source: ABdhPJzDisFSABJkMTtSAeT+LT8KYcrdHZ+zzXD6KZGtG9h1XvmPB1dd6boFlfbvs+YCBGfx2R4lfQ==
X-Received: by 2002:ac8:2383:: with SMTP id q3mr861551qtq.230.1600977067814;
 Thu, 24 Sep 2020 12:51:07 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:c625:6c0e:4720:8228:5f68])
 by smtp.gmail.com with ESMTPSA id f3sm381613qtg.71.2020.09.24.12.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 12:51:06 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/6] pseries NUMA distance calculation
Date: Thu, 24 Sep 2020 16:50:52 -0300
Message-Id: <20200924195058.362984-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=danielhb413@gmail.com; helo=mail-qt1-x833.google.com
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
 groug@kaod.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This second version contains fixes based on the v1 review made
by Greg.

changes from v1:
- patch 1:
    * added Greg's R-b
- patch 2:
    * fixed 'order' typo
    * changed exit(1) to exit(EXIT_FAILURE)
    * added Greg's R-b
- patch 3:
    * clarified in the function comment the rounding of distance
values 30, 60 and 120
    * fixed a bug where distances 30, 60 and 120 wasn't being
PAPRified (use <= instead of just <)
- patch 4:
    * made the changes multi-line and more explicit, allowing
to easily see the differences between current and legacy arrays
- patch 5:
    * turned spapr_numa_get_NUMA_level() to lowercase
    * added a switch clause for distance = 10
    * removed MachineState parameter of
spapr_numa_define_associativity_domains()
    * clarified the reason why the associativity domains need
to be initialized with 'node_id' in the comment
    * we're now handling distances > 120 appropriately (no
NUMA match case)


v1 link: https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg08549.html


Daniel Henrique Barboza (6):
  spapr: add spapr_machine_using_legacy_numa() helper
  spapr_numa: forbid asymmetrical NUMA setups
  spapr_numa: translate regular NUMA distance to PAPR distance
  spapr_numa: change reference-points and maxdomain settings
  spapr_numa: consider user input when defining associativity
  specs/ppc-spapr-numa: update with new NUMA support

 docs/specs/ppc-spapr-numa.rst | 213 +++++++++++++++++++++++++++++++++
 hw/ppc/spapr.c                |  12 ++
 hw/ppc/spapr_numa.c           | 217 ++++++++++++++++++++++++++++++++--
 include/hw/ppc/spapr.h        |   2 +
 4 files changed, 436 insertions(+), 8 deletions(-)

-- 
2.26.2



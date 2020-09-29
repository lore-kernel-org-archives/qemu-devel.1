Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D8AC4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:40:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10BB2207C4
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTscYf6R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10BB2207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNFs4-0000U1-Lw
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 09:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kNFq4-0007K1-6m; Tue, 29 Sep 2020 09:38:40 -0400
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41]:44430)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kNFq2-0001BF-D2; Tue, 29 Sep 2020 09:38:39 -0400
Received: by mail-qv1-xf41.google.com with SMTP id j10so2243434qvk.11;
 Tue, 29 Sep 2020 06:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TdnkdwzxMtew+RJa8Jwiq1Efmr0xgmPw29slARsqhZ0=;
 b=YTscYf6R981ij2BbXdLPzHJamOq6ZRhYjo9ET0S3ZqCncP3jsfGe+xCGEO9fCXN3JN
 G80eKJ0Le4AUcG6YixqXDXMQ6NuNXIUioAJUCjBuACYzK0P6nrfwoek90GWL2qCB2MvI
 dznP3+mn2ItBl578rTBvBqkPaxFMuhwEt4AvkAEUOu9KTMo+Uj7GkexjlBcYvZKxqGqz
 kJkGOn3Py7QkgXQw9sMT7utkkX2qIWd3bmIionZiVqk/GQORTRXkHYfhnTIpQmDzMAuL
 jyz9OQsbqftF+AW6DvOvrum3ElgNmGG8v1hbCPA0MlqwJZduLtjS9pgUNVUj4G1/oJBY
 t0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TdnkdwzxMtew+RJa8Jwiq1Efmr0xgmPw29slARsqhZ0=;
 b=B+hf6CXsu8A/QhUVugyqbvwW05eFHnCBCbSerNOXL2Fi4THLaBDIG4Dsao8sjqRTc3
 xDU+QdIMnaB5t4X+gYlrmi1hMQ7gxE9JNEIWej/8tj5hnETbt7BvGbmlASOmEdKfdmgS
 VfHBEAvhxke+WlZuSbJHQ70cpWjF7ryZCR4j20vvhmOdnX5MKPo/1WCEE4jTafht3v4y
 5tT4ThdPkYKtO/vtCOylKcSsNRhvsxAFgvFPLuhaphoabvR23cy36bslkaevS3Mu/9+z
 7c2kQANleElVin4Tme9qqfA7SNkfPlXugIeT5wXpJBBGnM9TVO/ljqc2R0Hw6/3627Fm
 P7fQ==
X-Gm-Message-State: AOAM530f6LRvXw6jVD0d0aRxhaZAWR9te9yKMTiwQCGoKZ1/Rx/Y1uNa
 KXsJqTVWyiYVm/XCleWhz980HTenub8=
X-Google-Smtp-Source: ABdhPJzxvMuxYTo3uCMnm+rwV2QdTPOQ3MntN+T7z08biHV/RmNQb08Pb+cmOe6NR0dDNvAfFygviA==
X-Received: by 2002:ad4:5745:: with SMTP id q5mr4574342qvx.29.1601386715471;
 Tue, 29 Sep 2020 06:38:35 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:c625:6c0e:4720:8228:5f68])
 by smtp.gmail.com with ESMTPSA id j88sm5239938qte.96.2020.09.29.06.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 06:38:26 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/5] pseries NUMA distance calculation
Date: Tue, 29 Sep 2020 10:38:12 -0300
Message-Id: <20200929133817.560278-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f41;
 envelope-from=danielhb413@gmail.com; helo=mail-qv1-xf41.google.com
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

This third version is based on review comments and suggestion
from David.

changes from v2:
- patch 3 from v2: removed
- patch 2:
    * added David's R-b
- patch 3 (former 4 in v2):
    * added Greg and David R-bs
    * added G_STATIC_ASSERT() before memcpy()
- patch 4 (former 5 in v2):
    * clarified what 'node 0' means in the commit msg
    * rewrote a bit to clarify what the logic does
    * the translation of user distance to PAPR distance logic,
      previously presented in the former patch 3 in v2, was folded
      into spapr_numa_get_numa_level()
    * removed needless 'if' when assigning associativities in
      spapr_numa_define_associativity_domains()
- patch 5 (former 6 in v2):
    * moved the section describing the current logic up
    * created a new 'legacy' section describing the pre-5.2
      behavior
    * added a 'known limitations' section documentating that
      we don't support asymmetrical topologies and we do a poor
      job approximating 'non-transitive' topologies

v2 link: https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg09073.html

Daniel Henrique Barboza (5):
  spapr: add spapr_machine_using_legacy_numa() helper
  spapr_numa: forbid asymmetrical NUMA setups
  spapr_numa: change reference-points and maxdomain settings
  spapr_numa: consider user input when defining associativity
  specs/ppc-spapr-numa: update with new NUMA support

 docs/specs/ppc-spapr-numa.rst | 206 +++++++++++++++++++++++++++++++++-
 hw/ppc/spapr.c                |  12 ++
 hw/ppc/spapr_numa.c           | 195 ++++++++++++++++++++++++++++++--
 include/hw/ppc/spapr.h        |   2 +
 4 files changed, 406 insertions(+), 9 deletions(-)

-- 
2.26.2



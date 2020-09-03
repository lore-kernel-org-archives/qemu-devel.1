Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2337C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:07:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6177B20709
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2jnMvRk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6177B20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDxOU-0007i7-Hm
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 18:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kDxNd-0006Cm-Jv; Thu, 03 Sep 2020 18:06:53 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:46836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kDxNa-0007R2-Tb; Thu, 03 Sep 2020 18:06:53 -0400
Received: by mail-qt1-x844.google.com with SMTP id b3so3153521qtg.13;
 Thu, 03 Sep 2020 15:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SH/+lsUfHkbeubblBCF1HRXJWZ8A1QCiq68GOEeco2w=;
 b=O2jnMvRkuKp3ki6EqQ3t7qBMktzHqHo8XRF+4caOxzkxbNFxr4Fu/Qomt8/ltJKOlj
 P8qXmAJN9FLa0f8wGn3jTuON/jMLxA2qFc3CRrTjNu03fzJRSdEyMzqBTKz6zFFk7ywk
 xBfs1jfKkptruUVI5Szhb5J/w3QQNpeXDX1CQXbWetLpKfFpbFqaE6d7HjDTIrhqwpkI
 TqZ4XRTljpUCIxVnRBSiAVd/vVDWiXcZSWMxowhqL3GrK5inIvZtqWn3m7/5QDt3uh2S
 b/Ctp6kEsMgatS0sm7I3w5q9V9Y4GhLBmo6+m/Ueu/Z+oAkc59Wfi3fJlNKeN2H6z5tn
 gEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SH/+lsUfHkbeubblBCF1HRXJWZ8A1QCiq68GOEeco2w=;
 b=pWU/XZrTLM10dgvdbhFt44QvjHVjI3CCsZUuXnLWPmPGkc/2mcKPkMUh86a+VQUd3Z
 42xbzfqh8yG5JgGtfdBPX8PNmSWvPBsNLUYQYbDUXmq6ACCjPDovCMULDMg85v6X1KhD
 fzP+JHdbQD5k5lsih2GnAFATn058+m0zxEp7ih0e7xPrBtmbcLiXBJSZDiREiNcqX4a5
 +BAxwxSlUmto2KABI6Y+7bHYTQIJxLG+lTvh02+Cjd2JHK+NngyMAoRkBuLogiXAU8j9
 sPCEcG6/KG59T1TC/hX/mW01KmRAcETYnXa0NK+05hULdwH9+7NKKCAVI5ujJM8PRZx1
 /ykg==
X-Gm-Message-State: AOAM533IN6+YZqOsMv96EmCZ4BuglZ+l9cfek+HMx4dUldngojKsranC
 1sOannNMpOyd0VOfu+W76UoD7lq0FE9PDw==
X-Google-Smtp-Source: ABdhPJzcRBH7BgpMs1W3ffZsIYGqAf4gcpWEmiMy+y18iDMISyAfgumc4Nj4h/zGSvdZlWgIAJDMPw==
X-Received: by 2002:ac8:5b47:: with SMTP id n7mr5796368qtw.7.1599170809231;
 Thu, 03 Sep 2020 15:06:49 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca])
 by smtp.gmail.com with ESMTPSA id j1sm1798757qtk.91.2020.09.03.15.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 15:06:48 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/7] pseries NUMA distance rework
Date: Thu,  3 Sep 2020 19:06:32 -0300
Message-Id: <20200903220639.563090-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::844;
 envelope-from=danielhb413@gmail.com; helo=mail-qt1-x844.google.com
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

This spin attempts to cover all suggestions and concerns pointed
out by David Gibson in the v2 review.

The patches were rebased with David's ppc-for-5.2 at 615ae3763144.
They can also be cloned from
https://github.com/danielhb/qemu/tree/spapr_numa_v3.

Changes from v2:
- patches 1 and 2 from v2 -> already pushed to ppc-for-5.2
- patch 1 (former 3):
    * numa_assoc_array moved to SpaprMachineState
- patch 3 (former 5):
    * use memcpy
    * fix index increment to use MAX_DISTANCE_REF_POINTS
- patch 4 (former 6):
    * revamped. NVLink2 associativity is now calculated in
spapr_numa_associativity_init(). GPU code will use the same
helper everyone but vcpus uses to write the associativity DT
- patch 5 - new
- patch 6 - new
- patch 7:
    * no more brazilian portuguese notes in the commit message
    * change the code to handle an arbitrary vcpu associativity
array, retrieved with a new helper added by patch 6.

v2 link: https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg00261.html


Daniel Henrique Barboza (7):
  spapr: introduce SpaprMachineState::numa_assoc_array
  spapr, spapr_numa: handle vcpu ibm,associativity
  spapr, spapr_numa: move lookup-arrays handling to spapr_numa.c
  spapr_numa: move NVLink2 associativity handling to spapr_numa.c
  spapr: move h_home_node_associativity to spapr_numa.c
  spapr_numa: create a vcpu associativity helper
  spapr_numa: use spapr_numa_get_vcpu_assoc() in home_node hcall

 hw/ppc/spapr.c                |  65 +++---------
 hw/ppc/spapr_hcall.c          |  37 +------
 hw/ppc/spapr_numa.c           | 184 ++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_nvdimm.c         |  19 ++--
 hw/ppc/spapr_pci.c            |   9 +-
 hw/ppc/spapr_pci_nvlink2.c    |  20 +---
 include/hw/ppc/spapr.h        |  12 +++
 include/hw/ppc/spapr_numa.h   |  19 ++++
 include/hw/ppc/spapr_nvdimm.h |   2 +-
 9 files changed, 242 insertions(+), 125 deletions(-)

-- 
2.26.2



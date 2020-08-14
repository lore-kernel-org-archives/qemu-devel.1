Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA50C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:14:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF52323B18
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceRIMlQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF52323B18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6yot-0007F6-6W
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 12:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k6yo0-0006Hq-2i; Sat, 15 Aug 2020 12:13:16 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:43961)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k6ynx-00030h-3k; Sat, 15 Aug 2020 12:13:15 -0400
Received: by mail-qk1-x741.google.com with SMTP id 2so11140281qkf.10;
 Sat, 15 Aug 2020 09:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=atGe6DlHJT+pdfYvlmCT/HD9BWTa38Z3HdzUdi09iTI=;
 b=ceRIMlQTv8qSyeoXUDRuwcc2iSOkBJuzzI1hQN9PNLzgpkGfzTT+fubsIslZKbQIJS
 i/agEeYxW3wR6RQAo0ZezJj2zyLoJ1myjLGKr/WzME3x8vb6PRp/5rT/W83aE6GDZcfk
 fJ9CearQXTzA6IpAXQDE3Dcems7zOUK4CcgMUr8berJhouCVNjN1INlm4CqhuqUV8lS7
 bIbUtdXNAim0ToBWnq9ZKEgRJEcR+EwOEJFe/753twRRymtSMFCFsxZwDbe0jnJFzMQy
 ucHQtWRmVuoaUBg0fF4QCMT+Joo4HYkOIG8awcWpBaTWlHhxpIfiCo1jgGJ1Y1vDYMaF
 NY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=atGe6DlHJT+pdfYvlmCT/HD9BWTa38Z3HdzUdi09iTI=;
 b=eBI2WP2N7UHbuHi6HIkEpHwSKU0fr4nH//SHD+YJIVlcpQJTTUCTMKmijvAuO1VXXJ
 3pfzWcScXQIgScqm3a2kD53PwvCnU0jsgtsn3/hUpMNfKTr0564fVwn0Rl1/cAmrecw3
 5gPOExPN7em06sigI7uZ3XdHy4yYNYQpetRVkb5vUKaehOLrYt6mCJzpyg0mGVuEDyBZ
 9pgZskMzqv9MoP0TTI6KpbFxgQ0d8k+UEq/vPTBpfSUUzgaA4SuLcBDYQW+3mRfolXCR
 qeH9UXvvxtR3RPXy+wZkZyxQVOQYji82s6lM1KAhaMXIVBFLd9aqmJWDl1WOhIxOvGYt
 EKsQ==
X-Gm-Message-State: AOAM530I3sEjWW+k9Yon2vA1URnv4O6LIncfROHeMnnVoZAZhrJ78fI8
 Id+6cLYBbaiDf58Zseg2ZGLHwoBIavRXwA==
X-Google-Smtp-Source: ABdhPJzpLc+koM9ricwfTE4i3VhbuTWCqplV+o+vx7ZxcO/ScdNPZ7FbD6hpvg5jn8XhNNpyukzb1A==
X-Received: by 2002:a05:620a:792:: with SMTP id
 18mr3636889qka.346.1597438477391; 
 Fri, 14 Aug 2020 13:54:37 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:303f:d1dc:35d8:e9f6:c8b])
 by smtp.gmail.com with ESMTPSA id p33sm12301018qtp.49.2020.08.14.13.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 13:54:36 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/10] pseries NUMA distance rework
Date: Fri, 14 Aug 2020 17:54:14 -0300
Message-Id: <20200814205424.543857-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::741;
 envelope-from=danielhb413@gmail.com; helo=mail-qk1-x741.google.com
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

This series implements a new approach to the NUMA code in
the spapr machine. We're now able to make an attempt to
try to take user input in consideration, instead of ignoring
any user input regarding NUMA distance.

This series was rebased upon David's ppc-for-5.2 tree. More
information about what are being done here can be found in
the specs/ppc-spapr-numa.rst file (only available in David's
branch ATM). This is also available in [1].

First patch is the patch from Cornelia that added the 5.2 machine
type. I included it here because I built upon it for compatibility
code.

Second patch adds a flag to hw/core/numa.c to forbid assymetrical
topologies for the spapr machine, since we do not support that.

All other patches are focused on cleanups/code juggling and
the actual implementation inside the ppc/spapr files.

With this patch, we're now able to at least attempt to honor
user input. Patch 10 has examples of how the code is working
and what is to expect and, most important, what to not
expect.

NOTE: for anyone willing to test this series, be warned that there
is a bug in the Linux kernel, causing any associativity information
for the node 0 to be discarded. A patch was sent in [2] to try to 
fix that.


[1] https://github.com/danielhb/qemu/tree/spapr_numa_v1
[2] https://lore.kernel.org/linuxppc-dev/20200814203413.542050-1-danielhb413@gmail.com/T/#m5c85daff828d8c8156781f9f957ad04903e93151

Cornelia Huck (1):
  hw: add compat machines for 5.2

Daniel Henrique Barboza (9):
  numa: introduce MachineClass::forbid_asymmetrical_numa
  spapr: robustify NVLink2 NUMA node logic
  spapr: add spapr_machine_using_legacy_numa() helper
  spapr: make ibm,max-associativity-domains scale with user input
  spapr: allow 4 NUMA levels in ibm,associativity-reference-points
  spapr: create helper to set ibm,associativity
  spapr: introduce SpaprMachineClass::numa_assoc_domains
  spapr: consider user input when defining spapr guest NUMA
  specs/ppc-spapr-numa: update with new NUMA support

 docs/specs/ppc-spapr-numa.rst | 213 ++++++++++++++++++++++++++++++
 hw/arm/virt.c                 |   9 +-
 hw/core/machine.c             |   3 +
 hw/core/numa.c                |   7 +
 hw/i386/pc.c                  |   3 +
 hw/i386/pc_piix.c             |  14 +-
 hw/i386/pc_q35.c              |  13 +-
 hw/ppc/spapr.c                | 239 +++++++++++++++++++++++++++++-----
 hw/ppc/spapr_hcall.c          |  13 +-
 hw/ppc/spapr_nvdimm.c         |  19 ++-
 hw/ppc/spapr_pci.c            |  42 +++++-
 hw/ppc/spapr_pci_nvlink2.c    |  10 +-
 hw/s390x/s390-virtio-ccw.c    |  14 +-
 include/hw/boards.h           |   4 +
 include/hw/i386/pc.h          |   3 +
 include/hw/pci-host/spapr.h   |   2 +
 include/hw/ppc/spapr.h        |  12 +-
 include/hw/ppc/spapr_nvdimm.h |   5 +-
 18 files changed, 568 insertions(+), 57 deletions(-)

-- 
2.26.2



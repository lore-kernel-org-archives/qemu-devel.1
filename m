Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D83AC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:01:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A004206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhvL7gt+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A004206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD5uw-00007X-3H
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 09:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kD5qP-0001EP-8V; Tue, 01 Sep 2020 08:57:01 -0400
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e]:43494)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kD5qK-0002lv-5p; Tue, 01 Sep 2020 08:57:00 -0400
Received: by mail-qv1-xf2e.google.com with SMTP id cr8so422301qvb.10;
 Tue, 01 Sep 2020 05:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DqcoixjKsi7uljImn8N4orIuR659II94z7wOXwtHnZo=;
 b=PhvL7gt+NOy2p9ILbJI6CKqzGbEIq+7SgPOlNlqJci68/W+Ki8h8htjEQ8b2oEshjF
 VT/yTFxQHexR2eu0zRQ/WCT38k41qQTl94i/QTA+8xpifOlvyDjLmze6gAuYP69csN/T
 QsFiXPnImkj7lJ8DH+Ut02IDbayTK/lxigGHwQQBRHMcttQimU5rb97WZ4UN8YLjTkpY
 N3yCLzLcL3Gt/K/yZWlQLrmPAuG4NajqlM8utT8HeJvlI3p7AmTH12WzozW+QoG06W5H
 7xqOpEkJcRLUF+E9cjSam+0XrObP/tkqPzFcQNQo+fBBOFrMdsBE7VHUqS51WdSdH3aL
 SuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DqcoixjKsi7uljImn8N4orIuR659II94z7wOXwtHnZo=;
 b=sLr5BNLkUka0MUaKxWENcFt6om8OlCVQSxWAouscYHPIkM37Od0X+IJkEI0YLeEQea
 oS8VVuDQABsYVuiuc34BT5FVFbW5rQamvYvajp8uujcgYQEjemvxj4m1mVyJYxTr91+O
 pZfIdsjY5YJgdXAlRVMWQtZIVXHtq6g4ZzqsnST/nYeQIodybwuiX7EWSvqY8tKs5DKH
 U4m+cRLj8MJDEOtJ3C7APLdcMzvrStvSenSwgofqj9cFyikcqvnelFz94jeeNyjo4HV1
 Ip2AtdfPH0eJUWW/5x/y8s2yRRqoZgLRR1rdoa55Ygc/g+YjAToTMzOB/1NLWTRvcZ3Z
 4lKQ==
X-Gm-Message-State: AOAM531321oLw5XgaL23L3dYXPcGWnH50ZVdkdZN01lM34Wbqks4Sxdv
 D5+Chzcv8zgla9iCXJw87lGQUQ3tBadn6w==
X-Google-Smtp-Source: ABdhPJy9kUUWsjW3SQ4YiajGH6jzCDAZkWdcpxo8F8Uh5QzlBEZEaq61er9ysGPkxQTxKBR/e2cPNg==
X-Received: by 2002:a0c:f5c5:: with SMTP id q5mr1833382qvm.29.1598965014201;
 Tue, 01 Sep 2020 05:56:54 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:6be:f6e3:c671:cefe:b943])
 by smtp.gmail.com with ESMTPSA id q7sm1430164qkf.35.2020.09.01.05.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 05:56:53 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/7] pseries NUMA distance rework
Date: Tue,  1 Sep 2020 09:56:38 -0300
Message-Id: <20200901125645.118026-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=danielhb413@gmail.com; helo=mail-qv1-xf2e.google.com
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

Following the reviews of the first version [1], specially this
reply from David [2], I decided to take a step back and refactor
all the code in hw/ppc/spapr* that operates with ibm,associativity,
ibm,associativity-reference-points and ibm,max-associativity-domains.

A new file named 'spapr_numa.c' was created to gather all the
associativity related code into helpers that write NUMA/associativity
related info to the FDT. These helpers are then used in other
spapr_* files. This allows us to change NUMA related code in a
single location, instead of searching every file to see where is
associativity being written and how, and all the soon to get
more complex logic can be contained in spapr_numa.c. I consider
the end result to be better than what I ended up doing in v1.

Unlike v1, there is no NUMA distance change being done in this series.
Later on, the hub of the new NUMA distance calculation will be
spapr_numa_associativity_init(), where we'll take into consideration
user input from numa_states, handle sizes to what the PAPR kernel
understands and establish assoaciativity domains between the NUMA nodes.


Changes from v1:
- all the patches that did guest visible changes were removed. They
will be re-submitted in a follow-up series after this one.
- patch 02 from v1 will be reworked and reposted in the follow-up
series as well.
- version 1 link:
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg03169.html



These patches were rebased using David's ppc-for-5.2 tree. Github
repo with the patches applied:

https://github.com/danielhb/qemu/tree/spapr_numa_v2


[1] https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg03169.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg04661.html
 
Daniel Henrique Barboza (7):
  ppc: introducing spapr_numa.c NUMA code helper
  ppc/spapr_nvdimm: turn spapr_dt_nvdimm() static
  spapr: introduce SpaprMachineClass::numa_assoc_array
  spapr, spapr_numa: handle vcpu ibm,associativity
  spapr, spapr_numa: move lookup-arrays handling to spapr_numa.c
  spapr_numa: move NVLink2 associativity handling to spapr_numa.c
  spapr_hcall: h_home_node_associativity now reads numa_assoc_array

 hw/ppc/meson.build            |   3 +-
 hw/ppc/spapr.c                |  91 +++---------------
 hw/ppc/spapr_hcall.c          |  16 +++-
 hw/ppc/spapr_numa.c           | 172 ++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_nvdimm.c         |  37 ++++----
 hw/ppc/spapr_pci.c            |   9 +-
 hw/ppc/spapr_pci_nvlink2.c    |  19 +---
 include/hw/ppc/spapr.h        |  13 ++-
 include/hw/ppc/spapr_numa.h   |  32 +++++++
 include/hw/ppc/spapr_nvdimm.h |   3 +-
 10 files changed, 268 insertions(+), 127 deletions(-)
 create mode 100644 hw/ppc/spapr_numa.c
 create mode 100644 include/hw/ppc/spapr_numa.h

-- 
2.26.2



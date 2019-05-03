Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D283C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 05:55:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AC382075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 05:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZFFQxoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC382075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34934 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMRAH-00062L-DD
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 01:55:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR8h-00053M-A1
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:53:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR8g-0002m3-Ag
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:53:43 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:35327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
	id 1hMR8g-0002kW-36; Fri, 03 May 2019 01:53:42 -0400
Received: by mail-pf1-x429.google.com with SMTP id t87so1769242pfa.2;
	Thu, 02 May 2019 22:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=9tG6G0UrvYwkKKFj/+oiEnA/rZn/Jzjyqo2RXEvZ8qs=;
	b=GZFFQxoq8U0+J5Qw3E0ikM2/bfVUKNb8IeWp26QGfjAVscgEhq3Z2zn3wdw07nPJvs
	p0rIIlWzSFlGGW0msmVrTa8O2RAXwKYxC3UZbtkrWyFyeSbyj4M9ecHPXPTzs6642BVQ
	y5PsBOmcwbn4yHTqLx3ItwvhV65ovYeBGRdNRN0q0CdIyd30x7ZqgVmo3yBhTLUxP5Cf
	pw6ClOYdLBQkWd7KBwTDsN3OniCG7gIU+G7cTtDBQsLvopK13jobhNWoo9shg6pdJa3Z
	CsbXtNIEzwm4XT5Zvw5ouiJkbPr7Xc9b3bQBNXZ/UE0GjFpKrubJgHIYx2t9WxWLkG1z
	ydiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=9tG6G0UrvYwkKKFj/+oiEnA/rZn/Jzjyqo2RXEvZ8qs=;
	b=l/kD4eFmt7W0NU5u34BTRYbZL2Gp7BYY0zMVIGb4rHTXQv+NTAlfbUZ0c0mWVsfv29
	rukbUQ0W+0YiG4hYUDf5PvIZrazhcvh7SN2llDpdpdRdUoLNXa6sytpPMr6WeOBA/IOK
	pt4X4hO6bsSHn1Syo38ue20+cJJylULpvJ+pDjH8vm3UNwiroSnkAKgyFjuCKLk8fZxE
	5znK12aPa+b6j3sqr0dCntfD+hwNmxYu02Qj8CbIr561ACwrCl1TLmsG/mEMbRQkczyg
	DXKN5AZXaYtqOSNzqw21jfkAkrDIH8tiGbrAPwQlKN2AQ8RS7P+pe8MkcSuVBxq7IyoV
	G7eg==
X-Gm-Message-State: APjAAAVCxHzg7mE8LXJ88OVomTZw4kPjchImFhhpvWOJKSAr8/bSERJ1
	JrHcWiwdJF0dvxtNK28l1v+Uzteb
X-Google-Smtp-Source: APXvYqyKP0R47K57GzytTp3fNEnio0/oPyL9CSqdu9MzUiNbz+Pg9/gbLQLtUIGIbFo1LEonE5TFnA==
X-Received: by 2002:a62:be17:: with SMTP id l23mr8229495pff.241.1556862817242; 
	Thu, 02 May 2019 22:53:37 -0700 (PDT)
Received: from localhost.ibm.com ([1.129.142.217])
	by smtp.gmail.com with ESMTPSA id
	h187sm1292983pfc.52.2019.05.02.22.53.33
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 22:53:36 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 15:53:03 +1000
Message-Id: <20190503055316.6441-1-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::429
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 00/13] target/ppc: Implement KVM
 support under TCG
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
	Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
	david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190503055303.fRx7FwrNo4XrbuB_2JnwKFv1LGpDO6_8KUErYcJzzfI@z>

This patch series adds the necessary parts so that a tcg guest is able to use
kvm facilities. That is a tcg guest can boot its own kvm guests.

The main requirements for this were a few registers and instructions as well as
some hcalls and the addition of partition scoped translation in the radix mmu
emulation.

This can be used to boot a kvm guest under a pseries tcg guest:
Use power9_v2.2 cpu and add -machine cap-nested-hv=on for the first guest.
Then inside that guest boot a kvm guest as normal.
This takes advantage of the new hcalls with qemu emulating them as a normal
hypervisor would on a real machine.

This can also be used to boot a kvm guest under a powernv tcg guest:
Use any power9 cpu type.
This takes advantage of the new hv register access added.
Note that for powernv there is no xive interrupt excalation for KVM which means
that while the guest will boot, it won't receive any interrupts.

Suraj Jitindar Singh (13):
  target/ppc: Implement the VTB for HV access
  target/ppc: Work [S]PURR implementation and add HV support
  target/ppc: Add SPR ASDR
  target/ppc: Add SPR TBU40
  target/ppc: Add privileged message send facilities
  target/ppc: Enforce that the root page directory size must be at least
    5
  target/ppc: Handle partition scoped radix tree translation
  target/ppc: Implement hcall H_SET_PARTITION_TABLE
  target/ppc: Implement hcall H_ENTER_NESTED
  target/ppc: Implement hcall H_TLB_INVALIDATE
  target/ppc: Implement hcall H_COPY_TOFROM_GUEST
  target/ppc: Introduce POWER9 DD2.2 cpu type
  target/ppc: Enable SPAPR_CAP_NESTED_KVM_HV under tcg

 hw/ppc/ppc.c                    |  46 ++++-
 hw/ppc/spapr_caps.c             |  22 ++-
 hw/ppc/spapr_cpu_core.c         |   1 +
 hw/ppc/spapr_hcall.c            | 409 +++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/ppc.h            |   4 +-
 include/hw/ppc/spapr.h          |   7 +-
 linux-user/ppc/cpu_loop.c       |   5 +
 target/ppc/cpu-models.c         |   2 +
 target/ppc/cpu-models.h         |   1 +
 target/ppc/cpu.h                |  70 +++++++
 target/ppc/excp_helper.c        |  79 +++++++-
 target/ppc/helper.h             |   9 +
 target/ppc/misc_helper.c        |  46 +++++
 target/ppc/mmu-radix64.c        | 412 ++++++++++++++++++++++++++++------------
 target/ppc/mmu-radix64.h        |   4 +
 target/ppc/timebase_helper.c    |  20 ++
 target/ppc/translate.c          |  28 +++
 target/ppc/translate_init.inc.c | 107 +++++++++--
 18 files changed, 1115 insertions(+), 157 deletions(-)

-- 
2.13.6



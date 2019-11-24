Return-Path: <SRS0=aI0a=ZQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F131C432C0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 20:10:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DFA2207DD
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 20:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="pJsMrrpL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DFA2207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYyCp-0003nr-8G
	for qemu-devel@archiver.kernel.org; Sun, 24 Nov 2019 15:10:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1iYy8S-0006rN-Qo
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 15:05:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1iYy8R-0007vA-Js
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 15:05:32 -0500
Received: from ma1-aaemail-dr-lapp02.apple.com ([17.171.2.68]:53908)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1iYy8R-0007ub-DW
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 15:05:31 -0500
Received: from pps.filterd (ma1-aaemail-dr-lapp02.apple.com [127.0.0.1])
 by ma1-aaemail-dr-lapp02.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 xAOK1tPT034870; Sun, 24 Nov 2019 12:05:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : from : to :
 cc : subject : date : message-id : mime-version :
 content-transfer-encoding; s=20180706;
 bh=ljDamCEmRjWQkRx2wqIl4YmBoiEnkcuHVFO04s1WcOc=;
 b=pJsMrrpLIXWBKCA9hbeL+8dDCndJPyuDffn1ntKWf93XJ0XYpmFQni4h8v3Y3V4i3FP0
 jDdH3sAM/qCJX59Vlza9WkK6LaTRyibU6AYuPJWMCsF8pAZETmSRnsp4QT8kYdyHBtyR
 HRY2UCPP5e68mWDz1QA4zf5ykDkfkdRKxgUHrrrci/qPSstStXvG0I6vMUHzfYnC/bS0
 r9RYDnddGbJjzYOVYAmT/HiGeSAkHniY4LBIAbSn9sBBUIj8s8jknpc5+mJ3gpSiBkU+
 gT7cBaNVJF3B29rmcozScnba34pWH9XrZ4dUp6bX8ibFkQyipAW34kalVGS3X7YHAsa5 Vw== 
Received: from mr2-mtap-s03.rno.apple.com (mr2-mtap-s03.rno.apple.com
 [17.179.226.135])
 by ma1-aaemail-dr-lapp02.apple.com with ESMTP id 2wf2aw5bw0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Sun, 24 Nov 2019 12:05:29 -0800
Received: from nwk-mmpp-sz10.apple.com
 (nwk-mmpp-sz10.apple.com [17.128.115.122]) by mr2-mtap-s03.rno.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPS id <0Q1H0042LP55WU20@mr2-mtap-s03.rno.apple.com>; Sun,
 24 Nov 2019 12:05:29 -0800 (PST)
Received: from process_milters-daemon.nwk-mmpp-sz10.apple.com by
 nwk-mmpp-sz10.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) id <0Q1H00F00P3BWT00@nwk-mmpp-sz10.apple.com>; Sun,
 24 Nov 2019 12:05:29 -0800 (PST)
X-Va-A: 
X-Va-T-CD: c56cc4374afe9162bf6a337f3d661529
X-Va-E-CD: 2492a803496fe8ede299f303d41687b7
X-Va-R-CD: b3ffd859fa8c3ada03623d154edee813
X-Va-CD: 0
X-Va-ID: 2dc03855-86ce-4aec-b672-a62240d1ae39
X-V-A: 
X-V-T-CD: c56cc4374afe9162bf6a337f3d661529
X-V-E-CD: 2492a803496fe8ede299f303d41687b7
X-V-R-CD: b3ffd859fa8c3ada03623d154edee813
X-V-CD: 0
X-V-ID: 0c678cb5-228e-4d20-a793-134d562ceab5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-11-24_02:,, signatures=0
Received: from pontoon.com (unknown [17.234.36.164]) by nwk-mmpp-sz10.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPSA id <0Q1H000C0P54NN30@nwk-mmpp-sz10.apple.com>; Sun,
 24 Nov 2019 12:05:29 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 0/5] hvf: stability fixes for HVF
Date: Sun, 24 Nov 2019 12:05:22 -0800
Message-id: <cover.1574625592.git.dirty@apple.com>
X-Mailer: git-send-email 2.24.0
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-24_02:, , signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 17.171.2.68
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Cameron Esfahani <dirty@apple.com>
From: Cameron Esfahani via <qemu-devel@nongnu.org>

The following patches fix stability issues with running QEMU on Apple
Hypervisor Framework (HVF):
- non-RAM, non-ROMD areas need to trap so accesses can be correctly
  emulated.
- Current TSC synchronization implementation is insufficient: when
  running with more than 1 core, TSC values can go backwards.  Until
  a correct implementation can be written, remove calls to
  hv_vm_sync_tsc().  Pass through TSC to guest OS.
- Fix REX emulation in relation to legacy prefixes.
- More correctly match SDM when setting CR0 and PDPTE registers.
- Save away exception type as well as vector in hvf_store_events() so
  they can be correctly reinjected in hvf_inject_interrupts().  Under
  heavy loads, exceptions got misrouted.

Changes in v2:
- Fix code style errors.

Cameron Esfahani (5):
  hvf: non-RAM, non-ROMD memory ranges are now correctly mapped in
  hvf: remove TSC synchronization code because it isn't fully complete
  hvf: correctly handle REX prefix in relation to legacy prefixes
  hvf: more accurately match SDM when setting CR0 and PDPTE registers
  hvf: save away type as well as vector so we can reinject them

 target/i386/hvf/hvf.c        | 79 ++++++++++++++++++++++++++----------
 target/i386/hvf/vmx.h        | 18 ++++----
 target/i386/hvf/x86_decode.c | 64 ++++++++++++++++-------------
 target/i386/hvf/x86_decode.h | 20 ++++-----
 target/i386/hvf/x86_emu.c    |  3 --
 target/i386/hvf/x86hvf.c     | 26 +++++-------
 6 files changed, 124 insertions(+), 86 deletions(-)

-- 
2.24.0



Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7163C432C3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 23:58:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B8520678
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 23:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="N9jgBw2K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B8520678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibva9-0008Q9-Bg
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 18:58:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1ibvXd-0006fW-R4
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 18:55:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1ibvXc-0008Q8-J2
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 18:55:45 -0500
Received: from nwk-aaemail-lapp01.apple.com ([17.151.62.66]:37006)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1ibvXc-0008Lb-69
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 18:55:44 -0500
Received: from pps.filterd (nwk-aaemail-lapp01.apple.com [127.0.0.1])
 by nwk-aaemail-lapp01.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 xB2Nq89N044500; Mon, 2 Dec 2019 15:55:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : from : to :
 cc : subject : date : message-id : mime-version :
 content-transfer-encoding; s=20180706;
 bh=BL4BsHLqzln1DQ5XaqYwZDl8cvcm/KGsfzVwGV0ERLA=;
 b=N9jgBw2KmY3ORsD2+CppWJkoMDSfctbfDNvLC0AisqAkOukS4Hl4Ft/gK0sb+8tANSzZ
 us2P1wxigSlkXtDxw2LScmlYIyCtNy7C3+Ksg40dXCfBOVFpyzCdI1oLsoDpVcRt/IzP
 jIXAuYyEvdxpW7F7w4J7wkqqFAAiJYWr7B0AMqvJMB8DGg4g/Li2WK+OU1/bTnDFwqCB
 FdHV/ct2IpbXp9rSlEFWCw0Ho/CJ7ETc1Eye6IatanpWyLq2NcmvKUhvfeIF55dU3C18
 YnNeKbf3QFMD6YLxh7FuRsr9J9opNhLADUo/Pl8VrHDZVjxplzLDtyb7bBrV/0ZmNFRF 9w== 
Received: from mr2-mtap-s02.rno.apple.com (mr2-mtap-s02.rno.apple.com
 [17.179.226.134])
 by nwk-aaemail-lapp01.apple.com with ESMTP id 2wkr83ys16-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 02 Dec 2019 15:55:42 -0800
Received: from nwk-mmpp-sz12.apple.com
 (nwk-mmpp-sz12.apple.com [17.128.115.204]) by mr2-mtap-s02.rno.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPS id <0Q1W00L5GT4UNB80@mr2-mtap-s02.rno.apple.com>; Mon,
 02 Dec 2019 15:55:42 -0800 (PST)
Received: from process_milters-daemon.nwk-mmpp-sz12.apple.com by
 nwk-mmpp-sz12.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) id <0Q1W00A00SGIRL00@nwk-mmpp-sz12.apple.com>; Mon,
 02 Dec 2019 15:55:42 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 
X-Va-E-CD: 
X-Va-R-CD: 
X-Va-CD: 0
X-Va-ID: 2a32e029-f013-4bb4-b600-40bd0324adcc
X-V-A: 
X-V-T-CD: c56cc4374afe9162bf6a337f3d661529
X-V-E-CD: 8398ff3dbb88c6c26326c26407fdbef4
X-V-R-CD: 3bb37b3e3592381a502d559dfb978ae4
X-V-CD: 0
X-V-ID: 902474ee-2253-46c1-b80c-8e3d7fc7e06e
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-12-02_06:,, signatures=0
Received: from pontoon.com (unknown [17.193.42.217]) by nwk-mmpp-sz12.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPSA id <0Q1W00JNAT4TQI20@nwk-mmpp-sz12.apple.com>; Mon,
 02 Dec 2019 15:55:42 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v3 0/5] hvf: stability fixes for HVF
Date: Mon, 02 Dec 2019 15:55:36 -0800
Message-id: <cover.1575330463.git.dirty@apple.com>
X-Mailer: git-send-email 2.24.0
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-12-02_06:, , signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 17.151.62.66
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
- Previous implementation in hvf_inject_interrupts() would always inject
  VMCS_INTR_T_SWINTR even when VMCS_INTR_T_HWINTR was required.  Now
  correctly determine when VMCS_INTR_T_HWINTR is appropriate versus
  VMCS_INTR_T_SWINTR.  Under heavy loads, interrupts got misrouted.

Changes in v3:
- Change previous code which saved interrupt/exception type in
  hvf_store_events() to inject later in hvf_inject_interrupts().
  Now, hvf_inject_interrupts() will correctly determine when it's appropriate
  to inject VMCS_INTR_T_HWINTR versus VMCS_INTR_T_SWINTR.  From feedback by
  Paolo Bonzini to make code more similar to KVM model.

Changes in v2:
- Fix code style errors.

Cameron Esfahani (5):
  hvf: non-RAM, non-ROMD memory ranges are now correctly mapped in
  hvf: remove TSC synchronization code because it isn't fully complete
  hvf: correctly handle REX prefix in relation to legacy prefixes
  hvf: more accurately match SDM when setting CR0 and PDPTE registers
  hvf: correctly inject VMCS_INTR_T_HWINTR versus VMCS_INTR_T_SWINTR.

 target/i386/hvf/hvf.c        | 65 ++++++++++++++++++++++++++----------
 target/i386/hvf/vmx.h        | 18 +++++-----
 target/i386/hvf/x86_decode.c | 64 +++++++++++++++++++----------------
 target/i386/hvf/x86_decode.h | 20 +++++------
 target/i386/hvf/x86_emu.c    |  3 --
 target/i386/hvf/x86hvf.c     | 18 +++++-----
 6 files changed, 112 insertions(+), 76 deletions(-)

-- 
2.24.0



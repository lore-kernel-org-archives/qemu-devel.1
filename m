Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74370C2D0EE
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 00:17:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F435206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 00:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="hTrc+AJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F435206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ4b7-0006gc-CY
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 20:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1jJ4Zg-0005S7-9G
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1jJ4Zf-00006p-34
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:16:12 -0400
Received: from nwk-aaemail-lapp01.apple.com ([17.151.62.66]:35628)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1jJ4Ze-000054-Rx
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:16:11 -0400
Received: from pps.filterd (nwk-aaemail-lapp01.apple.com [127.0.0.1])
 by nwk-aaemail-lapp01.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 02V02BFB012127; Mon, 30 Mar 2020 17:16:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : from : to :
 cc : subject : date : message-id : mime-version :
 content-transfer-encoding; s=20180706;
 bh=B8CMo3JiUN4dypNp1YYuniPn9fZWiYUSbZVmyr+0AaM=;
 b=hTrc+AJ30o6dFxgi7fFFxtBdIyISeM2NchECEetRbkHgO0z97AjrXjoVe5nvHIfVLZYQ
 hr8rTHPZeByOAHt2PA6L9ADwgQ4G2j06uwl7HQb0MINUOXl8qQczzw3uUwHRPIAFEN/5
 ELtjHNsR85OW4bNDj/muP8NLOEQCHawIeFE1q8Re6hIxt1G75mDUHuwNW1Z2nE6tPuLg
 4N8MpP+uoQvKPknhfhK/DYQHtrXsJ9y8C40pDOH4IBqeu0zRHc+Li3FzK/W9FuBIsrvo
 xAUIHYsbvH9YBgkYZYJvbF1RmY2mh/kri7pP4s9SH1LbYzmO081x+g3oCuLyE9sV/qVi aw== 
Received: from rn-mailsvcp-mta-lapp04.rno.apple.com
 (rn-mailsvcp-mta-lapp04.rno.apple.com [10.225.203.152])
 by nwk-aaemail-lapp01.apple.com with ESMTP id 3025h0gryh-8
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 30 Mar 2020 17:16:09 -0700
Received: from rn-mailsvcp-mmp-lapp01.rno.apple.com
 (rn-mailsvcp-mmp-lapp01.rno.apple.com [17.179.253.14])
 by rn-mailsvcp-mta-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) with ESMTPS id <0Q8100XDF7EVTJB0@rn-mailsvcp-mta-lapp04.rno.apple.com>; 
 Mon, 30 Mar 2020 17:16:07 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp01.rno.apple.com by
 rn-mailsvcp-mmp-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) id <0Q8100B007DUTS00@rn-mailsvcp-mmp-lapp01.rno.apple.com>; Mon,
 30 Mar 2020 17:16:07 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: c56cc4374afe9162bf6a337f3d661529
X-Va-E-CD: f77409c6bc1c65704addf4137598222f
X-Va-R-CD: 160503dff8f4abc1bd1fc5fd20aea454
X-Va-CD: 0
X-Va-ID: 28f700af-2421-4608-a113-5ebc446bca24
X-V-A: 
X-V-T-CD: c56cc4374afe9162bf6a337f3d661529
X-V-E-CD: f77409c6bc1c65704addf4137598222f
X-V-R-CD: 160503dff8f4abc1bd1fc5fd20aea454
X-V-CD: 0
X-V-ID: cada5504-9ff1-46e0-8f02-73c4379505ba
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-03-30_07:2020-03-30,
 2020-03-30 signatures=0
Received: from pontoon.com (unknown [17.234.84.168])
 by rn-mailsvcp-mmp-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020))
 with ESMTPSA id <0Q81010CS7EU8N70@rn-mailsvcp-mmp-lapp01.rno.apple.com>; Mon,
 30 Mar 2020 17:16:07 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, r.bolshakov@yadro.com
Subject: [PATCH v1 0/3] hvf: Support AVX512 guests and cleanup
Date: Mon, 30 Mar 2020 17:16:03 -0700
Message-id: <cover.1585607927.git.dirty@apple.com>
X-Mailer: git-send-email 2.24.0
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-03-30_07:2020-03-30,
 2020-03-30 signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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

HVF had its own copy of the CR0 and CR4 register definitions.  Remove
them in favor of the definitions in target/i386/cpu.h.

Change long mode enter and exit code to be clearer.

Support AVX512 guests on capable hardware.  This involves two separate
changes:
- Correctly manage the OSXSAVE bit in CPUID[0x01].  cpu_x86_cpuid()
  attempts to account for OSXSAVE, but it refers to env->cr[4] for the
  guest copy of CR4.  That field isn't up to date under HVF.  Instead,
  we track OSXSAVE separately, by adding OSXSAVE to CR4 mask and saving
  the state.  Then, when handling CPUID[0x01] in EXIT_REASON_CPUID, we
  reflect the current state of CR4[OSXSAVE]. 
- macOS lazily enables AVX512 for processes.  Explicitly enable AVX512
  for QEMU.
With these two changes, guests can correctly detect and enable AVX512.

Cameron Esfahani (3):
  hvf: use standard CR0 and CR4 register definitions
  hvf: Make long mode enter and exit code clearer.
  hvf: Support AVX512 guests on capable hardware

 target/i386/cpu.h          |  3 ++
 target/i386/hvf/hvf.c      | 69 ++++++++++++++++++++++++++++++++++++--
 target/i386/hvf/vmx.h      | 32 ++++++++++++------
 target/i386/hvf/x86.c      |  6 ++--
 target/i386/hvf/x86.h      | 34 -------------------
 target/i386/hvf/x86_mmu.c  |  2 +-
 target/i386/hvf/x86_task.c |  3 +-
 target/i386/hvf/x86hvf.c   |  2 +-
 8 files changed, 98 insertions(+), 53 deletions(-)

-- 
2.24.0



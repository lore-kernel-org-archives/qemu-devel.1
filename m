Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC95C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 20:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EA8C205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 20:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdtZeUaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA8C205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIeFd-0007cy-OH
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 16:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIeDx-0006Au-0N
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 16:40:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35023)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIeDu-0002x1-7h
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 16:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600288812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DLMeXlaAeb8tjE7YKDswsBb2zaboMgq7LXbYKwBwmhs=;
 b=DdtZeUaYZHg2hh8LVwOnm4AHz5gPAzkyXvIccb5ExE3EDXrh/Sf9PpR7xCNHtFqAmEA1vn
 Jk6P32d3w+8D/ay92ra8BvmmsDR0DLGpp6KIgk6l3BwLpYQHFlzEBozCPGqm3GYHB0AJPd
 6NVbV7PJw6in/jgihOX0E4WFVxX/YUg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-vTJksi97NO-F1Ufr5rL-7A-1; Wed, 16 Sep 2020 16:40:08 -0400
X-MC-Unique: vTJksi97NO-F1Ufr5rL-7A-1
Received: by mail-wr1-f69.google.com with SMTP id l15so3004089wro.10
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 13:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DLMeXlaAeb8tjE7YKDswsBb2zaboMgq7LXbYKwBwmhs=;
 b=DAvPFWntT4rMZIa+xQpS7LIpkB8z11OXLGVz9o/1Q8trkj6qnOyqsu8OLNCoS9XT/7
 kUnqpIvT1IM7cNq2AU6+eYE95Zr2N5NCQale8wl+YF/IWKpti2dLYbW5+fujy8jFhVl/
 BmpzBnA05fLdRMF0plYk5Pyscs/KnrlHeMLvQQ8CBSXZpwtjvgnnxqvMICwG/ZXCPHYn
 yEvIsz6bJbuuxXapbGuVogCPcgmrsG8fZCIDojeEFgywqrAUpbMYuCMjHfS7FykxHUAW
 PXzD1aYJZDDmA2W4BO0B9hr2ssis9UbuoQUgDjjNg5x191MbKzloC9rMMQtZm9MaPT0Y
 ySNQ==
X-Gm-Message-State: AOAM533WAE6OOSwtI+zk2j4Bs/a8nqeB8jUTrLiBdRL2Ij5ExqbHKsAn
 G3yputEKDOdq2nZkbcdWOeDqDRBhXoIV3DXGMF/oMJhK6/bPQ7qYKnM+sRvhF4dyCz8M4BfmpkI
 S+fF41iDpxr0EjI0=
X-Received: by 2002:a1c:9a57:: with SMTP id c84mr6447597wme.136.1600288806814; 
 Wed, 16 Sep 2020 13:40:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwV8KvDIMSsFjwHgi00AGGBXdSGsf1Za2PfXMgU+a4s1xa8+mGU8Z739I3h4KeWG9IUKm10gg==
X-Received: by 2002:a1c:9a57:: with SMTP id c84mr6447580wme.136.1600288806564; 
 Wed, 16 Sep 2020 13:40:06 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id m1sm6812879wmc.28.2020.09.16.13.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 13:40:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] block/nvme: Fix NVMeRegs alignment/packing and use atomic
 operations
Date: Wed, 16 Sep 2020 22:40:01 +0200
Message-Id: <20200916204004.1511985-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix a compiler optimization problem introduced in commit
e5ff22ba9fc ("block/nvme: Pair doorbell registers"),
use atomic operations.

For some not understood yet reason using atomic_and triggers
a NMI on x86 arch. Using the following snippet on top of this
series:

-- >8 --
-    atomic_set(&s->regs->ctrl.cc,
-               cpu_to_le32(atomic_read(&s->regs->ctrl.cc) & const_le32(0xFE)=
));
+    atomic_and(&s->regs->ctrl.cc, const_le32(0xFE));
---

triggers:

 {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source:=
 3
 {1}[Hardware Error]: event severity: fatal
 {1}[Hardware Error]:  Error 0, type: fatal
 {1}[Hardware Error]:   section_type: PCIe error
 {1}[Hardware Error]:   port_type: 0, PCIe end point
 {1}[Hardware Error]:   version: 1.16
 {1}[Hardware Error]:   command: 0x0006, status: 0x0010
 {1}[Hardware Error]:   device_id: 0000:04:00.0
 {1}[Hardware Error]:   slot: 0
 {1}[Hardware Error]:   secondary_bus: 0x00
 {1}[Hardware Error]:   vendor_id: 0x8086, device_id: 0x2701
 {1}[Hardware Error]:   class_code: 010802
 {1}[Hardware Error]:   aer_uncor_status: 0x00100000, aer_uncor_mask: 0x00018=
000
 {1}[Hardware Error]:   aer_uncor_severity: 0x000e7030
 {1}[Hardware Error]:   TLP Header: 33000000 00000000 00000000 00000000
 Kernel panic - not syncing: Fatal hardware error!
 CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.6.8-100.fc30.x86_64 #1
 Hardware name: Dell Inc. PowerEdge R430/03XKDV, BIOS 1.2.6 06/08/2015
 Call Trace:
  <NMI>
  dump_stack+0x66/0x90
  panic+0xf1/0x2d3
  __ghes_panic.part.0+0x26/0x26
  ghes_notify_nmi.cold+0x5/0x5
  nmi_handle+0x66/0x120
  default_do_nmi+0x45/0x100
  do_nmi+0x165/0x1d0
  end_repeat_nmi+0x16/0x50
 RIP: 0010:intel_idle+0x82/0x130
 Code: 65 48 8b 04 25 c0 8b 01 00 0f 01 c8 48 8b 00 a8 08 75 17 e9 07 00 00 0=
0 0f 00 2d f5 cd 6d 00 b9 01 00 00 00 48 89 d8 0f 01 c9 <65> 48 8b 04 25 c0 8=
b 01 00 f0 80 60 02 df f0 83 44 24 fc 00 b
 RSP: 0018:ffffffffa8603e30 EFLAGS: 00000046
 RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000001
 RDX: 0000000000000000 RSI: ffffffffa875edc0 RDI: 0000000000000000
 RBP: ffffffffa875edc0 R08: 00000013ef2b797f R09: 000000000000ba42
 R10: 00000000000993b3 R11: ffffa070afc29ca4 R12: 0000000000000002
 R13: ffffffffa875edc0 R14: 0000000000000002 R15: ffffffffa8614840
  ? intel_idle+0x82/0x130
  ? intel_idle+0x82/0x130
  </NMI>
  cpuidle_enter_state+0x81/0x3e0
  cpuidle_enter+0x29/0x40
  do_idle+0x1c0/0x260
  cpu_startup_entry+0x19/0x20
  start_kernel+0x7ad/0x7ba
  secondary_startup_64+0xb6/0xc0
 Kernel Offset: 0x26000000 from 0xffffffff81000000 (relocation range: 0xfffff=
fff80000000-0xffffffffbfffffff)

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>

Philippe Mathieu-Daud=C3=A9 (3):
  block/nvme: Initialize constant values with const_le32()
  block/nvme: Use atomic operations instead of 'volatile' keyword
  block/nvme: Align NVMeRegs structure to 4KiB and mark it packed

 block/nvme.c | 55 ++++++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 25 deletions(-)

--=20
2.26.2



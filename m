Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA25C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 12:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35752207F5
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 12:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LLGGajW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35752207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeeWi-0008SM-DS
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 08:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeeW1-0007wS-J8
 for qemu-devel@nongnu.org; Fri, 29 May 2020 08:53:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39165
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeeVz-00064N-1f
 for qemu-devel@nongnu.org; Fri, 29 May 2020 08:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590756814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Imd9OM3BOpjnolVWdADoVavNUSv5BdspcgDMJvj7jGw=;
 b=LLGGajW0ilQnh3vi2aZnyNdlN15JZiVpg9hwIME9RJCuMRSN81MdOCnMguOw6Uwb3xSPDR
 7yuHmIeWkvls27HaBdqSAlIZmRbCwK9ZC+5PH9Sb2uCsPIMxdwhAPMuhkOUuOrQ5MxFIJp
 M21jdCdPlHS3fYB5C2QwVFKUsq/rneM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-Lj5qT0MEM2-SNeSa72aATA-1; Fri, 29 May 2020 08:53:30 -0400
X-MC-Unique: Lj5qT0MEM2-SNeSa72aATA-1
Received: by mail-wm1-f70.google.com with SMTP id l2so771325wmi.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 05:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Imd9OM3BOpjnolVWdADoVavNUSv5BdspcgDMJvj7jGw=;
 b=sGJ7/3vsNbQmGD0KaAIulnc/iFR2cLIdGCl3BwvaWnL7B4srs0ZdfyKgXwD056Uip9
 nuBIZqHOPp9dsbgt6PMrHGO0btbfTB/ZGJCklgh3NgVlWe1+P7EWska2VesV3SkGZAgY
 h599t0SHOn9R6zvlxH1msKgQ6/xeJXW/ORwkdv6Mq9FbTCZ5lgd4J/yWeu4K+PdRAvqk
 oek1JlnZfi1uyHeV74xDQAy91ydpgTJrUqgbhJVflGXpfqri4PWpJ7kYuYSAo6uNIXuj
 8KvGIoLLCn4mtrcxGesGeFQd6mNIERkOewOp28NMBZ0FY+5AOCBqt0qfSkIW2k9Drdhx
 /dxQ==
X-Gm-Message-State: AOAM5330trAPMWad0vAcn5YWRcI7+hFgj1Y2GxOdsAzoEsdWIj6aJImJ
 k3ugLwn8hS6Pr3Jt6xh1JyLdVSCIwKdp58TGevCJ2xs1foubYNTaigrERdivxr0J35xFRXVzDBX
 FILpBUo2Q5iebfDo=
X-Received: by 2002:a1c:4d11:: with SMTP id o17mr8195806wmh.37.1590756808762; 
 Fri, 29 May 2020 05:53:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7ufT1xAAUs5XfGN3mKVhzcxM9W+t2RxSUJIUVFvdyqxSw/uM3eHD3xnmIWdmQ6gLGYy9DsA==
X-Received: by 2002:a1c:4d11:: with SMTP id o17mr8195776wmh.37.1590756808268; 
 Fri, 29 May 2020 05:53:28 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id z206sm11982063wmg.30.2020.05.29.05.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 05:53:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] memory: Make 'info mtree' not display disabled regions by
 default
Date: Fri, 29 May 2020 14:53:25 +0200
Message-Id: <20200529125325.11916-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 01:34:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We might have many disabled memory regions, making the 'info mtree'
output too verbose to be useful.
Remove the disabled regions in the default output, but allow the
monitor user to display them using the '-D' option.

Before:

  (qemu) info mtree
  memory-region: system
    0000000000000000-ffffffffffffffff (prio 0, i/o): system
      0000000000000000-0000000007ffffff (prio 0, ram): alias ram-below-4g @pc.ram 0000000000000000-0000000007ffffff
      0000000000000000-ffffffffffffffff (prio -1, i/o): pci
        00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
        00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
        00000000000e0000-00000000000fffff (prio 1, rom): alias isa-bios @pc.bios 0000000000020000-000000000003ffff
        00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
      00000000000a0000-00000000000bffff (prio 1, i/o): alias smram-region @pci 00000000000a0000-00000000000bffff
      00000000000c0000-00000000000c3fff (prio 1, ram): alias pam-ram @pc.ram 00000000000c0000-00000000000c3fff [disabled]
      00000000000c0000-00000000000c3fff (prio 1, ram): alias pam-pci @pc.ram 00000000000c0000-00000000000c3fff [disabled]
      00000000000c0000-00000000000c3fff (prio 1, ram): alias pam-rom @pc.ram 00000000000c0000-00000000000c3fff [disabled]
      00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-pci @pci 00000000000c0000-00000000000c3fff
      00000000000c4000-00000000000c7fff (prio 1, ram): alias pam-ram @pc.ram 00000000000c4000-00000000000c7fff [disabled]
      00000000000c4000-00000000000c7fff (prio 1, ram): alias pam-pci @pc.ram 00000000000c4000-00000000000c7fff [disabled]
      00000000000c4000-00000000000c7fff (prio 1, ram): alias pam-rom @pc.ram 00000000000c4000-00000000000c7fff [disabled]
      00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-pci @pci 00000000000c4000-00000000000c7fff
      00000000000c8000-00000000000cbfff (prio 1, ram): alias pam-ram @pc.ram 00000000000c8000-00000000000cbfff [disabled]
      00000000000c8000-00000000000cbfff (prio 1, ram): alias pam-pci @pc.ram 00000000000c8000-00000000000cbfff [disabled]
      00000000000c8000-00000000000cbfff (prio 1, ram): alias pam-rom @pc.ram 00000000000c8000-00000000000cbfff [disabled]
      00000000000c8000-00000000000cbfff (prio 1, i/o): alias pam-pci @pci 00000000000c8000-00000000000cbfff
      00000000000cc000-00000000000cffff (prio 1, ram): alias pam-ram @pc.ram 00000000000cc000-00000000000cffff [disabled]
      00000000000cc000-00000000000cffff (prio 1, ram): alias pam-pci @pc.ram 00000000000cc000-00000000000cffff [disabled]
      00000000000cc000-00000000000cffff (prio 1, ram): alias pam-rom @pc.ram 00000000000cc000-00000000000cffff [disabled]
      00000000000cc000-00000000000cffff (prio 1, i/o): alias pam-pci @pci 00000000000cc000-00000000000cffff
      00000000000d0000-00000000000d3fff (prio 1, ram): alias pam-ram @pc.ram 00000000000d0000-00000000000d3fff [disabled]
      00000000000d0000-00000000000d3fff (prio 1, ram): alias pam-pci @pc.ram 00000000000d0000-00000000000d3fff [disabled]
      00000000000d0000-00000000000d3fff (prio 1, ram): alias pam-rom @pc.ram 00000000000d0000-00000000000d3fff [disabled]
      00000000000d0000-00000000000d3fff (prio 1, i/o): alias pam-pci @pci 00000000000d0000-00000000000d3fff
      00000000000d4000-00000000000d7fff (prio 1, ram): alias pam-ram @pc.ram 00000000000d4000-00000000000d7fff [disabled]
      00000000000d4000-00000000000d7fff (prio 1, ram): alias pam-pci @pc.ram 00000000000d4000-00000000000d7fff [disabled]
      00000000000d4000-00000000000d7fff (prio 1, ram): alias pam-rom @pc.ram 00000000000d4000-00000000000d7fff [disabled]
      00000000000d4000-00000000000d7fff (prio 1, i/o): alias pam-pci @pci 00000000000d4000-00000000000d7fff
      00000000000d8000-00000000000dbfff (prio 1, ram): alias pam-ram @pc.ram 00000000000d8000-00000000000dbfff [disabled]
      00000000000d8000-00000000000dbfff (prio 1, ram): alias pam-pci @pc.ram 00000000000d8000-00000000000dbfff [disabled]
      00000000000d8000-00000000000dbfff (prio 1, ram): alias pam-rom @pc.ram 00000000000d8000-00000000000dbfff [disabled]
      00000000000d8000-00000000000dbfff (prio 1, i/o): alias pam-pci @pci 00000000000d8000-00000000000dbfff
      00000000000dc000-00000000000dffff (prio 1, ram): alias pam-ram @pc.ram 00000000000dc000-00000000000dffff [disabled]
      00000000000dc000-00000000000dffff (prio 1, ram): alias pam-pci @pc.ram 00000000000dc000-00000000000dffff [disabled]
      00000000000dc000-00000000000dffff (prio 1, ram): alias pam-rom @pc.ram 00000000000dc000-00000000000dffff [disabled]
      00000000000dc000-00000000000dffff (prio 1, i/o): alias pam-pci @pci 00000000000dc000-00000000000dffff
      00000000000e0000-00000000000e3fff (prio 1, ram): alias pam-ram @pc.ram 00000000000e0000-00000000000e3fff [disabled]
      00000000000e0000-00000000000e3fff (prio 1, ram): alias pam-pci @pc.ram 00000000000e0000-00000000000e3fff [disabled]
      00000000000e0000-00000000000e3fff (prio 1, ram): alias pam-rom @pc.ram 00000000000e0000-00000000000e3fff [disabled]
      00000000000e0000-00000000000e3fff (prio 1, i/o): alias pam-pci @pci 00000000000e0000-00000000000e3fff
      00000000000e4000-00000000000e7fff (prio 1, ram): alias pam-ram @pc.ram 00000000000e4000-00000000000e7fff [disabled]
      00000000000e4000-00000000000e7fff (prio 1, ram): alias pam-pci @pc.ram 00000000000e4000-00000000000e7fff [disabled]
      00000000000e4000-00000000000e7fff (prio 1, ram): alias pam-rom @pc.ram 00000000000e4000-00000000000e7fff [disabled]
      00000000000e4000-00000000000e7fff (prio 1, i/o): alias pam-pci @pci 00000000000e4000-00000000000e7fff
      00000000000e8000-00000000000ebfff (prio 1, ram): alias pam-ram @pc.ram 00000000000e8000-00000000000ebfff [disabled]
      00000000000e8000-00000000000ebfff (prio 1, ram): alias pam-pci @pc.ram 00000000000e8000-00000000000ebfff [disabled]
      00000000000e8000-00000000000ebfff (prio 1, ram): alias pam-rom @pc.ram 00000000000e8000-00000000000ebfff [disabled]
      00000000000e8000-00000000000ebfff (prio 1, i/o): alias pam-pci @pci 00000000000e8000-00000000000ebfff
      00000000000ec000-00000000000effff (prio 1, ram): alias pam-ram @pc.ram 00000000000ec000-00000000000effff [disabled]
      00000000000ec000-00000000000effff (prio 1, ram): alias pam-pci @pc.ram 00000000000ec000-00000000000effff [disabled]
      00000000000ec000-00000000000effff (prio 1, ram): alias pam-rom @pc.ram 00000000000ec000-00000000000effff [disabled]
      00000000000ec000-00000000000effff (prio 1, i/o): alias pam-pci @pci 00000000000ec000-00000000000effff
      00000000000f0000-00000000000fffff (prio 1, ram): alias pam-ram @pc.ram 00000000000f0000-00000000000fffff [disabled]
      00000000000f0000-00000000000fffff (prio 1, ram): alias pam-pci @pc.ram 00000000000f0000-00000000000fffff [disabled]
      00000000000f0000-00000000000fffff (prio 1, ram): alias pam-rom @pc.ram 00000000000f0000-00000000000fffff [disabled]
      00000000000f0000-00000000000fffff (prio 1, i/o): alias pam-pci @pci 00000000000f0000-00000000000fffff
      00000000fec00000-00000000fec00fff (prio 0, i/o): ioapic
      00000000fed00000-00000000fed003ff (prio 0, i/o): hpet
      00000000fee00000-00000000feefffff (prio 4096, i/o): apic-msi

After:

  (qemu) info mtree
  memory-region: system
    0000000000000000-ffffffffffffffff (prio 0, i/o): system
      0000000000000000-0000000007ffffff (prio 0, ram): alias ram-below-4g @pc.ram 0000000000000000-0000000007ffffff
      0000000000000000-ffffffffffffffff (prio -1, i/o): pci
        00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
        00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
        00000000000e0000-00000000000fffff (prio 1, rom): alias isa-bios @pc.bios 0000000000020000-000000000003ffff
        00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
      00000000000a0000-00000000000bffff (prio 1, i/o): alias smram-region @pci 00000000000a0000-00000000000bffff
      00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-pci @pci 00000000000c0000-00000000000c3fff
      00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-pci @pci 00000000000c4000-00000000000c7fff
      00000000000c8000-00000000000cbfff (prio 1, i/o): alias pam-pci @pci 00000000000c8000-00000000000cbfff
      00000000000cc000-00000000000cffff (prio 1, i/o): alias pam-pci @pci 00000000000cc000-00000000000cffff
      00000000000d0000-00000000000d3fff (prio 1, i/o): alias pam-pci @pci 00000000000d0000-00000000000d3fff
      00000000000d4000-00000000000d7fff (prio 1, i/o): alias pam-pci @pci 00000000000d4000-00000000000d7fff
      00000000000d8000-00000000000dbfff (prio 1, i/o): alias pam-pci @pci 00000000000d8000-00000000000dbfff
      00000000000dc000-00000000000dffff (prio 1, i/o): alias pam-pci @pci 00000000000dc000-00000000000dffff
      00000000000e0000-00000000000e3fff (prio 1, i/o): alias pam-pci @pci 00000000000e0000-00000000000e3fff
      00000000000e4000-00000000000e7fff (prio 1, i/o): alias pam-pci @pci 00000000000e4000-00000000000e7fff
      00000000000e8000-00000000000ebfff (prio 1, i/o): alias pam-pci @pci 00000000000e8000-00000000000ebfff
      00000000000ec000-00000000000effff (prio 1, i/o): alias pam-pci @pci 00000000000ec000-00000000000effff
      00000000000f0000-00000000000fffff (prio 1, i/o): alias pam-pci @pci 00000000000f0000-00000000000fffff
      00000000fec00000-00000000fec00fff (prio 0, i/o): ioapic
      00000000fed00000-00000000fed003ff (prio 0, i/o): hpet
      00000000fee00000-00000000feefffff (prio 4096, i/o): apic-msi

The old behavior is preserved using 'info mtree -D'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/exec/memory.h |  2 +-
 memory.c              | 75 +++++++++++++++++++++++--------------------
 monitor/misc.c        |  3 +-
 hmp-commands-info.hx  |  7 ++--
 4 files changed, 48 insertions(+), 39 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index e000bd2f97..27f3bb59e0 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1973,7 +1973,7 @@ void memory_global_dirty_log_start(void);
  */
 void memory_global_dirty_log_stop(void);
 
-void mtree_info(bool flatview, bool dispatch_tree, bool owner);
+void mtree_info(bool flatview, bool dispatch_tree, bool owner, bool disabled);
 
 /**
  * memory_region_dispatch_read: perform a read directly to the specified
diff --git a/memory.c b/memory.c
index fd6f3d6aca..e79526f8ad 100644
--- a/memory.c
+++ b/memory.c
@@ -2876,7 +2876,7 @@ static void mtree_print_mr_owner(const MemoryRegion *mr)
 static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
                            hwaddr base,
                            MemoryRegionListHead *alias_print_queue,
-                           bool owner)
+                           bool owner, bool display_disabled)
 {
     MemoryRegionList *new_ml, *ml, *next_ml;
     MemoryRegionListHead submr_print_queue;
@@ -2888,10 +2888,6 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
         return;
     }
 
-    for (i = 0; i < level; i++) {
-        qemu_printf(MTREE_INDENT);
-    }
-
     cur_start = base + mr->addr;
     cur_end = cur_start + MR_SIZE(mr->size);
 
@@ -2920,35 +2916,46 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
             ml->mr = mr->alias;
             QTAILQ_INSERT_TAIL(alias_print_queue, ml, mrqueue);
         }
-        qemu_printf(TARGET_FMT_plx "-" TARGET_FMT_plx
-                    " (prio %d, %s%s): alias %s @%s " TARGET_FMT_plx
-                    "-" TARGET_FMT_plx "%s",
-                    cur_start, cur_end,
-                    mr->priority,
-                    mr->nonvolatile ? "nv-" : "",
-                    memory_region_type((MemoryRegion *)mr),
-                    memory_region_name(mr),
-                    memory_region_name(mr->alias),
-                    mr->alias_offset,
-                    mr->alias_offset + MR_SIZE(mr->size),
-                    mr->enabled ? "" : " [disabled]");
-        if (owner) {
-            mtree_print_mr_owner(mr);
+        if (mr->enabled || display_disabled) {
+            for (i = 0; i < level; i++) {
+                qemu_printf(MTREE_INDENT);
+            }
+            qemu_printf(TARGET_FMT_plx "-" TARGET_FMT_plx
+                        " (prio %d, %s%s): alias %s @%s " TARGET_FMT_plx
+                        "-" TARGET_FMT_plx "%s",
+                        cur_start, cur_end,
+                        mr->priority,
+                        mr->nonvolatile ? "nv-" : "",
+                        memory_region_type((MemoryRegion *)mr),
+                        memory_region_name(mr),
+                        memory_region_name(mr->alias),
+                        mr->alias_offset,
+                        mr->alias_offset + MR_SIZE(mr->size),
+                        mr->enabled ? "" : " [disabled]");
+            if (owner) {
+                mtree_print_mr_owner(mr);
+            }
+            qemu_printf("\n");
         }
     } else {
-        qemu_printf(TARGET_FMT_plx "-" TARGET_FMT_plx
-                    " (prio %d, %s%s): %s%s",
-                    cur_start, cur_end,
-                    mr->priority,
-                    mr->nonvolatile ? "nv-" : "",
-                    memory_region_type((MemoryRegion *)mr),
-                    memory_region_name(mr),
-                    mr->enabled ? "" : " [disabled]");
-        if (owner) {
-            mtree_print_mr_owner(mr);
+        if (mr->enabled || display_disabled) {
+            for (i = 0; i < level; i++) {
+                qemu_printf(MTREE_INDENT);
+            }
+            qemu_printf(TARGET_FMT_plx "-" TARGET_FMT_plx
+                        " (prio %d, %s%s): %s%s",
+                        cur_start, cur_end,
+                        mr->priority,
+                        mr->nonvolatile ? "nv-" : "",
+                        memory_region_type((MemoryRegion *)mr),
+                        memory_region_name(mr),
+                        mr->enabled ? "" : " [disabled]");
+            if (owner) {
+                mtree_print_mr_owner(mr);
+            }
+            qemu_printf("\n");
         }
     }
-    qemu_printf("\n");
 
     QTAILQ_INIT(&submr_print_queue);
 
@@ -2971,7 +2978,7 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
 
     QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
         mtree_print_mr(ml->mr, level + 1, cur_start,
-                       alias_print_queue, owner);
+                       alias_print_queue, owner, display_disabled);
     }
 
     QTAILQ_FOREACH_SAFE(ml, &submr_print_queue, mrqueue, next_ml) {
@@ -3082,7 +3089,7 @@ static gboolean mtree_info_flatview_free(gpointer key, gpointer value,
     return true;
 }
 
-void mtree_info(bool flatview, bool dispatch_tree, bool owner)
+void mtree_info(bool flatview, bool dispatch_tree, bool owner, bool disabled)
 {
     MemoryRegionListHead ml_head;
     MemoryRegionList *ml, *ml2;
@@ -3130,14 +3137,14 @@ void mtree_info(bool flatview, bool dispatch_tree, bool owner)
 
     QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
         qemu_printf("address-space: %s\n", as->name);
-        mtree_print_mr(as->root, 1, 0, &ml_head, owner);
+        mtree_print_mr(as->root, 1, 0, &ml_head, owner, disabled);
         qemu_printf("\n");
     }
 
     /* print aliased regions */
     QTAILQ_FOREACH(ml, &ml_head, mrqueue) {
         qemu_printf("memory-region: %s\n", memory_region_name(ml->mr));
-        mtree_print_mr(ml->mr, 1, 0, &ml_head, owner);
+        mtree_print_mr(ml->mr, 1, 0, &ml_head, owner, disabled);
         qemu_printf("\n");
     }
 
diff --git a/monitor/misc.c b/monitor/misc.c
index f5207cd242..89bb970b00 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -957,8 +957,9 @@ static void hmp_info_mtree(Monitor *mon, const QDict *qdict)
     bool flatview = qdict_get_try_bool(qdict, "flatview", false);
     bool dispatch_tree = qdict_get_try_bool(qdict, "dispatch_tree", false);
     bool owner = qdict_get_try_bool(qdict, "owner", false);
+    bool disabled = qdict_get_try_bool(qdict, "disabled", false);
 
-    mtree_info(flatview, dispatch_tree, owner);
+    mtree_info(flatview, dispatch_tree, owner, disabled);
 }
 
 #ifdef CONFIG_PROFILER
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index ca5198438d..30209e3903 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -254,11 +254,12 @@ ERST
 
     {
         .name       = "mtree",
-        .args_type  = "flatview:-f,dispatch_tree:-d,owner:-o",
-        .params     = "[-f][-d][-o]",
+        .args_type  = "flatview:-f,dispatch_tree:-d,owner:-o,disabled:-D",
+        .params     = "[-f][-d][-o][-D]",
         .help       = "show memory tree (-f: dump flat view for address spaces;"
                       "-d: dump dispatch tree, valid with -f only);"
-                      "-o: dump region owners/parents",
+                      "-o: dump region owners/parents;"
+                      "-D: dump disabled regions",
         .cmd        = hmp_info_mtree,
     },
 
-- 
2.21.3



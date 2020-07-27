Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4031C433F1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:17:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8439F20FC3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GmpyVL1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8439F20FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k03w9-0002GE-Qy
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k03u9-0007cn-Vo
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:15:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53221
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k03u8-00070G-C4
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595859299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=6U+L7RuNkE3PAHP4vKwL1LwlX4XOZZUjEv2fvASw5pY=;
 b=GmpyVL1bLfyPUkxX8tPgyD6BKyXBQ4pVhEbSKgwZjPE7iOu+9IfXmH8fubfsb1OOPmSvbB
 jE/0nxe4+lHiP9XwxoAzLBTPlPWm116gYE6Y3rId3t1dDbRYoILZwFLtPHz/YEWdFdQb5+
 MkW3CH+fh93sYCbIfrcYEgYsReWW6OM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-5q3CiglMPzyN0NCtM-CGRw-1; Mon, 27 Jul 2020 10:14:58 -0400
X-MC-Unique: 5q3CiglMPzyN0NCtM-CGRw-1
Received: by mail-wr1-f71.google.com with SMTP id j16so4009650wrw.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 07:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=6U+L7RuNkE3PAHP4vKwL1LwlX4XOZZUjEv2fvASw5pY=;
 b=kCZ3O1vrmKjRt5w+s6yxddHgyi3hzYWZyzjihfq3v4vOL4UtlL58LXz+zZ2isoIHA1
 PsOIWEksDD/TXxr1Y+2UWQ0Sf1m7EMIlXjGZERPE5krSjM8LiTfWSiPsh9n21jS6mhmq
 4smGjuHgfPtPK60g9DWlSZvKU2k2y8zz1d5zIE7Q0hbQ9dT932ucz62pmah7hAx3qMw7
 TaBNxLBpZvEG00dxztaZ8X39PL4T8R55zgIaxwYt/W8b5cqFWtlBPsfJxe3AGWKe04gp
 USxy/FCYdLQwBVdglLInZMXKmerIACVGYeoVdaVLmgy/vWo9eGI24CVBX1Z9y2756MAu
 8wsw==
X-Gm-Message-State: AOAM532ZHaAKvtLMwiZJAEbNsm+bxJoV7ThEgQtmtmqWObknvrYbAuWT
 dWkQtgit0Gsh7Oz/dnEe7vTCopGh6QiwZJHW3ckO6dnN0zxewIQ5UFnVK60ibgK29dV6GbJCjRS
 ut8+dDn2ZYL9Gn1s=
X-Received: by 2002:adf:8024:: with SMTP id 33mr21185716wrk.135.1595859296186; 
 Mon, 27 Jul 2020 07:14:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZ1/s4Qv0wK+BHOYb36NBiPe055YGCdOFDgxPrUozUKCgBa4kHsc9gPS75E3YN5D54vpcgnQ==
X-Received: by 2002:adf:8024:: with SMTP id 33mr21185703wrk.135.1595859295978; 
 Mon, 27 Jul 2020 07:14:55 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id m14sm4019150wrx.76.2020.07.27.07.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 07:14:54 -0700 (PDT)
Date: Mon, 27 Jul 2020 10:14:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] fixup! hw/pci-host: save/restore pci host config register
Message-ID: <20200727141410.97113-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Hogan Wang <king.wang@huawei.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I am squashing this into save/restore pci host config register
patch - otherwise all versioned arches are broken.

---
 hw/core/machine.c | 1 +
 hw/i386/pc.c      | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 2f881d6d75..8d1a90c6cf 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -29,6 +29,7 @@
 #include "migration/vmstate.h"
 
 GlobalProperty hw_compat_5_0[] = {
+    { "pci-host-bridge", "x-config-reg-migration-enabled", "off" },
     { "virtio-balloon-device", "page-poison", "false" },
     { "vmport", "x-read-set-eax", "off" },
     { "vmport", "x-signal-unsupported-cmd", "off" },
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f6ff0c5514..47c5ca3e34 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -98,7 +98,6 @@
 #include "trace.h"
 
 GlobalProperty pc_compat_5_0[] = {
-    { "pci-host-bridge", "x-config-reg-migration-enabled", "off" },
 };
 const size_t pc_compat_5_0_len = G_N_ELEMENTS(pc_compat_5_0);
 
-- 
MST



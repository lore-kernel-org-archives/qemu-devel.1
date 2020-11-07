Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD859C388F7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 15:10:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48CF420719
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 15:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="CD2WAUCc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48CF420719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbPqv-0008Cy-98
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 10:10:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kbPpz-0007bT-Np
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 10:09:07 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:33148)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kbPpx-00015u-Qs
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 10:09:07 -0500
Received: by mail-pg1-x52b.google.com with SMTP id r186so3401704pgr.0
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 07:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FgUBNn/WeXuzZ0IJo7k8Qi0MsF8WLkO7uhitXmPP18o=;
 b=CD2WAUCcUIwwlBXIxnHesEYbpTSfW9en+HQXO+B1VNo3WbOF3izkdXDWFwQN96hr/9
 p1izN9/8fneQvm3MW+ZnZ8PMr/kzam7y5iyLSevFocvJZYnjPmfI6iolGNAmdfOnlaoh
 34yG9EqjD4JOcu/vxGu+II8HyU80NOKI1s58yFYCObtcSaodIoGdTwzidpQKt9MGPM/O
 metLrbu+hoGZWxGl6Trf8Sir4108BepprPoZgO2p/vbX8MGItkKvq9VyfuaPy+6s0t5y
 +OablTFRHWlM0/9+VuUBydFM2XMUKzDL+IM44pCZJwk7FqIyamS0yCPzehy77vdI0QkY
 tHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FgUBNn/WeXuzZ0IJo7k8Qi0MsF8WLkO7uhitXmPP18o=;
 b=l6kN49xg7s9g5GH30Tup3tWc3Qmf6r+QUWDxmdcoV4EOiN4xmiR1Ajkp3jMikXcPrB
 kq0MZkZUiVNTVqnbXogtchBTnz2TKljkzXfCWNe4jPjN870c0xzBVx5MYnxTennjxheG
 upMgM00NwVCzvsdoQ/j6lRV0CZHVkYunrqOadrpXTD78/lWZyneSLzxEt7ZGIpfXfEb9
 64VBpNp4IiFrM1eHXsJ1GqBdIvh/leoPSs7tqd/f64h9Z/cysV5Hi6qFb4QN2FhD8i4+
 bTciPb891frv6TrOj5WJEAzGrX3xbHY+a8Dz9SS0c5+tc43GDLGUeh4eVRrhGhlIw9JJ
 FGUg==
X-Gm-Message-State: AOAM532P5u1l0s3thVk9fjEq23WG+KABEDADpjJVdecWHQKwpch22TO+
 ouqoL3moevNgGkRL//cWmz+tkwCucJuNZg==
X-Google-Smtp-Source: ABdhPJxu1F6BILcFtzOG5nl/Qfnhsw8O5vHsPrHgjRw8pQenw00oTftwWratL5qKDxqcv6lYu6WGbA==
X-Received: by 2002:a63:fb11:: with SMTP id o17mr6117622pgh.109.1604761741661; 
 Sat, 07 Nov 2020 07:09:01 -0800 (PST)
Received: from localhost.localdomain ([115.96.136.129])
 by smtp.googlemail.com with ESMTPSA id
 d145sm6478308pfd.136.2020.11.07.07.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2020 07:09:00 -0800 (PST)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2] acpi-build: Fix maybe-uninitialized warning when ACPI
 hotplug is off
Date: Sat,  7 Nov 2020 20:38:51 +0530
Message-Id: <20201107150851.87008-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52b;
 envelope-from=ani@anisinha.ca; helo=mail-pg1-x52b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, mst@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>, philmd@redhat.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 This fixes the following warning (gcc 9.3.0 on Ubuntu):

  ../hw/i386/acpi-build.c: In function 'build_append_pci_bus_devices':
  ../hw/i386/acpi-build.c:496:9: error: 'method' may be used uninitialized
  in this function [-Werror=maybe-uninitialized]
    496 |         aml_append(parent_scope, method);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors

Fixes: df4008c9c59 ("piix4: don't reserve hw resources when hotplug is off globally")
Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 hw/i386/acpi-build.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 4f66642d88..79b86d4a36 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -349,7 +349,7 @@ static void build_append_pcihp_notify_entry(Aml *method, int slot)
 static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
                                          bool pcihp_bridge_en)
 {
-    Aml *dev, *notify_method = NULL, *method;
+    Aml *dev, *notify_method = NULL, *method = NULL;
     QObject *bsel;
     PCIBus *sec;
     int i;
@@ -492,7 +492,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
         }
     }
 
-    if (bsel || pcihp_bridge_en) {
+    if (method) {
         aml_append(parent_scope, method);
     }
     qobject_unref(bsel);
-- 
2.25.1



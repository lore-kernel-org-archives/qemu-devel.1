Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569DBC388F7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 19:41:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2C2A2087E
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 19:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATouQogl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C2A2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbU5w-0006ZU-Sh
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 14:41:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbU52-00065s-TL
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 14:40:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23529)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbU4y-0000i0-Jd
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 14:40:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604778051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AQZWhvSbI5p4N1e0B4bgocntEDGXJm7E/SmoI1MVHIY=;
 b=ATouQoglAer5+3b/sCJgDPDswjEA6lB7TWE8Rb/3q9uYIT29nLGBmKr0PL8ka4QEbkCTpG
 17P6o40SwnyscuYO9l1iPxP2UdJvLHIpESxLsZAk84hNNhrUZccNsVGqja2EBozV+CTv0k
 8aV67rffyXu79CBBwmRQqTJIVLCqZGU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-InncbzfgNZum28zY_Bk9pA-1; Sat, 07 Nov 2020 14:40:50 -0500
X-MC-Unique: InncbzfgNZum28zY_Bk9pA-1
Received: by mail-wm1-f69.google.com with SMTP id z62so1952054wmb.1
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 11:40:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AQZWhvSbI5p4N1e0B4bgocntEDGXJm7E/SmoI1MVHIY=;
 b=YJDTJ2Zu7VpVDmm5g5dBbv/PUmtFTqAJjagnNFH2DSlHTdxfn2ombB12yOf30Qujtt
 dh+BDYfCiIomuZ7YFdZBCIH/gckySsias6Xj5ecpz3DxKbCOsggo6qH8KzyDvuh5VRBg
 xrF5gA/zAzG7tzucK8EzMPZb6uk5H0TNZMR/fcxL5eJxPubls7HEYsqiqzX/46IX4ZeB
 JX0X5Lbc0Cl1iTH9jGF/wbTA7QJqpKN0xxALjhRH0n36aWyBoxwhVd2OXTbLagiKj8Wd
 7iPIv3AWkRMT6NrfRcD2HSjE71CiuPRGnsYvKaaIAyxMt4qESVj9M4V5/lDi63EnW5MT
 FbMg==
X-Gm-Message-State: AOAM533Rzj4GvC66kBqC3nuaCU5DFaJbzCE9frZvD77qQnq+4havcuMA
 ZHSQbBTEtixks/fqzmVP5LO/XQb0WXrsX8qK/kOTb0KhRMnTPmjmAPld6yf4Ex+46/5KdKN8EWx
 qE3mB/JrNpN7GQrk=
X-Received: by 2002:adf:f3d2:: with SMTP id g18mr65217wrp.77.1604778048612;
 Sat, 07 Nov 2020 11:40:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwDSVt8lASy3Eq82HgII3vyyx1qJw3kYKfbLzY7KY7t3FE3ihO3HV4byqp1ONSTKCXfIYdqJg==
X-Received: by 2002:adf:f3d2:: with SMTP id g18mr65196wrp.77.1604778048420;
 Sat, 07 Nov 2020 11:40:48 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id t7sm7194233wrx.42.2020.11.07.11.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2020 11:40:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2] hw/i386/acpi-build: Fix maybe-uninitialized error
 when ACPI hotplug off
Date: Sat,  7 Nov 2020 20:40:45 +0100
Message-Id: <20201107194045.438027-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/07 14:38:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <ani@anisinha.ca>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

GCC 9.3.0 thinks that 'method' can be left uninitialized. This code
is already in the "if (bsel || pcihp_bridge_en)" block statement,
but it isn't smart enough to figure it out.

Restrict the code to be used only in the "if (bsel || pcihp_bridge_en)"
block statement to fix (on Ubuntu):

  ../hw/i386/acpi-build.c: In function 'build_append_pci_bus_devices':
  ../hw/i386/acpi-build.c:496:9: error: 'method' may be used uninitialized
  in this function [-Werror=maybe-uninitialized]
    496 |         aml_append(parent_scope, method);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors

Fixes: df4008c9c59 ("piix4: don't reserve hw resources when hotplug is off globally")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/i386/acpi-build.c | 45 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 4f66642d887..1f5c2112452 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -465,34 +465,31 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
      */
     if (bsel || pcihp_bridge_en) {
         method = aml_method("PCNT", 0, AML_NOTSERIALIZED);
-    }
-    /* If bus supports hotplug select it and notify about local events */
-    if (bsel) {
-        uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
 
-        aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
-        aml_append(method,
-            aml_call2("DVNT", aml_name("PCIU"), aml_int(1) /* Device Check */)
-        );
-        aml_append(method,
-            aml_call2("DVNT", aml_name("PCID"), aml_int(3)/* Eject Request */)
-        );
-    }
+        /* If bus supports hotplug select it and notify about local events */
+        if (bsel) {
+            uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
 
-    /* Notify about child bus events in any case */
-    if (pcihp_bridge_en) {
-        QLIST_FOREACH(sec, &bus->child, sibling) {
-            int32_t devfn = sec->parent_dev->devfn;
-
-            if (pci_bus_is_root(sec) || pci_bus_is_express(sec)) {
-                continue;
-            }
-
-            aml_append(method, aml_name("^S%.02X.PCNT", devfn));
+            aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
+            aml_append(method, aml_call2("DVNT", aml_name("PCIU"),
+                                         aml_int(1))); /* Device Check */
+            aml_append(method, aml_call2("DVNT", aml_name("PCID"),
+                                         aml_int(3))); /* Eject Request */
+        }
+
+        /* Notify about child bus events in any case */
+        if (pcihp_bridge_en) {
+            QLIST_FOREACH(sec, &bus->child, sibling) {
+                int32_t devfn = sec->parent_dev->devfn;
+
+                if (pci_bus_is_root(sec) || pci_bus_is_express(sec)) {
+                    continue;
+                }
+
+                aml_append(method, aml_name("^S%.02X.PCNT", devfn));
+            }
         }
-    }
 
-    if (bsel || pcihp_bridge_en) {
         aml_append(parent_scope, method);
     }
     qobject_unref(bsel);
-- 
2.26.2



Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579E9C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 19:46:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A4C920659
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 19:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4C920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsY55-0006gz-Bl
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 15:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59496)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hsY4T-0005n5-VU
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 15:46:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hsY4S-0004eB-VF
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 15:46:05 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:36925)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hsY4S-0004d2-RG
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 15:46:04 -0400
Received: by mail-vs1-f53.google.com with SMTP id v6so44484804vsq.4
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 12:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=q7E3EbLwQUaenvATGLNQkhPK0iKIF+d1BK+jvx4Gi8o=;
 b=mO/KzY8tLRGl4BwyVczjAnsIav5zcSUjI2pw1NY5Vuo5NfdTZajqRU01e2TDPgPW83
 8tJdHtqZ9/VpBf/l6QgoX+EImoX0eklxI2iDOlVtB3wDgKFRMNUcoE1PaT9YAF1XmonX
 DRXY7dzotTpv235FdC6bJRz6cwjJI3h1TbpMlVsABSRiDqZTbm/jQps7w6ABWcs6q9JL
 ggV0AoonhF4JHev39xBErK/uyNVRyp0v1UwRaksTUm1uuicwSddeLR83frhYchvApzqr
 OaOfSGiYGG9XwMlDcZV4ZqQXgm+odeMio+hJtEduLPfBR3TTYDDi1Q4qYGdrza48qd61
 A+zA==
X-Gm-Message-State: APjAAAWTlCLFcvkVAptfan1wbV1L+mnLfrFDXvtT6/jz/eUah6W4+ZNC
 jCx3d27uTh0U5cmqk3y/6nCyWLyxsS9QlQ==
X-Google-Smtp-Source: APXvYqzB/fDHrf9O5Qad4aodtHM1TzSN46JwtF8y6I7PoiqsODNeuIbZU4Z872QqDzpSvvjds7G8zQ==
X-Received: by 2002:a05:6102:105a:: with SMTP id
 h26mr80455865vsq.185.1564515963801; 
 Tue, 30 Jul 2019 12:46:03 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 f140sm48856458vka.36.2019.07.30.12.46.00
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 12:46:02 -0700 (PDT)
Date: Tue, 30 Jul 2019 15:45:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190730093719.12958-2-dgilbert@redhat.com>
References: <20190730194519.3689-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190730194519.3689-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.217.53
Subject: [Qemu-devel] [PULL 1/2] pcie_root_port: Allow ACS to be disabled
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190730194558.JsFYg9CxvKhAv43tztQxHDFUlhsY5iljDrPlrgYFnEY@z>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

ACS was added in 4.0 unconditionally, this breaks migration
compatibility.
Allow ACS to be disabled by adding a property that's
checked by pcie_root_port.

Unfortunately pcie-root-port doesn't have any instance data,
so there's no where for that flag to live, so stuff it into
PCIESlot.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190730093719.12958-2-dgilbert@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci-bridge/pcie_root_port.c | 3 ++-
 include/hw/pci/pcie_port.h     | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index 09019ca05d..1d8a778709 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -111,7 +111,7 @@ static void rp_realize(PCIDevice *d, Error **errp)
     pcie_aer_root_init(d);
     rp_aer_vector_update(d);
 
-    if (rpc->acs_offset) {
+    if (rpc->acs_offset && !s->disable_acs) {
         pcie_acs_init(d, rpc->acs_offset);
     }
     return;
@@ -145,6 +145,7 @@ static void rp_exit(PCIDevice *d)
 static Property rp_props[] = {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
+    DEFINE_PROP_BOOL("disable-acs", PCIESlot, disable_acs, false),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index 09586f4641..7515430087 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -53,6 +53,8 @@ struct PCIESlot {
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
 
+    /* Disable ACS (really for a pcie_root_port) */
+    bool        disable_acs;
     QLIST_ENTRY(PCIESlot) next;
 };
 
-- 
MST



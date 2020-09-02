Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810C7C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F5D20767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2UUK5HN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F5D20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbjM-0001eW-D2
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 18:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbUv-0003t0-AV
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:44:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58680
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbUt-0008TR-5N
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YTkyBykFkXbbk86GGkCUTC7xRyB9nfmDNLeqhsrCO9M=;
 b=P2UUK5HNeeee/r8sv6K92gWj66HbvAV+c4DvAtHQ8ASHggj98Rgz4lp1+zE8t6pjfAc8Ir
 XesXk2Bfyrb80uAIfQkgiJxi1n+oIml1zhPphIhGZVSJIoF3IMdfEJwGS4cDBD/cZxFQTu
 NZVVYq0v7uICszAG/Gm9CP8adnS2siM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-JivF25oUPYKVwEA8vXah_g-1; Wed, 02 Sep 2020 18:44:52 -0400
X-MC-Unique: JivF25oUPYKVwEA8vXah_g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCE971074642
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 22:44:51 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 85F44100EBBE;
 Wed,  2 Sep 2020 22:44:51 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 36/63] can: Rename PCM3680i_PCI_DEV to PCM3680_PCI
Date: Wed,  2 Sep 2020 18:42:44 -0400
Message-Id: <20200902224311.1321159-37-ehabkost@redhat.com>
In-Reply-To: <20200902224311.1321159-1-ehabkost@redhat.com>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 17:27:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Jason Wang <jasowang@redhat.com>, berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the type checking macro name consistent with the TYPE_*
constant.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/net/can/can_pcm3680_pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/net/can/can_pcm3680_pci.c b/hw/net/can/can_pcm3680_pci.c
index 530cd04a5d..cb9db3c322 100644
--- a/hw/net/can/can_pcm3680_pci.c
+++ b/hw/net/can/can_pcm3680_pci.c
@@ -44,7 +44,7 @@
 #define TYPE_PCM3680_PCI "pcm3680_pci"
 
 typedef struct Pcm3680iPCIState Pcm3680iPCIState;
-DECLARE_INSTANCE_CHECKER(Pcm3680iPCIState, PCM3680i_PCI_DEV,
+DECLARE_INSTANCE_CHECKER(Pcm3680iPCIState, PCM3680_PCI,
                          TYPE_PCM3680_PCI)
 
 /* the PCI device and vendor IDs */
@@ -76,7 +76,7 @@ struct Pcm3680iPCIState {
 
 static void pcm3680i_pci_reset(DeviceState *dev)
 {
-    Pcm3680iPCIState *d = PCM3680i_PCI_DEV(dev);
+    Pcm3680iPCIState *d = PCM3680_PCI(dev);
     int i;
 
     for (i = 0; i < PCM3680i_PCI_SJA_COUNT; i++) {
@@ -156,7 +156,7 @@ static const MemoryRegionOps pcm3680i_pci_sja2_io_ops = {
 
 static void pcm3680i_pci_realize(PCIDevice *pci_dev, Error **errp)
 {
-    Pcm3680iPCIState *d = PCM3680i_PCI_DEV(pci_dev);
+    Pcm3680iPCIState *d = PCM3680_PCI(pci_dev);
     uint8_t *pci_conf;
     int i;
 
@@ -190,7 +190,7 @@ static void pcm3680i_pci_realize(PCIDevice *pci_dev, Error **errp)
 
 static void pcm3680i_pci_exit(PCIDevice *pci_dev)
 {
-    Pcm3680iPCIState *d = PCM3680i_PCI_DEV(pci_dev);
+    Pcm3680iPCIState *d = PCM3680_PCI(pci_dev);
     int i;
 
     for (i = 0; i < PCM3680i_PCI_SJA_COUNT; i++) {
@@ -217,7 +217,7 @@ static const VMStateDescription vmstate_pcm3680i_pci = {
 
 static void pcm3680i_pci_instance_init(Object *obj)
 {
-    Pcm3680iPCIState *d = PCM3680i_PCI_DEV(obj);
+    Pcm3680iPCIState *d = PCM3680_PCI(obj);
 
     object_property_add_link(obj, "canbus0", TYPE_CAN_BUS,
                              (Object **)&d->canbus[0],
-- 
2.26.2



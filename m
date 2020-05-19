Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B880C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:00:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A4FE20825
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TMsD5Aea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4FE20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb3jS-0002Ao-9D
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3ez-00015y-CK
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28932
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3ey-0003UN-8b
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589900159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uygfuq9qutNukd4dKNLLsVjlqjhCsSD4Bsytkavs1ug=;
 b=TMsD5Aea9DT+ZjVkP0u+Ek31AZaPMeM8AMp3/BZ6cAuAcf8RGEfJC8DQ797FvRSovVsFsm
 UmGbcObnStH/MkTthMlsPEkqLC13+xRuq2WqLa7CNSKwHl7BUkvCZQRbkfvLf4DEdtZs9P
 Aq9GM4F/VVCHDNzIQKlByU9XTy3pYsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-_kfN5gwBPem9MC1sRYf93g-1; Tue, 19 May 2020 10:55:57 -0400
X-MC-Unique: _kfN5gwBPem9MC1sRYf93g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1A4C1855A06
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 14:55:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AEC5810027A5;
 Tue, 19 May 2020 14:55:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0402A11358D1; Tue, 19 May 2020 16:55:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 20/55] isa: isa_create(), isa_try_create() are now unused, drop
Date: Tue, 19 May 2020 16:55:16 +0200
Message-Id: <20200519145551.22836-21-armbru@redhat.com>
In-Reply-To: <20200519145551.22836-1-armbru@redhat.com>
References: <20200519145551.22836-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:56:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/hw/isa/isa.h |  2 --
 hw/isa/isa-bus.c     | 16 ----------------
 2 files changed, 18 deletions(-)

diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index 3b6215fafe..52b61eed88 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -103,8 +103,6 @@ void isa_bus_dma(ISABus *bus, IsaDma *dma8, IsaDma *dma16);
 IsaDma *isa_get_dma(ISABus *bus, int nchan);
 MemoryRegion *isa_address_space(ISADevice *dev);
 MemoryRegion *isa_address_space_io(ISADevice *dev);
-ISADevice *isa_create(ISABus *bus, const char *name);
-ISADevice *isa_try_create(ISABus *bus, const char *name);
 ISADevice *isa_new(const char *name);
 ISADevice *isa_try_new(const char *name);
 bool isa_realize_and_unref(ISADevice *dev, ISABus *bus, Error **errp);
diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 9a95ac3f96..630985604d 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -160,22 +160,6 @@ static void isa_device_init(Object *obj)
     dev->isairq[1] = -1;
 }
 
-ISADevice *isa_create(ISABus *bus, const char *name)
-{
-    DeviceState *dev;
-
-    dev = qdev_create(BUS(bus), name);
-    return ISA_DEVICE(dev);
-}
-
-ISADevice *isa_try_create(ISABus *bus, const char *name)
-{
-    DeviceState *dev;
-
-    dev = qdev_try_create(BUS(bus), name);
-    return ISA_DEVICE(dev);
-}
-
 ISADevice *isa_new(const char *name)
 {
     return ISA_DEVICE(qdev_new(name));
-- 
2.21.1



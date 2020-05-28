Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA1EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:08:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBDE52088E
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5lHOaTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBDE52088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeGOP-0003IU-48
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 07:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jeGLF-0005h5-OD
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:04:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52492
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jeGLD-0006e0-AU
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590663890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NToz3l3XRw+n9Z3WCBBOA+fw4xgEX+UBDn67/TKP84Y=;
 b=X5lHOaTNh8Hxdo3VFow6D8OVI9kjnbzCk7Aqd70trUhdWpilme49i0tVkMwW4D/31xKu05
 VmU2Ko3gKvSh3Djm9tO4jaQMuF7reMQcY/d1+Q3susyWHxVpyoWZQH3C6fWHrrtQ15bEJr
 1+zI4FoISfDZ2qzWN627vhc8NCU7JOE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-Etpn7hs_Nui_Pcodpv15WQ-1; Thu, 28 May 2020 07:04:48 -0400
X-MC-Unique: Etpn7hs_Nui_Pcodpv15WQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D589B1009440;
 Thu, 28 May 2020 11:04:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A29091001B0B;
 Thu, 28 May 2020 11:04:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C8F7D11358BC; Thu, 28 May 2020 13:04:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/24] armv7m: Delete unused "ARM,bitband-memory" devices
Date: Thu, 28 May 2020 13:04:26 +0200
Message-Id: <20200528110444.20456-7-armbru@redhat.com>
In-Reply-To: <20200528110444.20456-1-armbru@redhat.com>
References: <20200528110444.20456-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 01:51:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, qemu-arm@nongnu.org, berrange@redhat.com,
 ehabkost@redhat.com, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These devices are optional, and enabled by property "enable-bitband".
armv7m_instance_init() creates them unconditionally, because the
property has not been set then.  armv7m_realize() realizes them only
when the property is true.  Works, although it leaves unrealized
devices hanging around in the QOM composition tree.  Affects machines
microbit, mps2-an505, mps2-an521, musca-a, and musca-b1.

Delete the unused devices by making armv7m_realize() unparent them.
Visible in "info qom-tree"; here's the change for microbit:

     /machine (microbit-machine)
       /microbit.twi (microbit.i2c)
         /microbit.twi[0] (qemu:memory-region)
       /nrf51 (nrf51-soc)
         /armv6m (armv7m)
           /armv7m-container[0] (qemu:memory-region)
    -      /bitband[0] (ARM,bitband-memory)
    -        /bitband[0] (qemu:memory-region)
    -      /bitband[1] (ARM,bitband-memory)
    -        /bitband[0] (qemu:memory-region)
           /cpu (cortex-m0-arm-cpu)

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/arm/armv7m.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 7da57f56d3..f930619f53 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -245,8 +245,8 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->container, 0xe000e000,
                                 sysbus_mmio_get_region(sbd, 0));
 
-    if (s->enable_bitband) {
-        for (i = 0; i < ARRAY_SIZE(s->bitband); i++) {
+    for (i = 0; i < ARRAY_SIZE(s->bitband); i++) {
+        if (s->enable_bitband) {
             Object *obj = OBJECT(&s->bitband[i]);
             SysBusDevice *sbd = SYS_BUS_DEVICE(&s->bitband[i]);
 
@@ -265,6 +265,8 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
 
             memory_region_add_subregion(&s->container, bitband_output_addr[i],
                                         sysbus_mmio_get_region(sbd, 0));
+        } else {
+            object_unparent(OBJECT(&s->bitband[i]));
         }
     }
 }
-- 
2.21.3



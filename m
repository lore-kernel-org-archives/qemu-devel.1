Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F71C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:54:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BB9722DD3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="G/MeHLaH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB9722DD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Ts4-0001We-Hj
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 12:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1i0Ta6-0007rD-LL
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1i0Ta5-0006Bc-Dl
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:35:30 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:36492)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1i0Ta5-0006Ae-5c
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:35:29 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id DC66D96F54;
 Wed, 21 Aug 2019 16:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1566405328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IoXWqtvBGWyNCiBvyV0lKqkzc+865svTakM6A2Tn4Wk=;
 b=G/MeHLaH4aAjNQudwW3sXabdf2FzcsahvfF33SALhn2jSgXXDnFsgr5W4Zxmw5vZfZ7+l1
 wKumm0o2gYn2vBUw2zGlrUIq8EjX95fho8iBq1nkPaXKPn/H+FxDQCh8RG4ew4eRiaoFJO
 XW7EqGwzpS2/dWTwzPZFDoCCJHNtVRk=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 18:33:40 +0200
Message-Id: <20190821163341.16309-10-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821163341.16309-1-damien.hedde@greensocs.com>
References: <20190821163341.16309-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1566405328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IoXWqtvBGWyNCiBvyV0lKqkzc+865svTakM6A2Tn4Wk=;
 b=OLi8yLSbTEHnvGY6grGbLGGgzTuR4VU0EJxNEhluRs6/WFlqje4iQcdy8ye2tTgkeBMN6x
 ltIj5ttoqJhPtHVKAfYxthFz6GSypZR9MlZ8V+C9lREJH4RETEoQlmmF2q7WoTpFx7GWT3
 R9ogOklrt4xhn9D+fJ+I+Fd8eBcSZPw=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1566405328; a=rsa-sha256; cv=none;
 b=597dorltUPx5uesqcLQCv6daraqUYiPE46pTVlnjKi0Gb6RmAwl4fJkJMGm4a0R7ePNpHf
 +nPHru8zyO3aR2nuT1ozHx7H0FoXpup7TR1Ye3IIdt7s6173dNsDesCUOsxDWw9avRGs8z
 YWRHRDSy9RUxHLu5Gkerr0uRX7ASnJI=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v4 09/10] hw/core/: add warm reset helpers for
 devices and buses
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, peter.maydell@linaro.org,
 edgar.iglesias@xilinx.com, berrange@redhat.com, ehabkost@redhat.com,
 mark.burton@greensocs.com, pbonzini@redhat.com, philmd@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This add helpers to trigger warm reset and to retrieve the
reset current reset type.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/core/bus.c          | 11 +++++++++++
 hw/core/qdev.c         | 11 +++++++++++
 include/hw/qdev-core.h | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/hw/core/bus.c b/hw/core/bus.c
index 3be65ad041..b245fd6937 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -74,11 +74,22 @@ void bus_cold_reset(BusState *bus)
     resettable_reset(OBJECT(bus), RESET_TYPE_COLD);
 }
=20
+void bus_warm_reset(BusState *bus)
+{
+    resettable_reset(OBJECT(bus), RESET_TYPE_WARM);
+}
+
 bool bus_is_resetting(BusState *bus)
 {
     return resettable_is_resetting(OBJECT(bus));
 }
=20
+bool bus_test_reset_type(BusState *bus, ResetType type)
+{
+    ResetType cur_type =3D resettable_get_type(OBJECT(bus));
+    return (cur_type & type);
+}
+
 static ResetState *bus_get_reset_state(Object *obj)
 {
     BusState *bus =3D BUS(obj);
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 1638bc9f3b..9095f2b9c1 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -281,11 +281,22 @@ void device_cold_reset(DeviceState *dev)
     resettable_reset(OBJECT(dev), RESET_TYPE_COLD);
 }
=20
+void device_warm_reset(DeviceState *dev)
+{
+    resettable_reset(OBJECT(dev), RESET_TYPE_WARM);
+}
+
 bool device_is_resetting(DeviceState *dev)
 {
     return resettable_is_resetting(OBJECT(dev));
 }
=20
+bool device_test_reset_type(DeviceState *dev, ResetType type)
+{
+    ResetType cur_type =3D resettable_get_type(OBJECT(dev));
+    return (cur_type & type);
+}
+
 static ResetState *device_get_reset_state(Object *obj)
 {
     DeviceState *dev =3D DEVICE(obj);
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 2976121fbc..eb11f0f801 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -422,18 +422,52 @@ void device_cold_reset(DeviceState *dev);
  */
 void bus_cold_reset(BusState *bus);
=20
+/**
+ * device_warm_reset:
+ * Trigger a warm reset of the device @dev.
+ *
+ * Use the Resettable interface (see hw/interface.h); it also reset the
+ * device's qdev/qbus subtree.
+ */
+void device_warm_reset(DeviceState *dev);
+
+/**
+ * bus_warm_reset:
+ * Trigger a warm reset of the bus @bus.
+ *
+ * Use the Resettable interface (see hw/interface.h); it also reset the
+ * bus's qdev/qbus subtree.
+ */
+void bus_warm_reset(BusState *bus);
+
 /**
  * device_is_resetting:
  * Return true if the device @dev is currently being reset.
  */
 bool device_is_resetting(DeviceState *dev);
=20
+/**
+ * device_test_reset_type:
+ * Return true if the device @dev is currently under reset type
+ * @type.
+ * Only valid if device_is_resetting() is true
+ */
+bool device_test_reset_type(DeviceState *dev, ResetType type);
+
 /**
  * bus_is_resetting:
  * Return true if the bus @bus is currently being reset.
  */
 bool bus_is_resetting(BusState *bus);
=20
+/**
+ * bus_test_reset_type:
+ * Return true if the bus @bus is currently under reset type
+ * @type.
+ * Only valid if device_is_resetting() is true
+ */
+bool bus_test_reset_type(BusState *bus, ResetType type);
+
 /* This should go away once we get rid of the NULL bus hack */
 BusState *sysbus_get_default(void);
=20
--=20
2.22.0



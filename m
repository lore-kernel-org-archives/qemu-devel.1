Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0EDC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:23:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACF05214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDqVCsK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF05214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzoBu-0007ld-Ck
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 16:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1hzo5m-0007fF-KN
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:17:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1hzo5h-0003Il-DN
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:17:26 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37921)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1hzo5h-0003Hk-82
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:17:21 -0400
Received: by mail-ot1-x342.google.com with SMTP id r20so2890035ota.5
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 13:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jUXKUx2rlhtSYtdwrDHi7sGJBmXjmywSAXncINa39yo=;
 b=eDqVCsK/RmBweQxSR1xnD2nPDADp2Ym7Bt2zF0KrcLUS4kp0K9agPqZKXZ2VjprU4x
 pyOWEXhJjj3wj96RZvvZaJFIh0LXnAjxLco5OY3R4AINyIodWJK9LjOh/3URnLuPVHRr
 adJxKC53WunpFz20N5NeuhwBcdc2Vz415pob9snoJPkfVnmbI4lNfbK9oRk4nr+Y8nNE
 hyJQffxmQXpKfbjh+6LOtYAF8wS+jWplAl/h3v/MFtd/lsQ1+tga8RECyKZmVhIokZsC
 vt+IM7MkgWhKO585Gb6JbfilwtTOqxt0+9chH1El6T53ejTkDKx1WruVvZwf4+rEnOhL
 TdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=jUXKUx2rlhtSYtdwrDHi7sGJBmXjmywSAXncINa39yo=;
 b=PJ8puFQ7y/x8V08cL5GJYNWC5g85g3cMvFos5Olv54HiStPQQQlTRepcLeLFZvRV+1
 RORcKLq9hhFXX7msRVs36GOm5tAnUBXUgs3bP007n2EbNwDCUsKBzcFMjRgUu5iRFxX3
 rEQ6gzspdeetT62k2jNEkZnHYwcohoO86Ukbvh6PcWJbAkHldg9h521Dql+H2/Jk4uvO
 36wamFjRv9wJbS+H+pLMReeBY2iLNUKRBuW2ozl1qnjc2hT7QJxZEUu6xts9xC0W+SgN
 nkdm8vqs9O42V/Ji3ICNIcebA/2Xtho2PMag8OyWrYoGUbRieiB7tE8eeGjIMzvDhN6B
 yEJQ==
X-Gm-Message-State: APjAAAUYXM4YnzMtt9JJoEN+iezhmg8yS9ntEUF6Z22NwyLxL3FUatV6
 z16bjv0dbNbZWMN/qMLYf64Fh+E=
X-Google-Smtp-Source: APXvYqwMViOpla/RD1O4NEFKsFOau+6jhGJp4rcDXvMqvE6W0paOD2GthLlRuab4sRtVij6bTHr96g==
X-Received: by 2002:a9d:7c97:: with SMTP id q23mr19661059otn.271.1566245839716; 
 Mon, 19 Aug 2019 13:17:19 -0700 (PDT)
Received: from serve.minyard.net ([47.184.134.43])
 by smtp.gmail.com with ESMTPSA id r2sm5743452otk.49.2019.08.19.13.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 13:17:19 -0700 (PDT)
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
 by serve.minyard.net (Postfix) with ESMTPA id 494651805AB;
 Mon, 19 Aug 2019 20:17:17 +0000 (UTC)
Received: by t430.minyard.net (Postfix, from userid 1000)
 id 13EF4301176; Mon, 19 Aug 2019 15:17:16 -0500 (CDT)
From: minyard@acm.org
To: QEMU Developers <qemu-devel@nongnu.org>
Date: Mon, 19 Aug 2019 15:16:56 -0500
Message-Id: <20190819201705.31633-7-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819201705.31633-1-minyard@acm.org>
References: <20190819201705.31633-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: [Qemu-devel] [PATCH 06/15] ipmi: Add a UUID device property
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Corey Minyard <cminyard@mvista.com>

Using the UUID that qemu generates probably isn't the best thing
to do, allow it to be passed in via properties, and use QemuUUID
for the type.

If the UUID is not set, return an unsupported command error.  This
way we are not providing an all-zero (or randomly generated) GUID
to the IPMI user.  This lets the host fall back to the other
method of using the get device id command to determind the BMC
being accessed.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Cédric Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ipmi/ipmi_bmc_sim.c | 22 ++++++++++++++--------
 qemu-options.hx        | 10 +++++++---
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 6e6cd1b47d..71e56f3b13 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -223,7 +223,7 @@ struct IPMIBmcSim {
     uint8_t restart_cause;
 
     uint8_t acpi_power_state[2];
-    uint8_t uuid[16];
+    QemuUUID uuid;
 
     IPMISel sel;
     IPMISdr sdr;
@@ -941,8 +941,19 @@ static void get_device_guid(IPMIBmcSim *ibs,
 {
     unsigned int i;
 
+    /* An uninitialized uuid is all zeros, use that to know if it is set. */
     for (i = 0; i < 16; i++) {
-        rsp_buffer_push(rsp, ibs->uuid[i]);
+        if (ibs->uuid.data[i]) {
+            goto uuid_set;
+        }
+    }
+    /* No uuid is set, return an error. */
+    rsp_buffer_set_error(rsp, IPMI_CC_INVALID_CMD);
+    return;
+
+ uuid_set:
+    for (i = 0; i < 16; i++) {
+        rsp_buffer_push(rsp, ibs->uuid.data[i]);
     }
 }
 
@@ -1986,12 +1997,6 @@ static void ipmi_sim_realize(DeviceState *dev, Error **errp)
     ibs->acpi_power_state[0] = 0;
     ibs->acpi_power_state[1] = 0;
 
-    if (qemu_uuid_set) {
-        memcpy(&ibs->uuid, &qemu_uuid, 16);
-    } else {
-        memset(&ibs->uuid, 0, 16);
-    }
-
     ipmi_init_sensors_from_sdrs(ibs);
     register_cmds(ibs);
 
@@ -2011,6 +2016,7 @@ static Property ipmi_sim_properties[] = {
     DEFINE_PROP_UINT8("fwrev2", IPMIBmcSim, fwrev2, 0),
     DEFINE_PROP_UINT32("mfg_id", IPMIBmcSim, mfg_id, 0),
     DEFINE_PROP_UINT16("product_id", IPMIBmcSim, product_id, 0),
+    DEFINE_PROP_UUID_NODEFAULT("guid", IPMIBmcSim, uuid),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 9621e934c0..a082e99b49 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -701,7 +701,7 @@ possible drivers and properties, use @code{-device help} and
 @code{-device @var{driver},help}.
 
 Some drivers are:
-@item -device ipmi-bmc-sim,id=@var{id}[,slave_addr=@var{val}][,sdrfile=@var{file}][,furareasize=@var{val}][,furdatafile=@var{file}]
+@item -device ipmi-bmc-sim,id=@var{id}[,slave_addr=@var{val}][,sdrfile=@var{file}][,furareasize=@var{val}][,furdatafile=@var{file}][,guid=@var{uuid}]
 
 Add an IPMI BMC.  This is a simulation of a hardware management
 interface processor that normally sits on a system.  It provides
@@ -714,8 +714,8 @@ controllers.  If you don't know what this means, it is safe to ignore
 it.
 
 @table @option
-@item bmc=@var{id}
-The BMC to connect to, one of ipmi-bmc-sim or ipmi-bmc-extern above.
+@item id=@var{id}
+The BMC id for interfaces to use this device.
 @item slave_addr=@var{val}
 Define slave address to use for the BMC.  The default is 0x20.
 @item sdrfile=@var{file}
@@ -724,6 +724,10 @@ file containing raw Sensor Data Records (SDR) data. The default is none.
 size of a Field Replaceable Unit (FRU) area.  The default is 1024.
 @item frudatafile=@var{file}
 file containing raw Field Replaceable Unit (FRU) inventory data. The default is none.
+@item guid=@var{uuid}
+value for the GUID for the BMC, in standard UUID format.  If this is set,
+get "Get GUID" command to the BMC will return it.  Otherwise "Get GUID"
+will return an error.
 @end table
 
 @item -device ipmi-bmc-extern,id=@var{id},chardev=@var{id}[,slave_addr=@var{val}]
-- 
2.17.1



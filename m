Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C19AC48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 12:51:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C6F12083B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 12:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msWzvICk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C6F12083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgTsB-0000ip-9h
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 08:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53779)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tcminyard@gmail.com>) id 1hgTpa-0006yD-Jq
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:48:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1hgTpT-0003iN-7n
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:48:50 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41729)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1hgTpS-0003VB-Eg
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:48:42 -0400
Received: by mail-ot1-x341.google.com with SMTP id o101so1804089ota.8
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 05:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Mz9dF6CfjXk0LN/K2yMNd+TDsCbwVvqlvyyMEh6FyjY=;
 b=msWzvICk5j80hHbSqdIw289EZ1tX19kLPYhQUNfaCcmXmPOztCB4VMgbEQRtPXJg/j
 1x2iOBDgAdJXZUUz2p4B5A64lkWZ5k4EWMWv9c1GxWpwBw6gPRAC9qJ+HZUYdCqSNBO3
 50gmPKR7M9RfCQPFTRyNpD+eTa46VCe/4x3uqlZmmNy0t4P4y9TRHXiNu74El7/i2saZ
 xHbh0ebeTGPV4R+UrRsCXw0F9TcFRBT4eat+tQo184Z83jUVOzpkMto/uNfaDppHv/vh
 quBbCR9TUIM8Uihz/rb4IJOFp8Z/5+SHUsS9mCX5MuIh1dbJw9TFEDgT4zrz1ige88bd
 M2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Mz9dF6CfjXk0LN/K2yMNd+TDsCbwVvqlvyyMEh6FyjY=;
 b=ijk7h7cYl3Eha1W/9BLjmvCKQj5Je3EuXTsij8ozj3PUww7NQwXKDQnHmlTBdzILTc
 Kb5AwdpVwtFcbHJDLgJjR591+5oJDkKiM2kslWvN4EUOh9j/03JR0GZyCoqvkpsWOcNB
 p2jEopPjUfnyFEnhxIdcwWXzChevi5snzVxdvpbC/1wT6J5TzRrmRlruaLlc9E5s0Q0y
 belImUGpqHlyAPvwbgZWXa41RM04X5s06L/vStKeI72lYb7pbrjkJNP9YnLycda9YSuQ
 Qw44w4O2hvVbdA+IZ1QdQL63JQceSF41pgsuT4LQA7zeTaK1JpW80938JVhcIN9YTB4q
 mgYQ==
X-Gm-Message-State: APjAAAWZBKRNShpkKBg3mDL8iiRAm1ZH5B8e5yJ2XIxrC4xcfd7uN4Yk
 Lk6dcXKTxYlLAgwxkGd02w==
X-Google-Smtp-Source: APXvYqy09B3i+xYJ9zBuQMp1BfP2ey27Iujhn13Uryy8r2EcS8ylU8dYPCpoWOo00SCOZ8SU6G2ukQ==
X-Received: by 2002:a05:6830:199:: with SMTP id
 q25mr560546ota.79.1561639706247; 
 Thu, 27 Jun 2019 05:48:26 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id t6sm703428otk.36.2019.06.27.05.48.25
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 27 Jun 2019 05:48:25 -0700 (PDT)
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
 by serve.minyard.net (Postfix) with ESMTPA id 858D21800CD;
 Thu, 27 Jun 2019 12:48:24 +0000 (UTC)
Received: by t430.minyard.net (Postfix, from userid 1000)
 id 322BA302315; Thu, 27 Jun 2019 07:48:24 -0500 (CDT)
From: minyard@acm.org
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Jun 2019 07:48:15 -0500
Message-Id: <20190627124815.29536-3-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190627124815.29536-1-minyard@acm.org>
References: <20190627124815.29536-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: [Qemu-devel] [PULL 2/2] ipmi: Add a UUID device property
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
 QEMU Developers <qemu-devel@nongnu.org>,
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
index 1980536517..007e2c6588 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -221,7 +221,7 @@ struct IPMIBmcSim {
     uint8_t restart_cause;
 
     uint8_t acpi_power_state[2];
-    uint8_t uuid[16];
+    QemuUUID uuid;
 
     IPMISel sel;
     IPMISdr sdr;
@@ -937,8 +937,19 @@ static void get_device_guid(IPMIBmcSim *ibs,
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
 
@@ -1980,12 +1991,6 @@ static void ipmi_sim_realize(DeviceState *dev, Error **errp)
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
 
@@ -2005,6 +2010,7 @@ static Property ipmi_sim_properties[] = {
     DEFINE_PROP_UINT8("fwrev2", IPMIBmcSim, fwrev2, 0),
     DEFINE_PROP_UINT32("mfg_id", IPMIBmcSim, mfg_id, 0),
     DEFINE_PROP_UINT16("product_id", IPMIBmcSim, product_id, 0),
+    DEFINE_PROP_UUID_NODEFAULT("guid", IPMIBmcSim, uuid),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 0d8beb4afd..ec56ab8f6f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -700,7 +700,7 @@ possible drivers and properties, use @code{-device help} and
 @code{-device @var{driver},help}.
 
 Some drivers are:
-@item -device ipmi-bmc-sim,id=@var{id}[,slave_addr=@var{val}][,sdrfile=@var{file}][,furareasize=@var{val}][,furdatafile=@var{file}]
+@item -device ipmi-bmc-sim,id=@var{id}[,slave_addr=@var{val}][,sdrfile=@var{file}][,furareasize=@var{val}][,furdatafile=@var{file}][,guid=@var{uuid}]
 
 Add an IPMI BMC.  This is a simulation of a hardware management
 interface processor that normally sits on a system.  It provides
@@ -713,8 +713,8 @@ controllers.  If you don't know what this means, it is safe to ignore
 it.
 
 @table @option
-@item bmc=@var{id}
-The BMC to connect to, one of ipmi-bmc-sim or ipmi-bmc-extern above.
+@item id=@var{id}
+The BMC id for interfaces to use this device.
 @item slave_addr=@var{val}
 Define slave address to use for the BMC.  The default is 0x20.
 @item sdrfile=@var{file}
@@ -723,6 +723,10 @@ file containing raw Sensor Data Records (SDR) data. The default is none.
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



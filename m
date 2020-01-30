Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CF0C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:23:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D41B206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xn06Bu8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D41B206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCbK-000194-Hc
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:23:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCU0-0005hU-VP
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCTz-00032F-Kz
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:56 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:40737)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixCTz-00031F-EV
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:55 -0500
Received: by mail-wm1-x336.google.com with SMTP id t14so4929774wmi.5
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=gkX8yXLvj1vB2iCrSft8XMOOTuSOUkNF1VyrSoIYYZ0=;
 b=xn06Bu8Y8p6Mb/gr9v8gxt9p1OFbG9ltNMV+MfV0p8ufrag+9mbqje/dnCdbXI8aJN
 K5jZb2Y0XS8W3F+qeedPs8zgSyd3aZLK/u2qF5tdCU5iUCgueBI8M7wY1NCB935iiNYH
 NKVjQHXjTm2+NObJjvxeRAVNNLaKHx2J3k41gNYgWtc8VmJSRB0yFNySjI1PjvO9i7J/
 UspMYRzPJkg6ta4Dw4ksojUFGom0Z1p4Q5GCoCFa/OhX3RtkovXZh5nqPKTXh8dle1Ca
 i7bVcm1At8m95OAZj4URp1yYm9x/ZN1cA3KE8F0CaR8l0S5YnPPixZqA2pR6gFN4xUmL
 G51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gkX8yXLvj1vB2iCrSft8XMOOTuSOUkNF1VyrSoIYYZ0=;
 b=Cp7JnYXTic9ehGy4LwzNKfOjNKRsBtHrUmlOXKe3CCxG/HnNDzJuI4Y8y+we1P1YG8
 MmcNu/BxaPPKxbQcioXIhlogUB+DA7FCzXASOlIy+QGVowhWp/u7GZuH5WZnQZPuEwBn
 /xgAjwye1EEKBH60/Jnyx9Zn16PT20XIk+lD23IZCXVoxzrQd8x6BNDjxmn4unqA12Lg
 oZRzHOpAeYsPHp0X49qRuPJwha3Xsm5L1oKi+wVWFHG+wfGXbwLzlYpcZg8DEdhbZCKq
 89tcqJA8kW+wdujIjgEHKjGzFIg1xijLtBYRWSG9RZL73ytK0QEoFwU8WhE0EhV228cm
 Ltlg==
X-Gm-Message-State: APjAAAXE8Bju04MGQEKbtiK9bC5cbKBcB+ITElvzh7/GjjXy/fOszECR
 eD/iQH1SsAJi1vSWiLeaYX6GoibPfe1uHQ==
X-Google-Smtp-Source: APXvYqz9hoeI32wTYT/D8OHI6PAAEZ6GkBLFv1pGT8KHKHpKR8k2gJ8rmtQLJIpewOn5B34NPrFxww==
X-Received: by 2002:a05:600c:20c6:: with SMTP id
 y6mr6443641wmm.95.1580400953175; 
 Thu, 30 Jan 2020 08:15:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a22sm6994442wmd.20.2020.01.30.08.15.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 08:15:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/26] hw/core/qdev: update hotplug reset regarding resettable
Date: Thu, 30 Jan 2020 16:15:22 +0000
Message-Id: <20200130161533.8180-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130161533.8180-1-peter.maydell@linaro.org>
References: <20200130161533.8180-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Damien Hedde <damien.hedde@greensocs.com>

This commit make use of the resettable API to reset the device being
hotplugged when it is realized. Also it ensures it is put in a reset
state coherent with the parent it is plugged into.

Note that there is a difference in the reset. Instead of resetting
only the hotplugged device, we reset also its subtree (switch to
resettable API). This is not expected to be a problem because
sub-buses are just realized too. If a hotplugged device has any
sub-buses it is logical to reset them too at this point.

The recently added should_be_hidden and PCI's partially_hotplugged
mechanisms do not interfere with realize operation:
+ In the should_be_hidden use case, device creation is
delayed.
+ The partially_hotplugged mechanism prevents a device to be
unplugged and unrealized from qdev POV and unrealized.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200123132823.1117486-8-damien.hedde@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/resettable.h | 11 +++++++++++
 hw/core/qdev.c          | 15 ++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/hw/resettable.h b/include/hw/resettable.h
index 96073354fd6..5e215d94e42 100644
--- a/include/hw/resettable.h
+++ b/include/hw/resettable.h
@@ -153,6 +153,17 @@ struct ResettableState {
     bool exit_phase_in_progress;
 };
 
+/**
+ * resettable_state_clear:
+ * Clear the state. It puts the state to the initial (zeroed) state required
+ * to reuse an object. Typically used in realize step of base classes
+ * implementing the interface.
+ */
+static inline void resettable_state_clear(ResettableState *state)
+{
+    memset(state, 0, sizeof(ResettableState));
+}
+
 /**
  * resettable_reset:
  * Trigger a reset on an object @obj of type @type. @obj must implement
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 28fc93b1074..7697f033b19 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -909,6 +909,12 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
             }
         }
 
+        /*
+         * Clear the reset state, in case the object was previously unrealized
+         * with a dirty state.
+         */
+        resettable_state_clear(&dev->reset);
+
         QLIST_FOREACH(bus, &dev->child_bus, sibling) {
             object_property_set_bool(OBJECT(bus), true, "realized",
                                          &local_err);
@@ -917,7 +923,14 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
             }
         }
         if (dev->hotplugged) {
-            device_legacy_reset(dev);
+            /*
+             * Reset the device, as well as its subtree which, at this point,
+             * should be realized too.
+             */
+            resettable_assert_reset(OBJECT(dev), RESET_TYPE_COLD);
+            resettable_change_parent(OBJECT(dev), OBJECT(dev->parent_bus),
+                                     NULL);
+            resettable_release_reset(OBJECT(dev), RESET_TYPE_COLD);
         }
         dev->pending_deleted_event = false;
 
-- 
2.20.1



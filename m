Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6ACC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:06:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D4DD2072C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCigGM45"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D4DD2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXhQ-0004A8-Lv
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 14:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4S-0002X8-Sw
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4R-0004VU-MJ
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:44 -0500
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b]:41776)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX4R-0004VB-Ia; Mon, 06 Jan 2020 13:25:43 -0500
Received: by mail-qk1-x72b.google.com with SMTP id x129so40277788qke.8;
 Mon, 06 Jan 2020 10:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Adi6YmWzd5BlIyjySU/FHh29puafqwS6MyW1XVUsuis=;
 b=aCigGM45Roe/Nr1ZXPjbYM8Xz0GSFXDL5YrXrdeaqunEB+OI3Y2LN/2I5bPMtc5S8j
 CGMl++arbFq6+4W/1Q33RBV8me0qDj45oXKxyynzYylUQnuirH625VTao0ior+8O3qFz
 xIN4ehhT7CuPe+exRMgisa4ERBUk5Fyfv7wN9eqZEvjeCUXVXHs2zFK4EW5LgBgQGgDF
 p+tQzfTuoWQNk0l4xKS44jJE2a/ik0xT352iQsjb6V7RhWs7FCkfZBlQNDsAAU/zjGxu
 zl+jk5tZ7tXYfIiTIlZb4glU0uA69gLjeZNo3bgkwJKmZEbEjEO8+wU2ywCNKD0kvRiZ
 Y9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Adi6YmWzd5BlIyjySU/FHh29puafqwS6MyW1XVUsuis=;
 b=Vi54n9HzxSjjZja4aeMs2cWOWaNPxqHHeE0K7ReddM/v/3HWjFo+UNrJFO94oBo6rn
 8LjL+Jafo9/8MB8jJ/Qbia85OfOBA8Ur7fDlMkvMID5CLCiCW48xRi0jEUDyzUorJlD2
 O7T/Q1RRT+1rwjaezDlECLUCQxefKNPlL/wYS2ZhUiWNtD9KHfKVWhbuVjghAb1VFC/K
 Q8v5rTQKrBEllLMfr0oG9N48DtoS43oJxbDaeb8rEeF6BW8Czq6pVY8yHCW4BxQYUt75
 hz+ZfQrOnJ+zVN+2uJHB3si6SYq+ABHC8ZRqW8DZVZ8r8AwSF92kzMS+9Aoz5R/7PGZW
 82nA==
X-Gm-Message-State: APjAAAXgY8GzOA2N8+OZ5+X5jrK9qiSsDkklwJCsOgGlZoEA63CKQRXz
 /UPpSJ5IUSIFXDKoFP82gv4AylND
X-Google-Smtp-Source: APXvYqy9uuY+g/FFOUyP/GV4GYpoqMkRy1st8SV0/XE9bt2uTfjdO1LUISMtE5C85hik3nZV78SaHg==
X-Received: by 2002:ae9:f711:: with SMTP id s17mr83111219qkg.238.1578335142878; 
 Mon, 06 Jan 2020 10:25:42 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:25:42 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 28/59] qga/commands-win32.c: remove 'out' label in
 get_pci_info
Date: Mon,  6 Jan 2020 15:23:54 -0300
Message-Id: <20200106182425.20312-29-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::72b
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
Cc: qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'out' can be replaced by 'return pci' instead.

CC: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 qga/commands-win32.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 2461fd19bf..c520a341df 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -513,7 +513,7 @@ static GuestPCIAddress *get_pci_info(int number, Error **errp)
                                    DIGCF_PRESENT | DIGCF_DEVICEINTERFACE);
     if (dev_info == INVALID_HANDLE_VALUE) {
         error_setg_win32(errp, GetLastError(), "failed to get devices tree");
-        goto out;
+        return pci;
     }
 
     g_debug("enumerating devices");
@@ -584,7 +584,7 @@ static GuestPCIAddress *get_pci_info(int number, Error **errp)
                 } else {
                     error_setg_win32(errp, GetLastError(),
                                      "failed to get device instance ID");
-                    goto out;
+                    return pci;
                 }
             }
 
@@ -598,14 +598,14 @@ static GuestPCIAddress *get_pci_info(int number, Error **errp)
                 g_error("CM_Locate_DevInst failed with code %lx", cr);
                 error_setg_win32(errp, GetLastError(),
                                  "failed to get device instance");
-                goto out;
+                return pci;
             }
             cr = CM_Get_Parent(&parent_dev_inst, dev_inst, 0);
             if (cr != CR_SUCCESS) {
                 g_error("CM_Get_Parent failed with code %lx", cr);
                 error_setg_win32(errp, GetLastError(),
                                  "failed to get parent device instance");
-                goto out;
+                return pci;
             }
 
             cr = CM_Get_Device_ID_Size(&dev_id_size, parent_dev_inst, 0);
@@ -613,7 +613,7 @@ static GuestPCIAddress *get_pci_info(int number, Error **errp)
                 g_error("CM_Get_Device_ID_Size failed with code %lx", cr);
                 error_setg_win32(errp, GetLastError(),
                                  "failed to get parent device ID length");
-                goto out;
+                return pci;
             }
 
             ++dev_id_size;
@@ -628,7 +628,7 @@ static GuestPCIAddress *get_pci_info(int number, Error **errp)
                 g_error("CM_Get_Device_ID failed with code %lx", cr);
                 error_setg_win32(errp, GetLastError(),
                                  "failed to get parent device ID");
-                goto out;
+                return pci;
             }
         }
 
@@ -642,14 +642,14 @@ static GuestPCIAddress *get_pci_info(int number, Error **errp)
         if (parent_dev_info == INVALID_HANDLE_VALUE) {
             error_setg_win32(errp, GetLastError(),
                              "failed to get parent device");
-            goto out;
+            return pci;
         }
 
         parent_dev_info_data.cbSize = sizeof(SP_DEVINFO_DATA);
         if (!SetupDiEnumDeviceInfo(parent_dev_info, 0, &parent_dev_info_data)) {
             error_setg_win32(errp, GetLastError(),
                            "failed to get parent device data");
-            goto out;
+            return pci;
         }
 
         for (j = 0;
@@ -731,7 +731,6 @@ static GuestPCIAddress *get_pci_info(int number, Error **errp)
 
 free_dev_info:
     SetupDiDestroyDeviceInfoList(dev_info);
-out:
     return pci;
 }
 
-- 
2.24.1



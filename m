Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D49C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 20:45:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B9EE2078A
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 20:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="b+T/oLYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9EE2078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkD23-00011u-Lw
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 16:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wu000273@umn.edu>) id 1jkBTV-0008Fo-F4
 for qemu-devel@nongnu.org; Sat, 13 Jun 2020 15:05:53 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:42010)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wu000273@umn.edu>) id 1jkBTS-0000lK-Ms
 for qemu-devel@nongnu.org; Sat, 13 Jun 2020 15:05:52 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-p6.oit.umn.edu (Postfix) with ESMTP id 49kn9k0tl5z9vBtx
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2020 19:05:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
 by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GKlzBj-XfqqA for <qemu-devel@nongnu.org>;
 Sat, 13 Jun 2020 14:05:46 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 49kn9j6JtRz9vBt2
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2020 14:05:45 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 49kn9j6JtRz9vBt2
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 49kn9j6JtRz9vBt2
Received: by mail-io1-f72.google.com with SMTP id w2so8510479iom.13
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2020 12:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umn.edu; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=o2FOKEQ94D1GV7+5LNDHjuMFh+VY1uzX12Wnv43ZbD8=;
 b=b+T/oLYviKv/mte4B9pdAcQFXVhNY69kXPGrXUU38u3BOUFasXoyr1Kgej9HVkzXxs
 Ij8d+SfMB2q4QSeN+DyIfLyqpKAcKYYprE5PYt89EyliIe+dP6nEL/71vhcZxEuT6y04
 Q3dwBhcpiRRKbpkVWBIHSyEQjrfJbsdW8e0idsDZLGLlJEDjM6LmHO3WP1o1xA2l6uuC
 RbkC6vl793qCKGP3gEEO9lov999q5Wxe7GsBCkrkX2t1lVYG+PUxmNv9VPVyC1ETO0g5
 d82C1xJlw0XCNEIVoziCsfKDJrBoADvu2ELiZ09FPnNJykyk4gPnxGQjoT5eQw9aFedp
 ua0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=o2FOKEQ94D1GV7+5LNDHjuMFh+VY1uzX12Wnv43ZbD8=;
 b=qRICZvnSs1dVG4GfZA9IbMnGTqk9VgPDWlBg+BiJv8KSvywRMof8z8vDWn1wYRjaqI
 vGVZwciW3YmNy4A+AVVzIbRaBfIrt8PZz+1tuFJMVXWA6/SfmkRkHMaNgyK0MZVANv5o
 XtFkTLW64Ja4xmwEWi4V1yPiWsLA0mj+WuDwKflcaoukn3ScGdQL6m9e0Mtf/xill6qK
 Ziy6f5wirheR2zD1EQLQzXBh5EI0HirvulffNLO7tOZBUyLHLK3m6qKygQSkRevhCQL7
 Kd3qgPsihWwzfQDH2pbp1TCCpx4MDHB4FpnOaXlq+f/5qi9ECdPy1BsAQEYSUcMQinUi
 bO2A==
X-Gm-Message-State: AOAM532yepUGPUi61mgb5U1BxrPZwHbQMMi1fESp13UFkAEWsQXPoinN
 rE356CSQPmfBqCY6k1rFRjD23qkwujuj45quExxENfTqmnPPreIFkNVBsR+2cUWcYmwIBIpjXt3
 6cd74ZJgIDR8qnTIFpVM=
X-Received: by 2002:a92:9a5c:: with SMTP id t89mr18359193ili.280.1592075145379; 
 Sat, 13 Jun 2020 12:05:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8tFjRdEjUHCtUKGBzZRi4tcOgtgzZ46cDKJIORr6RvgnfT0GzOC80OcYvuDHb06XXjU6pcA==
X-Received: by 2002:a92:9a5c:: with SMTP id t89mr18359175ili.280.1592075145066; 
 Sat, 13 Jun 2020 12:05:45 -0700 (PDT)
Received: from qiushi.cs.umn.edu ([2607:ea00:101:3c74:4874:45:bcb4:df60])
 by smtp.gmail.com with ESMTPSA id r17sm5194889ilc.33.2020.06.13.12.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2020 12:05:44 -0700 (PDT)
From: wu000273@umn.edu
To: kjlu@umn.edu
Cc: wu000273@umn.edu, Gabriel Somlo <somlo@cmu.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: Fix a reference count leak.
Date: Sat, 13 Jun 2020 14:05:33 -0500
Message-Id: <20200613190533.15712-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=134.84.196.206; envelope-from=wu000273@umn.edu;
 helo=mta-p6.oit.umn.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/13 15:05:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 13 Jun 2020 16:44:50 -0400
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

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object.
Callback function fw_cfg_sysfs_release_entry() in kobject_put()
can handle the pointer "entry" properly.

Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/firmware/qemu_fw_cfg.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 039e0f91dba8..6945c3c96637 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -605,8 +605,10 @@ static int fw_cfg_register_file(const struct fw_cfg_file *f)
 	/* register entry under "/sys/firmware/qemu_fw_cfg/by_key/" */
 	err = kobject_init_and_add(&entry->kobj, &fw_cfg_sysfs_entry_ktype,
 				   fw_cfg_sel_ko, "%d", entry->select);
-	if (err)
-		goto err_register;
+	if (err) {
+		kobject_put(&entry->kobj);
+		return err;
+	}
 
 	/* add raw binary content access */
 	err = sysfs_create_bin_file(&entry->kobj, &fw_cfg_sysfs_attr_raw);
@@ -622,7 +624,6 @@ static int fw_cfg_register_file(const struct fw_cfg_file *f)
 
 err_add_raw:
 	kobject_del(&entry->kobj);
-err_register:
 	kfree(entry);
 	return err;
 }
-- 
2.17.1



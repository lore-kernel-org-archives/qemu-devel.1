Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B61AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:09:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79DCB247CA
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfvQXnZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79DCB247CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSKzm-0003Lg-JH
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 10:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kSKwH-0007tS-KK
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:06:05 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:47070)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kSKwB-0006LM-19
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:06:05 -0400
Received: by mail-qk1-x741.google.com with SMTP id a23so20874737qkg.13
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 07:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z5sCn2g22QNClDVC8ApV+Mu5VWc6D2QWQMvZw+Aegos=;
 b=CfvQXnZCbKI+aeJIUwszdFQKsZPrD0OxTTWrzEaSn/d3DDvLCCcXgs0dyeR+jPToj2
 ukNtrMP4s3qkhNcd4ZKW8eZc9hXTU5do+L9/1IXwwlil/SY1O+BoBGnTsV9LbPuRBOoW
 wLvovZjgplbCIvu7UWrbpYFfsq6LUq+KITh8knWtWOPyNIDkmkzgC/c/vjm/h9BKZtWR
 F3MUx8xrMrC6VFmBxyBfXPQUwvR2XyfQNtTxOgCECyVPgaWY048xCzZMVL3/JPU2XvOH
 +G7OLxyuA3UDUcVKDN5GSAS0q0FP/GZ8g0JPMLVvw8X0pYznkVSbSR2BOS0Poh4A+h+J
 J4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z5sCn2g22QNClDVC8ApV+Mu5VWc6D2QWQMvZw+Aegos=;
 b=N8+Vrh3h6uXcFXH2xPOMEFb9GaiEmYPxTpIrz7j3gx8pFur6Vs/VGdf3VMPlBltydD
 88cT5cuhUHDEnqUokA+rCduIvBOEj1cQKKBnaTzTc3TLsEraSRH7R14y8+xsegRonA5i
 fPa9BDuIokvF5egBlTDX5kwQLxvYdUdKZ1i2RD3XHSDMvT9o6kZ1ttZHlc25d8eLGbrl
 JDUmcg0AIJQKtdqp/+JtBcRRybYysR6c2NE9zd83Jh6ItAjc47FASMHpGBGiWjSSp4yd
 8vS3mVbXfNY7uIy1U0vySr8jaMDN3FFyvJg9tDqyMjxLNIDkEZ9Eh1aYlAjn2XyVYyX9
 qLlQ==
X-Gm-Message-State: AOAM533fOC1OSHSWbTVt9dWsUoGkNmmOsqVm3vkBVqkmYrnAjLbSqkNW
 KSOZSM2T21XK5xePJOG6yrK+IjK9wUY=
X-Google-Smtp-Source: ABdhPJwtxBEnRnNPjEHcuVVHof6O92obazL/vN2TmbQ5O2rfIz0/rAfUoxQkml2srmIG5IH2ZnkKwQ==
X-Received: by 2002:ae9:ef56:: with SMTP id d83mr100087qkg.83.1602597956496;
 Tue, 13 Oct 2020 07:05:56 -0700 (PDT)
Received: from shine.lan ([2001:470:8:67e:2df1:3321:942a:fbce])
 by smtp.gmail.com with ESMTPSA id z26sm13793609qki.40.2020.10.13.07.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 07:05:55 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] accel: Add xen CpusAccel using dummy-cpus
Date: Tue, 13 Oct 2020 10:05:11 -0400
Message-Id: <20201013140511.5681-4-jandryuk@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201013140511.5681-1-jandryuk@gmail.com>
References: <20201013140511.5681-1-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::741;
 envelope-from=jandryuk@gmail.com; helo=mail-qk1-x741.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Jason Andryuk <jandryuk@gmail.com>, Claudio Fontana <cfontana@suse.de>,
 Anthony Perard <anthony.perard@citrix.com>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Xen was broken by commit 1583a3898853 ("cpus: extract out qtest-specific
code to accel/qtest").  Xen relied on qemu_init_vcpu() calling
qemu_dummy_start_vcpu() in the default case, but that was replaced by
g_assert_not_reached().

Add a minimal "CpusAccel" for Xen using the dummy-cpus implementation
used by qtest.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
 accel/meson.build   | 1 +
 accel/xen/xen-all.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/accel/meson.build b/accel/meson.build
index 9a417396bd..b26cca227a 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -12,3 +12,4 @@ dummy_ss.add(files(
 ))
 
 specific_ss.add_all(when: ['CONFIG_SOFTMMU', 'CONFIG_POSIX'], if_true: dummy_ss)
+specific_ss.add_all(when: ['CONFIG_XEN'], if_true: dummy_ss)
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index 60b971d0a8..878a4089d9 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -16,6 +16,7 @@
 #include "hw/xen/xen_pt.h"
 #include "chardev/char.h"
 #include "sysemu/accel.h"
+#include "sysemu/cpus.h"
 #include "sysemu/xen.h"
 #include "sysemu/runstate.h"
 #include "migration/misc.h"
@@ -153,6 +154,10 @@ static void xen_setup_post(MachineState *ms, AccelState *accel)
     }
 }
 
+const CpusAccel xen_cpus = {
+    .create_vcpu_thread = dummy_start_vcpu_thread,
+};
+
 static int xen_init(MachineState *ms)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
@@ -180,6 +185,9 @@ static int xen_init(MachineState *ms)
      * opt out of system RAM being allocated by generic code
      */
     mc->default_ram_id = NULL;
+
+    cpus_register_accel(&xen_cpus);
+
     return 0;
 }
 
-- 
2.25.1



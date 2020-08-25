Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8CCC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 22:00:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E07620706
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 22:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AU0C6GRY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E07620706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgzM-0006aj-Id
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 18:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kAgxC-0002R6-6F; Tue, 25 Aug 2020 17:58:06 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:45587)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kAgx9-0000YB-Io; Tue, 25 Aug 2020 17:58:05 -0400
Received: by mail-qt1-x842.google.com with SMTP id p36so167858qtd.12;
 Tue, 25 Aug 2020 14:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gs8bi7VVxJby/VCGELptjbix2K07oxRPUhMrOOcTGBw=;
 b=AU0C6GRYJ0zM/9ZjjxtQHS+ejltWYnm05WyAAImVBcWogxMEf3DRSTxluvKsVrCwQW
 U19ge4DqspNMKIRlxidf9dOTf5wl89dAJKeaEXERsoDhFSvqOyjgY03blwuIp/qqSkc9
 PhyStZWw99dzpL9FBxYEigTUsWq3dgxkO6ZNb9KoHQ9WpBUJ2LY3Z9joXoNMpsAEUVno
 yEQw+IFqxLg9u+D8GgEjAVhzShayossUCjpD9aoB+Tlc758WYtcb/YY2ECgtoTrfdzfK
 fyJyvCtqjd+/I8OaqqxfqGPKDf1uBpeg4aRI9kHeHGJG5Cg1GWtcDLFQ711kFmOYdewz
 /9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gs8bi7VVxJby/VCGELptjbix2K07oxRPUhMrOOcTGBw=;
 b=s1WJqtbTSWoqWpWfMWlnlpp2WspV1S6UZH/qQXJkg6i/AhtdOqh47qKJQtU1yz/44Y
 EYpi6nelPZZ23JX73jRpujSY2Q6MQSS403gzjTP/flWR5BUKenxuTsLQUFWgk5s1Ykjc
 WnDTiWWG4LoAKY8xbGodhAv7zg/ImCfEbEfptlsNqTUAkoF3xYLHODvSSEng4GOX6Sg9
 DHWKvDh3t6rpnQ/ACGXvDud3Epn7WU3AzW0taSubLpZMmAiQ8Cpyr9PhDzFHOPMm69to
 KeA8O7urVZYMJPNJkPm4KiKIkj4rsplqDijB4/XPKndtg9Am3KoWFgpdm9OFSY/3TD8+
 PFwQ==
X-Gm-Message-State: AOAM530+juVD7XXiVAT1u3M5fPzQcPHevk4O/YVskIOqRrf6u5V2TQ1v
 pstkrvqN73UaQgj7WZarvCPWQiipEDk=
X-Google-Smtp-Source: ABdhPJxGi34TpnofDEwH6Hzd+uzM9jsVaiIZM9wELTcDyc+3e1I6tPx5TeUJBAwLKwkW/eyrPK2QIg==
X-Received: by 2002:ac8:4b52:: with SMTP id e18mr11432826qts.231.1598392682160; 
 Tue, 25 Aug 2020 14:58:02 -0700 (PDT)
Received: from localhost.localdomain ([2804:431:c7c7:c152:8180:e1dd:d6ac:1152])
 by smtp.gmail.com with ESMTPSA id z2sm347362qtu.11.2020.08.25.14.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:58:01 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] spapr,
 spapr_nvdimm: fold NVDIMM validation in the same place
Date: Tue, 25 Aug 2020 18:57:48 -0300
Message-Id: <20200825215749.213536-3-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200825215749.213536-1-danielhb413@gmail.com>
References: <20200825215749.213536-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::842;
 envelope-from=danielhb413@gmail.com; helo=mail-qt1-x842.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

NVDIMM has different contraints and conditions than the regular
DIMM and we'll need to add at least one more.

Instead of relying on 'if (nvdimm)' conditionals in the body of
spapr_memory_pre_plug(), use the existing spapr_nvdimm_validate_opts()
and put all NVDIMM handling code there. Rename it to
spapr_nvdimm_validate() to reflect that the function is now checking
more than the nvdimm device options. This makes spapr_memory_pre_plug()
a bit easier to follow, and we can tune in NVDIMM parameters
and validation in the same place.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr.c                | 18 ++++++------------
 hw/ppc/spapr_nvdimm.c         | 10 ++++++++--
 include/hw/ppc/spapr_nvdimm.h |  4 ++--
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index dd2fa4826b..b0a04443fb 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3520,7 +3520,6 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 {
     const SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(hotplug_dev);
     SpaprMachineState *spapr = SPAPR_MACHINE(hotplug_dev);
-    const MachineClass *mc = MACHINE_CLASS(smc);
     bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
     PCDIMMDevice *dimm = PC_DIMM(dev);
     Error *local_err = NULL;
@@ -3533,27 +3532,22 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    if (is_nvdimm && !mc->nvdimm_supported) {
-        error_setg(errp, "NVDIMM hotplug not supported for this machine");
-        return;
-    }
-
     size = memory_device_get_region_size(MEMORY_DEVICE(dimm), &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
 
-    if (!is_nvdimm && size % SPAPR_MEMORY_BLOCK_SIZE) {
-        error_setg(errp, "Hotplugged memory size must be a multiple of "
-                   "%" PRIu64 " MB", SPAPR_MEMORY_BLOCK_SIZE / MiB);
-        return;
-    } else if (is_nvdimm) {
-        spapr_nvdimm_validate_opts(NVDIMM(dev), size, &local_err);
+    if (is_nvdimm) {
+        spapr_nvdimm_validate(hotplug_dev, NVDIMM(dev), size, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             return;
         }
+    } else if (size % SPAPR_MEMORY_BLOCK_SIZE) {
+        error_setg(errp, "Hotplugged memory size must be a multiple of "
+                   "%" PRIu64 " MB", SPAPR_MEMORY_BLOCK_SIZE / MiB);
+        return;
     }
 
     memdev = object_property_get_link(OBJECT(dimm), PC_DIMM_MEMDEV_PROP,
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index 9a20a65640..bc2b65420c 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -30,13 +30,19 @@
 #include "hw/ppc/fdt.h"
 #include "qemu/range.h"
 
-void spapr_nvdimm_validate_opts(NVDIMMDevice *nvdimm, uint64_t size,
-                                Error **errp)
+void spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
+                           uint64_t size, Error **errp)
 {
+    const MachineClass *mc = MACHINE_GET_CLASS(hotplug_dev);
     g_autofree char *uuidstr = NULL;
     QemuUUID uuid;
     int ret;
 
+    if (!mc->nvdimm_supported) {
+        error_setg(errp, "NVDIMM hotplug not supported for this machine");
+        return;
+    }
+
     if (object_property_get_int(OBJECT(nvdimm), NVDIMM_LABEL_SIZE_PROP,
                                 &error_abort) == 0) {
         error_setg(errp, "PAPR requires NVDIMM devices to have label-size set");
diff --git a/include/hw/ppc/spapr_nvdimm.h b/include/hw/ppc/spapr_nvdimm.h
index b3330cc485..fd1736634c 100644
--- a/include/hw/ppc/spapr_nvdimm.h
+++ b/include/hw/ppc/spapr_nvdimm.h
@@ -29,8 +29,8 @@ int spapr_pmem_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                            void *fdt, int *fdt_start_offset, Error **errp);
 int spapr_dt_nvdimm(void *fdt, int parent_offset, NVDIMMDevice *nvdimm);
 void spapr_dt_persistent_memory(void *fdt);
-void spapr_nvdimm_validate_opts(NVDIMMDevice *nvdimm, uint64_t size,
-                                Error **errp);
+void spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
+                           uint64_t size, Error **errp);
 void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp);
 void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spapr);
 
-- 
2.26.2



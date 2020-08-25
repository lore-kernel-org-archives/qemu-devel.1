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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F388C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 22:01:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4214720706
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 22:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vDyI43j5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4214720706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAh0c-0007kF-GV
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 18:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kAgxD-0002Vb-MT; Tue, 25 Aug 2020 17:58:07 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:45587)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kAgxB-0000YX-IE; Tue, 25 Aug 2020 17:58:07 -0400
Received: by mail-qt1-x841.google.com with SMTP id p36so167933qtd.12;
 Tue, 25 Aug 2020 14:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mJdoucNwI/OnnzvaQh846qvbJjNp6NDdrYfpoZKb5zI=;
 b=vDyI43j5QW2UHrMiUy7YS9k2xNQOUqKX6n7RPidjjbeazTgiqc/qiyV14x5rUn9BTL
 4hhXEh1CwCsDlL1w36+xFACFpPkJNTrYa/GXMt1CJ2xilOibeOIrvHQoMjqLug+jzDBq
 iiee6hFUc/1zD0IYNHvabltOfVb2AUXZbLZDZoIxTYGurnQVyS+hzuGgHN3mZK24/p+Q
 tZgckjbN4FWuiPbR/+BiwA6gvx3T4oSXkl7nBEOMzEr0J1RCQq8nwPUUZ73n9PfxiS4k
 H0Mbf9f9U7+yZ5S0Hq+BGCz1A0wQDupjMDU1YTU/FynLsgph9W/I+7VruD/H+/YEHi5E
 rFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mJdoucNwI/OnnzvaQh846qvbJjNp6NDdrYfpoZKb5zI=;
 b=DPr1KNneLb0YYR2n4a+fExrEWeHdUA3FJIq+V6oOnjg0WVmgpE1U+kAq4LvVFoNmN1
 znDWxARw/xDNtW3bi44bLIcNiRiXd/J2vcfVZMnY7BwJ8iOmiJOkPbCoDRWNXDAJN9ac
 I533mYYPjSu2bel+3sJfek8TSH7Z4+duCJMbN4QG+BjFQNfUkenSkvJlwunG3X28XgZK
 Rva6K1pn00WD65HYU4hmMpyluCiDgZIZI4HQ2pkMb2vQ6klpzcuOvsAc6ZrfafgVQ56P
 SI2I0npD2o7zaIsYA1d0R2+zyxBDnc6OQP9tMoGnxPI0SsKEL0zZzmw9ZOsIwRvy1owI
 vT8g==
X-Gm-Message-State: AOAM533FKX6/wxPwwJGdhfAeKOidibwYryccZAsZjO6hM23bCVBbpUPD
 YpkACisV1gbm9jAex8Z4Wr7X+hvZp8k=
X-Google-Smtp-Source: ABdhPJwwZtulvPRufcinJMi0gBKmPVJIhjvTIVGNRlAJSy1vmIYZWQEQXbWEBDYZRL39zh0mTguyOg==
X-Received: by 2002:ac8:4b78:: with SMTP id g24mr11532474qts.248.1598392684073; 
 Tue, 25 Aug 2020 14:58:04 -0700 (PDT)
Received: from localhost.localdomain ([2804:431:c7c7:c152:8180:e1dd:d6ac:1152])
 by smtp.gmail.com with ESMTPSA id z2sm347362qtu.11.2020.08.25.14.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:58:03 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] ppc/spapr_nvdimm: do not enable support with 'nvdimm=off'
Date: Tue, 25 Aug 2020 18:57:49 -0300
Message-Id: <20200825215749.213536-4-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200825215749.213536-1-danielhb413@gmail.com>
References: <20200825215749.213536-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::841;
 envelope-from=danielhb413@gmail.com; helo=mail-qt1-x841.google.com
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

The NVDIMM support for pSeries was introduced in 5.1, but it
didn't contemplate the 'nvdimm' machine option that other
archs uses. For every other arch, if no '-machine nvdimm(=on)'
is present, it is assumed that the NVDIMM support is disabled.
The user must explictly inform that the machine supports
NVDIMM. For pseries-5.1 the 'nvdimm' option is completely
ignored, and support is always assumed to exist. This
leads to situations where the user is able to set 'nvdimm=off'
but the guest boots up with the NVDIMMs anyway.

Fixing this now, after 5.1 launch, can put the overall NVDIMM
support for pseries in a strange place regarding this 'nvdimm'
machine option. If we force everything to be like other archs,
existing pseries-5.1 guests that didn't use 'nvdimm' to use NVDIMM
devices will break. If we attempt to make the newer pseries
machines (5.2+) behave like everyone else, but keep pseries-5.1
untouched, we'll have consistency problems on machine upgrade
(5.1 will have different default values for NVDIMM support than
5.2).

The common ground here is, if the user sets 'nvdimm=off', we
must comply regardless of being 5.1 or 5.2+. This patch
changes spapr_nvdimm_validate() to verify if the user set
NVDIMM support off in the machine options and, in that
case, error out if we have a NVDIMM device. The default
value for 5.2+ pseries machines will still be 'nvdimm=on'
when there is no 'nvdimm' option declared, just like it is today
with pseries-5.1. In the end we'll have different default
semantics from everyone else in the absence of the 'nvdimm'
machine option, but this boat has sailed.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1848887
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr_nvdimm.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index bc2b65420c..95cbc30528 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -27,13 +27,17 @@
 #include "hw/ppc/spapr_nvdimm.h"
 #include "hw/mem/nvdimm.h"
 #include "qemu/nvdimm-utils.h"
+#include "qemu/option.h"
 #include "hw/ppc/fdt.h"
 #include "qemu/range.h"
+#include "sysemu/sysemu.h"
 
 void spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
                            uint64_t size, Error **errp)
 {
     const MachineClass *mc = MACHINE_GET_CLASS(hotplug_dev);
+    const MachineState *ms = MACHINE(hotplug_dev);
+    const char *nvdimm_opt = qemu_opt_get(qemu_get_machine_opts(), "nvdimm");
     g_autofree char *uuidstr = NULL;
     QemuUUID uuid;
     int ret;
@@ -43,6 +47,20 @@ void spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
         return;
     }
 
+    /*
+     * NVDIMM support went live in 5.1 without considering that, in
+     * other archs, the user needs to enable NVDIMM support with the
+     * 'nvdimm' machine option and the default behavior is NVDIMM
+     * support disabled. It is too late to roll back to the standard
+     * behavior without breaking 5.1 guests. What we can do is to
+     * ensure that, if the user sets nvdimm=off, we error out
+     * regardless of being 5.1 or newer.
+     */
+    if (!ms->nvdimms_state->is_enabled && nvdimm_opt) {
+        error_setg(errp, "nvdimm device found but 'nvdimm=off' was set");
+        return;
+    }
+
     if (object_property_get_int(OBJECT(nvdimm), NVDIMM_LABEL_SIZE_PROP,
                                 &error_abort) == 0) {
         error_setg(errp, "PAPR requires NVDIMM devices to have label-size set");
-- 
2.26.2



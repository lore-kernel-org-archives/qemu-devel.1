Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C59FC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:25:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0804C206A4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmyrUyQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0804C206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9ssd-0006rt-Fo
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sDK-0006jR-P4
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sDI-0007bv-Ky
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:50 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37493)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1i9sDI-0007Zz-7R
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:48 -0400
Received: by mail-wr1-x441.google.com with SMTP id i1so38606996wro.4
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yV/n/mgO1W/0/jiaPYcXrk5/ziKrwU2IWT+KPvHpW0I=;
 b=AmyrUyQ6+2UsoDSk0L9O8hj9+k7/HFvVl2HZxaWSHAgVjvbGjiaDHOiTVq68F0BBbG
 LCgXCp8FOkWH6SMvkJv2nkS43o3dd01bFoVf1MsI9/MNosi26YHsuzlU3iK23OpW5VRR
 waN4tb9dvfY3B75BLp7z1JQBz58wRiIXxxVyIisUZUgkZDOQFs+E8PmwC2C6psdJiuRc
 LkSdOmS9IV7yFvvX6l8OyXc7yoX8bg7gYGMEO7ZibLSGveloSrJsacvgVIos+1MDGuKb
 SyTnN5XkVKqhECCEaSVrqGQRoKt+lmkyo4eoJf9R+9J8rXZu99sQ7zohLnsMzjevW4me
 xItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=yV/n/mgO1W/0/jiaPYcXrk5/ziKrwU2IWT+KPvHpW0I=;
 b=jfVgpWaWo67r4Z2/wWrKebX84Hpm+md8vabTdry0e8CO6GUXJWC0EAX1c0i9s6sY6G
 ak9awoH+ePShSQY8X7teqPHAKqCh3sOnJHwseVQq4GPYx6gm686V3juFRXsCVvrH9Ub4
 DY16uhBxkXfcN7GmCORb/k8gekhTBLvIn1Jn9FAiCaY0QsOEHwJHgP4JTisOBcM5tiRl
 +hmKOXSnpwZb0doS6menuX8BDUxHPmUTfVK9tft9ipL4T9Gu2/wSBBa9nJvbkduNQ3y2
 Mt8EqjCS+VgxFX8BDGkODA8vMD2bd4g+P8QiczKb3tphS1WkUCDS9UkDl56QI7Kz1+vv
 86rw==
X-Gm-Message-State: APjAAAW6oyu2TE2a8cDeLDCOYGqQxf3rFNYHPVuETJ53H2DwtMxIL2qU
 BHs2aIHpThGcGlUk4a9IdT6ErnTI
X-Google-Smtp-Source: APXvYqz1RlbjPjekDVU5ssekGTOoK/61oqbFtQyny3WCbwpm+z/DXdSo5BpNfgx9Fs8jbwA0u3wo6g==
X-Received: by 2002:a5d:694e:: with SMTP id r14mr153953wrw.34.1568644961459;
 Mon, 16 Sep 2019 07:42:41 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id i14sm17024298wra.78.2019.09.16.07.42.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Sep 2019 07:42:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 16:42:08 +0200
Message-Id: <1568644929-9124-29-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
References: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PULL 28/29] hw/i386/pc: Rename
 pc_build_feature_control() as generic fw_cfg_build_*
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Now that the pc_build_feature_control_file() function has been
refactored to not depend of PC specific types, rename it to a
more generic name.

Suggested-by: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190818225414.22590-15-philmd@redhat.com>
---
 hw/i386/pc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 438c485..9446596 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1623,8 +1623,8 @@ void pc_cpus_init(PCMachineState *pcms)
     }
 }
 
-static void pc_build_feature_control_file(MachineState *ms,
-                                          FWCfgState *fw_cfg)
+static void fw_cfg_build_feature_control(MachineState *ms,
+                                         FWCfgState *fw_cfg)
 {
     X86CPU *cpu = X86_CPU(ms->possible_cpus->cpus[0].cpu);
     CPUX86State *env = &cpu->env;
@@ -1695,7 +1695,7 @@ void pc_machine_done(Notifier *notifier, void *data)
     acpi_setup();
     if (pcms->fw_cfg) {
         fw_cfg_build_smbios(MACHINE(pcms), pcms->fw_cfg);
-        pc_build_feature_control_file(MACHINE(pcms), pcms->fw_cfg);
+        fw_cfg_build_feature_control(MACHINE(pcms), pcms->fw_cfg);
         /* update FW_CFG_NB_CPUS to account for -device added CPUs */
         fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
     }
-- 
1.8.3.1




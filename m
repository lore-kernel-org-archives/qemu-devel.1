Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1809C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:56:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8213720675
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IM0VIel6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8213720675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqHg3-0006wZ-P9
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 10:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqHcu-0000XO-Ra
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 10:52:48 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:35244)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqHct-0002UH-6t
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 10:52:48 -0400
Received: by mail-ej1-x643.google.com with SMTP id rk21so20967759ejb.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 07:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eR9kP7Fz+9gQhaNg+BX9SC6Oil6Qv/iwmZJA+m/P2z8=;
 b=IM0VIel6TLMIbnilKQNCq4GpNnsYnQ82Q7PxyiiTSGVg47BXqTyELVHldTJu9KZno0
 Y1K/fvRaxrL7WtiQK0efSuTsdjEC2b28V8Fdt+g29FLqlDbhvhu/wm2Lo3Ni/3BJzDbg
 hbNtrYoAKsR8rLrQdWxcbAHKo3zmMYuTtQCpFlYJ4SbD3xgITx6h0cfiOicplr34Emjr
 IW8++ef9FATKI4ptQUcNItTEjkMDs1blP08XPZJKxxIjzhLxN1g7ymobamcjfWiEsJVp
 4rdW5vr4nQS6BspglmyZwFwRqwaCkUlbph9RZ7vDCSVNhVV6C23xPQYw+FmMjDxF/kN9
 p/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=eR9kP7Fz+9gQhaNg+BX9SC6Oil6Qv/iwmZJA+m/P2z8=;
 b=pA4F7wbXKobEQW+W5g4aL4etl7ionjfWcxZde48PKdyn7/QQ4iSrDzdz6SMpGfiSd7
 IRzjmGfwoI8pn0l/0X3C1xPF6fZqpAzsdnhVwKUbsitg7aJnfejeeAv6fbeBVBYgYfMN
 GGQMRJPzqpPGlH4ki4MepXGQigp2ELYdEx5FIZxdbEQFkhUQru9APaBVlngQlIbrlKGN
 BVRDw9We0GdePBdxoY9fzze1i2hl1tVbcFZGRWpz8okIOPo1DgmHEQqNWP9FqYLZKMcX
 R1exZTM9Ogc4HJ6ei3rYpAH98sKz+92YQEqI1477b8iyI7UElXo5FKlj8BPBy4wMm9tH
 9T7Q==
X-Gm-Message-State: AOAM533YZARuKy7TeTCs18EJKnv/Pt5XS772DL03JKA0KPbTzRxZhQym
 jKxGClI+2pLQ19hR/epMRNU=
X-Google-Smtp-Source: ABdhPJz0l1FpXALqfLJPKtaGdB5u40cuqgm4dPaanc+7JJ+HKznRm1eb43W+9b50iK49+2RSzbPS4A==
X-Received: by 2002:a17:906:33ca:: with SMTP id
 w10mr10996175eja.171.1593528765911; 
 Tue, 30 Jun 2020 07:52:45 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p9sm2144569ejd.50.2020.06.30.07.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 07:52:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Aurelien Jarno <aurelien@aurel32.net>, Yunqiang Su <ysu@wavecomp.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 6/6] hw/mips/malta: Introduce the 'malta-unleashed' 64-bit
 machine
Date: Tue, 30 Jun 2020 16:52:36 +0200
Message-Id: <20200630145236.27529-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630145236.27529-1-f4bug@amsat.org>
References: <20200630145236.27529-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Ximin Luo <infinity0@debian.org>, debian-mips@lists.debian.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Jonathan Jackson <jnthjackson@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Martin Quinson <mquinson@debian.org>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce the 'malta-unleashed' machine. This machine does not
model any existing hardware (as the default 'malta' neither model
a real hardware). The purpose of this machine is to allow user
of the current 'malta' machine to use more RAM, as it has been
reported to be useful for build farms.

References:
- https://www.mail-archive.com/debian-mips@lists.debian.org/msg10912.html
- https://alioth-lists.debian.net/pipermail/pkg-rust-maintainers/2019-January/004844.html
- https://www.mail-archive.com/qemu-devel@nongnu.org/msg691406.html

Cc: debian-mips@lists.debian.org
Cc: Ximin Luo <infinity0@debian.org>
Cc: Martin Quinson <mquinson@debian.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Jonathan Jackson <jnthjackson@gmail.com>
Suggested-by: Yunqiang Su <ysu@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
This patch is RFC because an upstream QEMU maintainer disagree
with this approach, but I'm sending it so interested folks in
the community (Debian or other) can test it.

Previous discussion on Jiaxun Yang's patch:
https://patchwork.kernel.org/patch/11416915/
---
 hw/mips/malta.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 63c1d5ea5f..1695994493 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1505,6 +1505,20 @@ static void malta_machine_strict_class_init(ObjectClass *oc, void *data)
     mmc->verify_dimm_sizes = true;
 };
 
+#ifdef TARGET_MIPS64
+static void malta_machine_unleashed_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    MaltaMachineClass *mmc = MALTA_MACHINE_CLASS(oc);
+
+    mc->desc = "MIPS Malta Core LV (physically unlimited)";
+    mc->block_default_type = IF_IDE;
+    mc->max_cpus = 16;
+    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("20Kc");
+    mmc->max_ramsize = 3 * GiB;
+}
+#endif /* TARGET_MIPS64 */
+
 static const TypeInfo malta_machine_types[] = {
     {
         .name          = MACHINE_TYPE_NAME("malta"),
@@ -1516,6 +1530,13 @@ static const TypeInfo malta_machine_types[] = {
         .parent        = TYPE_MALTA_MACHINE,
         .class_init    = malta_machine_strict_class_init,
     },
+#ifdef TARGET_MIPS64
+    {
+        .name          = MACHINE_TYPE_NAME("malta-unleashed"),
+        .parent        = TYPE_MALTA_MACHINE,
+        .class_init    = malta_machine_unleashed_class_init,
+    },
+#endif /* TARGET_MIPS64 */
     {
         .name          = TYPE_MALTA_MACHINE,
         .parent        = TYPE_MACHINE,
-- 
2.21.3



Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A11C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:22:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B6662072F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CY7klDGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B6662072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiIf8-0006NM-6d
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 10:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jiIbe-0001KN-Tb; Mon, 08 Jun 2020 10:18:30 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44460)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jiIbe-0004Ve-00; Mon, 08 Jun 2020 10:18:30 -0400
Received: by mail-pl1-x642.google.com with SMTP id bh7so6705629plb.11;
 Mon, 08 Jun 2020 07:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7OPh7ztGSwFOj/4M8wX7DpoLYf/oIKyYZ1UVi3dy1kc=;
 b=CY7klDGRnaz6YHzBLCOuTQ29PTnMR3Wy3vsvJKpBFTMBAd/dUK2S8UJxphZD4yCAsM
 hjf3fcxb7jtRcOOiWFP49DjmkCii5Hn6uIAQB06rwBeGKwbUC6EVKSIwHfiE3YXPVQnO
 sHoRfyjTGqA6JqlNqvLe5nNIpU3CfFeJknSSg9Dd4NahPl0q9xM4dd52syYfSGQLZr9s
 cwR2fbng52UJ3I2T30uspK+zXilH3s12/cXI0kRP2xDuw0JHsWspvXhDx7gTWkv/3Vlo
 1yJeSNsq/HluuoQpYQcOnWpmQhPHZ/ci22xkikHv7/RHj6lcjYWDfU9HaZ0MIksquzSr
 RCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7OPh7ztGSwFOj/4M8wX7DpoLYf/oIKyYZ1UVi3dy1kc=;
 b=o2hC71Xg4prIF4qRHzcq7fQP9adB22gTdcJEjT8SY0+m1M/9czdDMogADQJPSH1LKH
 RYM2XXGfFCTf+vzaGRXfQSwRIUcaG6QHipNtRRU9VgIWHuUs0uGCSognH3H4WkddXA58
 3ZzLZAswURmjp5E5evaWWaHR0x2X2Ygv6GbvZpKB5pd74flT6pbF5tYlvB2Wpsi2Sr5+
 9ciPYs/AkTXUIx8DQpumBOg/xLxAXTbkTOzkSZ3p6vHwlA5f+RaWENAVUG74dyPehpec
 esOEGaSIFQPdKoY/rR1WGQB898L2jN7OZfum2cd51KwXyHNaejieEsVuYDF1T5Jp6w3x
 Waag==
X-Gm-Message-State: AOAM533/rDl0U0kAEuH1f/kxPcwBnckE29Lh/rZFwOaQ++4i/NI6hnyL
 7mXvV4iT58VlW+KUHSVGmtA=
X-Google-Smtp-Source: ABdhPJy2ShW1HbItqYULL8geeBzKYcuXb6TZ/DGr4gFFVv2verrUqMD31BUwOzQeaCt9QYSVlmh1iA==
X-Received: by 2002:a17:90b:4d08:: with SMTP id
 mw8mr17200083pjb.119.1591625908323; 
 Mon, 08 Jun 2020 07:18:28 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id b19sm7292575pft.74.2020.06.08.07.18.27
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 08 Jun 2020 07:18:27 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 10/15] hw/riscv: sifive_u: Rename serial property get/set
 functions to a generic name
Date: Mon,  8 Jun 2020 07:17:39 -0700
Message-Id: <1591625864-31494-11-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
References: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

In prepration to add more properties to this machine, rename the
existing serial property get/set functions to a generic name.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/riscv/sifive_u.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index ef51874..07e2ba0 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -481,14 +481,16 @@ static void sifive_u_machine_set_start_in_flash(Object *obj, bool value, Error *
     s->start_in_flash = value;
 }
 
-static void sifive_u_machine_get_serial(Object *obj, Visitor *v, const char *name,
-                                void *opaque, Error **errp)
+static void sifive_u_machine_get_uint32_prop(Object *obj, Visitor *v,
+                                             const char *name, void *opaque,
+                                             Error **errp)
 {
     visit_type_uint32(v, name, (uint32_t *)opaque, errp);
 }
 
-static void sifive_u_machine_set_serial(Object *obj, Visitor *v, const char *name,
-                                void *opaque, Error **errp)
+static void sifive_u_machine_set_uint32_prop(Object *obj, Visitor *v,
+                                             const char *name, void *opaque,
+                                             Error **errp)
 {
     visit_type_uint32(v, name, (uint32_t *)opaque, errp);
 }
@@ -507,8 +509,8 @@ static void sifive_u_machine_instance_init(Object *obj)
 
     s->serial = OTP_SERIAL;
     object_property_add(obj, "serial", "uint32",
-                        sifive_u_machine_get_serial,
-                        sifive_u_machine_set_serial, NULL, &s->serial);
+                        sifive_u_machine_get_uint32_prop,
+                        sifive_u_machine_set_uint32_prop, NULL, &s->serial);
     object_property_set_description(obj, "serial", "Board serial number");
 }
 
-- 
2.7.4



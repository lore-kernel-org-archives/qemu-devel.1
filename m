Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A35C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:54:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E701520758
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBNszTaa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E701520758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jai6F-0005OV-2Y
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 11:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jai4q-00034C-A2; Mon, 18 May 2020 11:53:16 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53829)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jai4p-00005F-F0; Mon, 18 May 2020 11:53:15 -0400
Received: by mail-wm1-x344.google.com with SMTP id k12so20719wmj.3;
 Mon, 18 May 2020 08:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WPXev8+IwguGZ8+5BAOfNLRRppnJCLUsP59v0te4Ye0=;
 b=GBNszTaaBEoLSKErf6Onp2KjlP2lFLTKTV4hGUyCnOMb7cgyVRocIEAPY8J3mCvb8Z
 vCLXgoCH3exBUN+Yjhpatnjh2Fa5e1ewx1l3wOj4/SrE8ApiJzbGKFBw2Fk0/ADaP63I
 bKZiVONe3xodATG6yQv3Mm0gvaazMRU/T7zFjIayETtffjPtUlcgjkmY4YHXL9KjPjUG
 8NwSfTHR05vPqYuItDiHZDYMDcHpYzEeXbnyBK2nu5eOha5ZGzFFsSAJhOruzapfQKPz
 24y236VkwWStBZHxoh2/GZN2xjsFUq8IM0KPfG/DLwlqaj2FIlz5EX4CG6JWCxKql8/O
 rSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=WPXev8+IwguGZ8+5BAOfNLRRppnJCLUsP59v0te4Ye0=;
 b=g6+5pdi0m1zEr4EJRrxwlYmdopVaJ+YGots8QTbGYRScwSsJk8FsejKog/w1Qac/K4
 K8SrYahudcqFi0LhBPyQqxp3wwvggLis5HcTZLjAr1NHBxxhWIcEFii7zaxKwowWDegJ
 o1kWiQMly2qYQ4hhzEDVzYsb85edhapm5haP4RaKUHI2lO3cw2D3s6OD07+9sYzJnSkH
 exVw8lfbl1J2WcsBHiayZ1Mvq+ctAlEq4JS9LUiEARElaD8sn3HSesk2CgNxlSL6rzrw
 ROSh1jtZ+03JKPreKYjq+2SRmIANzJdFM9+HkZLuqOnt5Wc7U2Ga4oud9CuxKCSlfXvc
 7bJQ==
X-Gm-Message-State: AOAM533ctikKRfSxJgk991EjAjFOamYkTAxv/drQX/EigPBvk8CF2E1F
 AmzDh0BZKXXuY6stQWrjRIxYI4t8KZQ=
X-Google-Smtp-Source: ABdhPJzmaRkrF6Y1/DbPQKadJiZELqBF4agH6qtXZaXxgNHiLJ/vIraP/94NcfVxkbXCvsz/IBZspw==
X-Received: by 2002:a7b:c8d4:: with SMTP id f20mr60869wml.72.1589817192193;
 Mon, 18 May 2020 08:53:12 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 7sm17647462wra.50.2020.05.18.08.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 08:53:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/7] exec: Propagate cpu_memory_rw_debug() error
Date: Mon, 18 May 2020 17:53:03 +0200
Message-Id: <20200518155308.15851-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200518155308.15851-1-f4bug@amsat.org>
References: <20200518155308.15851-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not ignore the MemTxResult error type returned by
the address_space_rw() API.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/exec/cpu-all.h |  1 +
 exec.c                 | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index d14374bdd4..fb4e8a8e29 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -413,6 +413,7 @@ void dump_exec_info(void);
 void dump_opcount_info(void);
 #endif /* !CONFIG_USER_ONLY */
 
+/* Returns: 0 on success, -1 on error */
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
                         void *ptr, target_ulong len, bool is_write);
 
diff --git a/exec.c b/exec.c
index 877b51cc5c..ae5a6944ef 100644
--- a/exec.c
+++ b/exec.c
@@ -3769,6 +3769,7 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
     while (len > 0) {
         int asidx;
         MemTxAttrs attrs;
+        MemTxResult res;
 
         page = addr & TARGET_PAGE_MASK;
         phys_addr = cpu_get_phys_page_attrs_debug(cpu, page, &attrs);
@@ -3781,11 +3782,14 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
             l = len;
         phys_addr += (addr & ~TARGET_PAGE_MASK);
         if (is_write) {
-            address_space_write_rom(cpu->cpu_ases[asidx].as, phys_addr,
-                                    attrs, buf, l);
+            res = address_space_write_rom(cpu->cpu_ases[asidx].as, phys_addr,
+                                          attrs, buf, l);
         } else {
-            address_space_read(cpu->cpu_ases[asidx].as, phys_addr, attrs, buf,
-                               l);
+            res = address_space_read(cpu->cpu_ases[asidx].as, phys_addr,
+                                     attrs, buf, l);
+        }
+        if (res != MEMTX_OK) {
+            return -1;
         }
         len -= l;
         buf += l;
-- 
2.21.3



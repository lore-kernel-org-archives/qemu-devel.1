Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEBDC47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 20:02:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51D4206B6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 20:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="K/cgc8ip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51D4206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIIAg-0002H1-Od
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 16:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56188)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <msmarduch@digitalocean.com>) id 1iIF69-000263-8z
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 12:46:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <msmarduch@digitalocean.com>) id 1iIF68-0001k6-3Q
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 12:46:01 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39920)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <msmarduch@digitalocean.com>)
 id 1iIF67-0001ix-UY
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 12:46:00 -0400
Received: by mail-oi1-x243.google.com with SMTP id w144so2329728oia.6
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 09:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=digitalocean.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=USBhbd2qdz43lBvTF90+/aku+zY1BGuB8YB3YsvDEsk=;
 b=K/cgc8ip8Trh/UzP24Ybq9Ru+/wEGzn3Ce8H2Df4fY0jqGSTyhWVKXsBeg1xcxRSZf
 bzCD3XJoTx8j+2dQ6RX8zZvwa6blK+f0IVtrZWAkKTB2USKgxfdUfM+Gn93pbOlttmqP
 jtv6b9yfDvAn27g31BvHO29aGYvnqEmQFC5b4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=USBhbd2qdz43lBvTF90+/aku+zY1BGuB8YB3YsvDEsk=;
 b=e/rdw9E2C7bjXb8BFV0eq68WSYi3qFeBtCjXPzhcWMkg4gc0yDc89ToWd5W2gzoirH
 6iooZM5IiznY2wZp7rfQ96fw3/N5zo9yp7ksHYib3e7eT5pEd+1MkYG2Q1v5/oMjrD0+
 nCb3eHvcwXCU9XiQxrxWBXc4MTVP/k7J6rpdP8VqUmNg1SLxOM5G4DoAuW3nq64fKsn8
 52GsL/t1cZCZfQqcKi4bC1gL1dFKi7pyEQfq04OFkT/qjVVvlcjadyrKE4QGT3Z6Yo5O
 QH1LvrissHfbzn4138gCCXyMe41tDdvxWdwMc+tWjEpj9eJq9NGTPHZJgJmFTQlKQaNT
 MHKQ==
X-Gm-Message-State: APjAAAW6WHvwKAFqpANSfZsellaPUeVF5gsolUv+UZHcwQRddSEj7yhP
 LptHII5ChhPluNjZMuuajf1ZrQ==
X-Google-Smtp-Source: APXvYqzSykY2vXaWT1phz43fJDxY1HjvHG5KdsjA7bg8aI5Ho+b967sZD4OAa21R66F5htQHVrwqGg==
X-Received: by 2002:a54:4519:: with SMTP id l25mr3163818oil.143.1570639557881; 
 Wed, 09 Oct 2019 09:45:57 -0700 (PDT)
Received: from msmarduch-ThinkPad-T460s.attlocal.net
 ([2600:1700:4a30:84c0:8d5e:794e:8a2e:ee89])
 by smtp.gmail.com with ESMTPSA id q1sm789818otn.8.2019.10.09.09.45.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Oct 2019 09:45:57 -0700 (PDT)
From: Mario Smarduch <msmarduch@digitalocean.com>
To: philmd@redhat.com, mtosatti@redhat.com, pbonzini@redhat.com,
 armbru@redhat.com
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, rth@twiddle.net,
 ehabkost@redhat.com, Mario Smarduch <msmarduch@digitalocean.com>
Subject: [PATCHv2 2/2] target/i386: log MCE guest and host addresses
Date: Wed,  9 Oct 2019 09:44:59 -0700
Message-Id: <20191009164459.8209-3-msmarduch@digitalocean.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20191009164459.8209-1-msmarduch@digitalocean.com>
References: <20191009164459.8209-1-msmarduch@digitalocean.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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

Patch logs MCE AO, AR messages injected to guest or taken by QEMU itself.
We print the QEMU address for guest MCEs, helps on hypervisors that have
another source of MCE logging like mce log, and when they go missing.

For example we found these QEMU logs:

September 26th 2019, 17:36:02.309        Droplet-153258224: Guest MCE Memory Error at qemu addr 0x7f8ce14f5000 and guest 3d6f5000 addr of type BUS_MCEERR_AR injected   qemu-system-x86_64      amsN    ams3nodeNNNN

September 27th 2019, 06:25:03.234        Droplet-153258224: Guest MCE Memory Error at qemu addr 0x7f8ce14f5000 and guest 3d6f5000 addr of type BUS_MCEERR_AR injected   qemu-system-x86_64      amsN    ams3nodeNNNN

The first log had a corresponding mce log entry, the second didnt (logging
thresholds) we can infer from second entry same PA and mce type.

Signed-off-by: Mario Smarduch <msmarduch@digitalocean.com>
---
 target/i386/kvm.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 11b9c85..7eeefac 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -592,9 +592,9 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
                        (MCM_ADDR_PHYS << 6) | 0xc, flags);
 }
 
-static void hardware_memory_error(void)
+static void hardware_memory_error(void *host_addr)
 {
-    fprintf(stderr, "Hardware memory error!\n");
+    error_report("QEMU got Hardware memory error at addr %p", host_addr);
     exit(1);
 }
 
@@ -618,15 +618,34 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
             kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
             kvm_hwpoison_page_add(ram_addr);
             kvm_mce_inject(cpu, paddr, code);
+
+            /*
+             * Use different logging severity based on error type.
+             * If there is additional MCE reporting on the hypervisor, QEMU VA
+             * could be another source to identify the PA and MCE details.
+             */
+            if (code == BUS_MCEERR_AR) {
+                error_report("Guest MCE Memory Error at QEMU addr %p and "
+                    "GUEST addr 0x%" HWADDR_PRIx " of type %s injected",
+                    addr, paddr, "BUS_MCEERR_AR");
+            } else {
+                 warn_report("Guest MCE Memory Error at QEMU addr %p and "
+                     "GUEST addr 0x%" HWADDR_PRIx " of type %s injected",
+                     addr, paddr, "BUS_MCEERR_AO");
+            }
+
             return;
         }
 
-        fprintf(stderr, "Hardware memory error for memory used by "
-                "QEMU itself instead of guest system!\n");
+        if (code == BUS_MCEERR_AO) {
+            warn_report("Hardware memory error at addr %p of type %s "
+                "for memory used by QEMU itself instead of guest system!",
+                 addr, "BUS_MCEERR_AO");
+        }
     }
 
     if (code == BUS_MCEERR_AR) {
-        hardware_memory_error();
+        hardware_memory_error(addr);
     }
 
     /* Hope we are lucky for AO MCE */
-- 
2.9.3



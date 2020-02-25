Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC0DC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:52:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA3D21556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dm+WYq/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA3D21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Ylk-0002Or-FQ
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:52:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkB-0000D6-JI
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkA-0005db-EM
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:19 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:43419)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Yk7-0005Mw-90
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:15 -0500
Received: by mail-wr1-x42b.google.com with SMTP id r11so14365586wrq.10
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=o7csTB+CkyjNH23bHf4nGPkpPJisSHmuxScF4XcbInI=;
 b=Dm+WYq/oYQyRr8f4cXXm6bwJLct54m+uUOM8vGC+2ycFQj2az/EdlUUJ2wPlNgN2yZ
 5f6ZRnmRgh4rGJsNgPwIUh6R+Yd1jHJ73L3uls7lfqeZh2AoJIzEX40nNF9tobipsphB
 2bu++vqzsFVwBF6aG0a0nRBul+jdnpjog8S35fexQvAMlR6V2HiT2BtSSRDejAsC4Y3w
 9S+c3A62rIO64RpEPaR1uRcL0WmPMtZblzOcsef8ZTxwvZeB8j5dEo5G0ChPR5zdUdzV
 L5DB8cH0sCYHFJ1n0YSnPSY0JSeJtmXjm60zmooywSPZ6KVuF69vXTHjaJ8tsNOFoeAY
 qWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=o7csTB+CkyjNH23bHf4nGPkpPJisSHmuxScF4XcbInI=;
 b=t2YrpzQpcyINKxkeEjhxYBFhZc2kMQIGXDZ9Zcc3h0AOtqntlBEWpQZHxhvW6rEsKe
 22tVn5dnrXgExv1PlNRK8HZByC6VuzAHKLJCC3muIGTrM+kWAn/tRNGbegQhK6G3UFCU
 mYtE5Nfew3Mgg2x37ClvncEonmmBBcSo4mbr10tN8bYmLjsm6puN4zMlP+cd+JwE41BF
 VMdDPHMPtyy3I0Zo52fYiELxrOsitf1ws50hpNHTyago43nZOYMn7iuztvyEdch8crqD
 JKam5pRtDSS8HHPmgguHdIJnYErQ3vl4Gy6LWcFLL9rFwa2VbaWGrP47mpVKOGazNPD+
 qQQw==
X-Gm-Message-State: APjAAAWsKbyLaPU2skuJWn9IKxy/TkeCjUhXgwxh6GIHmKnYCDbzZKsl
 KxXalGMD1lELOyDhyseLq6bH4xxe
X-Google-Smtp-Source: APXvYqxtgE4e8X+rAeNE8SiqReEAIAMJgvT1gyJiMlb+H5+Q2wKPv0n737JjYUf0rTYrZXCpoILxtA==
X-Received: by 2002:adf:f3cd:: with SMTP id g13mr74400336wrp.54.1582631472151; 
 Tue, 25 Feb 2020 03:51:12 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 006/136] vl.c: move -m parsing after memory backends has been
 processed
Date: Tue, 25 Feb 2020 12:48:56 +0100
Message-Id: <1582631466-13880-6-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

It will be possible for main RAM to come from memory-backend
and we should check that size specified in -m matches the size
of the backend and [MachineState::]ram_size also matches
backend's size.

However -m parsing (set_memory_options()) happens before backends
are intialized (object_create_delayed()) which complicates it.
Consolidate set_memory_options() and assigning parsed results to
current_machine after backends are initialized, so it would be
possible access the initialized backend instance to compare
sizes.

This patch only consolidates scattered places touching ram_size
within vl.c. And follow up patch will integrate backend handling
to set_memory_options().

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200219160953.13771-7-imammedo@redhat.com>
---
 vl.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/vl.c b/vl.c
index 2103804..72ffc06 100644
--- a/vl.c
+++ b/vl.c
@@ -2655,6 +2655,14 @@ static void set_memory_options(uint64_t *ram_slots, ram_addr_t *maxram_size,
         exit(EXIT_FAILURE);
     }
 
+    if (!xen_enabled()) {
+        /* On 32-bit hosts, QEMU is limited by virtual address space */
+        if (ram_size > (2047 << 20) && HOST_LONG_BITS == 32) {
+            error_report("at most 2047 MB RAM can be simulated");
+            exit(1);
+        }
+    }
+
     loc_pop(&loc);
 }
 
@@ -3819,8 +3827,6 @@ int main(int argc, char **argv, char **envp)
     machine_class = select_machine();
     object_set_machine_compat_props(machine_class->compat_props);
 
-    set_memory_options(&ram_slots, &maxram_size, machine_class);
-
     os_daemonize();
     rcu_disable_atfork();
 
@@ -4122,9 +4128,6 @@ int main(int argc, char **argv, char **envp)
     machine_opts = qemu_get_machine_opts();
     qemu_opt_foreach(machine_opts, machine_set_property, current_machine,
                      &error_fatal);
-    current_machine->ram_size = ram_size;
-    current_machine->maxram_size = maxram_size;
-    current_machine->ram_slots = ram_slots;
 
     /*
      * Note: uses machine properties such as kernel-irqchip, must run
@@ -4235,14 +4238,6 @@ int main(int argc, char **argv, char **envp)
 
     tpm_init();
 
-    if (!xen_enabled()) {
-        /* On 32-bit hosts, QEMU is limited by virtual address space */
-        if (ram_size > (2047 << 20) && HOST_LONG_BITS == 32) {
-            error_report("at most 2047 MB RAM can be simulated");
-            exit(1);
-        }
-    }
-
     blk_mig_init();
     ram_mig_init();
     dirty_bitmap_mig_init();
@@ -4287,6 +4282,12 @@ int main(int argc, char **argv, char **envp)
     if (cpu_option) {
         current_machine->cpu_type = parse_cpu_option(cpu_option);
     }
+
+    set_memory_options(&ram_slots, &maxram_size, machine_class);
+    current_machine->ram_size = ram_size;
+    current_machine->maxram_size = maxram_size;
+    current_machine->ram_slots = ram_slots;
+
     parse_numa_opts(current_machine);
 
     if (machine_class->default_ram_id && current_machine->ram_size &&
-- 
1.8.3.1




Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C8AC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:24:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 407DC20CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cd+ZMBtO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407DC20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZFr-0007cT-Dr
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:24:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl4-0001Hg-1p
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykz-0008GS-8C
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:13 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:36617)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Ykx-00083p-D5
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:08 -0500
Received: by mail-wr1-x42b.google.com with SMTP id z3so14384082wru.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vPqLsmgksx1vqy9WuZ6jPM/E+F8HlA4FUDvGLVEw7hk=;
 b=Cd+ZMBtOki0dX8w+vrs+TnxgJJ24sjoQxXdXzMD3DvEfF5T36zHMyq6OXHkAsShsSf
 J8SD5Mff5n5kqdEdbbEg0Gnq8qtTiMd7qkVWrscXw9z+qNfcgtyy4+TqpYYGi9vv1DAu
 PcPwpExoMLhmjPDags47lOdpkKTWPAaoHSMYd5y9/zRFgGmloX3z64UUL06/aNmD7xjX
 uLVlF3qruiqjSUMx/lfNl1eMOTxvqkm1pVCq0Tb+VXUhmtPP2yRGHW1UuF/41wxKQOwo
 77bOhW8HeuKGaB1OhRyQw7t4VAM9RU3mQp669eaEzontm6VP5wUHWRjHf3Dd7WLYO4UI
 yIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=vPqLsmgksx1vqy9WuZ6jPM/E+F8HlA4FUDvGLVEw7hk=;
 b=p6di2VsZGS1J18HgyLsjtHd2dUK25OWTqIBuw48JZG/nvmLGT2BHeQgohJoP++89NG
 MgvqQUQJbbfhlu6fjxhHw0/euPGL3y44yifyqCjm5geM2846EJhbjvFPf7dc0pWGhvM9
 tNPw1fYlonixuRsud8BRSXGxBbgyGcBURvKA1t0wwXbzjALNQuniR7We46ECW609S2wH
 eu0/hzra6Js93q9Gs+jUJzdd7CYEtXPUP7IFRHk7m6rK9ABWsS+YRvKOVVN4cwcr/z3I
 dZtDbdVU6m4qMYpzPXf0PyppIb6+GOvtVIE9GrfIA2UvlxhA9T+OywUhv2n4cSZpCScv
 VjVQ==
X-Gm-Message-State: APjAAAVnqB1KC+6hHOZ+2163f1c7m/SSsYVa6yUfnuz12uZOKlyciEbO
 1KqIJ9wQKHJLcV3ECn+rDJBZeDuI
X-Google-Smtp-Source: APXvYqyvveM+Xq76a/FV0js3V6obkcsc1AIVRe06WfLibrPrXhcnkSHbG6ILs2XvvcUiz2w8PkXWXg==
X-Received: by 2002:adf:e546:: with SMTP id z6mr648129wrm.423.1582631519600;
 Tue, 25 Feb 2020 03:51:59 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 058/136] ppc/e500: drop RAM size fixup
Date: Tue, 25 Feb 2020 12:49:48 +0100
Message-Id: <1582631466-13880-58-git-send-email-pbonzini@redhat.com>
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

If user provided non-sense RAM size, board will complain and
continue running with max RAM size supported.
Also RAM is going to be allocated by generic code, so it won't be
possible for board to fix things up for user.

Make it error message and exit to force user fix CLI,
instead of accepting non-sense CLI values.

While at it, replace usage of global ram_size with
machine->ram_size

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-59-imammedo@redhat.com>
---
 hw/ppc/e500.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 886442e..960024b 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -906,12 +906,14 @@ void ppce500_init(MachineState *machine)
 
     env = firstenv;
 
-    /* Fixup Memory size on a alignment boundary */
-    ram_size &= ~(RAM_SIZES_ALIGN - 1);
-    machine->ram_size = ram_size;
+    if (!QEMU_IS_ALIGNED(machine->ram_size, RAM_SIZES_ALIGN)) {
+        error_report("RAM size must be multiple of %" PRIu64, RAM_SIZES_ALIGN);
+        exit(EXIT_FAILURE);
+    }
 
     /* Register Memory */
-    memory_region_allocate_system_memory(ram, NULL, "mpc8544ds.ram", ram_size);
+    memory_region_allocate_system_memory(ram, NULL, "mpc8544ds.ram",
+                                         machine->ram_size);
     memory_region_add_subregion(address_space_mem, 0, ram);
 
     dev = qdev_create(NULL, "e500-ccsr");
@@ -1083,7 +1085,7 @@ void ppce500_init(MachineState *machine)
         kernel_base = cur_base;
         kernel_size = load_image_targphys(machine->kernel_filename,
                                           cur_base,
-                                          ram_size - cur_base);
+                                          machine->ram_size - cur_base);
         if (kernel_size < 0) {
             error_report("could not load kernel '%s'",
                          machine->kernel_filename);
@@ -1097,7 +1099,7 @@ void ppce500_init(MachineState *machine)
     if (machine->initrd_filename) {
         initrd_base = (cur_base + INITRD_LOAD_PAD) & ~INITRD_PAD_MASK;
         initrd_size = load_image_targphys(machine->initrd_filename, initrd_base,
-                                          ram_size - initrd_base);
+                                          machine->ram_size - initrd_base);
 
         if (initrd_size < 0) {
             error_report("could not load initial ram disk '%s'",
@@ -1115,7 +1117,7 @@ void ppce500_init(MachineState *machine)
      * ensures enough space between kernel and initrd.
      */
     dt_base = (loadaddr + payload_size + DTC_LOAD_PAD) & ~DTC_PAD_MASK;
-    if (dt_base + DTB_MAX_SIZE > ram_size) {
+    if (dt_base + DTB_MAX_SIZE > machine->ram_size) {
             error_report("not enough memory for device tree");
             exit(1);
     }
-- 
1.8.3.1




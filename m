Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DEAC35240
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 01:00:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7402D2071E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 01:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJXHPXxV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7402D2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iunKl-0002zF-LK
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 20:00:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCw-0002YN-4O
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:52:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCr-0005Xv-Qb
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:52:22 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33400)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCr-0005Wh-JW; Thu, 23 Jan 2020 19:52:17 -0500
Received: by mail-wr1-x443.google.com with SMTP id b6so93009wrq.0;
 Thu, 23 Jan 2020 16:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dGXYfTp1tAJSxkUbjHMAEY4QwD94q//Di6i1M2vBqg8=;
 b=rJXHPXxVsSFpjxXqwp+Qnd5zHRqmU2NWiYFTlyIhLD7zKrfxRIJhpj4aZW22Nx2XEI
 Z1TYLhpPwO8zrlDVbexQRPAaVJa+ua74BTDpFHcMWRI27MDG5OMOlnJUTcGdLFd86SgG
 DwkMVefqfPZBCCyfIuRyi2G9OcHvmaHBjBMog0VsXcTbrVaAOVRNhxsSbsXJAJVlaWSx
 OH9Mxjqbobm7mKzEJQJmP4kSnov/yBjCnZfUkQ5Au0fqSD8oQUXoeKqSECGiJDhOHzmy
 9bQMRaZfeDV2YQwKFfZ60WbauHPx2uDjiDCcSaGbLR+wOxktxXbFZCr3/MTQtn7HuG9R
 f+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=dGXYfTp1tAJSxkUbjHMAEY4QwD94q//Di6i1M2vBqg8=;
 b=E0aWRC1jbfTpCDJn26K94RKX9EdZQ60Os9hkKFINzmSUqkStu+WCvy3QrD7lnFNrog
 okD2qvbRUwUhyaoIH8xVqXTPtGpqXcHmyseMPFLg0iQJGzjBftiREpwzyIYf9cOe3mm4
 PTNDJLS/OiY2h6g5DclJFKJzebO2dnyMCD6NV5E85xhhW1W1rT/ccdi0yRs0adwUZdaE
 rT684X6VrPLMB1umEyrXjbdetGxWipk9CA0hCTBw54QMsCKEouiFzUfEqSGyJSfnZW7Q
 NIhzHMEk/EnQgcl7bvPzb8r5yxYrd9zYHb70aaI8l2O17CQYkq2OobqdE8O+GINnNGlG
 f0qw==
X-Gm-Message-State: APjAAAX5p2KvIeyGGKO2Ey00KKUC3PWlbAR6EsUhcfr73S/ncJWYKzsF
 lndqqs/x/50fSfY/idUDVyVxCe8X
X-Google-Smtp-Source: APXvYqzJyMp4pn8qYZJFl0vNPC1Is6VnlD3AF/RY6fL1eC8lo+QlqVu1hOyynAuSp6/QOpWHZ8OGRw==
X-Received: by 2002:a5d:6344:: with SMTP id b4mr832418wrw.414.1579827136244;
 Thu, 23 Jan 2020 16:52:16 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id s139sm4598271wme.35.2020.01.23.16.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 16:52:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, mrolnik@gmail.com, richard.henderson@linaro.org,
 me@xcancerberox.com.ar
Subject: [PATCH rc2 18/25] hw/core/loader: Let load_elf populate the
 processor-specific flags
Date: Fri, 24 Jan 2020 01:51:24 +0100
Message-Id: <20200124005131.16276-19-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200124005131.16276-1-f4bug@amsat.org>
References: <20200124005131.16276-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Fam Zheng <fam@euphon.net>, S.E.Harris@kent.ac.uk,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Markus Armbruster <armbru@redhat.com>, dovgaluk@ispras.ru,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 aleksandar.m.mail@gmail.com, Laurent Vivier <lvivier@redhat.com>,
 thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

One some architectures (like AVR) we can determine
the cpu type by reading the ELF flags.

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <<20191218210329.1960-16-mrolnik@gmail.com>
[PMD: Extracted from bigger patch,
      Replaced 'uint32_t *pe_flags' by 'int proc_flags']
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/elf_ops.h |  6 +++++-
 include/hw/loader.h  |  6 ++++--
 hw/core/loader.c     | 15 ++++++++-------
 hw/riscv/boot.c      |  2 +-
 4 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index e07d276df7..5d0f9587d3 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -316,7 +316,8 @@ static int glue(load_elf, SZ)(const char *name, int fd,
                               void *translate_opaque,
                               int must_swab, uint64_t *pentry,
                               uint64_t *lowaddr, uint64_t *highaddr,
-                              int elf_machine, int clear_lsb, int data_swab,
+                              int *proc_flags, int elf_machine,
+                              int clear_lsb, int data_swab,
                               AddressSpace *as, bool load_rom,
                               symbol_fn_t sym_cb)
 {
@@ -389,6 +390,9 @@ static int glue(load_elf, SZ)(const char *name, int fd,
             }
     }
 
+    if (proc_flags) {
+        *proc_flags = (elf_sword)ehdr.e_flags;
+    }
     if (pentry)
         *pentry = (uint64_t)(elf_sword)ehdr.e_entry;
 
diff --git a/include/hw/loader.h b/include/hw/loader.h
index 48a96cd559..cc5ede7b90 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -101,6 +101,7 @@ const char *load_elf_strerror(int error);
  * @pentry: Populated with program entry point. Ignored if NULL.
  * @lowaddr: Populated with lowest loaded address. Ignored if NULL.
  * @highaddr: Populated with highest loaded address. Ignored if NULL.
+ * @proc_flags: Populated with ELF processor-specific flags. Ignore if NULL.
  * @bigendian: Expected ELF endianness. 0 for LE otherwise BE
  * @elf_machine: Expected ELF machine type
  * @clear_lsb: Set to mask off LSB of addresses (Some architectures use
@@ -131,8 +132,9 @@ int load_elf_ram_sym(const char *filename,
                      uint64_t (*elf_note_fn)(void *, void *, bool),
                      uint64_t (*translate_fn)(void *, uint64_t),
                      void *translate_opaque, uint64_t *pentry,
-                     uint64_t *lowaddr, uint64_t *highaddr, int big_endian,
-                     int elf_machine, int clear_lsb, int data_swab,
+                     uint64_t *lowaddr, uint64_t *highaddr, int *proc_flags,
+                     int big_endian, int elf_machine,
+                     int clear_lsb, int data_swab,
                      AddressSpace *as, bool load_rom, symbol_fn_t sym_cb);
 
 /** load_elf_ram:
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 5099f27dc8..3bee2f8ae0 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -438,7 +438,7 @@ int load_elf_ram(const char *filename,
 {
     return load_elf_ram_sym(filename, elf_note_fn,
                             translate_fn, translate_opaque,
-                            pentry, lowaddr, highaddr, big_endian,
+                            pentry, lowaddr, highaddr, NULL, big_endian,
                             elf_machine, clear_lsb, data_swab, as,
                             load_rom, NULL);
 }
@@ -448,8 +448,9 @@ int load_elf_ram_sym(const char *filename,
                      uint64_t (*elf_note_fn)(void *, void *, bool),
                      uint64_t (*translate_fn)(void *, uint64_t),
                      void *translate_opaque, uint64_t *pentry,
-                     uint64_t *lowaddr, uint64_t *highaddr, int big_endian,
-                     int elf_machine, int clear_lsb, int data_swab,
+                     uint64_t *lowaddr, uint64_t *highaddr, int *proc_flags,
+                     int big_endian, int elf_machine,
+                     int clear_lsb, int data_swab,
                      AddressSpace *as, bool load_rom, symbol_fn_t sym_cb)
 {
     int fd, data_order, target_data_order, must_swab, ret = ELF_LOAD_FAILED;
@@ -490,13 +491,13 @@ int load_elf_ram_sym(const char *filename,
     if (e_ident[EI_CLASS] == ELFCLASS64) {
         ret = load_elf64(filename, fd, elf_note_fn,
                          translate_fn, translate_opaque, must_swab,
-                         pentry, lowaddr, highaddr, elf_machine, clear_lsb,
-                         data_swab, as, load_rom, sym_cb);
+                         pentry, lowaddr, highaddr, proc_flags, elf_machine,
+                         clear_lsb, data_swab, as, load_rom, sym_cb);
     } else {
         ret = load_elf32(filename, fd, elf_note_fn,
                          translate_fn, translate_opaque, must_swab,
-                         pentry, lowaddr, highaddr, elf_machine, clear_lsb,
-                         data_swab, as, load_rom, sym_cb);
+                         pentry, lowaddr, highaddr, proc_flags, elf_machine,
+                         clear_lsb, data_swab, as, load_rom, sym_cb);
     }
 
  fail:
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 027303d2a3..746ca1f795 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -119,7 +119,7 @@ target_ulong riscv_load_kernel(const char *kernel_filename, symbol_fn_t sym_cb)
     uint64_t kernel_entry, kernel_high;
 
     if (load_elf_ram_sym(kernel_filename, NULL, NULL, NULL,
-                         &kernel_entry, NULL, &kernel_high, 0,
+                         &kernel_entry, NULL, &kernel_high, NULL, 0,
                          EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
         return kernel_entry;
     }
-- 
2.21.1



Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05AFC55179
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:54:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BA4C2225F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cLidm0Xu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA4C2225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVIJQ-0006EV-6Q
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kVI3x-0006hC-W2
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:38:14 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:44568)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kVI3u-0006UY-6c
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:38:13 -0400
Received: by mail-pf1-x441.google.com with SMTP id f19so1880732pfj.11
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uXEiXCwmZ4IatXzjo8oCm1sQVSclKFFXnkVflorhWjg=;
 b=cLidm0XuUM7MSAP6Wh9lagSVqpYg6YyccFm218JS/hD14EZYis6gZr3svZWmJGa73s
 zRzI3nTxuOk5mW47b7AA5A50Pen3l8gTOxYHo2nMzNEJ2wZ44icaoDgey/8fI2yak3tL
 2xKaZzfdtgNlTdx32sSyii8MFBGozaDWfvJmPJWOx/ntF6gGXhKhbfz6pfUBofCDrsW5
 8lTXsyYoCptmA3dOU3nboqIHctu2ZG/z/bxdNH18RFYpYJ9AS27G5Slh158nX3KwJyuf
 PJas4AAAR8rYU6kgTgCSFewG2/trEqUyYSV9WmIcYc+MVMa+VHVd1Bi5ePm4OTwo6aKz
 Jo2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uXEiXCwmZ4IatXzjo8oCm1sQVSclKFFXnkVflorhWjg=;
 b=h3X9+u8xUtYYeyjwzO4tKQoZpIGzG1YBpSaS3kHw3CQA9Qzc+s5YKhFls7t0fCMC0d
 sKk9WqSlUC0yfRpcUo5RC2CCZtKXWH8ZVPkHtNj3r2iXGcqMSYifiZ2vrLtNaUyGMVbL
 A6vyIScWG20T9F+Ts9McmJhmIG5EVadUui/YNAcLj7uVy8P5l3hNznnUmkY5ncN3tShH
 0XTZo6cRfigaSVHgfvZ+ZqOOFloKmwcrN7eFzcc2UB4duGdw3NzTDqYWsdsV3LvyPaVU
 mUHfMkF5qTf0FmvqxPl+4Zw5InaCUPmIxNbjT85uelYMZtpR30MvGkdNY4QX2IkKaIHQ
 GeTQ==
X-Gm-Message-State: AOAM5328md9jFdPDny+WW0JaLOuqLPmTbD/FvPXTKTzkWu6iXhzy/yoa
 TEeTtNS6FkUtdx8tP6TEhK3WnXchjY6IiA==
X-Google-Smtp-Source: ABdhPJz+wIYocRi8SBDyTYbF5+lWxZAK8g1x/9hBahiJ5k2Qn23OEeECRfU5E6mRC030lFlAaj7+gg==
X-Received: by 2002:a62:17c2:0:b029:158:ca2e:3cd7 with SMTP id
 185-20020a6217c20000b0290158ca2e3cd7mr4546856pfx.43.1603301886732; 
 Wed, 21 Oct 2020 10:38:06 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id h5sm2928829pfh.9.2020.10.21.10.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:38:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v12 10/12] linux-user/elfload: Parse NT_GNU_PROPERTY_TYPE_0
 notes
Date: Wed, 21 Oct 2020 10:37:47 -0700
Message-Id: <20201021173749.111103-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021173749.111103-1-richard.henderson@linaro.org>
References: <20201021173749.111103-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is generic support, with the code disabled for all targets.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v9: Only map the startup executable with BTI; anything else must be
    handled by the interpreter.
v10: Split out preparatory patches (pmm).
v11: Mirror(-ish) the kernel's code structure (pmm).
---
 linux-user/qemu.h    |   4 ++
 linux-user/elfload.c | 157 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 161 insertions(+)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 941ca99722..534753ca12 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -61,6 +61,10 @@ struct image_info {
         abi_ulong       interpreter_loadmap_addr;
         abi_ulong       interpreter_pt_dynamic_addr;
         struct image_info *other_info;
+
+        /* For target-specific processing of NT_GNU_PROPERTY_TYPE_0. */
+        uint32_t        note_flags;
+
 #ifdef TARGET_MIPS
         int             fp_abi;
         int             interp_fp_abi;
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 04c04bc260..428dcaa152 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1522,6 +1522,15 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 
 #include "elf.h"
 
+static bool arch_parse_elf_property(uint32_t pr_type, uint32_t pr_datasz,
+                                    const uint32_t *data,
+                                    struct image_info *info,
+                                    Error **errp)
+{
+    g_assert_not_reached();
+}
+#define ARCH_USE_GNU_PROPERTY 0
+
 struct exec
 {
     unsigned int a_info;   /* Use macros N_MAGIC, etc for access */
@@ -2373,6 +2382,150 @@ void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
                   "@ 0x%" PRIx64 "\n", (uint64_t)guest_base);
 }
 
+enum {
+    /* The string "GNU\0" as a magic number. */
+    GNU0_MAGIC = const_le32('G' | 'N' << 8 | 'U' << 16),
+    NOTE_DATA_SZ = 1 * KiB,
+    NOTE_NAME_SZ = 4,
+    ELF_GNU_PROPERTY_ALIGN = ELF_CLASS == ELFCLASS32 ? 4 : 8,
+};
+
+/*
+ * Process a single gnu_property entry.
+ * Return false for error.
+ */
+static bool parse_elf_property(const uint32_t *data, int *off, int datasz,
+                               struct image_info *info, bool have_prev_type,
+                               uint32_t *prev_type, Error **errp)
+{
+    uint32_t pr_type, pr_datasz, step;
+
+    if (*off > datasz || !QEMU_IS_ALIGNED(*off, ELF_GNU_PROPERTY_ALIGN)) {
+        goto error_data;
+    }
+    datasz -= *off;
+    data += *off / sizeof(uint32_t);
+
+    if (datasz < 2 * sizeof(uint32_t)) {
+        goto error_data;
+    }
+    pr_type = data[0];
+    pr_datasz = data[1];
+    data += 2;
+    datasz -= 2 * sizeof(uint32_t);
+    step = ROUND_UP(pr_datasz, ELF_GNU_PROPERTY_ALIGN);
+    if (step > datasz) {
+        goto error_data;
+    }
+
+    /* Properties are supposed to be unique and sorted on pr_type. */
+    if (have_prev_type && pr_type <= *prev_type) {
+        if (pr_type == *prev_type) {
+            error_setg(errp, "Duplicate property in PT_GNU_PROPERTY");
+        } else {
+            error_setg(errp, "Unsorted property in PT_GNU_PROPERTY");
+        }
+        return false;
+    }
+    *prev_type = pr_type;
+
+    if (!arch_parse_elf_property(pr_type, pr_datasz, data, info, errp)) {
+        return false;
+    }
+
+    *off += 2 * sizeof(uint32_t) + step;
+    return true;
+
+ error_data:
+    error_setg(errp, "Ill-formed property in PT_GNU_PROPERTY");
+    return false;
+}
+
+/* Process NT_GNU_PROPERTY_TYPE_0. */
+static bool parse_elf_properties(int image_fd,
+                                 struct image_info *info,
+                                 const struct elf_phdr *phdr,
+                                 char bprm_buf[BPRM_BUF_SIZE],
+                                 Error **errp)
+{
+    union {
+        struct elf_note nhdr;
+        uint32_t data[NOTE_DATA_SZ / sizeof(uint32_t)];
+    } note;
+
+    int n, off, datasz;
+    bool have_prev_type;
+    uint32_t prev_type;
+
+    /* Unless the arch requires properties, ignore them. */
+    if (!ARCH_USE_GNU_PROPERTY) {
+        return true;
+    }
+
+    /* If the properties are crazy large, that's too bad. */
+    n = phdr->p_filesz;
+    if (n > sizeof(note)) {
+        error_setg(errp, "PT_GNU_PROPERTY too large");
+        return false;
+    }
+    if (n < sizeof(note.nhdr)) {
+        error_setg(errp, "PT_GNU_PROPERTY too small");
+        return false;
+    }
+
+    if (phdr->p_offset + n <= BPRM_BUF_SIZE) {
+        memcpy(&note, bprm_buf + phdr->p_offset, n);
+    } else {
+        ssize_t len = pread(image_fd, &note, n, phdr->p_offset);
+        if (len != n) {
+            error_setg_errno(errp, errno, "Error reading file header");
+            return false;
+        }
+    }
+
+    /*
+     * The contents of a valid PT_GNU_PROPERTY is a sequence
+     * of uint32_t -- swap them all now.
+     */
+#ifdef BSWAP_NEEDED
+    for (int i = 0; i < n / 4; i++) {
+        bswap32s(note.data + i);
+    }
+#endif
+
+    /*
+     * Note that nhdr is 3 words, and that the "name" described by namesz
+     * immediately follows nhdr and is thus at the 4th word.  Further, all
+     * of the inputs to the kernel's round_up are multiples of 4.
+     */
+    if (note.nhdr.n_type != NT_GNU_PROPERTY_TYPE_0 ||
+        note.nhdr.n_namesz != NOTE_NAME_SZ ||
+        note.data[3] != GNU0_MAGIC) {
+        error_setg(errp, "Invalid note in PT_GNU_PROPERTY");
+        return false;
+    }
+    off = sizeof(note.nhdr) + NOTE_NAME_SZ;
+
+    datasz = note.nhdr.n_descsz + off;
+    if (datasz > n) {
+        error_setg(errp, "Invalid note size in PT_GNU_PROPERTY");
+        return false;
+    }
+
+    have_prev_type = false;
+    prev_type = 0;
+    while (1) {
+        if (off == datasz) {
+            return true;  /* end, exit ok */
+        }
+        if (!parse_elf_property(note.data, &off, datasz, info,
+                                have_prev_type, &prev_type, errp)) {
+            return false;
+        }
+        have_prev_type = true;
+    }
+}
+
 /* Load an ELF image into the address space.
 
    IMAGE_NAME is the filename of the image, to use in error messages.
@@ -2467,6 +2620,10 @@ static void load_elf_image(const char *image_name, int image_fd,
                 goto exit_errmsg;
             }
             *pinterp_name = g_steal_pointer(&interp_name);
+        } else if (eppnt->p_type == PT_GNU_PROPERTY) {
+            if (!parse_elf_properties(image_fd, info, eppnt, bprm_buf, &err)) {
+                goto exit_errmsg;
+            }
         }
     }
 
-- 
2.25.1



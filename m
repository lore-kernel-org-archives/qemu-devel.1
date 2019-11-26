Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B25C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 09:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5356F20722
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 09:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hwg2t4mj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5356F20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51743 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZWnR-00089q-HX
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 04:06:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iZWhE-00020a-JU
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:59:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iZWhD-00036o-3z
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:59:44 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:53113)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iZWhC-00036J-Td
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:59:43 -0500
Received: by mail-wm1-x32c.google.com with SMTP id l1so2260867wme.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 00:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zlo3vNzRp6z3EanSOjFlpKBYoVA1NruT4oaby34LW/4=;
 b=Hwg2t4mjO6rQWRpXbKIiGXrdqAWE9AiuTGQIAxJ4hosbtJJMyn7IksJ+M0KUuOSiQZ
 2EKLsmEzhCKNERZ1vkOqkzs/9XJlV5PFcPOxKZOjxwxMOp02/Ki3+ZnvUsyWC77Ppj6U
 aG+NrAOaRllldv+iX9M29in3wVYaq19OLRybyjo6IDWyu0uz+PfIKhoUQRrFkNXYIVMA
 CwxsktD3oCLqBqtYYYwYKm3XM30necPyafJsXg+cShZQAq86AkuQn337BDweo5KwWyrr
 wcWMa0THznRYINgsUo7IoDphV5SmSJaFTM2TSVGU6HfjGmx3PfW9HIAHTURoQGFexZ7P
 1HhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=zlo3vNzRp6z3EanSOjFlpKBYoVA1NruT4oaby34LW/4=;
 b=e8O1wL+7razx6LnH4qZGLFbmHj+n0dc5qDECpywGJ5g0p7jybjMV4mSxfxXLXUmGag
 NKdhDRhHDkXg55a+mk5WjDOW9O6Vjv7tGvweCWWMbKJRMQlSUA8feKzjsbTwOh5iSIe5
 LmjVWWRcjNUi/mpHX2zJYq20drQft5XXt226GlRh7vPMRSonyIJSnLKBoFe3H9KFG8RX
 zWyo3TK7/LVUvnr3cL1dXV/kSvALxI/9o8O1EeP50YUP7lTok6smwEtL/3MRkumQ5+/q
 AnOGnMrdx1VCWVCeWdIqtNs65IhJGHKhV59ghF5rXt7EhP3Pb9HOEffDW5Xk+qT5D3n8
 AYNA==
X-Gm-Message-State: APjAAAVj7MyYXyb5nbyUX0VsnneBBXlMVcS7tKje4PlpTAsIO6i4BbKB
 8xuj07irmKuqz04t3TcnLFqOJGfs
X-Google-Smtp-Source: APXvYqxr4uNF/SUvr7CkSDiUTOm4K3dEY415kMZVxZpPbmruyHAkmsreLx2bOLcWqtskGZOi4ep1Vg==
X-Received: by 2002:a7b:c357:: with SMTP id l23mr3099268wmj.152.1574758781462; 
 Tue, 26 Nov 2019 00:59:41 -0800 (PST)
Received: from donizetti.lan ([2001:b07:6468:f312:5454:a592:5a0a:75c])
 by smtp.gmail.com with ESMTPSA id a206sm2349172wmf.15.2019.11.26.00.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 00:59:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/5] hvf: correctly handle REX prefix in relation to legacy
 prefixes
Date: Tue, 26 Nov 2019 09:59:35 +0100
Message-Id: <20191126085936.1689-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191126085936.1689-1-pbonzini@redhat.com>
References: <20191126085936.1689-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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
Cc: Cameron Esfahani <dirty@apple.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cameron Esfahani <dirty@apple.com>

In real x86 processors, the REX prefix must come after legacy prefixes.
REX before legacy is ignored.  Update the HVF emulation code to properly
handle this.  Fix some spelling errors in constants.  Fix some decoder
table initialization issues found by Coverity.

Signed-off-by: Cameron Esfahani <dirty@apple.com>
Message-Id: <eff30ded8307471936bec5d84c3b6efbc95e3211.1574625592.git.dirty@apple.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86_decode.c | 64 ++++++++++++++++++++----------------
 target/i386/hvf/x86_decode.h | 20 +++++------
 2 files changed, 46 insertions(+), 38 deletions(-)

diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index 822fa1866e..77c346605f 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -122,7 +122,8 @@ static void decode_rax(CPUX86State *env, struct x86_decode *decode,
 {
     op->type = X86_VAR_REG;
     op->reg = R_EAX;
-    op->ptr = get_reg_ref(env, op->reg, decode->rex.rex, 0,
+    /* Since reg is always AX, REX prefix has no impact. */
+    op->ptr = get_reg_ref(env, op->reg, false, 0,
                           decode->operand_size);
 }
 
@@ -1687,40 +1688,37 @@ calc_addr:
     }
 }
 
-target_ulong get_reg_ref(CPUX86State *env, int reg, int rex, int is_extended,
-                         int size)
+target_ulong get_reg_ref(CPUX86State *env, int reg, int rex_present,
+                         int is_extended, int size)
 {
     target_ulong ptr = 0;
-    int which = 0;
 
     if (is_extended) {
         reg |= R_R8;
     }
 
-
     switch (size) {
     case 1:
-        if (is_extended || reg < 4 || rex) {
-            which = 1;
+        if (is_extended || reg < 4 || rex_present) {
             ptr = (target_ulong)&RL(env, reg);
         } else {
-            which = 2;
             ptr = (target_ulong)&RH(env, reg - 4);
         }
         break;
     default:
-        which = 3;
         ptr = (target_ulong)&RRX(env, reg);
         break;
     }
     return ptr;
 }
 
-target_ulong get_reg_val(CPUX86State *env, int reg, int rex, int is_extended,
-                         int size)
+target_ulong get_reg_val(CPUX86State *env, int reg, int rex_present,
+                         int is_extended, int size)
 {
     target_ulong val = 0;
-    memcpy(&val, (void *)get_reg_ref(env, reg, rex, is_extended, size), size);
+    memcpy(&val,
+           (void *)get_reg_ref(env, reg, rex_present, is_extended, size),
+           size);
     return val;
 }
 
@@ -1853,28 +1851,38 @@ void calc_modrm_operand(CPUX86State *env, struct x86_decode *decode,
 static void decode_prefix(CPUX86State *env, struct x86_decode *decode)
 {
     while (1) {
+        /*
+         * REX prefix must come after legacy prefixes.
+         * REX before legacy is ignored.
+         * Clear rex to simulate this.
+         */
         uint8_t byte = decode_byte(env, decode);
         switch (byte) {
         case PREFIX_LOCK:
             decode->lock = byte;
+            decode->rex.rex = 0;
             break;
         case PREFIX_REPN:
         case PREFIX_REP:
             decode->rep = byte;
+            decode->rex.rex = 0;
             break;
-        case PREFIX_CS_SEG_OVEERIDE:
-        case PREFIX_SS_SEG_OVEERIDE:
-        case PREFIX_DS_SEG_OVEERIDE:
-        case PREFIX_ES_SEG_OVEERIDE:
-        case PREFIX_FS_SEG_OVEERIDE:
-        case PREFIX_GS_SEG_OVEERIDE:
+        case PREFIX_CS_SEG_OVERRIDE:
+        case PREFIX_SS_SEG_OVERRIDE:
+        case PREFIX_DS_SEG_OVERRIDE:
+        case PREFIX_ES_SEG_OVERRIDE:
+        case PREFIX_FS_SEG_OVERRIDE:
+        case PREFIX_GS_SEG_OVERRIDE:
             decode->segment_override = byte;
+            decode->rex.rex = 0;
             break;
         case PREFIX_OP_SIZE_OVERRIDE:
             decode->op_size_override = byte;
+            decode->rex.rex = 0;
             break;
         case PREFIX_ADDR_SIZE_OVERRIDE:
             decode->addr_size_override = byte;
+            decode->rex.rex = 0;
             break;
         case PREFIX_REX ... (PREFIX_REX + 0xf):
             if (x86_is_long_mode(env_cpu(env))) {
@@ -2111,14 +2119,14 @@ void init_decoder()
 {
     int i;
     
-    for (i = 0; i < ARRAY_SIZE(_decode_tbl2); i++) {
-        memcpy(_decode_tbl1, &invl_inst, sizeof(invl_inst));
+    for (i = 0; i < ARRAY_SIZE(_decode_tbl1); i++) {
+        memcpy(&_decode_tbl1[i], &invl_inst, sizeof(invl_inst));
     }
     for (i = 0; i < ARRAY_SIZE(_decode_tbl2); i++) {
-        memcpy(_decode_tbl2, &invl_inst, sizeof(invl_inst));
+        memcpy(&_decode_tbl2[i], &invl_inst, sizeof(invl_inst));
     }
     for (i = 0; i < ARRAY_SIZE(_decode_tbl3); i++) {
-        memcpy(_decode_tbl3, &invl_inst, sizeof(invl_inst_x87));
+        memcpy(&_decode_tbl3[i], &invl_inst_x87, sizeof(invl_inst_x87));
     
     }
     for (i = 0; i < ARRAY_SIZE(_1op_inst); i++) {
@@ -2167,22 +2175,22 @@ target_ulong decode_linear_addr(CPUX86State *env, struct x86_decode *decode,
                                target_ulong addr, X86Seg seg)
 {
     switch (decode->segment_override) {
-    case PREFIX_CS_SEG_OVEERIDE:
+    case PREFIX_CS_SEG_OVERRIDE:
         seg = R_CS;
         break;
-    case PREFIX_SS_SEG_OVEERIDE:
+    case PREFIX_SS_SEG_OVERRIDE:
         seg = R_SS;
         break;
-    case PREFIX_DS_SEG_OVEERIDE:
+    case PREFIX_DS_SEG_OVERRIDE:
         seg = R_DS;
         break;
-    case PREFIX_ES_SEG_OVEERIDE:
+    case PREFIX_ES_SEG_OVERRIDE:
         seg = R_ES;
         break;
-    case PREFIX_FS_SEG_OVEERIDE:
+    case PREFIX_FS_SEG_OVERRIDE:
         seg = R_FS;
         break;
-    case PREFIX_GS_SEG_OVEERIDE:
+    case PREFIX_GS_SEG_OVERRIDE:
         seg = R_GS;
         break;
     default:
diff --git a/target/i386/hvf/x86_decode.h b/target/i386/hvf/x86_decode.h
index bc574a7a44..ef7960113f 100644
--- a/target/i386/hvf/x86_decode.h
+++ b/target/i386/hvf/x86_decode.h
@@ -27,12 +27,12 @@ typedef enum x86_prefix {
     PREFIX_REPN =                  0xf2,
     PREFIX_REP =                   0xf3,
     /* group 2 */
-    PREFIX_CS_SEG_OVEERIDE =       0x2e,
-    PREFIX_SS_SEG_OVEERIDE =       0x36,
-    PREFIX_DS_SEG_OVEERIDE =       0x3e,
-    PREFIX_ES_SEG_OVEERIDE =       0x26,
-    PREFIX_FS_SEG_OVEERIDE =       0x64,
-    PREFIX_GS_SEG_OVEERIDE =       0x65,
+    PREFIX_CS_SEG_OVERRIDE =       0x2e,
+    PREFIX_SS_SEG_OVERRIDE =       0x36,
+    PREFIX_DS_SEG_OVERRIDE =       0x3e,
+    PREFIX_ES_SEG_OVERRIDE =       0x26,
+    PREFIX_FS_SEG_OVERRIDE =       0x64,
+    PREFIX_GS_SEG_OVERRIDE =       0x65,
     /* group 3 */
     PREFIX_OP_SIZE_OVERRIDE =      0x66,
     /* group 4 */
@@ -303,10 +303,10 @@ uint64_t sign(uint64_t val, int size);
 
 uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode);
 
-target_ulong get_reg_ref(CPUX86State *env, int reg, int rex, int is_extended,
-                         int size);
-target_ulong get_reg_val(CPUX86State *env, int reg, int rex, int is_extended,
-                         int size);
+target_ulong get_reg_ref(CPUX86State *env, int reg, int rex_present,
+                         int is_extended, int size);
+target_ulong get_reg_val(CPUX86State *env, int reg, int rex_present,
+                         int is_extended, int size);
 void calc_modrm_operand(CPUX86State *env, struct x86_decode *decode,
                         struct x86_decode_op *op);
 target_ulong decode_linear_addr(CPUX86State *env, struct x86_decode *decode,
-- 
2.21.0




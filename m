Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E796C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:43:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6EF22064C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWEd+7ax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6EF22064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqgr-0003mp-W8
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jsqeh-00016U-H6
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:41:16 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a]:46949)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jsqeb-00058t-Of
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:41:15 -0400
Received: by mail-ej1-x62a.google.com with SMTP id p20so47219794ejd.13
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 09:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=gVa+PWgMtiyklwL7huu6tzES9koqjiWeMuVWQr2tQxQ=;
 b=gWEd+7axSh4BKIOHK1OD8q0EjLeHRDuTAl5pgj5TGvppUmGgivUT/FdrT4cFYMtqMe
 dnVYpGwO4LKuGFVzkrYIewlw7Sv0JOi7sD0QYLLleWHYRMylZMXOfvQfl4MQpjLuwy+z
 TtRuhbVdSPTeuI118iUO15y4pGPjVPCIWxUDyBQrLV5oGqZB7X6tJ5Z1SS5xkImwjG5b
 VDJYJbOk0GcWEP1xPkiRHM0Sv2rddmFDMBA2eCC0Lq4Q88iou90A9ML2DERjgntN4R1L
 gzxIzXbhz+YLtnwiN6XBYxNgm3ugpXTPd9kfOiZHn1pQQrF/3GzKL+KJonyNJOBHc5+F
 exiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=gVa+PWgMtiyklwL7huu6tzES9koqjiWeMuVWQr2tQxQ=;
 b=HzJslsyX6WCRQ+WCYMyOBElXHm6klaeNhMlVlHCbe2FerfSONybQpLu/Xzx7YWN7wi
 4XOBubxH40VaqBp+8XuyvX8UiiIheYsNE8KhgAj1b/XFvhwA9pjt+vqoutSccJcQ9cVq
 OJBXIueELh4BxgnSiKRBdVAHmtEhKj7gBDLsU2lEgS9/8srMLw2Bk0TyQpaxf5LJ3+Fh
 LJ/eJAlFwxObr50NwKpLKJcwmP9R6dAA+SJe+4tmgos4RcJdZXdAmiWMPXAjPVhBM1Ma
 XG159xMUi9vk99aAFmWV4W+QA0UjutSok4FBbp2Ha/5cThlXpQMHox1PdJTQGvNuC8+K
 A71g==
X-Gm-Message-State: AOAM533YjoUG/zLrnlH0Add3gl6EccpFKfxUT1sDlZQg3ih1NZetFICV
 OaYpNFakeKxxUZ2CRznyBH5RxdEZ
X-Google-Smtp-Source: ABdhPJwOsQKw82XwuRngOTYdBwvwPwEMWAebipoez99fAdP0msEWC0ksmdHCMF4MXm2u1Me9ynwYzg==
X-Received: by 2002:a17:906:1998:: with SMTP id
 g24mr45157997ejd.11.1594140066180; 
 Tue, 07 Jul 2020 09:41:06 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id 23sm26428065edx.75.2020.07.07.09.41.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 07 Jul 2020 09:41:05 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 2/3] disas: mips: Add Loongson 2F disassembler
Date: Tue,  7 Jul 2020 18:41:01 +0200
Message-Id: <1594140062-23522-3-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594140062-23522-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1594140062-23522-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-ej1-x62a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Brankovic <stefanbrankovic96@gmail.com>

Add disassembler for Loongson 2F instruction set.

Testing is done by comparing qemu disassembly output, obtained by
using -d in_asm command line option, with appropriate objdump output.

This disassembler is written as a generic disassembler that can be
integrated into other projects. In this case, it is integrated into
QEMU. One of initial key requirements was that it uses C++ as its
language.

Signed-off-by: Stefan Brankovic <stefan.brankovic@syrmia.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <20200703104409.6986-2-stefan.brankovic@syrmia.com>
---
 configure               |    1 +
 disas/loongson2f.h      | 2562 +++++++++++++++
 include/disas/dis-asm.h |    1 +
 include/exec/poison.h   |    1 +
 target/mips/cpu.c       |    6 +
 MAINTAINERS             |    1 +
 disas/Makefile.objs     |    1 +
 disas/loongson2f.cpp    | 8154 +++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 10727 insertions(+)
 create mode 100644 disas/loongson2f.h
 create mode 100644 disas/loongson2f.cpp

diff --git a/configure b/configure
index e50791f..fa65121 100755
--- a/configure
+++ b/configure
@@ -8388,6 +8388,7 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
     disas_config "MIPS"
     if test -n "${cxx}"; then
       disas_config "NANOMIPS"
+      disas_config "LOONGSON2F"
     fi
   ;;
   moxie*)
diff --git a/disas/loongson2f.h b/disas/loongson2f.h
new file mode 100644
index 0000000..13780ca
--- /dev/null
+++ b/disas/loongson2f.h
@@ -0,0 +1,2562 @@
+/*
+ *  Header file for Loongson 2F disassembler component of QEMU
+ *
+ *  Copyright (C) 2020  Stefan Brankovic <stefan.brankovic@syrmia.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef DISAS_LOONGSON2F_H
+#define DISAS_LOONGSON2F_H
+
+#include "disas/dis-asm.h"
+
+class Fields32
+{
+public:
+    virtual void decode_fields32(uint32_t insn) = 0;
+};
+
+class Fields32RdRsRt : public Fields32
+{
+protected:
+    int rd;
+    int rs;
+    int rt;
+public:
+    int getRd();
+    int getRs();
+    int getRt();
+};
+
+class Fields32RdRsRtD0 : public Fields32RdRsRt
+{
+public:
+    void decode_fields32(uint32_t insn);
+};
+
+class Fields32ImmRsRt : public Fields32
+{
+protected:
+    int imm;
+    int rs;
+    int rt;
+public:
+    int getImm();
+    int getRs();
+    int getRt();
+};
+
+class Fields32ImmRsRtD0 : public Fields32ImmRsRt
+{
+public:
+    void decode_fields32(uint32_t insn);
+};
+
+class Fields32ImmRsRtD1 : public Fields32ImmRsRt
+{
+public:
+    void decode_fields32(uint32_t insn);
+};
+
+class Fields32RdRs : public Fields32
+{
+protected:
+    int rd;
+    int rs;
+public:
+    int getRd();
+    int getRs();
+};
+
+class Fields32RdRsD0 : public Fields32RdRs
+{
+public:
+    void decode_fields32(uint32_t insn);
+};
+
+class Fields32Rs : public Fields32
+{
+protected:
+    int rs;
+public:
+    int getRs();
+};
+
+class Fields32RsD0 : public Fields32Rs
+{
+public:
+    void decode_fields32(uint32_t insn);
+};
+
+class Fields32BaseOffsetRt : public Fields32
+{
+protected:
+    int base;
+    int offset;
+    int rt;
+public:
+    int getBase();
+    int getOffset();
+    int getRt();
+};
+
+class Fields32BaseOffsetRtD0 : public Fields32BaseOffsetRt
+{
+public:
+    void decode_fields32(uint32_t insn);
+};
+
+class Fields32ImmRt : public Fields32
+{
+protected:
+    int imm;
+    int rt;
+public:
+    int getImm();
+    int getRt();
+};
+
+class Fields32ImmRtD0 : public Fields32ImmRt
+{
+public:
+    void decode_fields32(uint32_t insn);
+};
+
+class Fields32Rd : public Fields32
+{
+protected:
+    int rd;
+public:
+    int getRd();
+};
+
+class Fields32RdD0 : public Fields32Rd
+{
+public:
+    void decode_fields32(uint32_t insn);
+};
+
+class Fields32Stype : public Fields32
+{
+protected:
+    int stype;
+public:
+    int getStype();
+};
+
+class Fields32StypeD0 : public Fields32Stype
+{
+public:
+    void decode_fields32(uint32_t insn);
+};
+
+class Fields32CodeRsRt : public Fields32
+{
+protected:
+    int code;
+    int rs;
+    int rt;
+public:
+    int getCode();
+    int getRs();
+    int getRt();
+};
+
+class Fields32CodeRsRtD0 : public Fields32CodeRsRt
+{
+public:
+    void decode_fields32(uint32_t insn);
+};
+
+class Fields32ImmRs : public Fields32
+{
+protected:
+    int imm;
+    int rs;
+public:
+    int getImm();
+    int getRs();
+};
+
+class Fields32ImmRsD0 : public Fields32ImmRs
+{
+public:
+    void decode_fields32(uint32_t insn);
+};
+
+class Fields32FdFs : public Fields32
+{
+protected:
+    int fd;
+    int fs;
+public:
+    int getFd();
+    int getFs();
+};
+
+class Fields32FdFsD0 : public Fields32FdFs
+{
+public:
+    void decode_fields32(uint32_t insn);
+};
+
+class Fields32FdFsFt : public Fields32
+{
+protected:
+    int fd;
+    int fs;
+    int ft;
+public:
+    int getFd();
+    int getFs();
+    int getFt();
+};
+
+class Fields32FdFsFtD0 : public Fields32FdFsFt
+{
+public:
+    void decode_fields32(uint32_t insn);
+};
+
+class Fields32Offset : public Fields32
+{
+protected:
+    int offset;
+public:
+    int getOffset();
+};
+
+class Fields32OffsetD0 : public Fields32Offset
+{
+public:
+    void decode_fields32(uint32_t insn);
+};
+
+class Fields32FsFt : public Fields32
+{
+protected:
+    int fs;
+    int ft;
+public:
+    int getFs();
+    int getFt();
+};
+
+class Fields32FsFtD0 : public Fields32FsFt
+{
+public:
+    void decode_fields32(uint32_t insn);
+};
+
+class Fields32FsRt : public Fields32
+{
+protected:
+    int fs;
+    int rt;
+public:
+    int getFs();
+    int getRt();
+};
+
+class Fields32FsRtD0 : public Fields32FsRt
+{
+public:
+    void decode_fields32(uint32_t insn);
+};
+
+class Fields32BaseFtOffset : public Fields32
+{
+protected:
+    int base;
+    int ft;
+    int offset;
+public:
+    int getBase();
+    int getFt();
+    int getOffset();
+};
+
+class Fields32BaseFtOffsetD0 : public Fields32BaseFtOffset
+{
+public:
+    void decode_fields32(uint32_t insn);
+};
+
+class Fields32OffsetRsRt : public Fields32
+{
+protected:
+    int offset;
+    int rs;
+    int rt;
+public:
+    int getOffset();
+    int getRs();
+    int getRt();
+};
+
+class Fields32OffsetRsRtD0 : public Fields32OffsetRsRt
+{
+public:
+    void decode_fields32(uint32_t insn);
+};
+
+class Fields32OffsetRs : public Fields32
+{
+protected:
+    int offset;
+    int rs;
+public:
+    int getOffset();
+    int getRs();
+};
+
+class Fields32OffsetRsD0 : public Fields32OffsetRs
+{
+public:
+    void decode_fields32(uint32_t insn);
+};
+
+class Fields32Code : public Fields32
+{
+protected:
+    int code;
+public:
+    int getCode();
+};
+
+class Fields32CodeD0 : public Fields32Code
+{
+public:
+    void decode_fields32(uint32_t insn);
+};
+
+class Fields32Cop_fun : public Fields32
+{
+protected:
+    int cop_fun;
+public:
+    int getCop_fun();
+};
+
+class Fields32Cop_funD0 : public Fields32Cop_fun
+{
+public:
+    void decode_fields32(uint32_t insn);
+};
+
+class Fields32RsRt : public Fields32
+{
+protected:
+    int rs;
+    int rt;
+public:
+    int getRs();
+    int getRt();
+};
+
+class Fields32RsRtD0 : public Fields32RsRt
+{
+public:
+    void decode_fields32(uint32_t insn);
+};
+
+class Fields32RdRtSa : public Fields32
+{
+protected:
+    int rd;
+    int rt;
+    int sa;
+public:
+    int getRd();
+    int getRt();
+    int getSa();
+};
+
+class Fields32RdRtSaD0 : public Fields32RdRtSa
+{
+public:
+    void decode_fields32(uint32_t insn);
+};
+
+class Fields32Instr_index : public Fields32
+{
+protected:
+    int instr_index;
+public:
+    int getInstr_index();
+};
+
+class Fields32Instr_indexD0 : public Fields32Instr_index
+{
+public:
+    void decode_fields32(uint32_t insn);
+};
+
+class Instruction32
+{
+protected:
+    uint32_t opcode32;
+    uint32_t mask32;
+    Fields32 *fields32;
+
+    void getAlias(char *buffer, int regNo);
+public:
+    virtual bool disas_output(disassemble_info *info) = 0;
+    virtual ~Instruction32()  = 0;
+};
+
+class ADD : public Instruction32
+{
+public:
+    ADD(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class ADDI : public Instruction32
+{
+public:
+    ADDI(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class ADDIU : public Instruction32
+{
+public:
+    ADDIU(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class ADDU : public Instruction32
+{
+public:
+    ADDU(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class AND : public Instruction32
+{
+public:
+    AND(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class ANDI : public Instruction32
+{
+public:
+    ANDI(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class BEQ : public Instruction32
+{
+public:
+    BEQ(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class BEQL : public Instruction32
+{
+public:
+    BEQL(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class BGEZ : public Instruction32
+{
+public:
+    BGEZ(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class BGEZAL : public Instruction32
+{
+public:
+    BGEZAL(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class BGEZALL : public Instruction32
+{
+public:
+    BGEZALL(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class BGEZL : public Instruction32
+{
+public:
+    BGEZL(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class BGTZ : public Instruction32
+{
+public:
+    BGTZ(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class BGTZL : public Instruction32
+{
+public:
+    BGTZL(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class BLEZ : public Instruction32
+{
+public:
+    BLEZ(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class BLEZL : public Instruction32
+{
+public:
+    BLEZL(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class BLTZ : public Instruction32
+{
+public:
+    BLTZ(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class BLTZAL : public Instruction32
+{
+public:
+    BLTZAL(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class BLTZALL : public Instruction32
+{
+public:
+    BLTZALL(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class BLTZL : public Instruction32
+{
+public:
+    BLTZL(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class BNE : public Instruction32
+{
+public:
+    BNE(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class BNEL : public Instruction32
+{
+public:
+    BNEL(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class BREAK : public Instruction32
+{
+public:
+    BREAK(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class COP0 : public Instruction32
+{
+public:
+    COP0(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class COP3 : public Instruction32
+{
+public:
+    COP3(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DADD : public Instruction32
+{
+public:
+    DADD(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DADDI : public Instruction32
+{
+public:
+    DADDI(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DADDIU : public Instruction32
+{
+public:
+    DADDIU(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DADDU : public Instruction32
+{
+public:
+    DADDU(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DDIV : public Instruction32
+{
+public:
+    DDIV(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DDIVU : public Instruction32
+{
+public:
+    DDIVU(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DIV : public Instruction32
+{
+public:
+    DIV(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DIVU : public Instruction32
+{
+public:
+    DIVU(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DMULT : public Instruction32
+{
+public:
+    DMULT(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DMULTU : public Instruction32
+{
+public:
+    DMULTU(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DSLL : public Instruction32
+{
+public:
+    DSLL(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DSLL32 : public Instruction32
+{
+public:
+    DSLL32(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DSLLV : public Instruction32
+{
+public:
+    DSLLV(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DSRA : public Instruction32
+{
+public:
+    DSRA(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DSRA32 : public Instruction32
+{
+public:
+    DSRA32(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DSRAV : public Instruction32
+{
+public:
+    DSRAV(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DSRL : public Instruction32
+{
+public:
+    DSRL(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DSRL32 : public Instruction32
+{
+public:
+    DSRL32(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DSRLV : public Instruction32
+{
+public:
+    DSRLV(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DSUB : public Instruction32
+{
+public:
+    DSUB(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DSUBU : public Instruction32
+{
+public:
+    DSUBU(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class J : public Instruction32
+{
+public:
+    J(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class JAL : public Instruction32
+{
+public:
+    JAL(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class JALR : public Instruction32
+{
+public:
+    JALR(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class JR : public Instruction32
+{
+public:
+    JR(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class LB : public Instruction32
+{
+public:
+    LB(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class LBU : public Instruction32
+{
+public:
+    LBU(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class LD : public Instruction32
+{
+public:
+    LD(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class LDC2 : public Instruction32
+{
+public:
+    LDC2(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class LDL : public Instruction32
+{
+public:
+    LDL(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class LDR : public Instruction32
+{
+public:
+    LDR(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class LH : public Instruction32
+{
+public:
+    LH(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class LHU : public Instruction32
+{
+public:
+    LHU(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class LL : public Instruction32
+{
+public:
+    LL(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class LLD : public Instruction32
+{
+public:
+    LLD(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class LUI : public Instruction32
+{
+public:
+    LUI(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class LW : public Instruction32
+{
+public:
+    LW(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class LWC2 : public Instruction32
+{
+public:
+    LWC2(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class LWC3 : public Instruction32
+{
+public:
+    LWC3(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class LWL : public Instruction32
+{
+public:
+    LWL(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class LWR : public Instruction32
+{
+public:
+    LWR(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class LWU : public Instruction32
+{
+public:
+    LWU(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class MFHI : public Instruction32
+{
+public:
+    MFHI(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class MFLO : public Instruction32
+{
+public:
+    MFLO(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class MTHI : public Instruction32
+{
+public:
+    MTHI(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class MTLO : public Instruction32
+{
+public:
+    MTLO(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class MULT : public Instruction32
+{
+public:
+    MULT(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class MULTU : public Instruction32
+{
+public:
+    MULTU(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class NOR : public Instruction32
+{
+public:
+    NOR(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class OR : public Instruction32
+{
+public:
+    OR(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class ORI : public Instruction32
+{
+public:
+    ORI(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SB : public Instruction32
+{
+public:
+    SB(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SC : public Instruction32
+{
+public:
+    SC(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SCD : public Instruction32
+{
+public:
+    SCD(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SD : public Instruction32
+{
+public:
+    SD(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SDC2 : public Instruction32
+{
+public:
+    SDC2(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SDL : public Instruction32
+{
+public:
+    SDL(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SDR : public Instruction32
+{
+public:
+    SDR(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SH : public Instruction32
+{
+public:
+    SH(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SLL : public Instruction32
+{
+public:
+    SLL(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SLLV : public Instruction32
+{
+public:
+    SLLV(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SLT : public Instruction32
+{
+public:
+    SLT(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SLTI : public Instruction32
+{
+public:
+    SLTI(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SLTIU : public Instruction32
+{
+public:
+    SLTIU(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SLTU : public Instruction32
+{
+public:
+    SLTU(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SRA : public Instruction32
+{
+public:
+    SRA(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SRAV : public Instruction32
+{
+public:
+    SRAV(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SRL : public Instruction32
+{
+public:
+    SRL(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SRLV : public Instruction32
+{
+public:
+    SRLV(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SUB : public Instruction32
+{
+public:
+    SUB(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SUBU : public Instruction32
+{
+public:
+    SUBU(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SW : public Instruction32
+{
+public:
+    SW(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SWC2 : public Instruction32
+{
+public:
+    SWC2(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SWC3 : public Instruction32
+{
+public:
+    SWC3(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SWL : public Instruction32
+{
+public:
+    SWL(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SWR : public Instruction32
+{
+public:
+    SWR(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SYNC : public Instruction32
+{
+public:
+    SYNC(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SYSCALL : public Instruction32
+{
+public:
+    SYSCALL(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class TEQ : public Instruction32
+{
+public:
+    TEQ(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class TEQI : public Instruction32
+{
+public:
+    TEQI(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class TGE : public Instruction32
+{
+public:
+    TGE(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class TGEI : public Instruction32
+{
+public:
+    TGEI(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class TGEIU : public Instruction32
+{
+public:
+    TGEIU(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class TGEU : public Instruction32
+{
+public:
+    TGEU(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class TLT : public Instruction32
+{
+public:
+    TLT(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class TLTI : public Instruction32
+{
+public:
+    TLTI(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class TLTIU : public Instruction32
+{
+public:
+    TLTIU(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class TLTU : public Instruction32
+{
+public:
+    TLTU(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class TNE : public Instruction32
+{
+public:
+    TNE(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class TNEI : public Instruction32
+{
+public:
+    TNEI(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class XOR : public Instruction32
+{
+public:
+    XOR(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class XORI : public Instruction32
+{
+public:
+    XORI(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class ABS_S : public Instruction32
+{
+public:
+    ABS_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class ABS_D : public Instruction32
+{
+public:
+    ABS_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class ADD_S : public Instruction32
+{
+public:
+    ADD_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class ADD_D : public Instruction32
+{
+public:
+    ADD_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class BC1F : public Instruction32
+{
+public:
+    BC1F(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class BC1FL : public Instruction32
+{
+public:
+    BC1FL(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class BC1T : public Instruction32
+{
+public:
+    BC1T(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class BC1TL : public Instruction32
+{
+public:
+    BC1TL(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_F_S : public Instruction32
+{
+public:
+    C_F_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_UN_S : public Instruction32
+{
+public:
+    C_UN_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_EQ_S : public Instruction32
+{
+public:
+    C_EQ_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_UEQ_S : public Instruction32
+{
+public:
+    C_UEQ_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_OLT_S : public Instruction32
+{
+public:
+    C_OLT_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_ULT_S : public Instruction32
+{
+public:
+    C_ULT_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_OLE_S : public Instruction32
+{
+public:
+    C_OLE_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_ULE_S : public Instruction32
+{
+public:
+    C_ULE_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_SF_S : public Instruction32
+{
+public:
+    C_SF_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_NGLE_S : public Instruction32
+{
+public:
+    C_NGLE_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_SEQ_S : public Instruction32
+{
+public:
+    C_SEQ_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_NGL_S : public Instruction32
+{
+public:
+    C_NGL_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_LT_S : public Instruction32
+{
+public:
+    C_LT_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_NGE_S : public Instruction32
+{
+public:
+    C_NGE_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_LE_S : public Instruction32
+{
+public:
+    C_LE_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_NGT_S : public Instruction32
+{
+public:
+    C_NGT_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_F_D : public Instruction32
+{
+public:
+    C_F_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_UN_D : public Instruction32
+{
+public:
+    C_UN_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_EQ_D : public Instruction32
+{
+public:
+    C_EQ_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_UEQ_D : public Instruction32
+{
+public:
+    C_UEQ_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_OLT_D : public Instruction32
+{
+public:
+    C_OLT_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_ULT_D : public Instruction32
+{
+public:
+    C_ULT_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_OLE_D : public Instruction32
+{
+public:
+    C_OLE_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_ULE_D : public Instruction32
+{
+public:
+    C_ULE_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_SF_D : public Instruction32
+{
+public:
+    C_SF_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_NGLE_D : public Instruction32
+{
+public:
+    C_NGLE_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_SEQ_D : public Instruction32
+{
+public:
+    C_SEQ_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_NGL_D : public Instruction32
+{
+public:
+    C_NGL_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_LT_D : public Instruction32
+{
+public:
+    C_LT_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_NGE_D : public Instruction32
+{
+public:
+    C_NGE_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_LE_D : public Instruction32
+{
+public:
+    C_LE_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class C_NGT_D : public Instruction32
+{
+public:
+    C_NGT_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class CEIL_L_S : public Instruction32
+{
+public:
+    CEIL_L_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class CEIL_L_D : public Instruction32
+{
+public:
+    CEIL_L_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class CEIL_W_S : public Instruction32
+{
+public:
+    CEIL_W_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class CEIL_W_D : public Instruction32
+{
+public:
+    CEIL_W_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class CFC1 : public Instruction32
+{
+public:
+    CFC1(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class CTC1 : public Instruction32
+{
+public:
+    CTC1(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class CVT_D_S : public Instruction32
+{
+public:
+    CVT_D_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class CVT_D_W : public Instruction32
+{
+public:
+    CVT_D_W(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class CVT_D_L : public Instruction32
+{
+public:
+    CVT_D_L(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class CVT_L_S : public Instruction32
+{
+public:
+    CVT_L_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class CVT_L_D : public Instruction32
+{
+public:
+    CVT_L_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class CVT_S_D : public Instruction32
+{
+public:
+    CVT_S_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class CVT_S_W : public Instruction32
+{
+public:
+    CVT_S_W(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class CVT_S_L : public Instruction32
+{
+public:
+    CVT_S_L(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class CVT_W_S : public Instruction32
+{
+public:
+    CVT_W_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class CVT_W_D : public Instruction32
+{
+public:
+    CVT_W_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DIV_S : public Instruction32
+{
+public:
+    DIV_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DIV_D : public Instruction32
+{
+public:
+    DIV_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DMFC1 : public Instruction32
+{
+public:
+    DMFC1(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DMTC1 : public Instruction32
+{
+public:
+    DMTC1(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class FLOOR_L_S : public Instruction32
+{
+public:
+    FLOOR_L_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class FLOOR_L_D : public Instruction32
+{
+public:
+    FLOOR_L_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class FLOOR_W_S : public Instruction32
+{
+public:
+    FLOOR_W_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class FLOOR_W_D : public Instruction32
+{
+public:
+    FLOOR_W_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class LDC1 : public Instruction32
+{
+public:
+    LDC1(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class LWC1 : public Instruction32
+{
+public:
+    LWC1(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class MFC1 : public Instruction32
+{
+public:
+    MFC1(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class MOV_S : public Instruction32
+{
+public:
+    MOV_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class MOV_D : public Instruction32
+{
+public:
+    MOV_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class MTC1 : public Instruction32
+{
+public:
+    MTC1(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class MUL_S : public Instruction32
+{
+public:
+    MUL_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class MUL_D : public Instruction32
+{
+public:
+    MUL_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class NEG_S : public Instruction32
+{
+public:
+    NEG_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class NEG_D : public Instruction32
+{
+public:
+    NEG_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class ROUND_L_S : public Instruction32
+{
+public:
+    ROUND_L_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class ROUND_L_D : public Instruction32
+{
+public:
+    ROUND_L_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class ROUND_W_S : public Instruction32
+{
+public:
+    ROUND_W_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class ROUND_W_D : public Instruction32
+{
+public:
+    ROUND_W_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SDC1 : public Instruction32
+{
+public:
+    SDC1(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SQRT_S : public Instruction32
+{
+public:
+    SQRT_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SQRT_D : public Instruction32
+{
+public:
+    SQRT_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SUB_S : public Instruction32
+{
+public:
+    SUB_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SUB_D : public Instruction32
+{
+public:
+    SUB_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SWC1 : public Instruction32
+{
+public:
+    SWC1(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class TRUNC_L_S : public Instruction32
+{
+public:
+    TRUNC_L_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class TRUNC_L_D : public Instruction32
+{
+public:
+    TRUNC_L_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class TRUNC_W_S : public Instruction32
+{
+public:
+    TRUNC_W_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class TRUNC_W_D : public Instruction32
+{
+public:
+    TRUNC_W_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class MULT_G : public Instruction32
+{
+public:
+    MULT_G(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class MULTU_G : public Instruction32
+{
+public:
+    MULTU_G(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DMULT_G : public Instruction32
+{
+public:
+    DMULT_G(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DMULTU_G : public Instruction32
+{
+public:
+    DMULTU_G(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DIV_G : public Instruction32
+{
+public:
+    DIV_G(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DIVU_G : public Instruction32
+{
+public:
+    DIVU_G(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DDIV_G : public Instruction32
+{
+public:
+    DDIV_G(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DDIVU_G : public Instruction32
+{
+public:
+    DDIVU_G(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class MOD_G : public Instruction32
+{
+public:
+    MOD_G(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class MODU_G : public Instruction32
+{
+public:
+    MODU_G(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DMOD_G : public Instruction32
+{
+public:
+    DMOD_G(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DMODU_G : public Instruction32
+{
+public:
+    DMODU_G(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class MADD_S : public Instruction32
+{
+public:
+    MADD_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class MADD_D : public Instruction32
+{
+public:
+    MADD_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class MSUB_S : public Instruction32
+{
+public:
+    MSUB_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class MSUB_D : public Instruction32
+{
+public:
+    MSUB_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class NMADD_S : public Instruction32
+{
+public:
+    NMADD_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class NMADD_D : public Instruction32
+{
+public:
+    NMADD_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class NMSUB_S : public Instruction32
+{
+public:
+    NMSUB_S(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class NMSUB_D : public Instruction32
+{
+public:
+    NMSUB_D(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PACKSSHB : public Instruction32
+{
+public:
+    PACKSSHB(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PACKSSWH : public Instruction32
+{
+public:
+    PACKSSWH(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PACKUSHB : public Instruction32
+{
+public:
+    PACKUSHB(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PADDB : public Instruction32
+{
+public:
+    PADDB(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PADDH : public Instruction32
+{
+public:
+    PADDH(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PADDW : public Instruction32
+{
+public:
+    PADDW(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PADDD : public Instruction32
+{
+public:
+    PADDD(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PADDSB : public Instruction32
+{
+public:
+    PADDSB(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PADDSH : public Instruction32
+{
+public:
+    PADDSH(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PADDUSB : public Instruction32
+{
+public:
+    PADDUSB(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PADDUSH : public Instruction32
+{
+public:
+    PADDUSH(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PANDN : public Instruction32
+{
+public:
+    PANDN(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PAVGB : public Instruction32
+{
+public:
+    PAVGB(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PAVGH : public Instruction32
+{
+public:
+    PAVGH(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PCMPEQB : public Instruction32
+{
+public:
+    PCMPEQB(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PCMPEQH : public Instruction32
+{
+public:
+    PCMPEQH(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PCMPEQW : public Instruction32
+{
+public:
+    PCMPEQW(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PCMPGTB : public Instruction32
+{
+public:
+    PCMPGTB(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PCMPGTH : public Instruction32
+{
+public:
+    PCMPGTH(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PCMPGTW : public Instruction32
+{
+public:
+    PCMPGTW(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PEXTRH : public Instruction32
+{
+public:
+    PEXTRH(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PINSRH_0 : public Instruction32
+{
+public:
+    PINSRH_0(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PINSRH_1 : public Instruction32
+{
+public:
+    PINSRH_1(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PINSRH_2 : public Instruction32
+{
+public:
+    PINSRH_2(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PINSRH_3 : public Instruction32
+{
+public:
+    PINSRH_3(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PMADDHW : public Instruction32
+{
+public:
+    PMADDHW(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PMAXSH : public Instruction32
+{
+public:
+    PMAXSH(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PMAXUB : public Instruction32
+{
+public:
+    PMAXUB(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PMINSH : public Instruction32
+{
+public:
+    PMINSH(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PMINUB : public Instruction32
+{
+public:
+    PMINUB(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PMOVMSKB : public Instruction32
+{
+public:
+    PMOVMSKB(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PMULHUH : public Instruction32
+{
+public:
+    PMULHUH(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PMULHH : public Instruction32
+{
+public:
+    PMULHH(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PMULLH : public Instruction32
+{
+public:
+    PMULLH(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PMULUW : public Instruction32
+{
+public:
+    PMULUW(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PASUBUB : public Instruction32
+{
+public:
+    PASUBUB(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class BIADD : public Instruction32
+{
+public:
+    BIADD(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PSHUFH : public Instruction32
+{
+public:
+    PSHUFH(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PSLLH : public Instruction32
+{
+public:
+    PSLLH(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PSLLW : public Instruction32
+{
+public:
+    PSLLW(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PSRAH : public Instruction32
+{
+public:
+    PSRAH(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PSRAW : public Instruction32
+{
+public:
+    PSRAW(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PSRLH : public Instruction32
+{
+public:
+    PSRLH(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PSRLW : public Instruction32
+{
+public:
+    PSRLW(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PSUBB : public Instruction32
+{
+public:
+    PSUBB(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PSUBH : public Instruction32
+{
+public:
+    PSUBH(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PSUBW : public Instruction32
+{
+public:
+    PSUBW(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PSUBD : public Instruction32
+{
+public:
+    PSUBD(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PSUBSB : public Instruction32
+{
+public:
+    PSUBSB(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PSUBSH : public Instruction32
+{
+public:
+    PSUBSH(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PSUBUSB : public Instruction32
+{
+public:
+    PSUBUSB(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PSUBUSH : public Instruction32
+{
+public:
+    PSUBUSH(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PUNPCKHBH : public Instruction32
+{
+public:
+    PUNPCKHBH(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PUNPCKHHW : public Instruction32
+{
+public:
+    PUNPCKHHW(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PUNPCKHWD : public Instruction32
+{
+public:
+    PUNPCKHWD(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PUNPCKLBH : public Instruction32
+{
+public:
+    PUNPCKLBH(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PUNPCKLHW : public Instruction32
+{
+public:
+    PUNPCKLHW(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class PUNPCKLWD : public Instruction32
+{
+public:
+    PUNPCKLWD(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class ADD_CP2 : public Instruction32
+{
+public:
+    ADD_CP2(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class ADDU_CP2 : public Instruction32
+{
+public:
+    ADDU_CP2(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DADD_CP2 : public Instruction32
+{
+public:
+    DADD_CP2(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SUB_CP2 : public Instruction32
+{
+public:
+    SUB_CP2(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SUBU_CP2 : public Instruction32
+{
+public:
+    SUBU_CP2(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DSUB_CP2 : public Instruction32
+{
+public:
+    DSUB_CP2(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class OR_CP2 : public Instruction32
+{
+public:
+    OR_CP2(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SLI_CP2 : public Instruction32
+{
+public:
+    SLI_CP2(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DSLL_CP2 : public Instruction32
+{
+public:
+    DSLL_CP2(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class XOR_CP2 : public Instruction32
+{
+public:
+    XOR_CP2(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class NOR_CP2 : public Instruction32
+{
+public:
+    NOR_CP2(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class AND_CP2 : public Instruction32
+{
+public:
+    AND_CP2(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SRL_CP2 : public Instruction32
+{
+public:
+    SRL_CP2(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DSRL_CP2 : public Instruction32
+{
+public:
+    DSRL_CP2(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SRA_CP2 : public Instruction32
+{
+public:
+    SRA_CP2(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class DSRA_CP2 : public Instruction32
+{
+public:
+    DSRA_CP2(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SEQU_CP2 : public Instruction32
+{
+public:
+    SEQU_CP2(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SLTU_CP2 : public Instruction32
+{
+public:
+    SLTU_CP2(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SLEU_CP2 : public Instruction32
+{
+public:
+    SLEU_CP2(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SEQ_CP2 : public Instruction32
+{
+public:
+    SEQ_CP2(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SLT_CP2 : public Instruction32
+{
+public:
+    SLT_CP2(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class SLE_CP2 : public Instruction32
+{
+public:
+    SLE_CP2(uint32_t insn);
+    bool disas_output(disassemble_info *info);
+};
+
+class Decoder
+{
+public:
+    int decode32(disassemble_info *ctx, uint32_t insn);
+};
+
+#endif
diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
index c5f9fa0..d89e998 100644
--- a/include/disas/dis-asm.h
+++ b/include/disas/dis-asm.h
@@ -396,6 +396,7 @@ int print_insn_tci(bfd_vma, disassemble_info*);
 int print_insn_big_mips         (bfd_vma, disassemble_info*);
 int print_insn_little_mips      (bfd_vma, disassemble_info*);
 int print_insn_nanomips         (bfd_vma, disassemble_info*);
+int print_insn_loongson2f       (bfd_vma, disassemble_info*);
 int print_insn_i386             (bfd_vma, disassemble_info*);
 int print_insn_m68k             (bfd_vma, disassemble_info*);
 int print_insn_z8001            (bfd_vma, disassemble_info*);
diff --git a/include/exec/poison.h b/include/exec/poison.h
index 7b9ac36..b1df91a 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -78,6 +78,7 @@
 #pragma GCC poison CONFIG_M68K_DIS
 #pragma GCC poison CONFIG_MICROBLAZE_DIS
 #pragma GCC poison CONFIG_MIPS_DIS
+#pragma GCC poison CONFIG_LOONGSON2F_DIS
 #pragma GCC poison CONFIG_NANOMIPS_DIS
 #pragma GCC poison CONFIG_MOXIE_DIS
 #pragma GCC poison CONFIG_NIOS2_DIS
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index e86cd06..d471326 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -132,6 +132,12 @@ static void mips_cpu_disas_set_info(CPUState *s, disassemble_info *info)
         info->print_insn = print_insn_nanomips;
 #endif
     }
+
+    if (env->insn_flags & INSN_LOONGSON2F) {
+#if defined(CONFIG_LOONGSON2F_DIS)
+        info->print_insn = print_insn_loongson2f;
+#endif
+    }
 }
 
 static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
diff --git a/MAINTAINERS b/MAINTAINERS
index 70bceb5..89f9f1d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -219,6 +219,7 @@ S: Maintained
 F: target/mips/
 F: default-configs/*mips*
 F: disas/*mips*
+F: disas/loongson*
 F: docs/system/cpu-models-mips.rst.inc
 F: hw/intc/mips_gic.c
 F: hw/mips/
diff --git a/disas/Makefile.objs b/disas/Makefile.objs
index 3c1cdce..0d5ee1e 100644
--- a/disas/Makefile.objs
+++ b/disas/Makefile.objs
@@ -14,6 +14,7 @@ common-obj-$(CONFIG_I386_DIS) += i386.o
 common-obj-$(CONFIG_M68K_DIS) += m68k.o
 common-obj-$(CONFIG_MICROBLAZE_DIS) += microblaze.o
 common-obj-$(CONFIG_MIPS_DIS) += mips.o
+common-obj-$(CONFIG_LOONGSON2F_DIS) += loongson2f.o
 common-obj-$(CONFIG_NANOMIPS_DIS) += nanomips.o
 common-obj-$(CONFIG_NIOS2_DIS) += nios2.o
 common-obj-$(CONFIG_MOXIE_DIS) += moxie.o
diff --git a/disas/loongson2f.cpp b/disas/loongson2f.cpp
new file mode 100644
index 0000000..e84a2c0
--- /dev/null
+++ b/disas/loongson2f.cpp
@@ -0,0 +1,8154 @@
+/*
+ *  Source file for Loongson 2F disassembler component of QEMU
+ *
+ *  Copyright (C) 2020  Stefan Brankovic <stefan.brankovic@syrmia.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+extern "C" {
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "disas/dis-asm.h"
+}
+
+#include "loongson2f.h"
+
+int print_insn_loongson2f(bfd_vma addr, disassemble_info *info)
+{
+    bfd_byte buffer[4];
+    uint32_t insn32;
+    int status;
+    Decoder *decoder = new Decoder();
+
+    status = info->read_memory_func(addr, buffer, 4, info);
+    if (status != 0) {
+        info->memory_error_func(status, addr, info);
+        return -1;
+    }
+    if (info->endian == BFD_ENDIAN_BIG) {
+        insn32 = bfd_getb32(buffer);
+    } else {
+        insn32 = bfd_getl32(buffer);
+    }
+
+    status = decoder->decode32(info, insn32);
+
+    delete decoder;
+
+    return status == 0 ? -1 : 4;
+}
+
+int Fields32RdRsRt::getRd()
+{
+    return this->rd;
+}
+
+int Fields32RdRsRt::getRs()
+{
+    return this->rs;
+}
+
+int Fields32RdRsRt::getRt()
+{
+    return this->rt;
+}
+
+int Fields32ImmRsRt::getImm()
+{
+    return this->imm;
+}
+
+int Fields32ImmRsRt::getRs()
+{
+    return this->rs;
+}
+
+int Fields32ImmRsRt::getRt()
+{
+    return this->rt;
+}
+
+int Fields32RdRs::getRd()
+{
+    return this->rd;
+}
+
+int Fields32RdRs::getRs()
+{
+    return this->rs;
+}
+
+int Fields32Rs::getRs()
+{
+    return this->rs;
+}
+
+int Fields32BaseOffsetRt::getBase()
+{
+    return this->base;
+}
+
+int Fields32BaseOffsetRt::getOffset()
+{
+    return this->offset;
+}
+
+int Fields32BaseOffsetRt::getRt()
+{
+    return this->rt;
+}
+
+int Fields32ImmRt::getImm()
+{
+    return this->imm;
+}
+
+int Fields32ImmRt::getRt()
+{
+    return this->rt;
+}
+
+int Fields32Rd::getRd()
+{
+    return this->rd;
+}
+
+int Fields32Stype::getStype()
+{
+    return this->stype;
+}
+
+int Fields32CodeRsRt::getCode()
+{
+    return this->code;
+}
+
+int Fields32CodeRsRt::getRs()
+{
+    return this->rs;
+}
+
+int Fields32CodeRsRt::getRt()
+{
+    return this->rt;
+}
+
+int Fields32ImmRs::getImm()
+{
+    return this->imm;
+}
+
+int Fields32ImmRs::getRs()
+{
+    return this->rs;
+}
+
+int Fields32FdFs::getFd()
+{
+    return this->fd;
+}
+
+int Fields32FdFs::getFs()
+{
+    return this->fs;
+}
+
+int Fields32FdFsFt::getFd()
+{
+    return this->fd;
+}
+
+int Fields32FdFsFt::getFs()
+{
+    return this->fs;
+}
+
+int Fields32FdFsFt::getFt()
+{
+    return this->ft;
+}
+
+int Fields32Offset::getOffset()
+{
+    return this->offset;
+}
+
+int Fields32FsFt::getFs()
+{
+    return this->fs;
+}
+
+int Fields32FsFt::getFt()
+{
+    return this->ft;
+}
+
+int Fields32FsRt::getFs()
+{
+    return this->fs;
+}
+
+int Fields32FsRt::getRt()
+{
+    return this->rt;
+}
+
+int Fields32BaseFtOffset::getBase()
+{
+    return this->base;
+}
+
+int Fields32BaseFtOffset::getFt()
+{
+    return this->ft;
+}
+
+int Fields32BaseFtOffset::getOffset()
+{
+    return this->offset;
+}
+
+int Fields32OffsetRsRt::getOffset()
+{
+    return this->offset;
+}
+
+int Fields32OffsetRsRt::getRs()
+{
+    return this->rs;
+}
+
+int Fields32OffsetRsRt::getRt()
+{
+    return this->rt;
+}
+
+int Fields32OffsetRs::getOffset()
+{
+    return this->offset;
+}
+
+int Fields32OffsetRs::getRs()
+{
+    return this->rs;
+}
+
+int Fields32Code::getCode()
+{
+    return this->code;
+}
+
+int Fields32Cop_fun::getCop_fun()
+{
+    return this->cop_fun;
+}
+
+int Fields32RsRt::getRs()
+{
+    return this->rs;
+}
+
+int Fields32RsRt::getRt()
+{
+    return this->rt;
+}
+
+int Fields32RdRtSa::getRd()
+{
+    return this->rd;
+}
+
+int Fields32RdRtSa::getRt()
+{
+    return this->rt;
+}
+
+int Fields32RdRtSa::getSa()
+{
+    return this->sa;
+}
+
+int Fields32Instr_index::getInstr_index()
+{
+    return this->instr_index;
+}
+
+void Fields32RdRsRtD0::decode_fields32(uint32_t insn)
+{
+    this->rt = extract32(insn, 16, 5);
+    this->rd = extract32(insn, 11, 5);
+    this->rs = extract32(insn, 21, 5);
+}
+
+void Fields32ImmRsRtD0::decode_fields32(uint32_t insn)
+{
+    this->rt = extract32(insn, 16, 5);
+    this->imm = sextract32(insn, 0, 16);
+    this->rs = extract32(insn, 21, 5);
+}
+
+void Fields32RdRsD0::decode_fields32(uint32_t insn)
+{
+    this->rd = extract32(insn, 11, 5);
+    this->rs = extract32(insn, 21, 5);
+}
+
+void Fields32RsD0::decode_fields32(uint32_t insn)
+{
+    this->rs = extract32(insn, 21, 5);
+}
+
+void Fields32BaseOffsetRtD0::decode_fields32(uint32_t insn)
+{
+    this->rt = extract32(insn, 16, 5);
+    this->base = extract32(insn, 21, 5);
+    this->offset = sextract32(insn, 0, 16);
+}
+
+void Fields32ImmRtD0::decode_fields32(uint32_t insn)
+{
+    this->rt = extract32(insn, 16, 5);
+    this->imm = extract32(insn, 0, 16);
+}
+
+void Fields32RdD0::decode_fields32(uint32_t insn)
+{
+    this->rd = extract32(insn, 11, 5);
+}
+
+void Fields32StypeD0::decode_fields32(uint32_t insn)
+{
+    this->stype = extract32(insn, 6, 5);
+}
+
+void Fields32CodeRsRtD0::decode_fields32(uint32_t insn)
+{
+    this->rt = extract32(insn, 16, 5);
+    this->code = extract32(insn, 6, 10);
+    this->rs = extract32(insn, 21, 5);
+}
+
+void Fields32ImmRsD0::decode_fields32(uint32_t insn)
+{
+    this->imm = sextract32(insn, 0, 16);
+    this->rs = extract32(insn, 21, 5);
+}
+
+void Fields32FdFsD0::decode_fields32(uint32_t insn)
+{
+    this->fs = extract32(insn, 11, 5);
+    this->fd = extract32(insn, 6, 5);
+}
+
+void Fields32FdFsFtD0::decode_fields32(uint32_t insn)
+{
+    this->ft = extract32(insn, 16, 5);
+    this->fs = extract32(insn, 11, 5);
+    this->fd = extract32(insn, 6, 5);
+}
+
+void Fields32ImmRsRtD1::decode_fields32(uint32_t insn)
+{
+    this->rt = extract32(insn, 16, 5);
+    this->imm = extract32(insn, 0, 16);
+    this->rs = extract32(insn, 21, 5);
+}
+
+void Fields32OffsetD0::decode_fields32(uint32_t insn)
+{
+    this->offset = sextract32(insn, 0, 16);
+}
+
+void Fields32FsFtD0::decode_fields32(uint32_t insn)
+{
+    this->fs = extract32(insn, 11, 5);
+    this->ft = extract32(insn, 16, 5);
+}
+
+void Fields32FsRtD0::decode_fields32(uint32_t insn)
+{
+    this->rt = extract32(insn, 16, 5);
+    this->fs = extract32(insn, 11, 5);
+}
+
+void Fields32BaseFtOffsetD0::decode_fields32(uint32_t insn)
+{
+    this->base = extract32(insn, 21, 5);
+    this->ft = extract32(insn, 16, 5);
+    this->offset = sextract32(insn, 0, 16);
+}
+
+void Fields32OffsetRsRtD0::decode_fields32(uint32_t insn)
+{
+    this->rt = extract32(insn, 16, 5);
+    this->rs = extract32(insn, 21, 5);
+    this->offset = sextract32(insn, 0, 16);
+}
+
+void Fields32OffsetRsD0::decode_fields32(uint32_t insn)
+{
+    this->rs = extract32(insn, 21, 5);
+    this->offset = sextract32(insn, 0, 16);
+}
+
+void Fields32CodeD0::decode_fields32(uint32_t insn)
+{
+    this->code = extract32(insn, 6, 20);
+}
+
+void Fields32Cop_funD0::decode_fields32(uint32_t insn)
+{
+    this->cop_fun = extract32(insn, 0, 26);
+}
+
+void Fields32RsRtD0::decode_fields32(uint32_t insn)
+{
+    this->rt = extract32(insn, 16, 5);
+    this->rs = extract32(insn, 21, 5);
+}
+
+void Fields32RdRtSaD0::decode_fields32(uint32_t insn)
+{
+    this->rt = extract32(insn, 16, 5);
+    this->rd = extract32(insn, 11, 5);
+    this->sa = extract32(insn, 6, 5);
+}
+
+void Fields32Instr_indexD0::decode_fields32(uint32_t insn)
+{
+    this->instr_index = extract32(insn, 0, 26);
+}
+
+void Instruction32::getAlias(char *buffer, int regNo)
+{
+    switch (regNo) {
+    case 0:
+        strncpy(buffer, "zero", 5);
+        break;
+    case 1:
+        strncpy(buffer, "at", 5);
+        break;
+    case 2:
+    case 3:
+        sprintf(buffer, "v%d", regNo - 2);
+        break;
+    case 4:
+    case 5:
+    case 6:
+    case 7:
+    case 8:
+    case 9:
+    case 10:
+    case 11:
+        sprintf(buffer, "a%d", regNo - 4);
+        break;
+    case 12:
+    case 13:
+    case 14:
+    case 15:
+        sprintf(buffer, "t%d", regNo - 12);
+        break;
+    case 16:
+    case 17:
+    case 18:
+    case 19:
+    case 20:
+    case 21:
+    case 22:
+    case 23:
+        sprintf(buffer, "s%d", regNo - 16);
+        break;
+    case 24:
+    case 25:
+        sprintf(buffer, "t%d", regNo - 16);
+        break;
+    case 28:
+        strncpy(buffer, "gp", 5);
+        break;
+    case 29:
+        strncpy(buffer, "sp", 5);
+        break;
+    case 30:
+        strncpy(buffer, "s8", 5);
+        break;
+    case 31:
+        strncpy(buffer, "ra", 5);
+        break;
+    default:
+        sprintf(buffer, "r%d", regNo);
+        break;
+    }
+}
+
+Instruction32::~Instruction32() {}
+
+ADD::ADD(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool ADD::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "ADD",
+     alias1, alias2, alias3));
+    return true;
+}
+
+ADDI::ADDI(uint32_t insn)
+{
+    this->fields32 = new Fields32ImmRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool ADDI::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32ImmRsRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32ImmRsRt *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "ADDI",
+     alias1, alias2, ((Fields32ImmRsRt *)this->fields32)->getImm()));
+    return true;
+}
+
+ADDIU::ADDIU(uint32_t insn)
+{
+    this->fields32 = new Fields32ImmRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool ADDIU::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32ImmRsRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32ImmRsRt *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "ADDIU",
+     alias1, alias2, ((Fields32ImmRsRt *)this->fields32)->getImm()));
+    return true;
+}
+
+ADDU::ADDU(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool ADDU::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "ADDU",
+     alias1, alias2, alias3));
+    return true;
+}
+
+AND::AND(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool AND::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "AND",
+     alias1, alias2, alias3));
+    return true;
+}
+
+ANDI::ANDI(uint32_t insn)
+{
+    this->fields32 = new Fields32ImmRsRtD1();
+    this->fields32->decode_fields32(insn);
+}
+
+bool ANDI::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32ImmRsRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32ImmRsRt *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "ANDI",
+     alias1, alias2, ((Fields32ImmRsRt *)this->fields32)->getImm()));
+    return true;
+}
+
+BEQ::BEQ(uint32_t insn)
+{
+    this->fields32 = new Fields32OffsetRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool BEQ::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32OffsetRsRt *)this->fields32)->getRs());
+    getAlias(alias2, ((Fields32OffsetRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "BEQ",
+     alias1, alias2, ((Fields32OffsetRsRt *)this->fields32)->getOffset()));
+    return true;
+}
+
+BEQL::BEQL(uint32_t insn)
+{
+    this->fields32 = new Fields32OffsetRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool BEQL::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32OffsetRsRt *)this->fields32)->getRs());
+    getAlias(alias2, ((Fields32OffsetRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "BEQL",
+     alias1, alias2, ((Fields32OffsetRsRt *)this->fields32)->getOffset()));
+    return true;
+}
+
+BGEZ::BGEZ(uint32_t insn)
+{
+    this->fields32 = new Fields32OffsetRsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool BGEZ::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    getAlias(alias1, ((Fields32OffsetRs *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "BGEZ",
+     alias1, ((Fields32OffsetRs *)this->fields32)->getOffset()));
+    return true;
+}
+
+BGEZAL::BGEZAL(uint32_t insn)
+{
+    this->fields32 = new Fields32OffsetRsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool BGEZAL::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    getAlias(alias1, ((Fields32OffsetRs *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "BGEZAL",
+     alias1, ((Fields32OffsetRs *)this->fields32)->getOffset()));
+    return true;
+}
+
+BGEZALL::BGEZALL(uint32_t insn)
+{
+    this->fields32 = new Fields32OffsetRsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool BGEZALL::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    getAlias(alias1, ((Fields32OffsetRs *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "BGEZALL",
+     alias1, ((Fields32OffsetRs *)this->fields32)->getOffset()));
+    return true;
+}
+
+BGEZL::BGEZL(uint32_t insn)
+{
+    this->fields32 = new Fields32OffsetRsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool BGEZL::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    getAlias(alias1, ((Fields32OffsetRs *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "BGEZL",
+     alias1, ((Fields32OffsetRs *)this->fields32)->getOffset()));
+    return true;
+}
+
+BGTZ::BGTZ(uint32_t insn)
+{
+    this->fields32 = new Fields32OffsetRsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool BGTZ::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    getAlias(alias1, ((Fields32OffsetRs *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "BGTZ",
+     alias1, ((Fields32OffsetRs *)this->fields32)->getOffset()));
+    return true;
+}
+
+BGTZL::BGTZL(uint32_t insn)
+{
+    this->fields32 = new Fields32OffsetRsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool BGTZL::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    getAlias(alias1, ((Fields32OffsetRs *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "BGTZL",
+     alias1, ((Fields32OffsetRs *)this->fields32)->getOffset()));
+    return true;
+}
+
+BLEZ::BLEZ(uint32_t insn)
+{
+    this->fields32 = new Fields32OffsetRsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool BLEZ::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    getAlias(alias1, ((Fields32OffsetRs *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "BLEZ",
+     alias1, ((Fields32OffsetRs *)this->fields32)->getOffset()));
+    return true;
+}
+
+BLEZL::BLEZL(uint32_t insn)
+{
+    this->fields32 = new Fields32OffsetRsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool BLEZL::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    getAlias(alias1, ((Fields32OffsetRs *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "BLEZL",
+     alias1, ((Fields32OffsetRs *)this->fields32)->getOffset()));
+    return true;
+}
+
+BLTZ::BLTZ(uint32_t insn)
+{
+    this->fields32 = new Fields32OffsetRsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool BLTZ::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    getAlias(alias1, ((Fields32OffsetRs *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "BLTZ",
+     alias1, ((Fields32OffsetRs *)this->fields32)->getOffset()));
+    return true;
+}
+
+BLTZAL::BLTZAL(uint32_t insn)
+{
+    this->fields32 = new Fields32OffsetRsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool BLTZAL::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    getAlias(alias1, ((Fields32OffsetRs *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "BLTZAL",
+     alias1, ((Fields32OffsetRs *)this->fields32)->getOffset()));
+    return true;
+}
+
+BLTZALL::BLTZALL(uint32_t insn)
+{
+    this->fields32 = new Fields32OffsetRsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool BLTZALL::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    getAlias(alias1, ((Fields32OffsetRs *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "BLTZALL",
+     alias1, ((Fields32OffsetRs *)this->fields32)->getOffset()));
+    return true;
+}
+
+BLTZL::BLTZL(uint32_t insn)
+{
+    this->fields32 = new Fields32OffsetRsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool BLTZL::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    getAlias(alias1, ((Fields32OffsetRs *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "BLTZL",
+     alias1, ((Fields32OffsetRs *)this->fields32)->getOffset()));
+    return true;
+}
+
+BNE::BNE(uint32_t insn)
+{
+    this->fields32 = new Fields32OffsetRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool BNE::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32OffsetRsRt *)this->fields32)->getRs());
+    getAlias(alias2, ((Fields32OffsetRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "BNE",
+     alias1, alias2, ((Fields32OffsetRsRt *)this->fields32)->getOffset()));
+    return true;
+}
+
+BNEL::BNEL(uint32_t insn)
+{
+    this->fields32 = new Fields32OffsetRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool BNEL::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32OffsetRsRt *)this->fields32)->getRs());
+    getAlias(alias2, ((Fields32OffsetRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "BNEL",
+     alias1, alias2, ((Fields32OffsetRsRt *)this->fields32)->getOffset()));
+    return true;
+}
+
+BREAK::BREAK(uint32_t insn)
+{
+    this->fields32 = new Fields32CodeD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool BREAK::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " %d", "" "BREAK",
+     ((Fields32Code *)this->fields32)->getCode()));
+    return true;
+}
+
+COP0::COP0(uint32_t insn)
+{
+    this->fields32 = new Fields32Cop_funD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool COP0::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " %d", "" "COP0",
+     ((Fields32Cop_fun *)this->fields32)->getCop_fun()));
+    return true;
+}
+
+COP3::COP3(uint32_t insn)
+{
+    this->fields32 = new Fields32Cop_funD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool COP3::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " %d", "" "COP3",
+     ((Fields32Cop_fun *)this->fields32)->getCop_fun()));
+    return true;
+}
+
+DADD::DADD(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DADD::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "DADD",
+     alias1, alias2, alias3));
+    return true;
+}
+
+DADDI::DADDI(uint32_t insn)
+{
+    this->fields32 = new Fields32ImmRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DADDI::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32ImmRsRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32ImmRsRt *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "DADDI",
+     alias1, alias2, ((Fields32ImmRsRt *)this->fields32)->getImm()));
+    return true;
+}
+
+DADDIU::DADDIU(uint32_t insn)
+{
+    this->fields32 = new Fields32ImmRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DADDIU::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32ImmRsRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32ImmRsRt *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "DADDIU",
+     alias1, alias2, ((Fields32ImmRsRt *)this->fields32)->getImm()));
+    return true;
+}
+
+DADDU::DADDU(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DADDU::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "DADDU",
+     alias1, alias2, alias3));
+    return true;
+}
+
+DDIV::DDIV(uint32_t insn)
+{
+    this->fields32 = new Fields32RsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DDIV::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32RsRt *)this->fields32)->getRs());
+    getAlias(alias2, ((Fields32RsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s", "" "DDIV",
+     alias1, alias2));
+    return true;
+}
+
+DDIVU::DDIVU(uint32_t insn)
+{
+    this->fields32 = new Fields32RsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DDIVU::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32RsRt *)this->fields32)->getRs());
+    getAlias(alias2, ((Fields32RsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s", "" "DDIVU",
+     alias1, alias2));
+    return true;
+}
+
+DIV::DIV(uint32_t insn)
+{
+    this->fields32 = new Fields32RsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DIV::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32RsRt *)this->fields32)->getRs());
+    getAlias(alias2, ((Fields32RsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s", "" "DIV",
+     alias1, alias2));
+    return true;
+}
+
+DIVU::DIVU(uint32_t insn)
+{
+    this->fields32 = new Fields32RsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DIVU::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32RsRt *)this->fields32)->getRs());
+    getAlias(alias2, ((Fields32RsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s", "" "DIVU",
+     alias1, alias2));
+    return true;
+}
+
+DMULT::DMULT(uint32_t insn)
+{
+    this->fields32 = new Fields32RsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DMULT::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32RsRt *)this->fields32)->getRs());
+    getAlias(alias2, ((Fields32RsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s", "" "DMULT",
+     alias1, alias2));
+    return true;
+}
+
+DMULTU::DMULTU(uint32_t insn)
+{
+    this->fields32 = new Fields32RsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DMULTU::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32RsRt *)this->fields32)->getRs());
+    getAlias(alias2, ((Fields32RsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s", "" "DMULTU",
+     alias1, alias2));
+    return true;
+}
+
+DSLL::DSLL(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRtSaD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DSLL::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32RdRtSa *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRtSa *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "DSLL",
+     alias1, alias2, ((Fields32RdRtSa *)this->fields32)->getSa()));
+    return true;
+}
+
+DSLL32::DSLL32(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRtSaD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DSLL32::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32RdRtSa *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRtSa *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "DSLL32",
+     alias1, alias2, ((Fields32RdRtSa *)this->fields32)->getSa()));
+    return true;
+}
+
+DSLLV::DSLLV(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DSLLV::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRt());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "DSLLV",
+     alias1, alias2, alias3));
+    return true;
+}
+
+DSRA::DSRA(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRtSaD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DSRA::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32RdRtSa *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRtSa *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "DSRA",
+     alias1, alias2, ((Fields32RdRtSa *)this->fields32)->getSa()));
+    return true;
+}
+
+DSRA32::DSRA32(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRtSaD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DSRA32::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32RdRtSa *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRtSa *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "DSRA32",
+     alias1, alias2, ((Fields32RdRtSa *)this->fields32)->getSa()));
+    return true;
+}
+
+DSRAV::DSRAV(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DSRAV::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRt());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "DSRAV",
+     alias1, alias2, alias3));
+    return true;
+}
+
+DSRL::DSRL(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRtSaD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DSRL::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32RdRtSa *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRtSa *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "DSRL",
+     alias1, alias2, ((Fields32RdRtSa *)this->fields32)->getSa()));
+    return true;
+}
+
+DSRL32::DSRL32(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRtSaD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DSRL32::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32RdRtSa *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRtSa *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "DSRL32",
+     alias1, alias2, ((Fields32RdRtSa *)this->fields32)->getSa()));
+    return true;
+}
+
+DSRLV::DSRLV(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DSRLV::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRt());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "DSRLV",
+     alias1, alias2, alias3));
+    return true;
+}
+
+DSUB::DSUB(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DSUB::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "DSUB",
+     alias1, alias2, alias3));
+    return true;
+}
+
+DSUBU::DSUBU(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DSUBU::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "DSUBU",
+     alias1, alias2, alias3));
+    return true;
+}
+
+J::J(uint32_t insn)
+{
+    this->fields32 = new Fields32Instr_indexD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool J::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " %d", "" "J",
+     ((Fields32Instr_index *)this->fields32)->getInstr_index()));
+    return true;
+}
+
+JAL::JAL(uint32_t insn)
+{
+    this->fields32 = new Fields32Instr_indexD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool JAL::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " %d", "" "JAL",
+     ((Fields32Instr_index *)this->fields32)->getInstr_index()));
+    return true;
+}
+
+JALR::JALR(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool JALR::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32RdRs *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRs *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s", "" "JALR",
+     alias1, alias2));
+    return true;
+}
+
+JR::JR(uint32_t insn)
+{
+    this->fields32 = new Fields32RsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool JR::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    getAlias(alias1, ((Fields32Rs *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s", "" "JR",
+     alias1));
+    return true;
+}
+
+LB::LB(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseOffsetRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool LB::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32BaseOffsetRt *)this->fields32)->getBase());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LB",
+     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(), alias2));
+    return true;
+}
+
+LBU::LBU(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseOffsetRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool LBU::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32BaseOffsetRt *)this->fields32)->getBase());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LBU",
+     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(), alias2));
+    return true;
+}
+
+LD::LD(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseOffsetRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool LD::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32BaseOffsetRt *)this->fields32)->getBase());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LD",
+     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(), alias2));
+    return true;
+}
+
+LDC2::LDC2(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseOffsetRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool LDC2::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32BaseOffsetRt *)this->fields32)->getBase());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LDC2",
+     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(), alias2));
+    return true;
+}
+
+LDL::LDL(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseOffsetRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool LDL::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32BaseOffsetRt *)this->fields32)->getBase());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LDL",
+     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(), alias2));
+    return true;
+}
+
+LDR::LDR(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseOffsetRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool LDR::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32BaseOffsetRt *)this->fields32)->getBase());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LDR",
+     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(), alias2));
+    return true;
+}
+
+LH::LH(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseOffsetRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool LH::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32BaseOffsetRt *)this->fields32)->getBase());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LH",
+     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(), alias2));
+    return true;
+}
+
+LHU::LHU(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseOffsetRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool LHU::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32BaseOffsetRt *)this->fields32)->getBase());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LHU",
+     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(), alias2));
+    return true;
+}
+
+LL::LL(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseOffsetRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool LL::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32BaseOffsetRt *)this->fields32)->getBase());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LL",
+     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(), alias2));
+    return true;
+}
+
+LLD::LLD(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseOffsetRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool LLD::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32BaseOffsetRt *)this->fields32)->getBase());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LLD",
+     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(), alias2));
+    return true;
+}
+
+LUI::LUI(uint32_t insn)
+{
+    this->fields32 = new Fields32ImmRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool LUI::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    getAlias(alias1, ((Fields32ImmRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "LUI",
+     alias1, ((Fields32ImmRt *)this->fields32)->getImm()));
+    return true;
+}
+
+LW::LW(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseOffsetRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool LW::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32BaseOffsetRt *)this->fields32)->getBase());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LW",
+     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(), alias2));
+    return true;
+}
+
+LWC2::LWC2(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseOffsetRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool LWC2::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32BaseOffsetRt *)this->fields32)->getBase());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LWC2",
+     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(), alias2));
+    return true;
+}
+
+LWC3::LWC3(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseOffsetRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool LWC3::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32BaseOffsetRt *)this->fields32)->getBase());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LWC3",
+     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(), alias2));
+    return true;
+}
+
+LWL::LWL(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseOffsetRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool LWL::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32BaseOffsetRt *)this->fields32)->getBase());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LWL",
+     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(), alias2));
+    return true;
+}
+
+LWR::LWR(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseOffsetRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool LWR::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32BaseOffsetRt *)this->fields32)->getBase());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LWR",
+     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(), alias2));
+    return true;
+}
+
+LWU::LWU(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseOffsetRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool LWU::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32BaseOffsetRt *)this->fields32)->getBase());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LWU",
+     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(), alias2));
+    return true;
+}
+
+MFHI::MFHI(uint32_t insn)
+{
+    this->fields32 = new Fields32RdD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool MFHI::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    getAlias(alias1, ((Fields32Rd *)this->fields32)->getRd());
+    (info->fprintf_func(info->stream, "%-9s" " %s", "" "MFHI",
+     alias1));
+    return true;
+}
+
+MFLO::MFLO(uint32_t insn)
+{
+    this->fields32 = new Fields32RdD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool MFLO::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    getAlias(alias1, ((Fields32Rd *)this->fields32)->getRd());
+    (info->fprintf_func(info->stream, "%-9s" " %s", "" "MFLO",
+     alias1));
+    return true;
+}
+
+MTHI::MTHI(uint32_t insn)
+{
+    this->fields32 = new Fields32RsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool MTHI::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    getAlias(alias1, ((Fields32Rs *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s", "" "MTHI",
+     alias1));
+    return true;
+}
+
+MTLO::MTLO(uint32_t insn)
+{
+    this->fields32 = new Fields32RsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool MTLO::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    getAlias(alias1, ((Fields32Rs *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s", "" "MTLO",
+     alias1));
+    return true;
+}
+
+MULT::MULT(uint32_t insn)
+{
+    this->fields32 = new Fields32RsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool MULT::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32RsRt *)this->fields32)->getRs());
+    getAlias(alias2, ((Fields32RsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s", "" "MULT",
+     alias1, alias2));
+    return true;
+}
+
+MULTU::MULTU(uint32_t insn)
+{
+    this->fields32 = new Fields32RsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool MULTU::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32RsRt *)this->fields32)->getRs());
+    getAlias(alias2, ((Fields32RsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s", "" "MULTU",
+     alias1, alias2));
+    return true;
+}
+
+NOR::NOR(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool NOR::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "NOR",
+     alias1, alias2, alias3));
+    return true;
+}
+
+OR::OR(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool OR::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "OR",
+     alias1, alias2, alias3));
+    return true;
+}
+
+ORI::ORI(uint32_t insn)
+{
+    this->fields32 = new Fields32ImmRsRtD1();
+    this->fields32->decode_fields32(insn);
+}
+
+bool ORI::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32ImmRsRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32ImmRsRt *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "ORI",
+     alias1, alias2, ((Fields32ImmRsRt *)this->fields32)->getImm()));
+    return true;
+}
+
+SB::SB(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseOffsetRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SB::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32BaseOffsetRt *)this->fields32)->getBase());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "SB",
+     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(), alias2));
+    return true;
+}
+
+SC::SC(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseOffsetRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SC::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32BaseOffsetRt *)this->fields32)->getBase());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "SC",
+     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(), alias2));
+    return true;
+}
+
+SCD::SCD(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseOffsetRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SCD::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32BaseOffsetRt *)this->fields32)->getBase());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "SCD",
+     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(), alias2));
+    return true;
+}
+
+SD::SD(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseOffsetRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SD::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32BaseOffsetRt *)this->fields32)->getBase());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "SD",
+     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(), alias2));
+    return true;
+}
+
+SDC2::SDC2(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseOffsetRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SDC2::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32BaseOffsetRt *)this->fields32)->getBase());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "SDC2",
+     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(), alias2));
+    return true;
+}
+
+SDL::SDL(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseOffsetRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SDL::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32BaseOffsetRt *)this->fields32)->getBase());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "SDL",
+     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(), alias2));
+    return true;
+}
+
+SDR::SDR(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseOffsetRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SDR::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32BaseOffsetRt *)this->fields32)->getBase());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "SDR",
+     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(), alias2));
+    return true;
+}
+
+SH::SH(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseOffsetRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SH::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32BaseOffsetRt *)this->fields32)->getBase());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "SH",
+     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(), alias2));
+    return true;
+}
+
+SLL::SLL(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRtSaD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SLL::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32RdRtSa *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRtSa *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "SLL",
+     alias1, alias2, ((Fields32RdRtSa *)this->fields32)->getSa()));
+    return true;
+}
+
+SLLV::SLLV(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SLLV::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "SLLV",
+     alias1, alias2, alias3));
+    return true;
+}
+
+SLT::SLT(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SLT::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "SLT",
+     alias1, alias2, alias3));
+    return true;
+}
+
+SLTI::SLTI(uint32_t insn)
+{
+    this->fields32 = new Fields32ImmRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SLTI::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32ImmRsRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32ImmRsRt *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "SLTI",
+     alias1, alias2, ((Fields32ImmRsRt *)this->fields32)->getImm()));
+    return true;
+}
+
+SLTIU::SLTIU(uint32_t insn)
+{
+    this->fields32 = new Fields32ImmRsRtD1();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SLTIU::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32ImmRsRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32ImmRsRt *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "SLTIU",
+     alias1, alias2, ((Fields32ImmRsRt *)this->fields32)->getImm()));
+    return true;
+}
+
+SLTU::SLTU(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SLTU::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "SLTU",
+     alias1, alias2, alias3));
+    return true;
+}
+
+SRA::SRA(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRtSaD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SRA::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32RdRtSa *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRtSa *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "SRA",
+     alias1, alias2, ((Fields32RdRtSa *)this->fields32)->getSa()));
+    return true;
+}
+
+SRAV::SRAV(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SRAV::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRt());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "SRAV",
+     alias1, alias2, alias3));
+    return true;
+}
+
+SRL::SRL(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRtSaD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SRL::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32RdRtSa *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRtSa *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "SRL",
+     alias1, alias2, ((Fields32RdRtSa *)this->fields32)->getSa()));
+    return true;
+}
+
+SRLV::SRLV(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SRLV::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "SRLV",
+     alias1, alias2, alias3));
+    return true;
+}
+
+SUB::SUB(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SUB::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "SUB",
+     alias1, alias2, alias3));
+    return true;
+}
+
+SUBU::SUBU(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SUBU::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "SUBU",
+     alias1, alias2, alias3));
+    return true;
+}
+
+SW::SW(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseOffsetRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SW::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32BaseOffsetRt *)this->fields32)->getBase());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "SW",
+     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(), alias2));
+    return true;
+}
+
+SWC2::SWC2(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseOffsetRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SWC2::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32BaseOffsetRt *)this->fields32)->getBase());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "SWC2",
+     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(), alias2));
+    return true;
+}
+
+SWC3::SWC3(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseOffsetRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SWC3::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32BaseOffsetRt *)this->fields32)->getBase());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "SWC3",
+     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(), alias2));
+    return true;
+}
+
+SWL::SWL(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseOffsetRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SWL::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32BaseOffsetRt *)this->fields32)->getBase());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "SWL",
+     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(), alias2));
+    return true;
+}
+
+SWR::SWR(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseOffsetRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SWR::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32BaseOffsetRt *)this->fields32)->getBase());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "SWR",
+     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(), alias2));
+    return true;
+}
+
+SYNC::SYNC(uint32_t insn)
+{
+    this->fields32 = new Fields32StypeD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SYNC::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " %d", "" "SYNC",
+     ((Fields32Stype *)this->fields32)->getStype()));
+    return true;
+}
+
+SYSCALL::SYSCALL(uint32_t insn)
+{
+    this->fields32 = new Fields32CodeD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SYSCALL::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " %d", "" "SYSCALL",
+     ((Fields32Code *)this->fields32)->getCode()));
+    return true;
+}
+
+TEQ::TEQ(uint32_t insn)
+{
+    this->fields32 = new Fields32CodeRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool TEQ::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32CodeRsRt *)this->fields32)->getRs());
+    getAlias(alias2, ((Fields32CodeRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s", "" "TEQ",
+     alias1, alias2));
+    return true;
+}
+
+TEQI::TEQI(uint32_t insn)
+{
+    this->fields32 = new Fields32ImmRsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool TEQI::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    getAlias(alias1, ((Fields32ImmRs *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "TEQI",
+     alias1, ((Fields32ImmRs *)this->fields32)->getImm()));
+    return true;
+}
+
+TGE::TGE(uint32_t insn)
+{
+    this->fields32 = new Fields32CodeRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool TGE::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32CodeRsRt *)this->fields32)->getRs());
+    getAlias(alias2, ((Fields32CodeRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s", "" "TGE",
+     alias1, alias2));
+    return true;
+}
+
+TGEI::TGEI(uint32_t insn)
+{
+    this->fields32 = new Fields32ImmRsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool TGEI::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    getAlias(alias1, ((Fields32ImmRs *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "TGEI",
+     alias1, ((Fields32ImmRs *)this->fields32)->getImm()));
+    return true;
+}
+
+TGEIU::TGEIU(uint32_t insn)
+{
+    this->fields32 = new Fields32ImmRsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool TGEIU::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    getAlias(alias1, ((Fields32ImmRs *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "TGEIU",
+     alias1, ((Fields32ImmRs *)this->fields32)->getImm()));
+    return true;
+}
+
+TGEU::TGEU(uint32_t insn)
+{
+    this->fields32 = new Fields32CodeRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool TGEU::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32CodeRsRt *)this->fields32)->getRs());
+    getAlias(alias2, ((Fields32CodeRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s", "" "TGEU",
+     alias1, alias2));
+    return true;
+}
+
+TLT::TLT(uint32_t insn)
+{
+    this->fields32 = new Fields32CodeRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool TLT::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32CodeRsRt *)this->fields32)->getRs());
+    getAlias(alias2, ((Fields32CodeRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s", "" "TLT",
+     alias1, alias2));
+    return true;
+}
+
+TLTI::TLTI(uint32_t insn)
+{
+    this->fields32 = new Fields32ImmRsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool TLTI::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    getAlias(alias1, ((Fields32ImmRs *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "TLTI",
+     alias1, ((Fields32ImmRs *)this->fields32)->getImm()));
+    return true;
+}
+
+TLTIU::TLTIU(uint32_t insn)
+{
+    this->fields32 = new Fields32ImmRsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool TLTIU::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    getAlias(alias1, ((Fields32ImmRs *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "TLTIU",
+     alias1, ((Fields32ImmRs *)this->fields32)->getImm()));
+    return true;
+}
+
+TLTU::TLTU(uint32_t insn)
+{
+    this->fields32 = new Fields32CodeRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool TLTU::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32CodeRsRt *)this->fields32)->getRs());
+    getAlias(alias2, ((Fields32CodeRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s", "" "TLTU",
+     alias1, alias2));
+    return true;
+}
+
+TNE::TNE(uint32_t insn)
+{
+    this->fields32 = new Fields32CodeRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool TNE::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32CodeRsRt *)this->fields32)->getRs());
+    getAlias(alias2, ((Fields32CodeRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s", "" "TNE",
+     alias1, alias2));
+    return true;
+}
+
+TNEI::TNEI(uint32_t insn)
+{
+    this->fields32 = new Fields32ImmRsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool TNEI::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    getAlias(alias1, ((Fields32ImmRs *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "TNEI",
+     alias1, ((Fields32ImmRs *)this->fields32)->getImm()));
+    return true;
+}
+
+XOR::XOR(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool XOR::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "XOR",
+     alias1, alias2, alias3));
+    return true;
+}
+
+XORI::XORI(uint32_t insn)
+{
+    this->fields32 = new Fields32ImmRsRtD1();
+    this->fields32->decode_fields32(insn);
+}
+
+bool XORI::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    getAlias(alias1, ((Fields32ImmRsRt *)this->fields32)->getRt());
+    getAlias(alias2, ((Fields32ImmRsRt *)this->fields32)->getRs());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "XORI",
+     alias1, alias2, ((Fields32ImmRsRt *)this->fields32)->getImm()));
+    return true;
+}
+
+ABS_S::ABS_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool ABS_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "ABS_S",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+ABS_D::ABS_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool ABS_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "ABS_D",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+ADD_S::ADD_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool ADD_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "ADD_S",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+ADD_D::ADD_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool ADD_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "ADD_D",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+BC1F::BC1F(uint32_t insn)
+{
+    this->fields32 = new Fields32OffsetD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool BC1F::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " %d", "" "BC1F",
+     ((Fields32Offset *)this->fields32)->getOffset()));
+    return true;
+}
+
+BC1FL::BC1FL(uint32_t insn)
+{
+    this->fields32 = new Fields32OffsetD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool BC1FL::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " %d", "" "BC1FL",
+     ((Fields32Offset *)this->fields32)->getOffset()));
+    return true;
+}
+
+BC1T::BC1T(uint32_t insn)
+{
+    this->fields32 = new Fields32OffsetD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool BC1T::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " %d", "" "BC1T",
+     ((Fields32Offset *)this->fields32)->getOffset()));
+    return true;
+}
+
+BC1TL::BC1TL(uint32_t insn)
+{
+    this->fields32 = new Fields32OffsetD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool BC1TL::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " %d", "" "BC1TL",
+     ((Fields32Offset *)this->fields32)->getOffset()));
+    return true;
+}
+
+C_F_S::C_F_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_F_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_F_S",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+C_UN_S::C_UN_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_UN_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_UN_S",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+C_EQ_S::C_EQ_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_EQ_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_EQ_S",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+C_UEQ_S::C_UEQ_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_UEQ_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_UEQ_S",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+C_OLT_S::C_OLT_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_OLT_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_OLT_S",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+C_ULT_S::C_ULT_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_ULT_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_ULT_S",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+C_OLE_S::C_OLE_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_OLE_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_OLE_S",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+C_ULE_S::C_ULE_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_ULE_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_ULE_S",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+C_SF_S::C_SF_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_SF_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_SF_S",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+C_NGLE_S::C_NGLE_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_NGLE_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_NGLE_S",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+C_SEQ_S::C_SEQ_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_SEQ_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_SEQ_S",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+C_NGL_S::C_NGL_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_NGL_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_NGL_S",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+C_LT_S::C_LT_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_LT_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_LT_S",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+C_NGE_S::C_NGE_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_NGE_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_NGE_S",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+C_LE_S::C_LE_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_LE_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_LE_S",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+C_NGT_S::C_NGT_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_NGT_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_NGT_S",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+C_F_D::C_F_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_F_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_F_D",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+C_UN_D::C_UN_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_UN_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_UN_D",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+C_EQ_D::C_EQ_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_EQ_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_EQ_D",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+C_UEQ_D::C_UEQ_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_UEQ_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_UEQ_D",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+C_OLT_D::C_OLT_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_OLT_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_OLT_D",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+C_ULT_D::C_ULT_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_ULT_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_ULT_D",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+C_OLE_D::C_OLE_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_OLE_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_OLE_D",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+C_ULE_D::C_ULE_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_ULE_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_ULE_D",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+C_SF_D::C_SF_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_SF_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_SF_D",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+C_NGLE_D::C_NGLE_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_NGLE_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_NGLE_D",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+C_SEQ_D::C_SEQ_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_SEQ_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_SEQ_D",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+C_NGL_D::C_NGL_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_NGL_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_NGL_D",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+C_LT_D::C_LT_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_LT_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_LT_D",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+C_NGE_D::C_NGE_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_NGE_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_NGE_D",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+C_LE_D::C_LE_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_LE_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_LE_D",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+C_NGT_D::C_NGT_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool C_NGT_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "C_NGT_D",
+     ((Fields32FsFt *)this->fields32)->getFs(),
+     ((Fields32FsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+CEIL_L_S::CEIL_L_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool CEIL_L_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "CEIL_L_S",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+CEIL_L_D::CEIL_L_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool CEIL_L_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "CEIL_L_D",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+CEIL_W_S::CEIL_W_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool CEIL_W_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "CEIL_W_S",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+CEIL_W_D::CEIL_W_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool CEIL_W_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "CEIL_W_D",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+CFC1::CFC1(uint32_t insn)
+{
+    this->fields32 = new Fields32FsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool CFC1::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    getAlias(alias1, ((Fields32FsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, f%d", "" "CFC1",
+     alias1, ((Fields32FsRt *)this->fields32)->getFs()));
+    return true;
+}
+
+CTC1::CTC1(uint32_t insn)
+{
+    this->fields32 = new Fields32FsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool CTC1::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    getAlias(alias1, ((Fields32FsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, f%d", "" "CTC1",
+     alias1, ((Fields32FsRt *)this->fields32)->getFs()));
+    return true;
+}
+
+CVT_D_S::CVT_D_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool CVT_D_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "CVT_D_S",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+CVT_D_W::CVT_D_W(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool CVT_D_W::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "CVT_D_W",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+CVT_D_L::CVT_D_L(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool CVT_D_L::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "CVT_D_L",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+CVT_L_S::CVT_L_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool CVT_L_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "CVT_L_S",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+CVT_L_D::CVT_L_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool CVT_L_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "CVT_L_D",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+CVT_S_D::CVT_S_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool CVT_S_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "CVT_S_D",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+CVT_S_W::CVT_S_W(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool CVT_S_W::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "CVT_S_W",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+CVT_S_L::CVT_S_L(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool CVT_S_L::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "CVT_S_L",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+CVT_W_S::CVT_W_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool CVT_W_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "CVT_W_S",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+CVT_W_D::CVT_W_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool CVT_W_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "CVT_W_D",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+DIV_S::DIV_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DIV_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "DIV_S",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+DIV_D::DIV_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DIV_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "DIV_D",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+DMFC1::DMFC1(uint32_t insn)
+{
+    this->fields32 = new Fields32FsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DMFC1::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    getAlias(alias1, ((Fields32FsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, f%d", "" "DMFC1",
+     alias1, ((Fields32FsRt *)this->fields32)->getFs()));
+    return true;
+}
+
+DMTC1::DMTC1(uint32_t insn)
+{
+    this->fields32 = new Fields32FsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DMTC1::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    getAlias(alias1, ((Fields32FsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, f%d", "" "DMTC1",
+     alias1, ((Fields32FsRt *)this->fields32)->getFs()));
+    return true;
+}
+
+FLOOR_L_S::FLOOR_L_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool FLOOR_L_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "FLOOR_L_S",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+FLOOR_L_D::FLOOR_L_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool FLOOR_L_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "FLOOR_L_D",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+FLOOR_W_S::FLOOR_W_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool FLOOR_W_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "FLOOR_W_S",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+FLOOR_W_D::FLOOR_W_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool FLOOR_W_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "FLOOR_W_D",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+LDC1::LDC1(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseFtOffsetD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool LDC1::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, %d(r%d)", "" "LDC1",
+     ((Fields32BaseFtOffset *)this->fields32)->getFt(),
+     ((Fields32BaseFtOffset *)this->fields32)->getOffset(),
+     ((Fields32BaseFtOffset *)this->fields32)->getBase()));
+    return true;
+}
+
+LWC1::LWC1(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseFtOffsetD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool LWC1::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, %d(r%d)", "" "LWC1",
+     ((Fields32BaseFtOffset *)this->fields32)->getFt(),
+     ((Fields32BaseFtOffset *)this->fields32)->getOffset(),
+     ((Fields32BaseFtOffset *)this->fields32)->getBase()));
+    return true;
+}
+
+MFC1::MFC1(uint32_t insn)
+{
+    this->fields32 = new Fields32FsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool MFC1::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    getAlias(alias1, ((Fields32FsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, f%d", "" "MFC1",
+     alias1, ((Fields32FsRt *)this->fields32)->getFs()));
+    return true;
+}
+
+MOV_S::MOV_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool MOV_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "MOV_S",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+MOV_D::MOV_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool MOV_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "MOV_D",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+MTC1::MTC1(uint32_t insn)
+{
+    this->fields32 = new Fields32FsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool MTC1::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    getAlias(alias1, ((Fields32FsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, f%d", "" "MTC1",
+     alias1, ((Fields32FsRt *)this->fields32)->getFs()));
+    return true;
+}
+
+MUL_S::MUL_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool MUL_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "MUL_S",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+MUL_D::MUL_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool MUL_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "MUL_D",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+NEG_S::NEG_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool NEG_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "NEG_S",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+NEG_D::NEG_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool NEG_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "NEG_D",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+ROUND_L_S::ROUND_L_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool ROUND_L_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "ROUND_L_S",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+ROUND_L_D::ROUND_L_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool ROUND_L_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "ROUND_L_D",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+ROUND_W_S::ROUND_W_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool ROUND_W_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "ROUND_W_S",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+ROUND_W_D::ROUND_W_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool ROUND_W_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "ROUND_W_D",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+SDC1::SDC1(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseFtOffsetD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SDC1::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, %d(r%d)", "" "SDC1",
+     ((Fields32BaseFtOffset *)this->fields32)->getFt(),
+     ((Fields32BaseFtOffset *)this->fields32)->getOffset(),
+     ((Fields32BaseFtOffset *)this->fields32)->getBase()));
+    return true;
+}
+
+SQRT_S::SQRT_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SQRT_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "SQRT_S",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+SQRT_D::SQRT_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SQRT_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "SQRT_D",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+SUB_S::SUB_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SUB_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "SUB_S",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+SUB_D::SUB_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SUB_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "SUB_D",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+SWC1::SWC1(uint32_t insn)
+{
+    this->fields32 = new Fields32BaseFtOffsetD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SWC1::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, %d(r%d)", "" "SWC1",
+     ((Fields32BaseFtOffset *)this->fields32)->getFt(),
+     ((Fields32BaseFtOffset *)this->fields32)->getOffset(),
+     ((Fields32BaseFtOffset *)this->fields32)->getBase()));
+    return true;
+}
+
+TRUNC_L_S::TRUNC_L_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool TRUNC_L_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "TRUNC_L_S",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+TRUNC_L_D::TRUNC_L_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool TRUNC_L_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "TRUNC_L_D",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+TRUNC_W_S::TRUNC_W_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool TRUNC_W_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "TRUNC_W_S",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+TRUNC_W_D::TRUNC_W_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool TRUNC_W_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "TRUNC_W_D",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+MULT_G::MULT_G(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool MULT_G::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "MULT_G",
+     alias1, alias2, alias3));
+    return true;
+}
+
+MULTU_G::MULTU_G(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool MULTU_G::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "MULTU_G",
+     alias1, alias2, alias3));
+    return true;
+}
+
+DMULT_G::DMULT_G(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DMULT_G::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "DMULT_G",
+     alias1, alias2, alias3));
+    return true;
+}
+
+DMULTU_G::DMULTU_G(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DMULTU_G::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "DMULTU_G",
+     alias1, alias2, alias3));
+    return true;
+}
+
+DIV_G::DIV_G(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DIV_G::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "DIV_G",
+     alias1, alias2, alias3));
+    return true;
+}
+
+DIVU_G::DIVU_G(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DIVU_G::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "DIVU_G",
+     alias1, alias2, alias3));
+    return true;
+}
+
+DDIV_G::DDIV_G(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DDIV_G::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "DDIV_G",
+     alias1, alias2, alias3));
+    return true;
+}
+
+DDIVU_G::DDIVU_G(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DDIVU_G::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "DDIVU_G",
+     alias1, alias2, alias3));
+    return true;
+}
+
+MOD_G::MOD_G(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool MOD_G::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "MOD_G",
+     alias1, alias2, alias3));
+    return true;
+}
+
+MODU_G::MODU_G(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool MODU_G::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "MODU_G",
+     alias1, alias2, alias3));
+    return true;
+}
+
+DMOD_G::DMOD_G(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DMOD_G::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "DMOD_G",
+     alias1, alias2, alias3));
+    return true;
+}
+
+DMODU_G::DMODU_G(uint32_t insn)
+{
+    this->fields32 = new Fields32RdRsRtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DMODU_G::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
+    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
+    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
+    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
+    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "DMODU_G",
+     alias1, alias2, alias3));
+    return true;
+}
+
+MADD_S::MADD_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool MADD_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "MADD_S",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+MADD_D::MADD_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool MADD_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "MADD_D",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+MSUB_S::MSUB_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool MSUB_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "MSUB_S",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+MSUB_D::MSUB_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool MSUB_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "MSUB_D",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+NMADD_S::NMADD_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool NMADD_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "NMADD_S",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+NMADD_D::NMADD_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool NMADD_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "NMADD_D",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+NMSUB_S::NMSUB_S(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool NMSUB_S::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "NMSUB_S",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+NMSUB_D::NMSUB_D(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool NMSUB_D::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "NMSUB_D",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PACKSSHB::PACKSSHB(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PACKSSHB::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PACKSSHB",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PACKSSWH::PACKSSWH(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PACKSSWH::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PACKSSWH",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PACKUSHB::PACKUSHB(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PACKUSHB::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PACKUSHB",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PADDB::PADDB(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PADDB::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PADDB",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PADDH::PADDH(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PADDH::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PADDH",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PADDW::PADDW(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PADDW::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PADDW",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PADDD::PADDD(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PADDD::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PADDD",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PADDSB::PADDSB(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PADDSB::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PADDSB",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PADDSH::PADDSH(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PADDSH::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PADDSH",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PADDUSB::PADDUSB(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PADDUSB::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PADDUSB",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PADDUSH::PADDUSH(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PADDUSH::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PADDUSH",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PANDN::PANDN(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PANDN::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PANDN",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PAVGB::PAVGB(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PAVGB::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PAVGB",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PAVGH::PAVGH(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PAVGH::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PAVGH",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PCMPEQB::PCMPEQB(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PCMPEQB::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PCMPEQB",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PCMPEQH::PCMPEQH(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PCMPEQH::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PCMPEQH",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PCMPEQW::PCMPEQW(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PCMPEQW::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PCMPEQW",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PCMPGTB::PCMPGTB(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PCMPGTB::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PCMPGTB",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PCMPGTH::PCMPGTH(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PCMPGTH::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PCMPGTH",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PCMPGTW::PCMPGTW(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PCMPGTW::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PCMPGTW",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PEXTRH::PEXTRH(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PEXTRH::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PEXTRH",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PINSRH_0::PINSRH_0(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PINSRH_0::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PINSRH_0",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PINSRH_1::PINSRH_1(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PINSRH_1::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PINSRH_1",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PINSRH_2::PINSRH_2(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PINSRH_2::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PINSRH_2",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PINSRH_3::PINSRH_3(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PINSRH_3::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PINSRH_3",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PMADDHW::PMADDHW(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PMADDHW::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PMADDHW",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PMAXSH::PMAXSH(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PMAXSH::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PMAXSH",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PMAXUB::PMAXUB(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PMAXUB::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PMAXUB",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PMINSH::PMINSH(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PMINSH::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PMINSH",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PMINUB::PMINUB(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PMINUB::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PMINUB",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PMOVMSKB::PMOVMSKB(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PMOVMSKB::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "PMOVMSKB",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+PMULHUH::PMULHUH(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PMULHUH::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PMULHUH",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PMULHH::PMULHH(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PMULHH::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PMULHH",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PMULLH::PMULLH(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PMULLH::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PMULLH",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PMULUW::PMULUW(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PMULUW::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PMULUW",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PASUBUB::PASUBUB(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PASUBUB::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PASUBUB",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+BIADD::BIADD(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool BIADD::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d", "" "BIADD",
+     ((Fields32FdFs *)this->fields32)->getFd(),
+     ((Fields32FdFs *)this->fields32)->getFs()));
+    return true;
+}
+
+PSHUFH::PSHUFH(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PSHUFH::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PSHUFH",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PSLLH::PSLLH(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PSLLH::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PSLLH",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PSLLW::PSLLW(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PSLLW::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PSLLW",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PSRAH::PSRAH(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PSRAH::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PSRAH",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PSRAW::PSRAW(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PSRAW::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PSRAW",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PSRLH::PSRLH(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PSRLH::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PSRLH",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PSRLW::PSRLW(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PSRLW::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PSRLW",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PSUBB::PSUBB(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PSUBB::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PSUBB",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PSUBH::PSUBH(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PSUBH::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PSUBH",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PSUBW::PSUBW(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PSUBW::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PSUBW",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PSUBD::PSUBD(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PSUBD::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PSUBD",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PSUBSB::PSUBSB(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PSUBSB::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PSUBSB",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PSUBSH::PSUBSH(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PSUBSH::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PSUBSH",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PSUBUSB::PSUBUSB(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PSUBUSB::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PSUBUSB",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PSUBUSH::PSUBUSH(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PSUBUSH::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PSUBUSH",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PUNPCKHBH::PUNPCKHBH(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PUNPCKHBH::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PUNPCKHBH",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PUNPCKHHW::PUNPCKHHW(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PUNPCKHHW::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PUNPCKHHW",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PUNPCKHWD::PUNPCKHWD(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PUNPCKHWD::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PUNPCKHWD",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PUNPCKLBH::PUNPCKLBH(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PUNPCKLBH::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PUNPCKLBH",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PUNPCKLHW::PUNPCKLHW(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PUNPCKLHW::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PUNPCKLHW",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+PUNPCKLWD::PUNPCKLWD(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool PUNPCKLWD::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "PUNPCKLWD",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+ADD_CP2::ADD_CP2(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool ADD_CP2::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "ADD_CP2",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+ADDU_CP2::ADDU_CP2(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool ADDU_CP2::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "ADDU_CP2",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+DADD_CP2::DADD_CP2(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DADD_CP2::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "DADD_CP2",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+SUB_CP2::SUB_CP2(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SUB_CP2::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "SUB_CP2",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+SUBU_CP2::SUBU_CP2(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SUBU_CP2::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "SUBU_CP2",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+DSUB_CP2::DSUB_CP2(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DSUB_CP2::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "DSUB_CP2",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+OR_CP2::OR_CP2(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool OR_CP2::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "OR_CP2",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+SLI_CP2::SLI_CP2(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SLI_CP2::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "SLI_CP2",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+DSLL_CP2::DSLL_CP2(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DSLL_CP2::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "DSLL_CP2",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+XOR_CP2::XOR_CP2(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool XOR_CP2::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "XOR_CP2",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+NOR_CP2::NOR_CP2(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool NOR_CP2::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "NOR_CP2",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+AND_CP2::AND_CP2(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool AND_CP2::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "AND_CP2",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+SRL_CP2::SRL_CP2(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SRL_CP2::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "SRL_CP2",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+DSRL_CP2::DSRL_CP2(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DSRL_CP2::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "DSRL_CP2",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+SRA_CP2::SRA_CP2(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SRA_CP2::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "SRA_CP2",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+DSRA_CP2::DSRA_CP2(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool DSRA_CP2::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "DSRA_CP2",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+SEQU_CP2::SEQU_CP2(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SEQU_CP2::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "SEQU_CP2",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+SLTU_CP2::SLTU_CP2(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SLTU_CP2::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "SLTU_CP2",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+SLEU_CP2::SLEU_CP2(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SLEU_CP2::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "SLEU_CP2",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+SEQ_CP2::SEQ_CP2(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SEQ_CP2::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "SEQ_CP2",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+SLT_CP2::SLT_CP2(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SLT_CP2::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "SLT_CP2",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+SLE_CP2::SLE_CP2(uint32_t insn)
+{
+    this->fields32 = new Fields32FdFsFtD0();
+    this->fields32->decode_fields32(insn);
+}
+
+bool SLE_CP2::disas_output(disassemble_info *info)
+{
+    (info->fprintf_func(info->stream, "%-9s" " f%d, f%d, f%d", "" "SLE_CP2",
+     ((Fields32FdFsFt *)this->fields32)->getFd(),
+     ((Fields32FdFsFt *)this->fields32)->getFs(),
+     ((Fields32FdFsFt *)this->fields32)->getFt()));
+    return true;
+}
+
+int Decoder::decode32(disassemble_info *ctx, uint32_t insn)
+{
+    Instruction32 *instruction;
+    int ret = 0;
+
+    switch ((insn >> 26) & 0b111111) {
+    case 0b0:
+        /*                              000000__ ________ ________ ________ */
+        switch (insn & 0b111111) {
+        case 0b0:
+            /*                          000000__ ________ ________ __000000 */
+            if (((insn >> 21) & 0b11111) == 0b0) {
+                /*                      00000000 000_____ ________ __000000 */
+                instruction = new SLL(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b10:
+            /*                          000000__ ________ ________ __000010 */
+            if (((insn >> 21) & 0b11111) == 0b0) {
+                /*                      00000000 000_____ ________ __000010 */
+                instruction = new SRL(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b11:
+            /*                          000000__ ________ ________ __000011 */
+            if (((insn >> 21) & 0b11111) == 0b0) {
+                /*                      00000000 000_____ ________ __000011 */
+                instruction = new SRA(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b100:
+            /*                          000000__ ________ ________ __000100 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      000000__ ________ _____000 00000100 */
+                instruction = new SLLV(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b110:
+            /*                          000000__ ________ ________ __000110 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      000000__ ________ _____000 00000110 */
+                instruction = new SRLV(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b111:
+            /*                          000000__ ________ ________ __000111 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      000000__ ________ _____000 00000111 */
+                instruction = new SRAV(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b1000:
+            /*                          000000__ ________ ________ __001000 */
+            if (((insn >> 6) & 0b111111111111111) == 0b0) {
+                /*                      000000__ ___00000 00000000 00001000 */
+                instruction = new JR(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b1001:
+            /*                          000000__ ________ ________ __001001 */
+            if ((insn & 0b111110000011111000000) == 0b0) {
+                /*                      000000__ ___00000 _____000 00001001 */
+                instruction = new JALR(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b1100:
+            /*                          000000__ ________ ________ __001100 */
+            instruction = new SYSCALL(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b1101:
+            /*                          000000__ ________ ________ __001101 */
+            instruction = new BREAK(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b1111:
+            /*                          000000__ ________ ________ __001111 */
+            if (((insn >> 11) & 0b111111111111111) == 0b0) {
+                /*                      00000000 00000000 00000___ __001111 */
+                instruction = new SYNC(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b10000:
+            /*                          000000__ ________ ________ __010000 */
+            if ((insn & 0b11111111110000011111000000) == 0b0) {
+                /*                      00000000 00000000 _____000 00010000 */
+                instruction = new MFHI(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b10001:
+            /*                          000000__ ________ ________ __010001 */
+            if (((insn >> 6) & 0b111111111111111) == 0b0) {
+                /*                      000000__ ___00000 00000000 00010001 */
+                instruction = new MTHI(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b10010:
+            /*                          000000__ ________ ________ __010010 */
+            if ((insn & 0b11111111110000011111000000) == 0b0) {
+                /*                      00000000 00000000 _____000 00010010 */
+                instruction = new MFLO(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b10011:
+            /*                          000000__ ________ ________ __010011 */
+            if (((insn >> 6) & 0b111111111111111) == 0b0) {
+                /*                      000000__ ___00000 00000000 00010011 */
+                instruction = new MTLO(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b10100:
+            /*                          000000__ ________ ________ __010100 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      000000__ ________ _____000 00010100 */
+                instruction = new DSLLV(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b10110:
+            /*                          000000__ ________ ________ __010110 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      000000__ ________ _____000 00010110 */
+                instruction = new DSRLV(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b10111:
+            /*                          000000__ ________ ________ __010111 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      000000__ ________ _____000 00010111 */
+                instruction = new DSRAV(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b11000:
+            /*                          000000__ ________ ________ __011000 */
+            if (((insn >> 6) & 0b1111111111) == 0b0) {
+                /*                      000000__ ________ 00000000 00011000 */
+                instruction = new MULT(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b11001:
+            /*                          000000__ ________ ________ __011001 */
+            if (((insn >> 6) & 0b1111111111) == 0b0) {
+                /*                      000000__ ________ 00000000 00011001 */
+                instruction = new MULTU(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b11010:
+            /*                          000000__ ________ ________ __011010 */
+            if (((insn >> 6) & 0b1111111111) == 0b0) {
+                /*                      000000__ ________ 00000000 00011010 */
+                instruction = new DIV(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b11011:
+            /*                          000000__ ________ ________ __011011 */
+            if (((insn >> 6) & 0b1111111111) == 0b0) {
+                /*                      000000__ ________ 00000000 00011011 */
+                instruction = new DIVU(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b11100:
+            /*                          000000__ ________ ________ __011100 */
+            if (((insn >> 6) & 0b1111111111) == 0b0) {
+                /*                      000000__ ________ 00000000 00011100 */
+                instruction = new DMULT(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b11101:
+            /*                          000000__ ________ ________ __011101 */
+            if (((insn >> 6) & 0b1111111111) == 0b0) {
+                /*                      000000__ ________ 00000000 00011101 */
+                instruction = new DMULTU(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b11110:
+            /*                          000000__ ________ ________ __011110 */
+            if (((insn >> 6) & 0b1111111111) == 0b0) {
+                /*                      000000__ ________ 00000000 00011110 */
+                instruction = new DDIV(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b11111:
+            /*                          000000__ ________ ________ __011111 */
+            if (((insn >> 6) & 0b1111111111) == 0b0) {
+                /*                      000000__ ________ 00000000 00011111 */
+                instruction = new DDIVU(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b100000:
+            /*                          000000__ ________ ________ __100000 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      000000__ ________ _____000 00100000 */
+                instruction = new ADD(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b100001:
+            /*                          000000__ ________ ________ __100001 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      000000__ ________ _____000 00100001 */
+                instruction = new ADDU(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b100010:
+            /*                          000000__ ________ ________ __100010 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      000000__ ________ _____000 00100010 */
+                instruction = new SUB(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b100011:
+            /*                          000000__ ________ ________ __100011 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      000000__ ________ _____000 00100011 */
+                instruction = new SUBU(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b100100:
+            /*                          000000__ ________ ________ __100100 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      000000__ ________ _____000 00100100 */
+                instruction = new AND(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b100101:
+            /*                          000000__ ________ ________ __100101 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      000000__ ________ _____000 00100101 */
+                instruction = new OR(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b100110:
+            /*                          000000__ ________ ________ __100110 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      000000__ ________ _____000 00100110 */
+                instruction = new XOR(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b100111:
+            /*                          000000__ ________ ________ __100111 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      000000__ ________ _____000 00100111 */
+                instruction = new NOR(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b101010:
+            /*                          000000__ ________ ________ __101010 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      000000__ ________ _____000 00101010 */
+                instruction = new SLT(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b101011:
+            /*                          000000__ ________ ________ __101011 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      000000__ ________ _____000 00101011 */
+                instruction = new SLTU(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b101100:
+            /*                          000000__ ________ ________ __101100 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      000000__ ________ _____000 00101100 */
+                instruction = new DADD(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b101101:
+            /*                          000000__ ________ ________ __101101 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      000000__ ________ _____000 00101101 */
+                instruction = new DADDU(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b101110:
+            /*                          000000__ ________ ________ __101110 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      000000__ ________ _____000 00101110 */
+                instruction = new DSUB(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b101111:
+            /*                          000000__ ________ ________ __101111 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      000000__ ________ _____000 00101111 */
+                instruction = new DSUBU(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b110000:
+            /*                          000000__ ________ ________ __110000 */
+            instruction = new TGE(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b110001:
+            /*                          000000__ ________ ________ __110001 */
+            instruction = new TGEU(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b110010:
+            /*                          000000__ ________ ________ __110010 */
+            instruction = new TLT(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b110011:
+            /*                          000000__ ________ ________ __110011 */
+            instruction = new TLTU(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b110100:
+            /*                          000000__ ________ ________ __110100 */
+            instruction = new TEQ(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b110110:
+            /*                          000000__ ________ ________ __110110 */
+            instruction = new TNE(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b111000:
+            /*                          000000__ ________ ________ __111000 */
+            if (((insn >> 21) & 0b11111) == 0b0) {
+                /*                      00000000 000_____ ________ __111000 */
+                instruction = new DSLL(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b111010:
+            /*                          000000__ ________ ________ __111010 */
+            if (((insn >> 21) & 0b11111) == 0b0) {
+                /*                      00000000 000_____ ________ __111010 */
+                instruction = new DSRL(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b111011:
+            /*                          000000__ ________ ________ __111011 */
+            if (((insn >> 21) & 0b11111) == 0b0) {
+                /*                      00000000 000_____ ________ __111011 */
+                instruction = new DSRA(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b111100:
+            /*                          000000__ ________ ________ __111100 */
+            if (((insn >> 21) & 0b11111) == 0b0) {
+                /*                      00000000 000_____ ________ __111100 */
+                instruction = new DSLL32(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b111110:
+            /*                          000000__ ________ ________ __111110 */
+            if (((insn >> 21) & 0b11111) == 0b0) {
+                /*                      00000000 000_____ ________ __111110 */
+                instruction = new DSRL32(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b111111:
+            /*                          000000__ ________ ________ __111111 */
+            if (((insn >> 21) & 0b11111) == 0b0) {
+                /*                      00000000 000_____ ________ __111111 */
+                instruction = new DSRA32(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        }
+        break;
+    case 0b1:
+        /*                              000001__ ________ ________ ________ */
+        switch ((insn >> 16) & 0b11111) {
+        case 0b0:
+            /*                          000001__ ___00000 ________ ________ */
+            instruction = new BLTZ(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b1:
+            /*                          000001__ ___00001 ________ ________ */
+            instruction = new BGEZ(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b10:
+            /*                          000001__ ___00010 ________ ________ */
+            instruction = new BLTZL(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11:
+            /*                          000001__ ___00011 ________ ________ */
+            instruction = new BGEZL(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b1000:
+            /*                          000001__ ___01000 ________ ________ */
+            instruction = new TGEI(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b1001:
+            /*                          000001__ ___01001 ________ ________ */
+            instruction = new TGEIU(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b1010:
+            /*                          000001__ ___01010 ________ ________ */
+            instruction = new TLTI(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b1011:
+            /*                          000001__ ___01011 ________ ________ */
+            instruction = new TLTIU(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b1100:
+            /*                          000001__ ___01100 ________ ________ */
+            instruction = new TEQI(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b1110:
+            /*                          000001__ ___01110 ________ ________ */
+            instruction = new TNEI(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b10000:
+            /*                          000001__ ___10000 ________ ________ */
+            instruction = new BLTZAL(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b10001:
+            /*                          000001__ ___10001 ________ ________ */
+            instruction = new BGEZAL(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b10010:
+            /*                          000001__ ___10010 ________ ________ */
+            instruction = new BLTZALL(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b10011:
+            /*                          000001__ ___10011 ________ ________ */
+            instruction = new BGEZALL(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        }
+        break;
+    case 0b10:
+        /*                              000010__ ________ ________ ________ */
+        instruction = new J(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b11:
+        /*                              000011__ ________ ________ ________ */
+        instruction = new JAL(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b100:
+        /*                              000100__ ________ ________ ________ */
+        instruction = new BEQ(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b101:
+        /*                              000101__ ________ ________ ________ */
+        instruction = new BNE(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b110:
+        /*                              000110__ ________ ________ ________ */
+        if (((insn >> 16) & 0b11111) == 0b0) {
+            /*                          000110__ ___00000 ________ ________ */
+            instruction = new BLEZ(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+        }
+        break;
+    case 0b111:
+        /*                              000111__ ________ ________ ________ */
+        if (((insn >> 16) & 0b11111) == 0b0) {
+            /*                          000111__ ___00000 ________ ________ */
+            instruction = new BGTZ(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+        }
+        break;
+    case 0b1000:
+        /*                              001000__ ________ ________ ________ */
+        instruction = new ADDI(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b1001:
+        /*                              001001__ ________ ________ ________ */
+        instruction = new ADDIU(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b1010:
+        /*                              001010__ ________ ________ ________ */
+        instruction = new SLTI(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b1011:
+        /*                              001011__ ________ ________ ________ */
+        instruction = new SLTIU(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b1100:
+        /*                              001100__ ________ ________ ________ */
+        instruction = new ANDI(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b1101:
+        /*                              001101__ ________ ________ ________ */
+        instruction = new ORI(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b1110:
+        /*                              001110__ ________ ________ ________ */
+        instruction = new XORI(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b1111:
+        /*                              001111__ ________ ________ ________ */
+        if (((insn >> 21) & 0b11111) == 0b0) {
+            /*                          00111100 000_____ ________ ________ */
+            instruction = new LUI(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+        }
+        break;
+    case 0b10000:
+        /*                              010000__ ________ ________ ________ */
+        instruction = new COP0(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b10001:
+        /*                              010001__ ________ ________ ________ */
+        switch ((insn >> 21) & 0b11111) {
+        case 0b0:
+            /*                          01000100 000_____ ________ ________ */
+            if ((insn & 0b11111111111) == 0b0) {
+                /*                      01000100 000_____ _____000 00000000 */
+                instruction = new MFC1(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b1:
+            /*                          01000100 001_____ ________ ________ */
+            if ((insn & 0b11111111111) == 0b0) {
+                /*                      01000100 001_____ _____000 00000000 */
+                instruction = new DMFC1(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b10:
+            /*                          01000100 010_____ ________ ________ */
+            if ((insn & 0b11111111111) == 0b0) {
+                /*                      01000100 010_____ _____000 00000000 */
+                instruction = new CFC1(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b100:
+            /*                          01000100 100_____ ________ ________ */
+            if ((insn & 0b11111111111) == 0b0) {
+                /*                      01000100 100_____ _____000 00000000 */
+                instruction = new MTC1(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b101:
+            /*                          01000100 101_____ ________ ________ */
+            if ((insn & 0b11111111111) == 0b0) {
+                /*                      01000100 101_____ _____000 00000000 */
+                instruction = new DMTC1(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b110:
+            /*                          01000100 110_____ ________ ________ */
+            if ((insn & 0b11111111111) == 0b0) {
+                /*                      01000100 110_____ _____000 00000000 */
+                instruction = new CTC1(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b1000:
+            /*                          01000101 000_____ ________ ________ */
+            switch ((insn >> 16) & 0b11111) {
+            case 0b0:
+                /*                      01000101 00000000 ________ ________ */
+                instruction = new BC1F(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+                break;
+            case 0b1:
+                /*                      01000101 00000001 ________ ________ */
+                instruction = new BC1T(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+                break;
+            case 0b10:
+                /*                      01000101 00000010 ________ ________ */
+                instruction = new BC1FL(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+                break;
+            case 0b11:
+                /*                      01000101 00000011 ________ ________ */
+                instruction = new BC1TL(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+                break;
+            }
+            break;
+        case 0b10000:
+            /*                          01000110 000_____ ________ ________ */
+            switch (insn & 0b111111) {
+            case 0b0:
+                /*                      01000110 000_____ ________ __000000 */
+                instruction = new ADD_S(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+                break;
+            case 0b1:
+                /*                      01000110 000_____ ________ __000001 */
+                instruction = new SUB_S(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+                break;
+            case 0b10:
+                /*                      01000110 000_____ ________ __000010 */
+                instruction = new MUL_S(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+                break;
+            case 0b11:
+                /*                      01000110 000_____ ________ __000011 */
+                instruction = new DIV_S(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+                break;
+            case 0b100:
+                /*                      01000110 000_____ ________ __000100 */
+                if (((insn >> 16) & 0b11111) == 0b0) {
+                    /*                  01000110 00000000 ________ __000100 */
+                    instruction = new SQRT_S(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b101:
+                /*                      01000110 000_____ ________ __000101 */
+                if (((insn >> 16) & 0b11111) == 0b0) {
+                    /*                  01000110 00000000 ________ __000101 */
+                    instruction = new ABS_S(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b110:
+                /*                      01000110 000_____ ________ __000110 */
+                if (((insn >> 16) & 0b11111) == 0b0) {
+                    /*                  01000110 00000000 ________ __000110 */
+                    instruction = new MOV_S(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b111:
+                /*                      01000110 000_____ ________ __000111 */
+                if (((insn >> 16) & 0b11111) == 0b0) {
+                    /*                  01000110 00000000 ________ __000111 */
+                    instruction = new NEG_S(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b1000:
+                /*                      01000110 000_____ ________ __001000 */
+                if (((insn >> 16) & 0b11111) == 0b0) {
+                    /*                  01000110 00000000 ________ __001000 */
+                    instruction = new ROUND_L_S(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b1001:
+                /*                      01000110 000_____ ________ __001001 */
+                if (((insn >> 16) & 0b11111) == 0b0) {
+                    /*                  01000110 00000000 ________ __001001 */
+                    instruction = new TRUNC_L_S(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b1010:
+                /*                      01000110 000_____ ________ __001010 */
+                if (((insn >> 16) & 0b11111) == 0b0) {
+                    /*                  01000110 00000000 ________ __001010 */
+                    instruction = new CEIL_L_S(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b1011:
+                /*                      01000110 000_____ ________ __001011 */
+                if (((insn >> 16) & 0b11111) == 0b0) {
+                    /*                  01000110 00000000 ________ __001011 */
+                    instruction = new FLOOR_L_S(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b1100:
+                /*                      01000110 000_____ ________ __001100 */
+                if (((insn >> 16) & 0b11111) == 0b0) {
+                    /*                  01000110 00000000 ________ __001100 */
+                    instruction = new ROUND_W_S(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b1101:
+                /*                      01000110 000_____ ________ __001101 */
+                if (((insn >> 16) & 0b11111) == 0b0) {
+                    /*                  01000110 00000000 ________ __001101 */
+                    instruction = new TRUNC_W_S(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b1110:
+                /*                      01000110 000_____ ________ __001110 */
+                if (((insn >> 16) & 0b11111) == 0b0) {
+                    /*                  01000110 00000000 ________ __001110 */
+                    instruction = new CEIL_W_S(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b1111:
+                /*                      01000110 000_____ ________ __001111 */
+                if (((insn >> 16) & 0b11111) == 0b0) {
+                    /*                  01000110 00000000 ________ __001111 */
+                    instruction = new FLOOR_W_S(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b100001:
+                /*                      01000110 000_____ ________ __100001 */
+                if (((insn >> 16) & 0b11111) == 0b0) {
+                    /*                  01000110 00000000 ________ __100001 */
+                    instruction = new CVT_D_S(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b100100:
+                /*                      01000110 000_____ ________ __100100 */
+                if (((insn >> 16) & 0b11111) == 0b0) {
+                    /*                  01000110 00000000 ________ __100100 */
+                    instruction = new CVT_W_S(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b100101:
+                /*                      01000110 000_____ ________ __100101 */
+                if (((insn >> 16) & 0b11111) == 0b0) {
+                    /*                  01000110 00000000 ________ __100101 */
+                    instruction = new CVT_L_S(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b110000:
+                /*                      01000110 000_____ ________ __110000 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 000_____ _____000 00110000 */
+                    instruction = new C_F_S(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b110001:
+                /*                      01000110 000_____ ________ __110001 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 000_____ _____000 00110001 */
+                    instruction = new C_UN_S(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b110010:
+                /*                      01000110 000_____ ________ __110010 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 000_____ _____000 00110010 */
+                    instruction = new C_EQ_S(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b110011:
+                /*                      01000110 000_____ ________ __110011 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 000_____ _____000 00110011 */
+                    instruction = new C_UEQ_S(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b110100:
+                /*                      01000110 000_____ ________ __110100 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 000_____ _____000 00110100 */
+                    instruction = new C_OLT_S(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b110101:
+                /*                      01000110 000_____ ________ __110101 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 000_____ _____000 00110101 */
+                    instruction = new C_ULT_S(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b110110:
+                /*                      01000110 000_____ ________ __110110 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 000_____ _____000 00110110 */
+                    instruction = new C_OLE_S(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b110111:
+                /*                      01000110 000_____ ________ __110111 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 000_____ _____000 00110111 */
+                    instruction = new C_ULE_S(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b111000:
+                /*                      01000110 000_____ ________ __111000 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 000_____ _____000 00111000 */
+                    instruction = new C_SF_S(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b111001:
+                /*                      01000110 000_____ ________ __111001 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 000_____ _____000 00111001 */
+                    instruction = new C_NGLE_S(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b111010:
+                /*                      01000110 000_____ ________ __111010 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 000_____ _____000 00111010 */
+                    instruction = new C_SEQ_S(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b111011:
+                /*                      01000110 000_____ ________ __111011 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 000_____ _____000 00111011 */
+                    instruction = new C_NGL_S(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b111100:
+                /*                      01000110 000_____ ________ __111100 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 000_____ _____000 00111100 */
+                    instruction = new C_LT_S(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b111101:
+                /*                      01000110 000_____ ________ __111101 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 000_____ _____000 00111101 */
+                    instruction = new C_NGE_S(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b111110:
+                /*                      01000110 000_____ ________ __111110 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 000_____ _____000 00111110 */
+                    instruction = new C_LE_S(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b111111:
+                /*                      01000110 000_____ ________ __111111 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 000_____ _____000 00111111 */
+                    instruction = new C_NGT_S(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            }
+            break;
+        case 0b10001:
+            /*                          01000110 001_____ ________ ________ */
+            switch (insn & 0b111111) {
+            case 0b0:
+                /*                      01000110 001_____ ________ __000000 */
+                instruction = new ADD_D(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+                break;
+            case 0b1:
+                /*                      01000110 001_____ ________ __000001 */
+                instruction = new SUB_D(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+                break;
+            case 0b10:
+                /*                      01000110 001_____ ________ __000010 */
+                instruction = new MUL_D(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+                break;
+            case 0b11:
+                /*                      01000110 001_____ ________ __000011 */
+                instruction = new DIV_D(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+                break;
+            case 0b100:
+                /*                      01000110 001_____ ________ __000100 */
+                if (((insn >> 16) & 0b11111) == 0b0) {
+                    /*                  01000110 00100000 ________ __000100 */
+                    instruction = new SQRT_D(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b101:
+                /*                      01000110 001_____ ________ __000101 */
+                if (((insn >> 16) & 0b11111) == 0b0) {
+                    /*                  01000110 00100000 ________ __000101 */
+                    instruction = new ABS_D(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b110:
+                /*                      01000110 001_____ ________ __000110 */
+                if (((insn >> 16) & 0b11111) == 0b0) {
+                    /*                  01000110 00100000 ________ __000110 */
+                    instruction = new MOV_D(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b111:
+                /*                      01000110 001_____ ________ __000111 */
+                if (((insn >> 16) & 0b11111) == 0b0) {
+                    /*                  01000110 00100000 ________ __000111 */
+                    instruction = new NEG_D(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b1000:
+                /*                      01000110 001_____ ________ __001000 */
+                if (((insn >> 16) & 0b11111) == 0b0) {
+                    /*                  01000110 00100000 ________ __001000 */
+                    instruction = new ROUND_L_D(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b1001:
+                /*                      01000110 001_____ ________ __001001 */
+                if (((insn >> 16) & 0b11111) == 0b0) {
+                    /*                  01000110 00100000 ________ __001001 */
+                    instruction = new TRUNC_L_D(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b1010:
+                /*                      01000110 001_____ ________ __001010 */
+                if (((insn >> 16) & 0b11111) == 0b0) {
+                    /*                  01000110 00100000 ________ __001010 */
+                    instruction = new CEIL_L_D(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b1011:
+                /*                      01000110 001_____ ________ __001011 */
+                if (((insn >> 16) & 0b11111) == 0b0) {
+                    /*                  01000110 00100000 ________ __001011 */
+                    instruction = new FLOOR_L_D(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b1100:
+                /*                      01000110 001_____ ________ __001100 */
+                if (((insn >> 16) & 0b11111) == 0b0) {
+                    /*                  01000110 00100000 ________ __001100 */
+                    instruction = new ROUND_W_D(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b1101:
+                /*                      01000110 001_____ ________ __001101 */
+                if (((insn >> 16) & 0b11111) == 0b0) {
+                    /*                  01000110 00100000 ________ __001101 */
+                    instruction = new TRUNC_W_D(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b1110:
+                /*                      01000110 001_____ ________ __001110 */
+                if (((insn >> 16) & 0b11111) == 0b0) {
+                    /*                  01000110 00100000 ________ __001110 */
+                    instruction = new CEIL_W_D(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b1111:
+                /*                      01000110 001_____ ________ __001111 */
+                if (((insn >> 16) & 0b11111) == 0b0) {
+                    /*                  01000110 00100000 ________ __001111 */
+                    instruction = new FLOOR_W_D(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b100000:
+                /*                      01000110 001_____ ________ __100000 */
+                if (((insn >> 16) & 0b11111) == 0b0) {
+                    /*                  01000110 00100000 ________ __100000 */
+                    instruction = new CVT_S_D(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b100100:
+                /*                      01000110 001_____ ________ __100100 */
+                if (((insn >> 16) & 0b11111) == 0b0) {
+                    /*                  01000110 00100000 ________ __100100 */
+                    instruction = new CVT_W_D(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b100101:
+                /*                      01000110 001_____ ________ __100101 */
+                if (((insn >> 16) & 0b11111) == 0b0) {
+                    /*                  01000110 00100000 ________ __100101 */
+                    instruction = new CVT_L_D(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b110000:
+                /*                      01000110 001_____ ________ __110000 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 001_____ _____000 00110000 */
+                    instruction = new C_F_D(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b110001:
+                /*                      01000110 001_____ ________ __110001 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 001_____ _____000 00110001 */
+                    instruction = new C_UN_D(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b110010:
+                /*                      01000110 001_____ ________ __110010 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 001_____ _____000 00110010 */
+                    instruction = new C_EQ_D(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b110011:
+                /*                      01000110 001_____ ________ __110011 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 001_____ _____000 00110011 */
+                    instruction = new C_UEQ_D(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b110100:
+                /*                      01000110 001_____ ________ __110100 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 001_____ _____000 00110100 */
+                    instruction = new C_OLT_D(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b110101:
+                /*                      01000110 001_____ ________ __110101 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 001_____ _____000 00110101 */
+                    instruction = new C_ULT_D(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b110110:
+                /*                      01000110 001_____ ________ __110110 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 001_____ _____000 00110110 */
+                    instruction = new C_OLE_D(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b110111:
+                /*                      01000110 001_____ ________ __110111 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 001_____ _____000 00110111 */
+                    instruction = new C_ULE_D(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b111000:
+                /*                      01000110 001_____ ________ __111000 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 001_____ _____000 00111000 */
+                    instruction = new C_SF_D(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b111001:
+                /*                      01000110 001_____ ________ __111001 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 001_____ _____000 00111001 */
+                    instruction = new C_NGLE_D(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b111010:
+                /*                      01000110 001_____ ________ __111010 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 001_____ _____000 00111010 */
+                    instruction = new C_SEQ_D(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b111011:
+                /*                      01000110 001_____ ________ __111011 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 001_____ _____000 00111011 */
+                    instruction = new C_NGL_D(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b111100:
+                /*                      01000110 001_____ ________ __111100 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 001_____ _____000 00111100 */
+                    instruction = new C_LT_D(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b111101:
+                /*                      01000110 001_____ ________ __111101 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 001_____ _____000 00111101 */
+                    instruction = new C_NGE_D(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b111110:
+                /*                      01000110 001_____ ________ __111110 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 001_____ _____000 00111110 */
+                    instruction = new C_LE_D(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            case 0b111111:
+                /*                      01000110 001_____ ________ __111111 */
+                if (((insn >> 6) & 0b11111) == 0b0) {
+                    /*                  01000110 001_____ _____000 00111111 */
+                    instruction = new C_NGT_D(insn);
+                    if (instruction->disas_output(ctx)) {
+                        ret = 4;
+                    }
+                    delete instruction;
+                }
+                break;
+            }
+            break;
+        case 0b10100:
+            /*                          01000110 100_____ ________ ________ */
+            switch (insn & 0b111110000000000111111) {
+            case 0b100000:
+                /*                      01000110 10000000 ________ __100000 */
+                instruction = new CVT_S_W(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+                break;
+            case 0b100001:
+                /*                      01000110 10000000 ________ __100001 */
+                instruction = new CVT_D_W(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+                break;
+            }
+            break;
+        case 0b10101:
+            /*                          01000110 101_____ ________ ________ */
+            switch (insn & 0b111110000000000111111) {
+            case 0b100000:
+                /*                      01000110 10100000 ________ __100000 */
+                instruction = new CVT_S_L(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+                break;
+            case 0b100001:
+                /*                      01000110 10100000 ________ __100001 */
+                instruction = new CVT_D_L(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+                break;
+            }
+            break;
+        }
+        break;
+    case 0b10010:
+        /*                              010010__ ________ ________ ________ */
+        switch (insn & 0b11111000000000000000111111) {
+        case 0b11000000000000000000000000:
+            /*                          01001011 000_____ ________ __000000 */
+            instruction = new PADDSH(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11000000000000000000000001:
+            /*                          01001011 000_____ ________ __000001 */
+            instruction = new PSUBSH(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11000000000000000000000010:
+            /*                          01001011 000_____ ________ __000010 */
+            instruction = new PSHUFH(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11000000000000000000000011:
+            /*                          01001011 000_____ ________ __000011 */
+            instruction = new PUNPCKLHW(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11000000000000000000001000:
+            /*                          01001011 000_____ ________ __001000 */
+            instruction = new PAVGH(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11000000000000000000001001:
+            /*                          01001011 000_____ ________ __001001 */
+            instruction = new PCMPEQW(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11000000000000000000001010:
+            /*                          01001011 000_____ ________ __001010 */
+            instruction = new PSLLW(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11000000000000000000001011:
+            /*                          01001011 000_____ ________ __001011 */
+            instruction = new PSRLW(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11000000000000000000001100:
+            /*                          01001011 000_____ ________ __001100 */
+            instruction = new ADDU_CP2(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11000000000000000000001101:
+            /*                          01001011 000_____ ________ __001101 */
+            instruction = new SUBU_CP2(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11000000000000000000001110:
+            /*                          01001011 000_____ ________ __001110 */
+            instruction = new SLI_CP2(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11000000000000000000001111:
+            /*                          01001011 000_____ ________ __001111 */
+            instruction = new SRL_CP2(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11001000000000000000000000:
+            /*                          01001011 001_____ ________ __000000 */
+            instruction = new PADDUSH(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11001000000000000000000001:
+            /*                          01001011 001_____ ________ __000001 */
+            instruction = new PSUBUSH(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11001000000000000000000010:
+            /*                          01001011 001_____ ________ __000010 */
+            instruction = new PACKSSWH(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11001000000000000000000011:
+            /*                          01001011 001_____ ________ __000011 */
+            instruction = new PUNPCKHHW(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11001000000000000000001000:
+            /*                          01001011 001_____ ________ __001000 */
+            instruction = new PAVGB(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11001000000000000000001001:
+            /*                          01001011 001_____ ________ __001001 */
+            instruction = new PCMPGTW(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11001000000000000000001010:
+            /*                          01001011 001_____ ________ __001010 */
+            instruction = new PSLLH(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11001000000000000000001011:
+            /*                          01001011 001_____ ________ __001011 */
+            instruction = new PSRLH(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11001000000000000000001100:
+            /*                          01001011 001_____ ________ __001100 */
+            instruction = new OR_CP2(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11001000000000000000001101:
+            /*                          01001011 001_____ ________ __001101 */
+            instruction = new PASUBUB(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11001000000000000000001110:
+            /*                          01001011 001_____ ________ __001110 */
+            instruction = new DSLL_CP2(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11001000000000000000001111:
+            /*                          01001011 001_____ ________ __001111 */
+            instruction = new DSRL_CP2(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11010000000000000000000000:
+            /*                          01001011 010_____ ________ __000000 */
+            instruction = new PADDH(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11010000000000000000000001:
+            /*                          01001011 010_____ ________ __000001 */
+            instruction = new PSUBH(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11010000000000000000000010:
+            /*                          01001011 010_____ ________ __000010 */
+            instruction = new PACKSSHB(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11010000000000000000000011:
+            /*                          01001011 010_____ ________ __000011 */
+            instruction = new PUNPCKLBH(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11010000000000000000001000:
+            /*                          01001011 010_____ ________ __001000 */
+            instruction = new PMAXSH(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11010000000000000000001001:
+            /*                          01001011 010_____ ________ __001001 */
+            instruction = new PCMPEQH(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11010000000000000000001010:
+            /*                          01001011 010_____ ________ __001010 */
+            instruction = new PMULLH(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11010000000000000000001011:
+            /*                          01001011 010_____ ________ __001011 */
+            instruction = new PSRAW(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11010000000000000000001100:
+            /*                          01001011 010_____ ________ __001100 */
+            instruction = new ADD_CP2(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11010000000000000000001101:
+            /*                          01001011 010_____ ________ __001101 */
+            instruction = new SUB_CP2(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11010000000000000000001110:
+            /*                          01001011 010_____ ________ __001110 */
+            instruction = new PEXTRH(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11010000000000000000001111:
+            /*                          01001011 010_____ ________ __001111 */
+            instruction = new SRA_CP2(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11011000000000000000000000:
+            /*                          01001011 011_____ ________ __000000 */
+            instruction = new PADDW(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11011000000000000000000001:
+            /*                          01001011 011_____ ________ __000001 */
+            instruction = new PSUBW(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11011000000000000000000010:
+            /*                          01001011 011_____ ________ __000010 */
+            instruction = new PACKUSHB(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11011000000000000000000011:
+            /*                          01001011 011_____ ________ __000011 */
+            instruction = new PUNPCKHBH(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11011000000000000000001000:
+            /*                          01001011 011_____ ________ __001000 */
+            instruction = new PMINSH(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11011000000000000000001001:
+            /*                          01001011 011_____ ________ __001001 */
+            instruction = new PCMPGTH(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11011000000000000000001010:
+            /*                          01001011 011_____ ________ __001010 */
+            instruction = new PMULHH(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11011000000000000000001011:
+            /*                          01001011 011_____ ________ __001011 */
+            instruction = new PSRAH(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11011000000000000000001100:
+            /*                          01001011 011_____ ________ __001100 */
+            instruction = new DADD_CP2(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11011000000000000000001101:
+            /*                          01001011 011_____ ________ __001101 */
+            instruction = new DSUB_CP2(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11011000000000000000001110:
+            /*                          01001011 011_____ ________ __001110 */
+            instruction = new PMADDHW(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11011000000000000000001111:
+            /*                          01001011 011_____ ________ __001111 */
+            instruction = new DSRA_CP2(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11100000000000000000000000:
+            /*                          01001011 100_____ ________ __000000 */
+            instruction = new PADDSB(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11100000000000000000000001:
+            /*                          01001011 100_____ ________ __000001 */
+            instruction = new PSUBSB(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11100000000000000000000010:
+            /*                          01001011 100_____ ________ __000010 */
+            instruction = new XOR_CP2(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11100000000000000000000011:
+            /*                          01001011 100_____ ________ __000011 */
+            instruction = new PINSRH_0(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11100000000000000000001000:
+            /*                          01001011 100_____ ________ __001000 */
+            instruction = new PMAXUB(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11100000000000000000001001:
+            /*                          01001011 100_____ ________ __001001 */
+            instruction = new PCMPEQB(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11100000000000000000001010:
+            /*                          01001011 100_____ ________ __001010 */
+            instruction = new PMULUW(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11100000000000000000001011:
+            /*                          01001011 100_____ ________ __001011 */
+            instruction = new PUNPCKLWD(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11100000000000000000001100:
+            /*                          01001011 100_____ ________ __001100 */
+            instruction = new SEQU_CP2(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11100000000000000000001101:
+            /*                          01001011 100_____ ________ __001101 */
+            instruction = new SLTU_CP2(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11100000000000000000001110:
+            /*                          01001011 100_____ ________ __001110 */
+            instruction = new SLEU_CP2(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11100000000000000000001111:
+            /*                          01001011 100_____ ________ __001111 */
+            if (((insn >> 16) & 0b11111) == 0b0) {
+                /*                      01001011 10000000 ________ __001111 */
+                instruction = new BIADD(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b11101000000000000000000000:
+            /*                          01001011 101_____ ________ __000000 */
+            instruction = new PADDUSB(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11101000000000000000000001:
+            /*                          01001011 101_____ ________ __000001 */
+            instruction = new PSUBUSB(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11101000000000000000000010:
+            /*                          01001011 101_____ ________ __000010 */
+            instruction = new NOR_CP2(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11101000000000000000000011:
+            /*                          01001011 101_____ ________ __000011 */
+            instruction = new PINSRH_1(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11101000000000000000001000:
+            /*                          01001011 101_____ ________ __001000 */
+            instruction = new PMINUB(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11101000000000000000001001:
+            /*                          01001011 101_____ ________ __001001 */
+            instruction = new PCMPGTB(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11101000000000000000001010:
+            /*                          01001011 101_____ ________ __001010 */
+            instruction = new PMULHUH(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11101000000000000000001011:
+            /*                          01001011 101_____ ________ __001011 */
+            instruction = new PUNPCKHWD(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11101000000000000000001100:
+            /*                          01001011 101_____ ________ __001100 */
+            instruction = new SEQ_CP2(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11101000000000000000001101:
+            /*                          01001011 101_____ ________ __001101 */
+            instruction = new SLT_CP2(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11101000000000000000001110:
+            /*                          01001011 101_____ ________ __001110 */
+            instruction = new SLE_CP2(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11101000000000000000001111:
+            /*                          01001011 101_____ ________ __001111 */
+            if (((insn >> 16) & 0b11111) == 0b0) {
+                /*                      01001011 10100000 ________ __001111 */
+                instruction = new PMOVMSKB(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b11110000000000000000000000:
+            /*                          01001011 110_____ ________ __000000 */
+            instruction = new PADDB(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11110000000000000000000001:
+            /*                          01001011 110_____ ________ __000001 */
+            instruction = new PSUBB(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11110000000000000000000010:
+            /*                          01001011 110_____ ________ __000010 */
+            instruction = new AND_CP2(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11110000000000000000000011:
+            /*                          01001011 110_____ ________ __000011 */
+            instruction = new PINSRH_2(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11111000000000000000000000:
+            /*                          01001011 111_____ ________ __000000 */
+            instruction = new PADDD(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11111000000000000000000001:
+            /*                          01001011 111_____ ________ __000001 */
+            instruction = new PSUBD(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11111000000000000000000010:
+            /*                          01001011 111_____ ________ __000010 */
+            instruction = new PANDN(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        case 0b11111000000000000000000011:
+            /*                          01001011 111_____ ________ __000011 */
+            instruction = new PINSRH_3(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+            break;
+        }
+        break;
+    case 0b10011:
+        /*                              010011__ ________ ________ ________ */
+        instruction = new COP3(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b10100:
+        /*                              010100__ ________ ________ ________ */
+        instruction = new BEQL(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b10101:
+        /*                              010101__ ________ ________ ________ */
+        instruction = new BNEL(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b10110:
+        /*                              010110__ ________ ________ ________ */
+        if (((insn >> 16) & 0b11111) == 0b0) {
+            /*                          010110__ ___00000 ________ ________ */
+            instruction = new BLEZL(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+        }
+        break;
+    case 0b10111:
+        /*                              010111__ ________ ________ ________ */
+        if (((insn >> 16) & 0b11111) == 0b0) {
+            /*                          010111__ ___00000 ________ ________ */
+            instruction = new BGTZL(insn);
+            if (instruction->disas_output(ctx)) {
+                ret = 4;
+            }
+            delete instruction;
+        }
+        break;
+    case 0b11000:
+        /*                              011000__ ________ ________ ________ */
+        instruction = new DADDI(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b11001:
+        /*                              011001__ ________ ________ ________ */
+        instruction = new DADDIU(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b11010:
+        /*                              011010__ ________ ________ ________ */
+        instruction = new LDL(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b11011:
+        /*                              011011__ ________ ________ ________ */
+        instruction = new LDR(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b11100:
+        /*                              011100__ ________ ________ ________ */
+        switch (insn & 0b111111) {
+        case 0b10000:
+            /*                          011100__ ________ ________ __010000 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      011100__ ________ _____000 00010000 */
+                instruction = new MULT_G(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b10001:
+            /*                          011100__ ________ ________ __010001 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      011100__ ________ _____000 00010001 */
+                instruction = new DMULT_G(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b10010:
+            /*                          011100__ ________ ________ __010010 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      011100__ ________ _____000 00010010 */
+                instruction = new MULTU_G(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b10011:
+            /*                          011100__ ________ ________ __010011 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      011100__ ________ _____000 00010011 */
+                instruction = new DMULTU_G(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b10100:
+            /*                          011100__ ________ ________ __010100 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      011100__ ________ _____000 00010100 */
+                instruction = new DIV_G(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b10101:
+            /*                          011100__ ________ ________ __010101 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      011100__ ________ _____000 00010101 */
+                instruction = new DDIV_G(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b10110:
+            /*                          011100__ ________ ________ __010110 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      011100__ ________ _____000 00010110 */
+                instruction = new DIVU_G(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b10111:
+            /*                          011100__ ________ ________ __010111 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      011100__ ________ _____000 00010111 */
+                instruction = new DDIVU_G(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b11000:
+            /*                          011100__ ________ ________ __011000 */
+            switch ((insn >> 21) & 0b11111) {
+            case 0b10000:
+                /*                      01110010 000_____ ________ __011000 */
+                instruction = new MADD_S(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+                break;
+            case 0b10001:
+                /*                      01110010 001_____ ________ __011000 */
+                instruction = new MADD_D(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+                break;
+            }
+            break;
+        case 0b11001:
+            /*                          011100__ ________ ________ __011001 */
+            switch ((insn >> 21) & 0b11111) {
+            case 0b10000:
+                /*                      01110010 000_____ ________ __011001 */
+                instruction = new MSUB_S(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+                break;
+            case 0b10001:
+                /*                      01110010 001_____ ________ __011001 */
+                instruction = new MSUB_D(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+                break;
+            }
+            break;
+        case 0b11010:
+            /*                          011100__ ________ ________ __011010 */
+            switch ((insn >> 21) & 0b11111) {
+            case 0b10000:
+                /*                      01110010 000_____ ________ __011010 */
+                instruction = new NMADD_S(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+                break;
+            case 0b10001:
+                /*                      01110010 001_____ ________ __011010 */
+                instruction = new NMADD_D(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+                break;
+            }
+            break;
+        case 0b11011:
+            /*                          011100__ ________ ________ __011011 */
+            switch ((insn >> 21) & 0b11111) {
+            case 0b10000:
+                /*                      01110010 000_____ ________ __011011 */
+                instruction = new NMSUB_S(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+                break;
+            case 0b10001:
+                /*                      01110010 001_____ ________ __011011 */
+                instruction = new NMSUB_D(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+                break;
+            }
+            break;
+        case 0b11100:
+            /*                          011100__ ________ ________ __011100 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      011100__ ________ _____000 00011100 */
+                instruction = new MOD_G(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b11101:
+            /*                          011100__ ________ ________ __011101 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      011100__ ________ _____000 00011101 */
+                instruction = new DMOD_G(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b11110:
+            /*                          011100__ ________ ________ __011110 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      011100__ ________ _____000 00011110 */
+                instruction = new MODU_G(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        case 0b11111:
+            /*                          011100__ ________ ________ __011111 */
+            if (((insn >> 6) & 0b11111) == 0b0) {
+                /*                      011100__ ________ _____000 00011111 */
+                instruction = new DMODU_G(insn);
+                if (instruction->disas_output(ctx)) {
+                    ret = 4;
+                }
+                delete instruction;
+            }
+            break;
+        }
+        break;
+    case 0b100000:
+        /*                              100000__ ________ ________ ________ */
+        instruction = new LB(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b100001:
+        /*                              100001__ ________ ________ ________ */
+        instruction = new LH(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b100010:
+        /*                              100010__ ________ ________ ________ */
+        instruction = new LWL(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b100011:
+        /*                              100011__ ________ ________ ________ */
+        instruction = new LW(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b100100:
+        /*                              100100__ ________ ________ ________ */
+        instruction = new LBU(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b100101:
+        /*                              100101__ ________ ________ ________ */
+        instruction = new LHU(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b100110:
+        /*                              100110__ ________ ________ ________ */
+        instruction = new LWR(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b100111:
+        /*                              100111__ ________ ________ ________ */
+        instruction = new LWU(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b101000:
+        /*                              101000__ ________ ________ ________ */
+        instruction = new SB(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b101001:
+        /*                              101001__ ________ ________ ________ */
+        instruction = new SH(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b101010:
+        /*                              101010__ ________ ________ ________ */
+        instruction = new SWL(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b101011:
+        /*                              101011__ ________ ________ ________ */
+        instruction = new SW(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b101100:
+        /*                              101100__ ________ ________ ________ */
+        instruction = new SDL(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b101101:
+        /*                              101101__ ________ ________ ________ */
+        instruction = new SDR(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b101110:
+        /*                              101110__ ________ ________ ________ */
+        instruction = new SWR(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b110000:
+        /*                              110000__ ________ ________ ________ */
+        instruction = new LL(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b110001:
+        /*                              110001__ ________ ________ ________ */
+        instruction = new LWC1(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b110010:
+        /*                              110010__ ________ ________ ________ */
+        instruction = new LWC2(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b110011:
+        /*                              110011__ ________ ________ ________ */
+        instruction = new LWC3(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b110100:
+        /*                              110100__ ________ ________ ________ */
+        instruction = new LLD(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b110101:
+        /*                              110101__ ________ ________ ________ */
+        instruction = new LDC1(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b110110:
+        /*                              110110__ ________ ________ ________ */
+        instruction = new LDC2(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b110111:
+        /*                              110111__ ________ ________ ________ */
+        instruction = new LD(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b111000:
+        /*                              111000__ ________ ________ ________ */
+        instruction = new SC(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b111001:
+        /*                              111001__ ________ ________ ________ */
+        instruction = new SWC1(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b111010:
+        /*                              111010__ ________ ________ ________ */
+        instruction = new SWC2(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b111011:
+        /*                              111011__ ________ ________ ________ */
+        instruction = new SWC3(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b111100:
+        /*                              111100__ ________ ________ ________ */
+        instruction = new SCD(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b111101:
+        /*                              111101__ ________ ________ ________ */
+        instruction = new SDC1(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b111110:
+        /*                              111110__ ________ ________ ________ */
+        instruction = new SDC2(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    case 0b111111:
+        /*                              111111__ ________ ________ ________ */
+        instruction = new SD(insn);
+        if (instruction->disas_output(ctx)) {
+            ret = 4;
+        }
+        delete instruction;
+        break;
+    }
+    return ret;
+}
-- 
2.7.4



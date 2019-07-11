Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5518AC742A1
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:36:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1063821019
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKcStCqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1063821019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlhfv-0004jG-6c
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 18:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40496)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhdO-00029E-8z
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhdJ-00047W-G1
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:50 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:43986)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hlhdH-0003dL-5S
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:43 -0400
Received: by mail-yb1-xb44.google.com with SMTP id y123so154907yby.10
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 15:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=A4FHd59rNfl5q7bloEVrXFoTtS493diWH99nR7kuulA=;
 b=KKcStCqnsQoqAXaHh4zT1Saj8CVWM6Vz3IPcavf7wiUTgj1D34tFt2qfGRGVjA1ZN1
 Qh+039Pb1r+j+I+lpMaQDPUjs3kJ2n8bRKL5q0cUrZ8Md8yPmj6ppqkTvtTcGxpivfsd
 WcOmXFpeGaRdno0MWn6gnsSH3ITiPq9mVfdF66nHtF7d5skyy3a1YKLgQrkesOrliM/1
 k7QQRuw5ng0yjlI/MT/foIQAriSfQ1qwMzk2lxx4UUta0JSsSxTscB/gp9L27ntsq7Es
 AId6PbnSchkEzIc5rsqajPdNIkL4/7vJbhUksUptP/ztPduqPuheJpfv7gITGmH8HnjF
 COfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A4FHd59rNfl5q7bloEVrXFoTtS493diWH99nR7kuulA=;
 b=CF5nmyCH9OvA010LiRS49UmLONvvglV5RhK9XpiJdCsASyb1eK0ko5IztovTPAXsy/
 6Ko+1gqGBMwcUTAo53xc2LFeCIP8InLvJwj4eIkQjw2OvmWNgMs3cR2xrvFUoGybj0Ur
 A4sKPbFx9Agx6aULevEP6alZvO6KxbfM1mdrw4Y6CU/pVNNmMKIQEmGoWDJwjPW1utRr
 yUmQC7V6aeR0s3eH21L/HSnpxWQ3IPywnCg3XzrE0/YQHw8rr/Asl3EWYmtLyqWDI28Q
 ig19ZtRZzrWMgLDIakNfyGp8mVE8FR3zNS697lr6WMPXJIO/bgeTJNUxKVo2MgOaxGZf
 bwnA==
X-Gm-Message-State: APjAAAWQA4wADYCTFol2ouUIP6ZCRnHt8IRqEF52xgiLDckU4J4MWfHt
 kHFrSCyfsjx5UKLUYGbr4ZTgVAuW
X-Google-Smtp-Source: APXvYqxR34PdSM0N/WfiWY/kviPacEhomp/nWDyLAiVBIu0cGMrgNUKWYdb8P4PdOi9/TLvySxAsnA==
X-Received: by 2002:a25:1e88:: with SMTP id e130mr3909763ybe.88.1562884394792; 
 Thu, 11 Jul 2019 15:33:14 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id z191sm1676728ywa.31.2019.07.11.15.33.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 11 Jul 2019 15:33:14 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 18:32:45 -0400
Message-Id: <20190711223300.6061-4-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711223300.6061-1-jan.bobek@gmail.com>
References: <20190711223300.6061-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: [Qemu-devel] [RISU PATCH v3 03/18] risugen_x86_asm: add module
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The module risugen_x86_asm.pm exports named register constants and
asm_insn_* family of functions, which greatly simplify emission of x86
instructions.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risugen_x86_asm.pm | 918 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 918 insertions(+)
 create mode 100644 risugen_x86_asm.pm

diff --git a/risugen_x86_asm.pm b/risugen_x86_asm.pm
new file mode 100644
index 0000000..642f18b
--- /dev/null
+++ b/risugen_x86_asm.pm
@@ -0,0 +1,918 @@
+#!/usr/bin/perl -w
+###############################################################################
+# Copyright (c) 2019 Jan Bobek
+# All rights reserved. This program and the accompanying materials
+# are made available under the terms of the Eclipse Public License v1.0
+# which accompanies this distribution, and is available at
+# http://www.eclipse.org/legal/epl-v10.html
+#
+# Contributors:
+#     Jan Bobek - initial implementation
+###############################################################################
+
+# risugen_x86_asm -- risugen_x86's helper module for x86 assembly
+package risugen_x86_asm;
+
+use strict;
+use warnings;
+
+use risugen_common;
+
+our @ISA    = qw(Exporter);
+our @EXPORT = qw(
+    asm_insn asm_insn_ud1 asm_insn_xor asm_insn_sahf asm_insn_lea64
+    asm_insn_call asm_insn_jmp asm_insn_pop asm_insn_mov
+    asm_insn_mov64 asm_insn_movq asm_insn_add asm_insn_add64
+    asm_insn_and asm_insn_and64 asm_insn_neg asm_insn_neg64
+    asm_insn_xchg asm_insn_xchg64 asm_insn_movaps asm_insn_vmovaps
+    asm_insn_movdqu asm_insn_vmovdqu
+    REG_RAX REG_RCX REG_RDX REG_RBX REG_RSP REG_RBP REG_RSI REG_RDI
+    REG_R8 REG_R9 REG_R10 REG_R11 REG_R12 REG_R13 REG_R14 REG_R15
+    );
+
+use constant {
+    VEX_L_128 => 0,
+    VEX_L_256 => 1,
+
+    VEX_P_NONE   => 0b00,
+    VEX_P_DATA16 => 0b01,
+    VEX_P_REP    => 0b10,
+    VEX_P_REPNE  => 0b11,
+
+    VEX_M_0F   => 0b00001,
+    VEX_M_0F38 => 0b00010,
+    VEX_M_0F3A => 0b00011,
+
+    VEX_V_UNUSED => 0b1111,
+
+    REG_RAX => 0,
+    REG_RCX => 1,
+    REG_RDX => 2,
+    REG_RBX => 3,
+    REG_RSP => 4,
+    REG_RBP => 5,
+    REG_RSI => 6,
+    REG_RDI => 7,
+    REG_R8  => 8,
+    REG_R9  => 9,
+    REG_R10 => 10,
+    REG_R11 => 11,
+    REG_R12 => 12,
+    REG_R13 => 13,
+    REG_R14 => 14,
+    REG_R15 => 15,
+
+    MOD_INDIRECT        => 0b00,
+    MOD_INDIRECT_DISP8  => 0b01,
+    MOD_INDIRECT_DISP32 => 0b10,
+    MOD_DIRECT          => 0b11,
+};
+
+sub write_insn_repne(%)
+{
+    insnv(value => 0xF2, width => 8);
+}
+
+sub write_insn_rep(%)
+{
+    insnv(value => 0xF3, width => 8);
+}
+
+sub write_insn_data16(%)
+{
+    insnv(value => 0x66, width => 8);
+}
+
+sub write_insn_rex(%)
+{
+    my (%args) = @_;
+
+    my $rex = 0x40;
+    $rex |= (defined $args{w} && $args{w}) << 3;
+    $rex |= (defined $args{r} && $args{r}) << 2;
+    $rex |= (defined $args{x} && $args{x}) << 1;
+    $rex |= (defined $args{b} && $args{b}) << 0;
+    insnv(value => $rex, width => 8);
+}
+
+sub write_insn_vex(%)
+{
+    my (%args) = @_;
+
+    $args{r} = 1            unless defined $args{r};
+    $args{x} = 1            unless defined $args{x};
+    $args{b} = 1            unless defined $args{b};
+    $args{w} = 0            unless defined $args{w};
+    $args{m} = VEX_M_0F     unless defined $args{m};
+    $args{v} = VEX_V_UNUSED unless defined $args{v};
+    $args{p} = VEX_P_NONE   unless defined $args{p};
+
+    # The Intel manual implies that 2-byte VEX prefix is equivalent to
+    # VEX.X = 1, VEX.B = 1, VEX.W = 0 and VEX.M = VEX_M_0F.
+    if ($args{x} && $args{b} && !$args{w} && $args{m} == VEX_M_0F) {
+        # We can use the 2-byte VEX prefix
+        my $vex = 0xC5 << 8;
+        $vex |= ($args{r} & 0b1)    << 7;
+        $vex |= ($args{v} & 0b1111) << 3;
+        $vex |= ($args{l} & 0b1)    << 2;
+        $vex |= ($args{p} & 0b11)   << 0;
+        insnv(value => $vex, width => 16);
+    } else {
+        # We have to use the 3-byte VEX prefix
+        my $vex = 0xC4 << 16;
+        $vex |= ($args{r} & 0b1)     << 15;
+        $vex |= ($args{x} & 0b1)     << 14;
+        $vex |= ($args{b} & 0b1)     << 13;
+        $vex |= ($args{m} & 0b11111) << 8;
+        $vex |= ($args{w} & 0b1)     << 7;
+        $vex |= ($args{v} & 0b1111)  << 3;
+        $vex |= ($args{l} & 0b1)     << 2;
+        $vex |= ($args{p} & 0b11)    << 0;
+        insnv(value => $vex, width => 24);
+    }
+}
+
+sub write_insn_modrm(%)
+{
+    my (%args) = @_;
+
+    my $modrm = 0;
+    $modrm |= ($args{mod} & 0b11)  << 6;
+    $modrm |= ($args{reg} & 0b111) << 3;
+    $modrm |= ($args{rm}  & 0b111) << 0;
+    insnv(value => $modrm, width => 8);
+}
+
+sub write_insn_sib(%)
+{
+    my (%args) = @_;
+
+    my $sib = 0;
+    $sib |= ($args{ss}    & 0b11)  << 6;
+    $sib |= ($args{index} & 0b111) << 3;
+    $sib |= ($args{base}  & 0b111) << 0;
+    insnv(value => $sib, width => 8);
+}
+
+sub write_insn(%)
+{
+    my (%insn) = @_;
+
+    my @tokens;
+    push @tokens, "EVEX"   if defined $insn{evex};
+    push @tokens, "VEX"    if defined $insn{vex};
+    push @tokens, "REP"    if defined $insn{rep};
+    push @tokens, "REPNE"  if defined $insn{repne};
+    push @tokens, "DATA16" if defined $insn{data16};
+    push @tokens, "REX"    if defined $insn{rex};
+    push @tokens, "OP"     if defined $insn{opcode};
+    push @tokens, "MODRM"  if defined $insn{modrm};
+    push @tokens, "SIB"    if defined $insn{sib};
+    push @tokens, "DISP"   if defined $insn{disp};
+    push @tokens, "IMM"    if defined $insn{imm};
+    push @tokens, "END";
+
+    # (EVEX | VEX | ((REP | REPNE)? DATA16? REX?)) OP (MODRM SIB? DISP?)? IMM? END
+    my $token = shift @tokens;
+
+    if ($token eq "EVEX") {
+        $token = shift @tokens;
+        write_insn_evex(%{$insn{evex}});
+    } elsif ($token eq "VEX") {
+        $token = shift @tokens;
+        write_insn_vex(%{$insn{vex}});
+    } else {
+        if ($token eq "REP") {
+            $token = shift @tokens;
+            write_insn_rep(%{$insn{rep}});
+        } elsif ($token eq "REPNE") {
+            $token = shift @tokens;
+            write_insn_repne(%{$insn{repne}});
+        }
+        if ($token eq "DATA16") {
+            $token = shift @tokens;
+            write_insn_data16(%{$insn{data16}});
+        }
+        if ($token eq "REX") {
+            $token = shift @tokens;
+            write_insn_rex(%{$insn{rex}});
+        }
+    }
+
+    die "Unexpected instruction tokens where OP expected: $token @tokens\n"
+        unless $token eq "OP";
+
+    $token = shift @tokens;
+    insnv(%{$insn{opcode}});
+
+    if ($token eq "MODRM") {
+        $token = shift @tokens;
+        write_insn_modrm(%{$insn{modrm}});
+
+        if ($token eq "SIB") {
+            $token = shift @tokens;
+            write_insn_sib(%{$insn{sib}});
+        }
+        if ($token eq "DISP") {
+            $token = shift @tokens;
+            insnv(%{$insn{disp}}, bigendian => 0);
+        }
+    }
+    if ($token eq "IMM") {
+        $token = shift @tokens;
+        insnv(%{$insn{imm}}, bigendian => 0);
+    }
+
+    die "Unexpected junk tokens at the end of instruction: $token @tokens\n"
+        unless $token eq "END";
+}
+
+sub asm_insn_vex_rxb($)
+{
+    my ($insn) = @_;
+    my $have_rex = defined $insn->{rex};
+
+    my @tokens;
+    push @tokens, "VEX.R"  if defined $insn->{vex}{r};
+    push @tokens, "REX.R"  if $have_rex && defined $insn->{rex}{r};
+    push @tokens, "VEX.X"  if defined $insn->{vex}{x};
+    push @tokens, "REX.X"  if $have_rex && defined $insn->{rex}{x};
+    push @tokens, "VEX.B"  if defined $insn->{vex}{b};
+    push @tokens, "REX.B"  if $have_rex && defined $insn->{rex}{b};
+    push @tokens, "END";
+
+    # (VEX.R | REX.R)? (VEX.X | REX.X)? (VEX.B | REX.B)? END
+    my $token = shift @tokens;
+
+    if ($token eq "VEX.R") {
+        $token = shift @tokens;
+    } elsif ($token eq "REX.R") {
+        $token = shift @tokens;
+        $insn->{vex}{r} = !$insn->{rex}{r};
+        delete $insn->{rex}{r};
+    }
+    if ($token eq "VEX.X") {
+        $token = shift @tokens;
+    } elsif ($token eq "REX.X") {
+        $token = shift @tokens;
+        $insn->{vex}{x} = !$insn->{rex}{x};
+        delete $insn->{rex}{x};
+    }
+    if ($token eq "VEX.B") {
+        $token = shift @tokens;
+    } elsif ($token eq "REX.B") {
+        $token = shift @tokens;
+        $insn->{vex}{b} = !$insn->{rex}{b};
+        delete $insn->{rex}{b};
+    }
+
+    die "unexpected junk at the end of VEX.RXB tokens: $token @tokens\n"
+        unless $token eq "END";
+
+    if ($have_rex) {
+        die "REX not empty"
+            unless !%{$insn->{rex}};
+
+        delete $insn->{rex};
+    }
+}
+
+sub asm_insn_vex_p($)
+{
+    my ($insn) = @_;
+
+    my @tokens;
+    push @tokens, "VEX.P"  if defined $insn->{vex}{p};
+    push @tokens, "DATA16" if defined $insn->{data16};
+    push @tokens, "REP"    if defined $insn->{rep};
+    push @tokens, "REPNE"  if defined $insn->{repne};
+    push @tokens, "END";
+
+    # (VEX.P | DATA16 | REP | REPNE)? END
+    my $token = shift @tokens;
+
+    if ($token eq "VEX.P") {
+        $token = shift @tokens;
+        my $vex_p = $insn->{vex}{p};
+        delete $insn->{vex}{p};
+
+        $insn->{vex}{p} = VEX_P_DATA16 if $vex_p == 0x66;
+        $insn->{vex}{p} = VEX_P_REPNE  if $vex_p == 0xF2;
+        $insn->{vex}{p} = VEX_P_REP    if $vex_p == 0xF3;
+
+        die "invalid value of VEX.P=$vex_p\n"
+            unless defined $insn->{vex}{p};
+    } elsif ($token eq "DATA16") {
+        $token = shift @tokens;
+        $insn->{vex}{p} = VEX_P_DATA16;
+        delete $insn->{data16};
+    } elsif ($token eq "REP") {
+        $token = shift @tokens;
+        $insn->{vex}{p} = VEX_P_REP;
+        delete $insn->{rep};
+    } elsif ($token eq "REPNE") {
+        $token = shift @tokens;
+        $insn->{vex}{p} = VEX_P_REPNE;
+        delete $insn->{repne};
+    }
+
+    die "unexpected junk at the end of VEX.P tokens: $token @tokens\n"
+        unless $token eq "END";
+}
+
+sub asm_insn_vex_m($)
+{
+    my ($insn) = @_;
+    my $opcvalue = $insn->{opcode}{value};
+    my $opcwidth = $insn->{opcode}{width};
+
+    my @tokens;
+    push @tokens, "VEX.M" if defined $insn->{vex}{m};
+    push @tokens, "0F"    if $opcwidth >= 16 && (($opcvalue >> ($opcwidth -  8)) & 0xFF) == 0x0F;
+    push @tokens, "38"    if $opcwidth >= 24 && (($opcvalue >> ($opcwidth - 16)) & 0xFF) == 0x38;
+    push @tokens, "3A"    if $opcwidth >= 24 && (($opcvalue >> ($opcwidth - 16)) & 0xFF) == 0x3A;
+    push @tokens, "END";
+
+    # (VEX.M | 0F (38 | 3A)?) END
+    my $token = shift @tokens;
+
+    if ($token eq "VEX.M") {
+        $token = shift @tokens;
+        my $vex_m = $insn->{vex}{m};
+        delete $insn->{vex}{m};
+
+        $insn->{vex}{m} = VEX_M_0F   if $vex_m == 0x0F;
+        $insn->{vex}{m} = VEX_M_0F38 if $vex_m == 0x0F38;
+        $insn->{vex}{m} = VEX_M_0F3A if $vex_m == 0x0F3A;
+
+        die "invalid value of VEX.M=$vex_m\n"
+            unless defined $insn->{vex}{m};
+    } elsif ($token eq "0F") {
+        $token = shift @tokens;
+
+        if ($token eq "38" || $token eq "3A") {
+            $token = shift @tokens;
+
+            $insn->{vex}{m} = VEX_M_0F38 if $token eq "38";
+            $insn->{vex}{m} = VEX_M_0F3A if $token eq "3A";
+            $insn->{opcode}{value} &= (1 << ($opcwidth - 16)) - 1;
+            $insn->{opcode}{width} -= 16;
+        } else {
+            $insn->{vex}{m} = VEX_M_0F;
+            $insn->{opcode}{value} &= (1 << ($opcwidth - 8)) - 1;
+            $insn->{opcode}{width} -= 8;
+        }
+    } else {
+        die "unexpected vex token where VEX.M or 0F expected: $token @tokens\n";
+    }
+
+    die "unexpected junk at the end of VEX.M tokens: $token @tokens\n"
+        unless $token eq "END";
+}
+
+sub asm_insn_vex_l($)
+{
+    my ($insn) = @_;
+    my $vex_l = $insn->{vex}{l};
+    delete $insn->{vex}{l};
+
+    $insn->{vex}{l} = 0         if $vex_l == 0;
+    $insn->{vex}{l} = VEX_L_128 if $vex_l == 128;
+    $insn->{vex}{l} = VEX_L_256 if $vex_l == 256;
+
+    die "invalid value of VEX.L=$vex_l\n"
+        unless defined $insn->{vex}{l};
+}
+
+sub asm_insn_vex_v($)
+{
+    my ($insn) = @_;
+
+    $insn->{vex}{v} ^= 0b1111 if defined $insn->{vex}{v};
+}
+
+sub asm_insn_vex($)
+{
+    my ($insn) = @_;
+
+    asm_insn_vex_rxb($insn);
+    asm_insn_vex_p($insn);
+    asm_insn_vex_m($insn);
+    asm_insn_vex_l($insn);
+    asm_insn_vex_v($insn);
+}
+
+sub asm_insn_modrm_rex($)
+{
+    my ($insn) = @_;
+
+    asm_insn_val($insn->{modrm}, 'disp');
+
+    my @tokens;
+    push @tokens, "REG"    if defined $insn->{modrm}{reg};
+    push @tokens, "REG2"   if defined $insn->{modrm}{reg2};
+    push @tokens, "BASE"   if defined $insn->{modrm}{base};
+    push @tokens, "DISP"   if defined $insn->{modrm}{disp};
+    push @tokens, "INDEX"  if defined $insn->{modrm}{index};
+    push @tokens, "VINDEX" if defined $insn->{modrm}{vindex};
+    push @tokens, "END";
+
+    # REG (REG2 | (BASE DISP? | DISP) (INDEX | VINDEX)?) END
+    my $token = shift @tokens;
+
+    die "unexpected modrm tokens where REG expected: $token @tokens\n"
+        unless $token eq "REG";
+
+    $token = shift @tokens;
+    my $reg = $insn->{modrm}{reg};
+
+    $insn->{rex}{r}     = 1 if $reg & 0b1000;
+    $insn->{modrm}{reg} = $reg & 0b111;
+
+    if ($token eq "REG2") {
+        $token = shift @tokens;
+        my $reg2 = $insn->{modrm}{reg2};
+        delete $insn->{modrm}{reg2};
+
+        $insn->{rex}{b}     = 1 if $reg2 & 0b1000;
+        $insn->{modrm}{mod} = MOD_DIRECT;
+        $insn->{modrm}{rm}  = $reg2 & 0b111;
+    } else {
+        if ($token eq "BASE") {
+            $token = shift @tokens;
+            my $base = $insn->{modrm}{base};
+            delete $insn->{modrm}{base};
+
+            $insn->{rex}{b}    = 1 if $base & 0b1000;
+            $insn->{modrm}{rm} = $base & 0b111;
+
+            if ($token eq "DISP") {
+                $token = shift @tokens;
+                my $disp = $insn->{modrm}{disp};
+                delete $insn->{modrm}{disp};
+
+                die "displacement too large: $disp->{width}\n"
+                    unless $disp->{width} <= 32;
+
+                if ($disp->{width} <= 8) {
+                    $insn->{modrm}{mod}  = MOD_INDIRECT_DISP8;
+                    $insn->{disp}{width} = 8;
+                } else {
+                    $insn->{modrm}{mod}  = MOD_INDIRECT_DISP32;
+                    $insn->{disp}{width} = 32;
+                }
+
+                $insn->{disp}{value} = $disp->{value};
+            } elsif (($base & 0b111) == REG_RBP) {
+                # Must use explicit displacement for RBP/R13-based
+                # addressing
+                $insn->{modrm}{mod}  = MOD_INDIRECT_DISP8;
+                $insn->{disp}{value} = 0;
+                $insn->{disp}{width} = 8;
+            } else {
+                $insn->{modrm}{mod} = MOD_INDIRECT;
+            }
+        } elsif ($token eq "DISP") {
+            $token = shift @tokens;
+            my $disp = $insn->{modrm}{disp};
+            delete $insn->{modrm}{disp};
+
+            die "displacement too large: $disp->{width}\n"
+                unless $disp->{width} <= 32;
+
+            # Displacement only
+            $insn->{modrm}{mod}  = MOD_INDIRECT;
+            $insn->{modrm}{rm}   = REG_RBP;
+            $insn->{disp}{value} = $disp->{value};
+            $insn->{disp}{width} = 32;
+        } else {
+            die "DISP or BASE expected: $token @tokens\n";
+        }
+
+        if ($token eq "INDEX" || $token eq "VINDEX") {
+            $insn->{modrm}{ss} = 0 unless defined $insn->{modrm}{ss};
+
+            my $index;
+            if ($token eq "VINDEX") {
+                $index = $insn->{modrm}{vindex};
+                delete $insn->{modrm}{vindex};
+            } else {
+                $index = $insn->{modrm}{index};
+                delete $insn->{modrm}{index};
+
+                # RSP cannot be encoded as index register.
+                die "cannot encode RSP as index register\n"
+                    if $index == REG_RSP;
+            }
+
+            $token = shift @tokens;
+            my $ss = $insn->{modrm}{ss};
+            delete $insn->{modrm}{ss};
+
+            $insn->{rex}{x}     = 1 if $index & 0b1000;
+            $insn->{sib}{ss}    = $ss;
+            $insn->{sib}{index} = $index & 0b111;
+            $insn->{sib}{base}  = $insn->{modrm}{rm};
+            $insn->{modrm}{rm}  = REG_RSP; # SIB
+        } elsif ($insn->{modrm}{rm} == REG_RSP) {
+            # Must use SIB for RSP/R12-based adressing
+            $insn->{sib}{ss}    = 0;
+            $insn->{sib}{index} = REG_RSP; # No index
+            $insn->{sib}{base}  = REG_RSP;
+        }
+    }
+
+    die "unexpected junk at the end of modrm tokens: $token @tokens\n"
+        unless $token eq "END";
+}
+
+sub asm_insn_val($$)
+{
+    my ($insn, $k) = @_;
+
+    my @tokens;
+    push @tokens, "K"   if defined $insn->{$k};
+    push @tokens, "K8"  if defined $insn->{$k . "8"};
+    push @tokens, "K16" if defined $insn->{$k . "16"};
+    push @tokens, "K32" if defined $insn->{$k . "32"};
+    push @tokens, "K64" if defined $insn->{$k . "64"};
+    push @tokens, "END";
+
+    # (K | K8 | K16 | K32 | K64)? END
+    my $token = shift @tokens;
+
+    if ($token eq "K") {
+        $token = shift @tokens;
+    } elsif ($token eq "K8") {
+        $token = shift @tokens;
+        my $value = $insn->{$k . "8"};
+        delete $insn->{$k . "8"};
+
+        $insn->{$k}{value} = $value;
+        $insn->{$k}{width} = 8;
+    } elsif ($token eq "K16") {
+        $token = shift @tokens;
+        my $value = $insn->{$k . "16"};
+        delete $insn->{$k . "16"};
+
+        $insn->{$k}{value} = $value;
+        $insn->{$k}{width} = 16;
+    } elsif ($token eq "K32") {
+        $token = shift @tokens;
+        my $value = $insn->{$k . "32"};
+        delete $insn->{$k . "32"};
+
+        $insn->{$k}{value} = $value;
+        $insn->{$k}{width} = 32;
+    } elsif ($token eq "K64") {
+        $token = shift @tokens;
+        my $value = $insn->{$k . "64"};
+        delete $insn->{$k . "64"};
+
+        $insn->{$k}{value} = $value;
+        $insn->{$k}{width} = 64;
+    }
+
+    die "unexpected junk at the end of value tokens: $token @tokens\n"
+        unless $token eq "END";
+}
+
+sub asm_insn(%)
+{
+    my (%insn) = @_;
+
+    asm_insn_val(\%insn, 'opcode');
+    asm_insn_val(\%insn, 'imm');
+    asm_insn_modrm_rex(\%insn) if defined $insn{modrm};
+    asm_insn_vex(\%insn)       if defined $insn{vex};
+    write_insn(%insn);
+}
+
+sub asm_insn_ud1(%)
+{
+    my (%modrm) = @_;
+    asm_insn(opcode16 => 0x0FB9, modrm => \%modrm);
+}
+
+sub asm_insn_xor(%)
+{
+    my (%modrm) = @_;
+
+    my %insn       = ();
+    $insn{opcode8} = 0x33;
+    $insn{modrm}   = \%modrm;
+    asm_insn(%insn);
+}
+
+sub asm_insn_sahf()
+{
+    my %insn       = ();
+    $insn{opcode8} = 0x9E;
+    asm_insn(%insn);
+}
+
+sub asm_insn_lea64(%)
+{
+    my (%modrm) = @_;
+
+    my %insn       = ();
+    $insn{rex}{w}  = 1;
+    $insn{opcode8} = 0x8D;
+    $insn{modrm}   = \%modrm;
+    asm_insn(%insn);
+}
+
+sub asm_insn_call(%)
+{
+    my (%insn) = @_;
+    asm_insn_val(\%insn, 'imm');
+
+    die "imm too large: $insn{imm}{width}"
+        unless $insn{imm}{width} <= 32;
+
+    $insn{opcode8}    = 0xE8;
+    $insn{imm}{width} = 32;
+    asm_insn(%insn);
+}
+
+sub asm_insn_jmp(%)
+{
+    my (%insn) = @_;
+    asm_insn_val(\%insn, 'imm');
+
+    die "imm too large: $insn{imm}{width}"
+        unless $insn{imm}{width} <= 32;
+
+    $insn{opcode8}    = 0xE9;
+    $insn{imm}{width} = 32;
+    asm_insn(%insn);
+}
+
+sub asm_insn_pop(%)
+{
+    my (%args) = @_;
+
+    my %insn       = ();
+    $insn{rex}{b}  = 1 if $args{reg} & 0b1000;
+    $insn{opcode8} = 0x58 | ($args{reg} & 0b111);
+    asm_insn(%insn);
+}
+
+sub asm_insn_mov_(%)
+{
+    my (%args) = @_;
+    my $is_wide64 = $args{w}; delete $args{w};
+    asm_insn_val(\%args, 'imm');
+
+    if (!defined $args{imm}) {
+        # Regular MOV reg, r/m. The W flag differentiates between
+        # 32-bit and 64-bit registers.
+        my %insn       = ();
+        $insn{rex}{w}  = 1 if $is_wide64;
+        $insn{opcode8} = 0x8B;
+        $insn{modrm}   = \%args;
+        asm_insn(%insn);
+    } elsif ($is_wide64
+             && $args{imm}{width} <= 32
+             && $args{imm}{value} < 0) {
+        # Move signed immediate to 64-bit register. This is the right
+        # time to use sign-extending move to save space; no point in
+        # using this opcode for 32-bit registers or for non-negative
+        # values, since both of these cases are better handled by
+        # 0xB8, which is shorter.
+        $args{imm}{width} = 32;
+
+        my %insn           = ();
+        $insn{rex}{w}      = 1;
+        $insn{opcode8}     = 0xC7;
+        $insn{modrm}{reg}  = 0;
+        $insn{modrm}{reg2} = $args{reg};
+        $insn{imm}         = $args{imm};
+        asm_insn(%insn);
+    } elsif ($args{imm}{width} <= (!$is_wide64 ? 32 : 64)) {
+        # Move immediate to 32/64-bit register. Note that this opcode
+        # is zero-extending, since the upper part of the destination
+        # register is automatically zeroed when moving a 32-bit
+        # immediate on x86_64.
+        $args{imm}{width} = ($args{imm}{width} <= 32 ? 32 : 64);
+
+        my %insn       = ();
+        $insn{rex}{w}  = 1 if $args{imm}{width} > 32;
+        $insn{rex}{b}  = 1 if $args{reg} & 0b1000;
+        $insn{opcode8} = 0xB8 | ($args{reg} & 0b111);
+        $insn{imm}     = $args{imm};
+        asm_insn(%insn);
+    } else {
+        die "imm too large: $args{imm}{width}";
+    }
+}
+
+sub asm_insn_mov(%)
+{
+    my (%args) = @_;
+    asm_insn_mov_(%args, w => 0);
+}
+
+sub asm_insn_mov64(%)
+{
+    my (%args) = @_;
+    asm_insn_mov_(%args, w => 1);
+}
+
+# Currently only the MOVQ mm, mm/m64 form is supported (and assumed).
+sub asm_insn_movq(%)
+{
+    my (%modrm) = @_;
+
+    my %insn        = ();
+    $insn{opcode16} = 0x0F6F;
+    $insn{modrm}    = \%modrm;
+    asm_insn(%insn);
+}
+
+sub asm_insn_add_(%)
+{
+    my (%args) = @_;
+    my $is_wide64 = $args{w}; delete $args{w};
+    asm_insn_val(\%args, 'imm');
+
+    if (!defined $args{imm}) {
+        # Regular ADD r/m, reg. The W flag differentiates between
+        # 32-bit and 64-bit registers.
+        my %insn       = ();
+        $insn{rex}{w}  = 1 if $is_wide64;
+        $insn{opcode8} = 0x01;
+        $insn{modrm}   = \%args;
+        asm_insn(%insn);
+    } elsif ($args{imm}{width} <= 8) {
+        # ADD r/m, imm8 with sign-extension.
+        my %insn          = ();
+        $insn{rex}{w}     = 1 if $is_wide64;
+        $insn{opcode8}    = 0x83;
+        $insn{modrm}      = \%args;
+        $insn{modrm}{reg} = 0;
+        $insn{imm}        = $args{imm}; delete $args{imm};
+        $insn{imm}{width} = 8;
+        asm_insn(%insn);
+    } else {
+        die "imm too large: $args{imm}{width}\n";
+    }
+}
+
+sub asm_insn_add(%)
+{
+    my (%args) = @_;
+    asm_insn_add_(%args, w => 0);
+}
+
+sub asm_insn_add64(%)
+{
+    my (%args) = @_;
+    asm_insn_add_(%args, w => 1);
+}
+
+sub asm_insn_and_(%)
+{
+    my (%args) = @_;
+    my $is_wide64 = $args{w}; delete $args{w};
+    asm_insn_val(\%args, 'imm');
+
+    if (!defined $args{imm}) {
+        # Regular AND r/m, reg. The W flag differentiates between
+        # 32-bit and 64-bit registers.
+        my %insn       = ();
+        $insn{rex}{w}  = 1 if $is_wide64;
+        $insn{opcode8} = 0x21;
+        $insn{modrm}   = \%args;
+        asm_insn(%insn);
+    } elsif ($args{imm}{width} <= 8) {
+        # AND r/m, imm8 with sign-extension.
+        my %insn          = ();
+        $insn{rex}{w}     = 1 if $is_wide64;
+        $insn{opcode8}    = 0x83;
+        $insn{modrm}      = \%args;
+        $insn{modrm}{reg} = 4;
+        $insn{imm}        = $args{imm}; delete $args{imm};
+        $insn{imm}{width} = 8;
+        asm_insn(%insn);
+    } else {
+        die "imm too large: $args{imm}{width}\n";
+    }
+}
+
+sub asm_insn_and(%)
+{
+    my (%args) = @_;
+    asm_insn_and_(%args, w => 0);
+}
+
+sub asm_insn_and64(%)
+{
+    my (%args) = @_;
+    asm_insn_and_(%args, w => 1);
+}
+
+sub asm_insn_neg_(%)
+{
+    my (%args) = @_;
+
+    my %insn          = ();
+    $insn{rex}{w}     = 1 if $args{w}; delete $args{w};
+    $insn{opcode8}    = 0xF7;
+    $insn{modrm}      = \%args;
+    $insn{modrm}{reg} = 3;
+    asm_insn(%insn);
+}
+
+sub asm_insn_neg(%)
+{
+    my (%modrm) = @_;
+    asm_insn_neg_(%modrm, w => 0);
+}
+
+sub asm_insn_neg64(%)
+{
+    my (%modrm) = @_;
+    asm_insn_neg_(%modrm, w => 1);
+}
+
+sub asm_insn_xchg_(%)
+{
+    my (%args) = @_;
+
+    if (defined $args{reg2} &&
+        ($args{reg} == REG_RAX || $args{reg2} == REG_RAX)) {
+        # We can use the short form, yay!
+        my $reg = ($args{reg} == REG_RAX ? $args{reg2} : $args{reg});
+
+        my %insn       = ();
+        $insn{rex}{w}  = 1 if $args{w}; delete $args{w};
+        $insn{rex}{b}  = 1 if $reg & 0b1000;
+        $insn{opcode8} = 0x90 | ($reg & 0b111);
+        asm_insn(%insn);
+    } else {
+        my %insn       = ();
+        $insn{rex}{w}  = 1 if $args{w}; delete $args{w};
+        $insn{opcode8} = 0x87;
+        $insn{modrm}   = \%args;
+        asm_insn(%insn);
+    }
+}
+
+sub asm_insn_xchg(%)
+{
+    my (%modrm) = @_;
+    asm_insn_xchg_(%modrm, w => 0);
+}
+
+sub asm_insn_xchg64(%)
+{
+    my (%modrm) = @_;
+    asm_insn_xchg_(%modrm, w => 1);
+}
+
+sub asm_insn_movaps(%)
+{
+    my (%modrm) = @_;
+
+    my %insn        = ();
+    $insn{opcode16} = 0x0F28;
+    $insn{modrm}    = \%modrm;
+    asm_insn(%insn);
+}
+
+sub asm_insn_vmovaps(%)
+{
+    my (%args) = @_;
+
+    my %insn       = ();
+    $insn{vex}{l}  = $args{l}; delete $args{l};
+    $insn{vex}{m}  = 0x0F;
+    $insn{opcode8} = 0x28;
+    $insn{modrm}   = \%args;
+    asm_insn(%insn);
+}
+
+sub asm_insn_movdqu(%)
+{
+    my (%modrm) = @_;
+
+    my %insn        = ();
+    $insn{rep}      = {};
+    $insn{opcode16} = 0x0F6F;
+    $insn{modrm}    = \%modrm;
+    asm_insn(%insn);
+}
+
+sub asm_insn_vmovdqu(%)
+{
+    my (%args) = @_;
+
+    my %insn       = ();
+    $insn{rep}     = {};
+    $insn{vex}{l}  = $args{l}; delete $args{l};
+    $insn{vex}{m}  = 0x0F;
+    $insn{opcode8} = 0x6F;
+    $insn{modrm}   = \%args;
+    asm_insn(%insn);
+}
-- 
2.20.1



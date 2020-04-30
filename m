Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D12C83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:28:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0D42214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D42214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU3c4-0004zB-VM
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 03:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jU3Xb-0004i1-Q1
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:23:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jU3W8-0006Yu-49
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:23:27 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:46114)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jU3W6-0006WR-Rn; Thu, 30 Apr 2020 03:21:55 -0400
X-Alimail-AntiSpam: AC=PASS; BC=0.07436282|-1; BR=01201311R111ee; CH=green;
 DM=|CONTINUE|false|; DS=SPAM|spam_ad|0.906831-5.56391e-05-0.0931137;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03306; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.HQfovas_1588231302; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HQfovas_1588231302) by smtp.aliyun-inc.com(10.147.40.7);
 Thu, 30 Apr 2020 15:21:44 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: peter.maydell@linaro.org
Subject: [RFC PATCH 2/8] riscv: Generate payload scripts
Date: Thu, 30 Apr 2020 15:21:33 +0800
Message-Id: <20200430072139.4602-3-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200430072139.4602-1-zhiwei_liu@c-sky.com>
References: <20200430072139.4602-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 03:21:44
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Received-From: 121.197.200.217
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
Cc: qemu-riscv@nongnu.org, richard.henderson@linaro.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com, wenmeng_zhang@c-sky.com, palmer@dabbelt.com,
 alistair23@gmail.com, alex.bennee@linaro.org,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 risugen_riscv.pm | 501 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 501 insertions(+)
 create mode 100644 risugen_riscv.pm

diff --git a/risugen_riscv.pm b/risugen_riscv.pm
new file mode 100644
index 0000000..092c246
--- /dev/null
+++ b/risugen_riscv.pm
@@ -0,0 +1,501 @@
+#!/usr/bin/perl -w
+###############################################################################
+# All rights reserved. This program and the accompanying materials
+# are made available under the terms of the Eclipse Public License v1.0
+# which accompanies this distribution, and is available at
+# http://www.eclipse.org/legal/epl-v10.html
+#
+# Contributors:
+#     LIU Zhiwei (PingTouGe) - RISC-V implementation
+#     based on Peter Maydell (Linaro) - initial implementation
+###############################################################################
+
+# risugen -- generate a test binary file for use with risu
+# See 'risugen --help' for usage information.
+package risugen_riscv;
+
+use strict;
+use warnings;
+
+use risugen_common;
+
+require Exporter;
+
+our @ISA    = qw(Exporter);
+our @EXPORT = qw(write_test_code);
+
+my $periodic_reg_random = 1;
+
+#
+# Maximum alignment restriction permitted for a memory op.
+my $MAXALIGN = 64;
+sub ctz($)
+{
+    my ($imm) = @_;
+    my $cnt = 0;
+
+    if ($imm == 0) {
+        return 0;
+    }
+    while (($imm & 1) == 0) {
+        $cnt++;
+        $imm = $imm >> 1;
+    }
+    return $cnt;
+}
+
+sub decode_li($)
+{
+    my ($imm) = @_;
+    my $cnt = 0;
+    my $idx = 0;
+    my $part = 0;
+    my $next = 0;
+    my %result;
+
+    $next = $imm;
+    # only one lui can not hold
+    while ((($next >> 12) != sextract(($next >> 12) & 0xfffff, 20)) ||
+           (($next & 0xfff) != 0)) {
+        # at the first time, just eat the least 12 bits
+        if ($idx == 0) {
+            $part = sextract($imm & 0xfff, 12);
+            $result{"first"} = $part;
+        } else {
+            $imm = $imm - $part; # clear the part before it
+            $cnt = ctz($imm); # add a shift
+            $imm >>= $cnt;
+            $part = sextract($imm & 0xfff, 12);
+            $result{"mid"}{$idx}{"part"} = $part;
+            $result{"mid"}{$idx}{"cnt"} = $cnt;
+            $next = $imm - $part;
+        }
+        $idx++;
+    }
+    # output a lui
+    $result{"lui"} =  sextract(($next >> 12) & 0xfffff, 20);
+    return %result;
+}
+
+# li is implements as Myraid sequences, just the common way here
+sub write_mov_ri($$)
+{
+    my ($rd, $imm) = @_;
+
+    # sequence of li rd, 0x1234567887654321
+    #
+    #  0:   002471b7                lui     rd,0x247
+    #  4:   8ad1819b                addiw   rd,rd,-1875
+    #  8:   00c19193                slli    rd,rd,0xc
+    #  c:   f1118193                addi    rd,rd,-239 # 0x246f11
+    # 10:   00d19193                slli    rd,rd,0xd
+    # 14:   d9518193                addi    rd,rd,-619
+    # 18:   00e19193                slli    rd,rd,0xe
+    # 1c:   32118193                addi    rd,rd,801
+    my %result = decode_li($imm);
+
+    my $len = keys %{$result{"mid"}};
+    my $i = 0;
+
+    # output the last lui
+    insn32(0x00000037 | $rd << 7 | $result{"lui"} << 12);
+    # output the sequence of slli and addi
+    foreach my $key (reverse sort keys %{$result{"mid"}}) {
+        $i++;
+        if ($i == 1) {
+            # output the last addiw
+            insn32(0x0000001b | $rd << 7 | $rd << 15 |
+                   $result{"mid"}{$key}{"part"} << 20);
+            # slli rd, rd, $result{"mid"}{$key}{"part"}
+            insn32(0x00001013 | $rd << 7 | $rd << 15 |
+                   $result{"mid"}{$key}{"cnt"}  << 20);
+        } else {
+            insn32(0x00000013 | $rd << 7 | $rd << 15 |
+                   ($result{"mid"}{$key}{"part"} & 0xfff) << 20);
+            # slli rd, rd, $result{"mid"}{$key}{"part"}
+            insn32(0x00001013 | $rd << 7 | $rd << 15 |
+                   $result{"mid"}{$key}{"cnt"}  << 20);
+        }
+    }
+    # addi rd, rd, $result{"first"}
+    insn32(0x00000013 | $rd << 7 | $rd << 15 | ($imm & 0xfff) << 20);
+}
+
+sub write_mov_rr($$)
+{
+    my ($rd, $rs1) = @_;
+
+    # addi $rd, $rs1, 0
+    insn32(0x00000013 | $rd << 7 | $rs1 << 15);
+}
+
+sub write_sub_rrr($$$)
+{
+    my ($rd, $rs1, $rs2) = @_;
+
+    # sub $rd, $rs1, $rs2
+    insn32(0x40000033 |$rd << 7 | $rs1 << 15 | $rs2 << 20);
+}
+
+my $OP_COMPARE = 0;        # compare registers
+my $OP_TESTEND = 1;        # end of test, stop
+my $OP_SETMEMBLOCK = 2;    # r0 is address of memory block (8192 bytes)
+my $OP_GETMEMBLOCK = 3;    # add the address of memory block to r0
+my $OP_COMPAREMEM = 4;     # compare memory block
+
+# write random fp value of passed precision (1=single, 2=double)
+sub write_random_fpreg_var($)
+{
+    my ($precision) = @_;
+    my $randomize_low = 0;
+
+    if ($precision != 1 && $precision != 2) {
+        die "write_random_fpreg: invalid precision.\n";
+    }
+
+    my ($low, $high);
+    my $r = rand(100);
+    if ($r < 5) {
+        # +-0 (5%)
+        $low = $high = 0;
+        $high |= 0x80000000 if (rand() < 0.5);
+    } elsif ($r < 10) {
+        # NaN (5%)
+        # (plus a tiny chance of generating +-Inf)
+        $randomize_low = 1;
+        $high = rand(0xffffffff) | 0x7ff00000;
+    } elsif ($r < 15) {
+        # Infinity (5%)
+        $low = 0;
+        $high = 0x7ff00000;
+        $high |= 0x80000000 if (rand() < 0.5);
+    } elsif ($r < 30) {
+        # Denormalized number (15%)
+        # (plus tiny chance of +-0)
+        $randomize_low = 1;
+        $high = rand(0xffffffff) & ~0x7ff00000;
+    } else {
+        # Normalized number (70%)
+        # (plus a small chance of the other cases)
+        $randomize_low = 1;
+        $high = rand(0xffffffff);
+    }
+
+    for (my $i = 1; $i < $precision; $i++) {
+        if ($randomize_low) {
+            $low = rand(0xffffffff);
+        }
+        insn32($low);
+    }
+    insn32($high);
+}
+
+sub write_random_riscv64_fpdata()
+{
+    # load floating point registers
+    my $align = 16;
+    my $datalen = 32 * 8 + $align;
+    write_pc_adr(10, (4 * 4) + ($align - 1)); # insn 1
+    write_align_reg(10, $align);              # insn 2
+    write_jump_fwd($datalen + 4);             # insn 3
+
+    # align safety
+    for (my $i = 0; $i < ($align / 4); $i++) {
+        insn32(rand(0xffffffff));
+    }
+
+    # Todo: As the x10 aligned, it won't be the base address of
+    # the interesting numbers.
+    for (my $rt = 0; $rt <= 31; $rt++) {
+        write_random_fpreg_var(2); # double
+    }
+
+    for (my ($rt, $imm) = (0, 0); $rt < 32; $rt++) {
+        # fld rt, x10, imm
+        insn32(0x00003007 | ($imm << 20) | (10 << 15) | ($rt << 7));
+        $imm += 8;
+    }
+}
+
+sub write_random_register_data($)
+{
+    my ($fp_enabled) = @_;
+
+    if ($fp_enabled) {
+        # load floating point
+        write_random_riscv64_fpdata();
+    }
+
+    # general purpose registers
+    for (my $i = 1; $i < 32; $i++) {
+	    if ($i != 2 && $i != 3 && $i!= 4) {
+            # TODO full 64 bit pattern instead of 32
+            write_mov_ri($i, rand(0xffffffff));
+        }
+    }
+    write_risuop($OP_COMPARE);
+}
+
+# put PC + offset into a register.
+# this must emit an instruction of 8 bytes.
+sub write_pc_adr($$)
+{
+    my ($rd, $imm) = @_;
+
+    # auipc rd, 0
+    # addi rd, rd, imm
+    insn32(0x00000017 | $rd << 7);
+    insn32(0x00000013 | $imm << 20 | $rd << 15 | $rd << 7);
+}
+
+# clear bits in register to satisfy alignment.
+# Must use exactly 4 instruction-bytes
+sub write_align_reg($$)
+{
+    my ($rd, $align) = @_;
+    my $imm = (-$align) & 0xfff;
+    die "bad alignment!" if ($align < 2);
+
+    # andi rd, rd, ~(align - 1)
+    insn32(0x00007013 | $imm << 20 | $rd << 15 | $rd << 7);
+}
+
+# jump ahead of n bytes starting from next instruction
+sub write_jump_fwd($)
+{
+    my ($len) = @_;
+
+    #     31         30     21   20        19      12   11    7     6    0
+    #   imm[20]      imm[10:1] imm[11]     imm[19:12]      rd       opcode
+    #     1              10      1              8          5          7
+    #                 offset[20:1]                        dest       JAL
+    my ($imm20, $imm1, $imm11, $imm12) = (($len & 0x100000) >> 20, ($len & 0x7fe) >> 1,
+                                          ($len & 0x800) >> 11, ($len & 0xff000) >> 12);
+
+    # jal x0, len
+    insn32(0x0000006f | $imm20 << 31 | $imm1 << 21 | $imm11 << 20 |
+           $imm12 << 12);
+}
+
+sub write_memblock_setup()
+{
+    # Write code which sets up the memory block for loads and stores.
+    # We set r0 to point to a block of 16K length
+    # of random data, aligned to the maximum desired alignment.
+
+    my $align = $MAXALIGN;
+    my $datalen = 16384 + $align;
+    if (($align > 255) || !is_pow_of_2($align) || $align < 4) {
+        die "bad alignment!";
+    }
+
+    # set x10 to (datablock + (align-1)) & ~(align-1)
+    # datablock is at PC + (4 * 5 instructions) = PC + 20
+    write_pc_adr(10, (4 * 5) + ($align - 1)); # insn 1
+    write_align_reg(10, $align);              # insn 2
+    write_risuop($OP_SETMEMBLOCK);            # insn 3
+    write_jump_fwd($datalen + 4);             # insn 4
+
+    for (my $i = 0; $i < $datalen / 4; $i++) {
+        insn32(rand(0xffffffff));
+    }
+    # next:
+}
+
+# Functions used in memory blocks to handle addressing modes.
+# These all have the same basic API: they get called with parameters
+# corresponding to the interesting fields of the instruction,
+# and should generate code to set up the base register to be
+# valid. They must return the register number of the base register.
+# The last (array) parameter lists the registers which are trashed
+# by the instruction (ie which are the targets of the load).
+# This is used to avoid problems when the base reg is a load target.
+
+# Global used to communicate between align(x) and reg() etc.
+my $alignment_restriction;
+
+sub align($)
+{
+    my ($a) = @_;
+    if (!is_pow_of_2($a) || ($a < 0) || ($a > $MAXALIGN)) {
+        die "bad align() value $a\n";
+    }
+    $alignment_restriction = $a;
+}
+
+sub write_get_offset()
+{
+    # Emit code to get a random offset within the memory block, of the
+    # right alignment, into r0
+    # We require the offset to not be within 256 bytes of either
+    # end, to (more than) allow for the worst case data transfer, which is
+    # 16 * 64 bit regs
+    my $offset = (rand(16384 - 8192) + 4096) & ~($alignment_restriction - 1);
+    write_mov_ri(10, $offset);
+    write_risuop($OP_GETMEMBLOCK);
+}
+
+sub reg($@)
+{
+    my ($base, @trashed) = @_;
+    write_get_offset();
+    # Now x10 is the address we want to do the access to,
+    # so just move it into the basereg
+    if ($base != 10) {
+        write_mov_rr($base, 10);
+        write_mov_ri(10, 0);
+    }
+    if (grep $_ == $base, @trashed) {
+        return -1;
+    }
+    return $base;
+}
+
+sub reg_plus_imm($$@)
+{
+    # Handle reg + immediate addressing mode
+    my ($base, $imm, @trashed) = @_;
+    if ($imm == 0) {
+        return reg($base, @trashed);
+    }
+
+    write_get_offset();
+    # Now x10 is the address we want to do the access to,
+    # so set the basereg by doing the inverse of the
+    # addressing mode calculation, ie base = x10 - imm
+    # We could do this more cleverly with a sub immediate.
+    if ($base != 10) {
+        write_mov_ri($base, $imm);
+        write_sub_rrr($base, 10, $base);
+        # Clear x10 to avoid register compare mismatches
+        # when the memory block location differs between machines.
+        write_mov_ri(10, 0);
+    } else {
+        # We borrow x11 as a temporary (not a problem
+        # as long as we don't leave anything in a register
+        # which depends on the location of the memory block)
+        write_mov_ri(11, $imm);
+        write_sub_rrr($base, 10, 11);
+    }
+    if (grep $_ == $base, @trashed) {
+        return -1;
+    }
+    return $base;
+}
+
+sub gen_one_insn($)
+{
+    # Given an instruction-details array, generate an instruction
+    my $constraintfailures = 0;
+
+    INSN: while(1) {
+        my ($rec) = @_;
+        my $insn = int(rand(0xffffffff));
+        my $insnname = $rec->{name};
+        my $insnwidth = $rec->{width};
+        my $fixedbits = $rec->{fixedbits};
+        my $fixedbitmask = $rec->{fixedbitmask};
+        my $constraint = $rec->{blocks}{"constraints"};
+        my $memblock = $rec->{blocks}{"memory"};
+
+        $insn &= ~$fixedbitmask;
+        $insn |= $fixedbits;
+
+        if (defined $constraint) {
+            # user-specified constraint: evaluate in an environment
+            # with variables set corresponding to the variable fields.
+            my $v = eval_with_fields($insnname, $insn, $rec, "constraints", $constraint);
+            if (!$v) {
+                $constraintfailures++;
+                if ($constraintfailures > 10000) {
+                    print "10000 consecutive constraint failures for $insnname constraints string:\n$constraint\n";
+                    exit (1);
+                }
+                next INSN;
+            }
+        }
+
+        # OK, we got a good one
+        $constraintfailures = 0;
+
+        my $basereg;
+
+        if (defined $memblock) {
+            # This is a load or store. We simply evaluate the block,
+            # which is expected to be a call to a function which emits
+            # the code to set up the base register and returns the
+            # number of the base register.
+            # we use 16 for riscv64, although often unnecessary and overkill.
+            align(16);
+            $basereg = eval_with_fields($insnname, $insn, $rec, "memory", $memblock);
+        }
+
+        insn32($insn);
+
+        if (defined $memblock) {
+            # Clean up following a memory access instruction:
+            # we need to turn the (possibly written-back) basereg
+            # into an offset from the base of the memory block,
+            # to avoid making register values depend on memory layout.
+            # $basereg -1 means the basereg was a target of a load
+            # (and so it doesn't contain a memory address after the op)
+            if ($basereg != -1) {
+                write_mov_ri($basereg, 0);
+            }
+        }
+        return;
+    }
+}
+
+sub write_risuop($)
+{
+    # instr with bits (6:0) == 1 1 0 1 0 1 1 are UNALLOCATED
+    my ($op) = @_;
+    insn32(0x0000006b | $op << 8);
+}
+
+sub write_test_code($)
+{
+    my ($params) = @_;
+
+    my $numinsns = $params->{ 'numinsns' };
+    my $fp_enabled = $params->{ 'fp_enabled' };
+    my $outfile = $params->{ 'outfile' };
+
+    my %insn_details = %{ $params->{ 'details' } };
+    my @keys = @{ $params->{ 'keys' } };
+
+    print "Enter write code", "\n";
+    open_bin($outfile);
+
+    # TODO better random number generator?
+    srand(0);
+
+    print "Generating code using patterns: @keys...\n";
+    progress_start(78, $numinsns);
+
+    if (grep { defined($insn_details{$_}->{blocks}->{"memory"}) } @keys) {
+        write_memblock_setup();
+    }
+
+    # memblock setup doesn't clean its registers, so this must come afterwards.
+    write_random_register_data($fp_enabled);
+
+    for my $i (1..$numinsns) {
+        my $insn_enc = $keys[int rand (@keys)];
+        #dump_insn_details($insn_enc, $insn_details{$insn_enc});
+        gen_one_insn($insn_details{$insn_enc});
+        write_risuop($OP_COMPARE);
+        # Rewrite the registers periodically. This avoids the tendency
+        # for the VFP registers to decay to NaNs and zeroes.
+        if ($periodic_reg_random && ($i % 100) == 0) {
+            write_random_register_data($fp_enabled);
+        }
+        progress_update($i);
+    }
+    write_risuop($OP_TESTEND);
+    progress_end();
+    close_bin();
+}
+
+1;
-- 
2.23.0



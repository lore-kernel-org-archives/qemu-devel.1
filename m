Received: from eggs.gnu.org ([2001:4830:134:3::10]:57409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eu9YM-0002GM-Q5
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 23:22:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eu9YL-0001bG-Jv
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 23:22:46 -0500
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:45052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eu9YL-0001b4-DE
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 23:22:45 -0500
Received: by mail-oi0-x22d.google.com with SMTP id b8so6073839oib.11
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 20:22:45 -0800 (PST)
MIME-Version: 1.0
From: Michael Clark <mjc@sifive.com>
Date: Fri, 9 Mar 2018 17:22:44 +1300
Message-ID: <CAHNT7NtB16m=Sn7bWugeOOiqVyeCT4Z7VrXijMDVZBA+tUdgPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Apparently fpu/softfloat.c:1374 is reachable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

I need to dig into this. I'll need to take the assertions out, or run with
tracing to see which fcvt test is triggering this unreachable piece of
code. FYI. I can look into it.

$ sh run-riscv-tests.sh
rv64ua-v-amoadd_d
rv64ua-v-amoadd_w
rv64ua-v-amoand_d
rv64ua-v-amoand_w
rv64ua-v-amomax_d
rv64ua-v-amomax_w
rv64ua-v-amomaxu_d
rv64ua-v-amomaxu_w
rv64ua-v-amomin_d
rv64ua-v-amomin_w
rv64ua-v-amominu_d
rv64ua-v-amominu_w
rv64ua-v-amoor_d
rv64ua-v-amoor_w
rv64ua-v-amoswap_d
rv64ua-v-amoswap_w
rv64ua-v-amoxor_d
rv64ua-v-amoxor_w
rv64ua-v-lrsc
rv64uc-v-rvc
rv64ud-v-fadd
rv64ud-v-fclass
rv64ud-v-fcmp
rv64ud-v-fcvt
rv64ud-v-fcvt_w
**
ERROR:/Users/mclark/src/sifive/riscv-qemu/fpu/softfloat.c:1374:round_to_int_and_pack:
code should not be reached
qemu-images/run-tests.sh: line 6: 58437 Abort trap: 6           ${QEMU}
-nographic -machine spike_v1.10 -kernel $i
rv64ud-v-fdiv
rv64ud-v-fmadd
rv64ud-v-fmin
rv64ud-v-ldst
rv64ud-v-move
rv64ud-v-recoding
rv64ud-v-structural
rv64uf-v-fadd
rv64uf-v-fclass
rv64uf-v-fcmp
rv64uf-v-fcvt
rv64uf-v-fcvt_w
**
ERROR:/Users/mclark/src/sifive/riscv-qemu/fpu/softfloat.c:1374:round_to_int_and_pack:
code should not be reached
qemu-images/run-tests.sh: line 6: 58461 Abort trap: 6           ${QEMU}
-nographic -machine spike_v1.10 -kernel $i
rv64uf-v-fdiv
rv64uf-v-fmadd
rv64uf-v-fmin
rv64uf-v-ldst
rv64uf-v-move
rv64uf-v-recoding
rv64ui-v-add
rv64ui-v-addi
rv64ui-v-addiw
rv64ui-v-addw
rv64ui-v-and
rv64ui-v-andi
rv64ui-v-auipc
rv64ui-v-beq
rv64ui-v-bge
rv64ui-v-bgeu
rv64ui-v-blt
rv64ui-v-bltu
rv64ui-v-bne
rv64ui-v-fence_i
rv64ui-v-jal
rv64ui-v-jalr
rv64ui-v-lb
rv64ui-v-lbu
rv64ui-v-ld
rv64ui-v-lh
rv64ui-v-lhu
rv64ui-v-lui
rv64ui-v-lw
rv64ui-v-lwu
rv64ui-v-or
rv64ui-v-ori
rv64ui-v-sb
rv64ui-v-sd
rv64ui-v-sh
rv64ui-v-simple
rv64ui-v-sll
rv64ui-v-slli
rv64ui-v-slliw
rv64ui-v-sllw
rv64ui-v-slt
rv64ui-v-slti
rv64ui-v-sltiu
rv64ui-v-sltu
rv64ui-v-sra
rv64ui-v-srai
rv64ui-v-sraiw
rv64ui-v-sraw
rv64ui-v-srl
rv64ui-v-srli
rv64ui-v-srliw
rv64ui-v-srlw
rv64ui-v-sub
rv64ui-v-subw
rv64ui-v-sw
rv64ui-v-xor
rv64ui-v-xori
rv64um-v-div
rv64um-v-divu
rv64um-v-divuw
rv64um-v-divw
rv64um-v-mul
rv64um-v-mulh
rv64um-v-mulhsu
rv64um-v-mulhu
rv64um-v-mulw
rv64um-v-rem
rv64um-v-remu
rv64um-v-remuw
rv64um-v-remw

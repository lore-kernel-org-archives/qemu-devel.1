Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC11EC742A8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 05:37:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9468C208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 05:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+Kg6jjQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9468C208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hloFq-0007ez-LC
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 01:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35019)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mrolnik@gmail.com>) id 1hloFA-0004vc-Ux
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 01:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1hloF9-0007fM-J1
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 01:37:16 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44610)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hloF9-0007ea-CT
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 01:37:15 -0400
Received: by mail-wr1-x441.google.com with SMTP id p17so8523889wrf.11
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 22:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=oElsIV9jGIkcznG1hjJ8A0RR90Xk82sVn+s7o2gFZVw=;
 b=T+Kg6jjQgNoAsjpznTiqzNLZnhX2sh8am2e5PZNRo1UErN/2zOA+aKsE8VZ4oWmZiS
 8q2QBTnzqa2BGab1CzMp8ffdzbiWrlwQR9kyXA16/0Eyeh37WPxJzCvZnqCuAADu71Y9
 kM02+IjZBScW5aR+cFI6I/VCrTIgN2Qhw5oVe2Dxkshe2e6SG9m0DnH89xoeOLVCfNUD
 2svovkVrlq07/pxR013NNTgPl7jVFv0ByEqzhbGHMgWWnYXR8XApnrclGoW4BpxxYblt
 qm2HXMdOTwGUfDoiKZQ0y8b8VDeE26OSxVo9c0/rziC4gsa/P/nGPBMGWSlWXhxiu87v
 x8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=oElsIV9jGIkcznG1hjJ8A0RR90Xk82sVn+s7o2gFZVw=;
 b=JCJgRwY01hc77XBDdn7lZrKHusMmGbVvfv+CDBxsnO0maWF0z5dn5AM0htmmgVKyQ5
 TooNffSCNsWW/2aXJeHrnRQcdLn6o1bwPg2bLplu04oAzNTIaUy1yW3HkaOzn9b7StY/
 N8fbpA5oyqXENZNPHuXDL5NARzuTsErGSd1WMsut1TRBnP5+M2TaD+Do9PIw3Pscxqs6
 v5iQKD458GknOTQtBe39neSTfJO14MHjZGiTyW5KsgMQy1iiyt9Eo7Zt4itud2vpoVVf
 anFMy/ougPK3AYzLnP1AW7UFHxtFg7Hw7LNUJDvumjilz6WVhDT+ihIYB8Q2Q1QG0O+J
 NQHA==
X-Gm-Message-State: APjAAAUQ8T2poF6Wzd3UFn8hPd/HzR3PMQF1ol0dJ2sqM/nZOV7I9poo
 UiYz46hKLx5OmAjOHJyE/ZjbOf+K/j0=
X-Google-Smtp-Source: APXvYqykxm0pzAbSduPjRrdwiFRJRNpd3Yw3Rk8rXtd7gZms/eqmiLiHV3tFqVeK+T8WxM+/amCjNQ==
X-Received: by 2002:adf:ea8b:: with SMTP id s11mr8945983wrm.100.1562909833975; 
 Thu, 11 Jul 2019 22:37:13 -0700 (PDT)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-109-66-61-47.red.bezeqint.net. [109.66.61.47])
 by smtp.gmail.com with ESMTPSA id y6sm7824009wmd.16.2019.07.11.22.37.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 11 Jul 2019 22:37:13 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 12 Jul 2019 08:37:00 +0300
Message-Id: <20190712053704.21228-4-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190712053704.21228-1-mrolnik@gmail.com>
References: <20190712053704.21228-1-mrolnik@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v26 3/7] target/avr: Add instruction decoding
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
Cc: imammedo@redhat.com, Michael Rolnik <mrolnik@gmail.com>,
 richard.henderson@linaro.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This includes:
- encoding of all 16 bit instructions
- encoding of all 32 bit instructions

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
---
 target/avr/insn.decode | 175 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 175 insertions(+)
 create mode 100644 target/avr/insn.decode

diff --git a/target/avr/insn.decode b/target/avr/insn.decode
new file mode 100644
index 0000000000..6b387762c6
--- /dev/null
+++ b/target/avr/insn.decode
@@ -0,0 +1,175 @@
+#
+#   A = [16 .. 31]
+#   B = [16 .. 23]
+#   C = [24, 26, 28, 30]
+#   D = [0, 2, 4, 6, 8, .. 30]
+
+%rd             4:5
+%rr             9:1 0:4
+
+&rd_rr          rd rr
+&rd_imm         rd imm
+
+@op_rd_rr       .... .. . ..... ....        &rd_rr      rd=%rd rr=%rr
+ADD             0000 11 . ..... ....        @op_rd_rr
+ADC             0001 11 . ..... ....        @op_rd_rr
+AND             0010 00 . ..... ....        @op_rd_rr
+CP              0001 01 . ..... ....        @op_rd_rr
+CPC             0000 01 . ..... ....        @op_rd_rr
+CPSE            0001 00 . ..... ....        @op_rd_rr
+EOR             0010 01 . ..... ....        @op_rd_rr
+MOV             0010 11 . ..... ....        @op_rd_rr
+MUL             1001 11 . ..... ....        @op_rd_rr
+OR              0010 10 . ..... ....        @op_rd_rr
+SBC             0000 10 . ..... ....        @op_rd_rr
+SUB             0001 10 . ..... ....        @op_rd_rr
+
+
+%rd_c           4:2                         !function=to_C
+%imm6           6:2 0:4
+
+@op_rd_imm6     .... .... .. .. ....        &rd_imm     rd=%rd_c imm=%imm6
+ADIW            1001 0110 .. .. ....        @op_rd_imm6
+SBIW            1001 0111 .. .. ....        @op_rd_imm6
+
+
+%rd_a           4:4                         !function=to_A
+%rr_a           0:4                         !function=to_A
+%rd_d           4:4                         !function=to_D
+%rr_d           0:4                         !function=to_D
+%imm8           8:4 0:4
+
+@op_rd_imm8     .... .... .... ....         &rd_imm     rd=%rd_a imm=%imm8
+ANDI            0111 .... .... ....         @op_rd_imm8
+CPI             0011 .... .... ....         @op_rd_imm8
+LDI             1110 .... .... ....         @op_rd_imm8
+ORI             0110 .... .... ....         @op_rd_imm8
+SBCI            0100 .... .... ....         @op_rd_imm8
+SUBI            0101 .... .... ....         @op_rd_imm8
+
+
+@op_rd          .... ... rd:5 ....
+ASR             1001 010 ..... 0101         @op_rd
+COM             1001 010 ..... 0000         @op_rd
+DEC             1001 010 ..... 1010         @op_rd
+ELPM2           1001 000 ..... 0110         @op_rd
+ELPMX           1001 000 ..... 0111         @op_rd
+INC             1001 010 ..... 0011         @op_rd
+LDX1            1001 000 ..... 1100         @op_rd
+LDX2            1001 000 ..... 1101         @op_rd
+LDX3            1001 000 ..... 1110         @op_rd
+LDY2            1001 000 ..... 1001         @op_rd
+LDY3            1001 000 ..... 1010         @op_rd
+LDZ2            1001 000 ..... 0001         @op_rd
+LDZ3            1001 000 ..... 0010         @op_rd
+LPM2            1001 000 ..... 0100         @op_rd
+LPMX            1001 000 ..... 0101         @op_rd
+LSR             1001 010 ..... 0110         @op_rd
+NEG             1001 010 ..... 0001         @op_rd
+POP             1001 000 ..... 1111         @op_rd
+PUSH            1001 001 ..... 1111         @op_rd
+ROR             1001 010 ..... 0111         @op_rd
+STY2            1001 001 ..... 1001         @op_rd
+STY3            1001 001 ..... 1010         @op_rd
+STZ2            1001 001 ..... 0001         @op_rd
+STZ3            1001 001 ..... 0010         @op_rd
+SWAP            1001 010 ..... 0010         @op_rd
+
+
+@op_bit         .... .... . bit:3 ....
+BCLR            1001 0100 1 ... 1000        @op_bit
+BSET            1001 0100 0 ... 1000        @op_bit
+
+
+@op_rd_bit      .... ... rd:5 . bit:3
+BLD             1111 100 ..... 0 ...        @op_rd_bit
+BST             1111 101 ..... 0 ...        @op_rd_bit
+
+
+@op_bit_imm     .... .. imm:s7 bit:3
+BRBC            1111 01 ....... ...         @op_bit_imm
+BRBS            1111 00 ....... ...         @op_bit_imm
+
+
+BREAK           1001 0101 1001 1000
+EICALL          1001 0101 0001 1001
+EIJMP           1001 0100 0001 1001
+ELPM1           1001 0101 1101 1000
+ICALL           1001 0101 0000 1001
+IJMP            1001 0100 0000 1001
+LPM1            1001 0101 1100 1000
+NOP             0000 0000 0000 0000
+RET             1001 0101 0000 1000
+RETI            1001 0101 0001 1000
+SLEEP           1001 0101 1000 1000
+SPM             1001 0101 1110 1000
+SPMX            1001 0101 1111 1000
+WDR             1001 0101 1010 1000
+
+
+@op_reg_bit     .... .... reg:5 bit:3
+CBI             1001 1000 ..... ...         @op_reg_bit
+SBI             1001 1010 ..... ...         @op_reg_bit
+SBIC            1001 1001 ..... ...         @op_reg_bit
+SBIS            1001 1011 ..... ...         @op_reg_bit
+
+
+DES             1001 0100 imm:4 1011
+
+
+%rd_b           4:3                         !function=to_B
+%rr_b           0:3                         !function=to_B
+@fmul           .... .... . ... . ...       &rd_rr      rd=%rd_b rr=%rr_b
+FMUL            0000 0011 0 ... 1 ...       @fmul
+FMULS           0000 0011 1 ... 0 ...       @fmul
+FMULSU          0000 0011 1 ... 1 ...       @fmul
+MULSU           0000 0011 0 ... 0 ...       @fmul
+
+
+%io_imm         9:2 0:4
+@io_rd_imm      .... . .. ..... ....        &rd_imm     rd=%rd imm=%io_imm
+IN              1011 0 .. ..... ....        @io_rd_imm
+OUT             1011 1 .. ..... ....        @io_rd_imm
+
+
+XCH             1001 001 rd:5 0100
+LAC             1001 001 rd:5 0110
+LAS             1001 001 rd:5 0101
+LAT             1001 001 rd:5 0111
+STX1            1001 001 rr:5 1100
+STX2            1001 001 rr:5 1101
+STX3            1001 001 rr:5 1110
+
+
+%ldst_d_imm     13:1 10:2 0:3
+@ldst_d         .. . . .. . rd:5  . ...     &rd_imm     imm=%ldst_d_imm
+LDDY            10 . 0 .. 0 ..... 1 ...     @ldst_d
+LDDZ            10 . 0 .. 0 ..... 0 ...     @ldst_d
+STDY            10 . 0 .. 1 ..... 1 ...     @ldst_d
+STDZ            10 . 0 .. 1 ..... 0 ...     @ldst_d
+
+
+MOVW            0000 0001 .... ....         &rd_rr      rd=%rd_d rr=%rr_d
+MULS            0000 0010 .... ....         &rd_rr      rd=%rd_a rr=%rr_a
+
+RCALL           1101 imm:s12
+RJMP            1100 imm:s12
+
+SBRC            1111 110 rr:5 0 bit:3
+SBRS            1111 111 rr:5 0 bit:3
+
+# The 22-bit immediate is partially in the opcode word,
+# and partially in the next.  Use append_16 to build the
+# complete 22-bit value.
+%imm_call       4:5 0:1                     !function=append_16
+CALL            1001 010 ..... 111 .        imm=%imm_call
+JMP             1001 010 ..... 110 .        imm=%imm_call
+
+
+# The 16-bit immediate is completely in the next word.
+# Fields cannot be defined with no bits, so we cannot play
+# the same trick and append to a zero-bit value.
+# Defer reading the immediate until trans_{LDS,STS}.
+@ldst_s         .... ... rd:5 ....          imm=0
+LDS             1001 000 ..... 0000         @ldst_s
+STS             1001 001 ..... 0000         @ldst_s
-- 
2.17.2 (Apple Git-113)



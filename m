Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032C6C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:57:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 804C420868
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804C420868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49002 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZDVD-0004XX-L6
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 07:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59507)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hZBl6-0003s0-8y
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:06:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hZBl3-00087h-1D
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:06:04 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:50163 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hZBkz-0007vA-Hg
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:05:59 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 2F40A1A1EAC;
 Fri,  7 Jun 2019 12:05:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id DF4D31A1D8A;
 Fri,  7 Jun 2019 12:05:49 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Fri,  7 Jun 2019 12:05:37 +0200
Message-Id: <1559901944-4578-4-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559901944-4578-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1559901944-4578-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 03/10] target/mips: Outline places for future
 MSA helpers
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Outline places for future MSA helpers to follow the same organization
as in MSA tests.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Message-Id: <1559838440-9866-4-git-send-email-aleksandar.markovic@rt-rk.com>
---
 target/mips/msa_helper.c | 461 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 461 insertions(+)

diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 851450c..8dd73d2 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -42,6 +42,467 @@
 /* Element-by-element access macros */
 #define DF_ELEMENTS(df) (MSA_WRLEN / DF_BITS(df))
 
+
+
+/*
+ * Bit Count
+ * ---------
+ *
+ * +---------------+----------------------------------------------------------+
+ * | NLOC.B        | Vector Leading Ones Count (byte)                         |
+ * | NLOC.H        | Vector Leading Ones Count (halfword)                     |
+ * | NLOC.W        | Vector Leading Ones Count (word)                         |
+ * | NLOC.D        | Vector Leading Ones Count (doubleword)                   |
+ * | NLZC.B        | Vector Leading Zeros Count (byte)                        |
+ * | NLZC.H        | Vector Leading Zeros Count (halfword)                    |
+ * | NLZC.W        | Vector Leading Zeros Count (word)                        |
+ * | NLZC.D        | Vector Leading Zeros Count (doubleword)                  |
+ * | PCNT.B        | Vector Population Count (byte)                           |
+ * | PCNT.H        | Vector Population Count (halfword)                       |
+ * | PCNT.W        | Vector Population Count (word)                           |
+ * | PCNT.D        | Vector Population Count (doubleword)                     |
+ * +---------------+----------------------------------------------------------+
+ */
+
+/* TODO: insert Bit Count group helpers here */
+
+
+/*
+ * Bit Move
+ * --------
+ *
+ * +---------------+----------------------------------------------------------+
+ * | BMNZ.V        | Vector Bit Move If Not Zero                              |
+ * | BMZ.V         | Vector Bit Move If Zero                                  |
+ * | BSEL.V        | Vector Bit Select                                        |
+ * | BINSL.B       | Vector Bit Insert Left (byte)                            |
+ * | BINSL.H       | Vector Bit Insert Left (halfword)                        |
+ * | BINSL.W       | Vector Bit Insert Left (word)                            |
+ * | BINSL.D       | Vector Bit Insert Left (doubleword)                      |
+ * | BINSR.B       | Vector Bit Insert Right (byte)                           |
+ * | BINSR.H       | Vector Bit Insert Right (halfword)                       |
+ * | BINSR.W       | Vector Bit Insert Right (word)                           |
+ * | BINSR.D       | Vector Bit Insert Right (doubleword)                     |
+ * +---------------+----------------------------------------------------------+
+ */
+
+/* TODO: insert Bit Move group helpers here */
+
+
+/*
+ * Bit Set
+ * -------
+ *
+ * +---------------+----------------------------------------------------------+
+ * | BCLR.B        | Vector Bit Clear (byte)                                  |
+ * | BCLR.H        | Vector Bit Clear (halfword)                              |
+ * | BCLR.W        | Vector Bit Clear (word)                                  |
+ * | BCLR.D        | Vector Bit Clear (doubleword)                            |
+ * | BNEG.B        | Vector Bit Negate (byte)                                 |
+ * | BNEG.H        | Vector Bit Negate (halfword)                             |
+ * | BNEG.W        | Vector Bit Negate (word)                                 |
+ * | BNEG.D        | Vector Bit Negate (doubleword)                           |
+ * | BSET.B        | Vector Bit Set (byte)                                    |
+ * | BSET.H        | Vector Bit Set (halfword)                                |
+ * | BSET.W        | Vector Bit Set (word)                                    |
+ * | BSET.D        | Vector Bit Set (doubleword)                              |
+ * +---------------+----------------------------------------------------------+
+ */
+
+/* TODO: insert Bit Set group helpers here */
+
+
+/*
+ * Fixed Multiply
+ * --------------
+ *
+ * +---------------+----------------------------------------------------------+
+ * | MADD_Q.H      | Vector Fixed-Point Multiply and Add (halfword)           |
+ * | MADD_Q.W      | Vector Fixed-Point Multiply and Add (word)               |
+ * | MADDR_Q.H     | Vector Fixed-Point Multiply and Add Rounded (halfword)   |
+ * | MADDR_Q.W     | Vector Fixed-Point Multiply and Add Rounded (word)       |
+ * | MSUB_Q.H      | Vector Fixed-Point Multiply and Subtr. (halfword)        |
+ * | MSUB_Q.W      | Vector Fixed-Point Multiply and Subtr. (word)            |
+ * | MSUBR_Q.H     | Vector Fixed-Point Multiply and Subtr. Rounded (halfword)|
+ * | MSUBR_Q.W     | Vector Fixed-Point Multiply and Subtr. Rounded (word)    |
+ * | MUL_Q.H       | Vector Fixed-Point Multiply (halfword)                   |
+ * | MUL_Q.W       | Vector Fixed-Point Multiply (word)                       |
+ * | MULR_Q.H      | Vector Fixed-Point Multiply Rounded (halfword)           |
+ * | MULR_Q.W      | Vector Fixed-Point Multiply Rounded (word)               |
+ * +---------------+----------------------------------------------------------+
+ */
+
+/* TODO: insert Fixed Multiply group helpers here */
+
+
+/*
+ * Float Max Min
+ * -------------
+ *
+ * +---------------+----------------------------------------------------------+
+ * | FMAX_A.W      | Vector Floating-Point Maximum (Absolute) (word)          |
+ * | FMAX_A.D      | Vector Floating-Point Maximum (Absolute) (doubleword)    |
+ * | FMAX.W        | Vector Floating-Point Maximum (word)                     |
+ * | FMAX.D        | Vector Floating-Point Maximum (doubleword)               |
+ * | FMIN_A.W      | Vector Floating-Point Minimum (Absolute) (word)          |
+ * | FMIN_A.D      | Vector Floating-Point Minimum (Absolute) (doubleword)    |
+ * | FMIN.W        | Vector Floating-Point Minimum (word)                     |
+ * | FMIN.D        | Vector Floating-Point Minimum (doubleword)               |
+ * +---------------+----------------------------------------------------------+
+ */
+
+/* TODO: insert Float Max Min group helpers here */
+
+
+/*
+ * Int Add
+ * -------
+ *
+ * +---------------+----------------------------------------------------------+
+ * | ADD_A.B       | Vector Add Absolute Values (byte)                        |
+ * | ADD_A.H       | Vector Add Absolute Values (halfword)                    |
+ * | ADD_A.W       | Vector Add Absolute Values (word)                        |
+ * | ADD_A.D       | Vector Add Absolute Values (doubleword)                  |
+ * | ADDS_A.B      | Vector Signed Saturated Add (of Absolute) (byte)         |
+ * | ADDS_A.H      | Vector Signed Saturated Add (of Absolute) (halfword)     |
+ * | ADDS_A.W      | Vector Signed Saturated Add (of Absolute) (word)         |
+ * | ADDS_A.D      | Vector Signed Saturated Add (of Absolute) (doubleword)   |
+ * | ADDS_S.B      | Vector Signed Saturated Add (of Signed) (byte)           |
+ * | ADDS_S.H      | Vector Signed Saturated Add (of Signed) (halfword)       |
+ * | ADDS_S.W      | Vector Signed Saturated Add (of Signed) (word)           |
+ * | ADDS_S.D      | Vector Signed Saturated Add (of Signed) (doubleword)     |
+ * | ADDS_U.B      | Vector Unsigned Saturated Add (of Unsigned) (byte)       |
+ * | ADDS_U.H      | Vector Unsigned Saturated Add (of Unsigned) (halfword)   |
+ * | ADDS_U.W      | Vector Unsigned Saturated Add (of Unsigned) (word)       |
+ * | ADDS_U.D      | Vector Unsigned Saturated Add (of Unsigned) (doubleword) |
+ * | ADDV.B        | Vector Add (byte)                                        |
+ * | ADDV.H        | Vector Add (halfword)                                    |
+ * | ADDV.W        | Vector Add (word)                                        |
+ * | ADDV.D        | Vector Add (doubleword)                                  |
+ * | HSUB_S.H      | Vector Signed Horizontal Add (halfword)                  |
+ * | HSUB_S.W      | Vector Signed Horizontal Add (word)                      |
+ * | HSUB_S.D      | Vector Signed Horizontal Add (doubleword)                |
+ * | HSUB_U.H      | Vector Unigned Horizontal Add (halfword)                 |
+ * | HSUB_U.W      | Vector Unigned Horizontal Add (word)                     |
+ * | HSUB_U.D      | Vector Unigned Horizontal Add (doubleword)               |
+ * +---------------+----------------------------------------------------------+
+ */
+
+/* TODO: insert Int Add group helpers here */
+
+
+/*
+ * Int Average
+ * -----------
+ *
+ * +---------------+----------------------------------------------------------+
+ * | AVE_S.B       | Vector Signed Average (byte)                             |
+ * | AVE_S.H       | Vector Signed Average (halfword)                         |
+ * | AVE_S.W       | Vector Signed Average (word)                             |
+ * | AVE_S.D       | Vector Signed Average (doubleword)                       |
+ * | AVE_U.B       | Vector Unsigned Average (byte)                           |
+ * | AVE_U.H       | Vector Unsigned Average (halfword)                       |
+ * | AVE_U.W       | Vector Unsigned Average (word)                           |
+ * | AVE_U.D       | Vector Unsigned Average (doubleword)                     |
+ * | AVER_S.B      | Vector Signed Average Rounded (byte)                     |
+ * | AVER_S.H      | Vector Signed Average Rounded (halfword)                 |
+ * | AVER_S.W      | Vector Signed Average Rounded (word)                     |
+ * | AVER_S.D      | Vector Signed Average Rounded (doubleword)               |
+ * | AVER_U.B      | Vector Unsigned Average Rounded (byte)                   |
+ * | AVER_U.H      | Vector Unsigned Average Rounded (halfword)               |
+ * | AVER_U.W      | Vector Unsigned Average Rounded (word)                   |
+ * | AVER_U.D      | Vector Unsigned Average Rounded (doubleword)             |
+ * +---------------+----------------------------------------------------------+
+ */
+
+/* TODO: insert Int Average group helpers here */
+
+
+/*
+ * Int Compare
+ * -----------
+ *
+ * +---------------+----------------------------------------------------------+
+ * | CEQ.B         | Vector Compare Equal (byte)                              |
+ * | CEQ.H         | Vector Compare Equal (halfword)                          |
+ * | CEQ.W         | Vector Compare Equal (word)                              |
+ * | CEQ.D         | Vector Compare Equal (doubleword)                        |
+ * | CLE_S.B       | Vector Compare Signed Less Than or Equal (byte)          |
+ * | CLE_S.H       | Vector Compare Signed Less Than or Equal (halfword)      |
+ * | CLE_S.W       | Vector Compare Signed Less Than or Equal (word)          |
+ * | CLE_S.D       | Vector Compare Signed Less Than or Equal (doubleword)    |
+ * | CLE_U.B       | Vector Compare Unsigned Less Than or Equal (byte)        |
+ * | CLE_U.H       | Vector Compare Unsigned Less Than or Equal (halfword)    |
+ * | CLE_U.W       | Vector Compare Unsigned Less Than or Equal (word)        |
+ * | CLE_U.D       | Vector Compare Unsigned Less Than or Equal (doubleword)  |
+ * | CLT_S.B       | Vector Compare Signed Less Than (byte)                   |
+ * | CLT_S.H       | Vector Compare Signed Less Than (halfword)               |
+ * | CLT_S.W       | Vector Compare Signed Less Than (word)                   |
+ * | CLT_S.D       | Vector Compare Signed Less Than (doubleword)             |
+ * | CLT_U.B       | Vector Compare Unsigned Less Than (byte)                 |
+ * | CLT_U.H       | Vector Compare Unsigned Less Than (halfword)             |
+ * | CLT_U.W       | Vector Compare Unsigned Less Than (word)                 |
+ * | CLT_U.D       | Vector Compare Unsigned Less Than (doubleword)           |
+ * +---------------+----------------------------------------------------------+
+ */
+
+/* TODO: insert Int Compare group helpers here */
+
+
+/*
+ * Int Divide
+ * ----------
+ *
+ * +---------------+----------------------------------------------------------+
+ * | DIV_S.B       | Vector Signed Divide (byte)                              |
+ * | DIV_S.H       | Vector Signed Divide (halfword)                          |
+ * | DIV_S.W       | Vector Signed Divide (word)                              |
+ * | DIV_S.D       | Vector Signed Divide (doubleword)                        |
+ * | DIV_U.B       | Vector Unsigned Divide (byte)                            |
+ * | DIV_U.H       | Vector Unsigned Divide (halfword)                        |
+ * | DIV_U.W       | Vector Unsigned Divide (word)                            |
+ * | DIV_U.D       | Vector Unsigned Divide (doubleword)                      |
+ * +---------------+----------------------------------------------------------+
+ */
+
+/* TODO: insert Int Divide group helpers here */
+
+
+/*
+ * Int Dot Product
+ * ---------------
+ *
+ * +---------------+----------------------------------------------------------+
+ * | DOTP_S.H      | Vector Signed Dot Product (halfword)                     |
+ * | DOTP_S.W      | Vector Signed Dot Product (word)                         |
+ * | DOTP_S.D      | Vector Signed Dot Product (doubleword)                   |
+ * | DOTP_U.H      | Vector Unsigned Dot Product (halfword)                   |
+ * | DOTP_U.W      | Vector Unsigned Dot Product (word)                       |
+ * | DOTP_U.D      | Vector Unsigned Dot Product (doubleword)                 |
+ * +---------------+----------------------------------------------------------+
+ */
+
+/* TODO: insert Int Dot Product group helpers here */
+
+
+/*
+ * Int Max Min
+ * -----------
+ *
+ * +---------------+----------------------------------------------------------+
+ * | MAX_A.B       | Vector Maximum Based on Absolute Value (byte)            |
+ * | MAX_A.H       | Vector Maximum Based on Absolute Value (halfword)        |
+ * | MAX_A.W       | Vector Maximum Based on Absolute Value (word)            |
+ * | MAX_A.D       | Vector Maximum Based on Absolute Value (doubleword)      |
+ * | MAX_S.B       | Vector Signed Maximum (byte)                             |
+ * | MAX_S.H       | Vector Signed Maximum (halfword)                         |
+ * | MAX_S.W       | Vector Signed Maximum (word)                             |
+ * | MAX_S.D       | Vector Signed Maximum (doubleword)                       |
+ * | MAX_U.B       | Vector Unsigned Maximum (byte)                           |
+ * | MAX_U.H       | Vector Unsigned Maximum (halfword)                       |
+ * | MAX_U.W       | Vector Unsigned Maximum (word)                           |
+ * | MAX_U.D       | Vector Unsigned Maximum (doubleword)                     |
+ * | MIN_A.B       | Vector Minimum Based on Absolute Value (byte)            |
+ * | MIN_A.H       | Vector Minimum Based on Absolute Value (halfword)        |
+ * | MIN_A.W       | Vector Minimum Based on Absolute Value (word)            |
+ * | MIN_A.D       | Vector Minimum Based on Absolute Value (doubleword)      |
+ * | MIN_S.B       | Vector Signed Minimum (byte)                             |
+ * | MIN_S.H       | Vector Signed Minimum (halfword)                         |
+ * | MIN_S.W       | Vector Signed Minimum (word)                             |
+ * | MIN_S.D       | Vector Signed Minimum (doubleword)                       |
+ * | MIN_U.B       | Vector Unsigned Minimum (byte)                           |
+ * | MIN_U.H       | Vector Unsigned Minimum (halfword)                       |
+ * | MIN_U.W       | Vector Unsigned Minimum (word)                           |
+ * | MIN_U.D       | Vector Unsigned Minimum (doubleword)                     |
+ * +---------------+----------------------------------------------------------+
+ */
+
+/* TODO: insert Int Max Min group helpers here */
+
+
+/*
+ * Int Modulo
+ * ----------
+ *
+ * +---------------+----------------------------------------------------------+
+ * | MOD_S.B       | Vector Signed Modulo (byte)                              |
+ * | MOD_S.H       | Vector Signed Modulo (halfword)                          |
+ * | MOD_S.W       | Vector Signed Modulo (word)                              |
+ * | MOD_S.D       | Vector Signed Modulo (doubleword)                        |
+ * | MOD_U.B       | Vector Unsigned Modulo (byte)                            |
+ * | MOD_U.H       | Vector Unsigned Modulo (halfword)                        |
+ * | MOD_U.W       | Vector Unsigned Modulo (word)                            |
+ * | MOD_U.D       | Vector Unsigned Modulo (doubleword)                      |
+ * +---------------+----------------------------------------------------------+
+ */
+
+/* TODO: insert Int Modulo group helpers here */
+
+
+/*
+ * Int Multiply
+ * ------------
+ *
+ * +---------------+----------------------------------------------------------+
+ * | MADDV.B       | Vector Multiply and Add (byte)                           |
+ * | MADDV.H       | Vector Multiply and Add (halfword)                       |
+ * | MADDV.W       | Vector Multiply and Add (word)                           |
+ * | MADDV.D       | Vector Multiply and Add (doubleword)                     |
+ * | MSUBV.B       | Vector Multiply and Subtract (byte)                      |
+ * | MSUBV.H       | Vector Multiply and Subtract (halfword)                  |
+ * | MSUBV.W       | Vector Multiply and Subtract (word)                      |
+ * | MSUBV.D       | Vector Multiply and Subtract (doubleword)                |
+ * | MULV.B        | Vector Multiply (byte)                                   |
+ * | MULV.H        | Vector Multiply (halfword)                               |
+ * | MULV.W        | Vector Multiply (word)                                   |
+ * | MULV.D        | Vector Multiply (doubleword)                             |
+ * +---------------+----------------------------------------------------------+
+ */
+
+/* TODO: insert Int Multiply group helpers here */
+
+
+/*
+ * Int Subtract
+ * ------------
+ *
+ * +---------------+----------------------------------------------------------+
+ * | ASUB_S.B      | Vector Absolute Values of Signed Subtract (byte)         |
+ * | ASUB_S.H      | Vector Absolute Values of Signed Subtract (halfword)     |
+ * | ASUB_S.W      | Vector Absolute Values of Signed Subtract (word)         |
+ * | ASUB_S.D      | Vector Absolute Values of Signed Subtract (doubleword)   |
+ * | ASUB_U.B      | Vector Absolute Values of Unsigned Subtract (byte)       |
+ * | ASUB_U.H      | Vector Absolute Values of Unsigned Subtract (halfword)   |
+ * | ASUB_U.W      | Vector Absolute Values of Unsigned Subtract (word)       |
+ * | ASUB_U.D      | Vector Absolute Values of Unsigned Subtract (doubleword) |
+ * | HSUB_S.H      | Vector Signed Horizontal Subtract (halfword)             |
+ * | HSUB_S.W      | Vector Signed Horizontal Subtract (word)                 |
+ * | HSUB_S.D      | Vector Signed Horizontal Subtract (doubleword)           |
+ * | HSUB_U.H      | Vector Unigned Horizontal Subtract (halfword)            |
+ * | HSUB_U.W      | Vector Unigned Horizontal Subtract (word)                |
+ * | HSUB_U.D      | Vector Unigned Horizontal Subtract (doubleword)          |
+ * | SUBS_S.B      | Vector Signed Saturated Subtract (of Signed) (byte)      |
+ * | SUBS_S.H      | Vector Signed Saturated Subtract (of Signed) (halfword)  |
+ * | SUBS_S.W      | Vector Signed Saturated Subtract (of Signed) (word)      |
+ * | SUBS_S.D      | Vector Signed Saturated Subtract (of Signed) (doubleword)|
+ * | SUBS_U.B      | Vector Unsigned Saturated Subtract (of Uns.) (byte)      |
+ * | SUBS_U.H      | Vector Unsigned Saturated Subtract (of Uns.) (halfword)  |
+ * | SUBS_U.W      | Vector Unsigned Saturated Subtract (of Uns.) (word)      |
+ * | SUBS_U.D      | Vector Unsigned Saturated Subtract (of Uns.) (doubleword)|
+ * | SUBSUS_S.B    | Vector Uns. Sat. Subtract (of S. from Uns.) (byte)       |
+ * | SUBSUS_S.H    | Vector Uns. Sat. Subtract (of S. from Uns.) (halfword)   |
+ * | SUBSUS_S.W    | Vector Uns. Sat. Subtract (of S. from Uns.) (word)       |
+ * | SUBSUS_S.D    | Vector Uns. Sat. Subtract (of S. from Uns.) (doubleword) |
+ * | SUBSUU_U.B    | Vector Signed Saturated Subtract (of Uns.) (byte)        |
+ * | SUBSUU_U.H    | Vector Signed Saturated Subtract (of Uns.) (halfword)    |
+ * | SUBSUU_U.W    | Vector Signed Saturated Subtract (of Uns.) (word)        |
+ * | SUBSUU_U.D    | Vector Signed Saturated Subtract (of Uns.) (doubleword)  |
+ * | SUBV.B        | Vector Subtract (byte)                                   |
+ * | SUBV.H        | Vector Subtract (halfword)                               |
+ * | SUBV.W        | Vector Subtract (word)                                   |
+ * | SUBV.D        | Vector Subtract (doubleword)                             |
+ * +---------------+----------------------------------------------------------+
+ */
+
+/* TODO: insert Int Subtract group helpers here */
+
+
+/*
+ * Interleave
+ * ----------
+ *
+ * +---------------+----------------------------------------------------------+
+ * | ILVEV.B       | Vector Interleave Even (byte)                            |
+ * | ILVEV.H       | Vector Interleave Even (halfword)                        |
+ * | ILVEV.W       | Vector Interleave Even (word)                            |
+ * | ILVEV.D       | Vector Interleave Even (doubleword)                      |
+ * | ILVOD.B       | Vector Interleave Odd (byte)                             |
+ * | ILVOD.H       | Vector Interleave Odd (halfword)                         |
+ * | ILVOD.W       | Vector Interleave Odd (word)                             |
+ * | ILVOD.D       | Vector Interleave Odd (doubleword)                       |
+ * | ILVL.B        | Vector Interleave Left (byte)                            |
+ * | ILVL.H        | Vector Interleave Left (halfword)                        |
+ * | ILVL.W        | Vector Interleave Left (word)                            |
+ * | ILVL.D        | Vector Interleave Left (doubleword)                      |
+ * | ILVR.B        | Vector Interleave Right (byte)                           |
+ * | ILVR.H        | Vector Interleave Right (halfword)                       |
+ * | ILVR.W        | Vector Interleave Right (word)                           |
+ * | ILVR.D        | Vector Interleave Right (doubleword)                     |
+ * +---------------+----------------------------------------------------------+
+ */
+
+/* TODO: insert Interleave group helpers here */
+
+
+/*
+ * Logic
+ * -----
+ *
+ * +---------------+----------------------------------------------------------+
+ * | AND.V         | Vector Logical And                                       |
+ * | NOR.V         | Vector Logical Negated Or                                |
+ * | OR.V          | Vector Logical Or                                        |
+ * | XOR.V         | Vector Logical Exclusive Or                              |
+ * +---------------+----------------------------------------------------------+
+ */
+
+/* TODO: insert Logic group helpers here */
+
+
+/*
+ * Pack
+ * ----
+ *
+ * +---------------+----------------------------------------------------------+
+ * | PCKEV.B       | Vector Pack Even (byte)                                  |
+ * | PCKEV.H       | Vector Pack Even (halfword)                              |
+ * | PCKEV.W       | Vector Pack Even (word)                                  |
+ * | PCKEV.D       | Vector Pack Even (doubleword)                            |
+ * | PCKOD.B       | Vector Pack Odd (byte)                                   |
+ * | PCKOD.H       | Vector Pack Odd (halfword)                               |
+ * | PCKOD.W       | Vector Pack Odd (word)                                   |
+ * | PCKOD.D       | Vector Pack Odd (doubleword)                             |
+ * | VSHF.B        | Vector Data Preserving Shuffle (byte)                    |
+ * | VSHF.H        | Vector Data Preserving Shuffle (halfword)                |
+ * | VSHF.W        | Vector Data Preserving Shuffle (word)                    |
+ * | VSHF.D        | Vector Data Preserving Shuffle (doubleword)              |
+ * +---------------+----------------------------------------------------------+
+ */
+
+/* TODO: insert Pack group helpers here */
+
+
+/*
+ * Shift
+ * -----
+ *
+ * +---------------+----------------------------------------------------------+
+ * | SLL.B         | Vector Shift Left (byte)                                 |
+ * | SLL.H         | Vector Shift Left (halfword)                             |
+ * | SLL.W         | Vector Shift Left (word)                                 |
+ * | SLL.D         | Vector Shift Left (doubleword)                           |
+ * | SRA.B         | Vector Shift Right Arithmetic (byte)                     |
+ * | SRA.H         | Vector Shift Right Arithmetic (halfword)                 |
+ * | SRA.W         | Vector Shift Right Arithmetic (word)                     |
+ * | SRA.D         | Vector Shift Right Arithmetic (doubleword)               |
+ * | SRAR.B        | Vector Shift Right Arithmetic Rounded (byte)             |
+ * | SRAR.H        | Vector Shift Right Arithmetic Rounded (halfword)         |
+ * | SRAR.W        | Vector Shift Right Arithmetic Rounded (word)             |
+ * | SRAR.D        | Vector Shift Right Arithmetic Rounded (doubleword)       |
+ * | SRL.B         | Vector Shift Right Logical (byte)                        |
+ * | SRL.H         | Vector Shift Right Logical (halfword)                    |
+ * | SRL.W         | Vector Shift Right Logical (word)                        |
+ * | SRL.D         | Vector Shift Right Logical (doubleword)                  |
+ * | SRLR.B        | Vector Shift Right Logical Rounded (byte)                |
+ * | SRLR.H        | Vector Shift Right Logical Rounded (halfword)            |
+ * | SRLR.W        | Vector Shift Right Logical Rounded (word)                |
+ * | SRLR.D        | Vector Shift Right Logical Rounded (doubleword)          |
+ * +---------------+----------------------------------------------------------+
+ */
+
+/* TODO: insert Shift group helpers here */
+
+
 static inline void msa_move_v(wr_t *pwd, wr_t *pws)
 {
     uint32_t i;
-- 
2.7.4



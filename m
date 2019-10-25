Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E706CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:16:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 240E82070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240E82070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO2GJ-0000UG-HD
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 12:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.rikalo@rt-rk.com>) id 1iO22w-0007pt-Lg
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:02:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.rikalo@rt-rk.com>) id 1iO22u-0001tx-Rp
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:02:38 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:38425 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.rikalo@rt-rk.com>)
 id 1iO22u-0001tk-Gl
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:02:36 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 606E11A2240;
 Fri, 25 Oct 2019 18:02:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from [10.10.14.141] (rtrkw304-lin.domain.local [10.10.14.141])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 41DF81A2090;
 Fri, 25 Oct 2019 18:02:34 +0200 (CEST)
Subject: Re: [PATCH v7 14/14] target/mips: Demacro LMI decoder
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1571826227-10583-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1571826227-10583-15-git-send-email-aleksandar.markovic@rt-rk.com>
From: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Message-ID: <b5495e17-8589-e07f-e3b3-3b401abae433@rt-rk.com>
Date: Fri, 25 Oct 2019 18:02:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1571826227-10583-15-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 > From: Aleksandar Markovic <amarkovic@wavecomp.com>
 >
 > This makes searches for instances of opcode usages easier.
 >
 > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
 > ---
 >=C2=A0 target/mips/translate.c | 247=20
+++++++++++++++++++++++++++++++++---------------
 >=C2=A0 1 file changed, 173 insertions(+), 74 deletions(-)
 >
 > diff --git a/target/mips/translate.c b/target/mips/translate.c
 > index b8e2707..36f57b1 100644
 > --- a/target/mips/translate.c
 > +++ b/target/mips/translate.c
 > @@ -5548,78 +5548,180 @@ static void=20
gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_load_fpr64(ctx, t0, rs);
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_load_fpr64(ctx, t1, rt);
 >
 > -#define LMI_HELPER(UP, LO) \
 > -=C2=A0=C2=A0=C2=A0 case OPC_##UP: gen_helper_##LO(t0, t0, t1); break
 > -#define LMI_HELPER_1(UP, LO) \
 > -=C2=A0=C2=A0=C2=A0 case OPC_##UP: gen_helper_##LO(t0, t0); break
 > -#define LMI_DIRECT(UP, LO, OP) \
 > -=C2=A0=C2=A0=C2=A0 case OPC_##UP: tcg_gen_##OP##_i64(t0, t0, t1); bre=
ak
 > -
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (opc) {
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PADDSH, paddsh);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PADDUSH, paddush);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PADDH, paddh);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PADDW, paddw);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PADDSB, paddsb);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PADDUSB, paddusb);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PADDB, paddb);
 > -
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PSUBSH, psubsh);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PSUBUSH, psubush);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PSUBH, psubh);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PSUBW, psubw);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PSUBSB, psubsb);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PSUBUSB, psubusb);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PSUBB, psubb);
 > -
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PSHUFH, pshufh);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PACKSSWH, packsswh);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PACKSSHB, packsshb);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PACKUSHB, packushb);
 > -
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PUNPCKLHW, punpcklhw);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PUNPCKHHW, punpckhhw);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PUNPCKLBH, punpcklbh);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PUNPCKHBH, punpckhbh);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PUNPCKLWD, punpcklwd);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PUNPCKHWD, punpckhwd);
 > -
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PAVGH, pavgh);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PAVGB, pavgb);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PMAXSH, pmaxsh);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PMINSH, pminsh);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PMAXUB, pmaxub);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PMINUB, pminub);
 > -
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PCMPEQW, pcmpeqw);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PCMPGTW, pcmpgtw);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PCMPEQH, pcmpeqh);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PCMPGTH, pcmpgth);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PCMPEQB, pcmpeqb);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PCMPGTB, pcmpgtb);
 > -
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PSLLW, psllw);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PSLLH, psllh);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PSRLW, psrlw);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PSRLH, psrlh);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PSRAW, psraw);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PSRAH, psrah);
 > -
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PMULLH, pmullh);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PMULHH, pmulhh);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PMULHUH, pmulhuh);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PMADDHW, pmaddhw);
 > -
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER(PASUBUB, pasubub);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER_1(BIADD, biadd);
 > -=C2=A0=C2=A0=C2=A0 LMI_HELPER_1(PMOVMSKB, pmovmskb);
 > -
 > -=C2=A0=C2=A0=C2=A0 LMI_DIRECT(PADDD, paddd, add);
 > -=C2=A0=C2=A0=C2=A0 LMI_DIRECT(PSUBD, psubd, sub);
 > -=C2=A0=C2=A0=C2=A0 LMI_DIRECT(XOR_CP2, xor, xor);
 > -=C2=A0=C2=A0=C2=A0 LMI_DIRECT(NOR_CP2, nor, nor);
 > -=C2=A0=C2=A0=C2=A0 LMI_DIRECT(AND_CP2, and, and);
 > -=C2=A0=C2=A0=C2=A0 LMI_DIRECT(OR_CP2, or, or);
 > +=C2=A0=C2=A0=C2=A0 case OPC_PADDSH:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_paddsh(t0, t0, =
t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PADDUSH:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_paddush(t0, t0,=
 t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PADDH:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_paddh(t0, t0, t=
1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PADDW:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_paddw(t0, t0, t=
1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PADDSB:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_paddsb(t0, t0, =
t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PADDUSB:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_paddusb(t0, t0,=
 t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PADDB:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_paddb(t0, t0, t=
1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +
 > +=C2=A0=C2=A0=C2=A0 case OPC_PSUBSH: gen_helper_psubsh(t0, t0, t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PSUBUSH:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_psubush(t0, t0,=
 t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PSUBH:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_psubh(t0, t0, t=
1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PSUBW:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_psubw(t0, t0, t=
1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PSUBSB:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_psubsb(t0, t0, =
t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PSUBUSB:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_psubusb(t0, t0,=
 t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PSUBB:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_psubb(t0, t0, t=
1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +
 > +=C2=A0=C2=A0=C2=A0 case OPC_PSHUFH:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_pshufh(t0, t0, =
t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PACKSSWH:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_packsswh(t0, t0=
, t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PACKSSHB:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_packsshb(t0, t0=
, t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PACKUSHB:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_packushb(t0, t0=
, t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +
 > +=C2=A0=C2=A0=C2=A0 case OPC_PUNPCKLHW:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_punpcklhw(t0, t=
0, t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PUNPCKHHW:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_punpckhhw(t0, t=
0, t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PUNPCKLBH:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_punpcklbh(t0, t=
0, t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PUNPCKHBH:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_punpckhbh(t0, t=
0, t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PUNPCKLWD:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_punpcklwd(t0, t=
0, t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PUNPCKHWD:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_punpckhwd(t0, t=
0, t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +
 > +=C2=A0=C2=A0=C2=A0 case OPC_PAVGH:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_pavgh(t0, t0, t=
1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PAVGB:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_pavgb(t0, t0, t=
1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PMAXSH:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_pmaxsh(t0, t0, =
t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PMINSH:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_pminsh(t0, t0, =
t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PMAXUB:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_pmaxub(t0, t0, =
t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PMINUB:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_pminub(t0, t0, =
t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +
 > +=C2=A0=C2=A0=C2=A0 case OPC_PCMPEQW:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_pcmpeqw(t0, t0,=
 t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PCMPGTW:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_pcmpgtw(t0, t0,=
 t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PCMPEQH:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_pcmpeqh(t0, t0,=
 t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PCMPGTH:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_pcmpgth(t0, t0,=
 t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PCMPEQB:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_pcmpeqb(t0, t0,=
 t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PCMPGTB:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_pcmpgtb(t0, t0,=
 t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +
 > +=C2=A0=C2=A0=C2=A0 case OPC_PSLLW:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_psllw(t0, t0, t=
1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PSLLH:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_psllh(t0, t0, t=
1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PSRLW:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_psrlw(t0, t0, t=
1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PSRLH:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_psrlh(t0, t0, t=
1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PSRAW:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_psraw(t0, t0, t=
1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PSRAH:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_psrah(t0, t0, t=
1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +
 > +=C2=A0=C2=A0=C2=A0 case OPC_PMULLH:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_pmullh(t0, t0, =
t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PMULHH:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_pmulhh(t0, t0, =
t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PMULHUH:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_pmulhuh(t0, t0,=
 t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PMADDHW:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_pmaddhw(t0, t0,=
 t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +
 > +=C2=A0=C2=A0=C2=A0 case OPC_PASUBUB:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_pasubub(t0, t0,=
 t1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_BIADD:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_biadd(t0, t0);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PMOVMSKB:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_pmovmskb(t0, t0=
);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +
 > +=C2=A0=C2=A0=C2=A0 case OPC_PADDD:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcg_gen_add_i64(t0, t0, t1=
);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_PSUBD:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcg_gen_sub_i64(t0, t0, t1=
);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_XOR_CP2:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcg_gen_xor_i64(t0, t0, t1=
);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_NOR_CP2:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcg_gen_nor_i64(t0, t0, t1=
);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_AND_CP2:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcg_gen_and_i64(t0, t0, t1=
);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case OPC_OR_CP2:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcg_gen_or_i64(t0, t0, t1)=
;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 >
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case OPC_PANDN:
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcg_gen_andc_i64=
(t0, t1, t0);
 > @@ -5772,9 +5874,6 @@ static void=20
gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 >
 > -#undef LMI_HELPER
 > -#undef LMI_DIRECT
 > -
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_store_fpr64(ctx, t0, rd);
 >
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcg_temp_free_i64(t0);

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>



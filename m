Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4857C48BD9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 17:29:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE2142133F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 17:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2142133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgYCq-0003zP-VX
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 13:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34280)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hgYBQ-0002yb-RT
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 13:27:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hgYBP-0007pA-OO
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 13:27:40 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:36274
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hgYBN-0006Vz-W1
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 13:27:39 -0400
Received: from host86-173-229-95.range86-173.btcentralplus.com
 ([86.173.229.95] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hgY7m-0007HL-RW; Thu, 27 Jun 2019 18:23:55 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190519041522.12327-1-richard.henderson@linaro.org>
 <8f28d008-2608-a579-7505-4546b08deb41@linaro.org>
 <085d6881-f518-9888-a13e-081cdc09de46@ilande.co.uk>
 <0b9f4772-37f6-1453-e4ea-5ad9d0f52a5b@ilande.co.uk>
 <acc57487-c8a0-9380-bc2a-4de22541eabf@ilande.co.uk>
 <CAL1e-=iavFqEeFuNm2efVM7mu5OaABBVo90wqJEhmoWa4DQv=Q@mail.gmail.com>
 <ffae3651-5daf-e008-6562-2de09d82ace9@linaro.org>
 <b8aab3f4-e3eb-a137-62b4-ba5ac1a2ad8f@ilande.co.uk>
 <68facefc-b801-4902-11c0-4542662bfc4e@linaro.org>
 <d2c1f979-7ff2-946e-4863-c1be19c5f003@ilande.co.uk>
 <16f26b7f-2435-aa05-66a3-073e8310d5c8@linaro.org>
 <0ceec012-fcdc-ccde-291a-121a4e475f86@ilande.co.uk>
 <7b1699e1-28ca-a58f-787e-c0ca11666b90@linaro.org>
 <9502af13-22b9-031e-2ba9-ec4ff75ccd0e@ilande.co.uk>
Openpgp: preference=signencrypt
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <cd1a0635-5b5d-3c2d-dec3-4ceda8c789f9@ilande.co.uk>
Date: Thu, 27 Jun 2019 18:24:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <9502af13-22b9-031e-2ba9-ec4ff75ccd0e@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.173.229.95
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: Re: [Qemu-devel] [PATCH v4 0/7] tcg/ppc: Add vector opcodes
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
Cc: Howard Spoelstra <hsp.cat7@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/06/2019 20:38, Mark Cave-Ayland wrote:

>> But I thought that _CALL_AIX was only defined for ppc64 elf version 1.  I
>> thought that ppc32 used _CALL_SYSV instead.  Certainly that's what is used
>> elsewhere...
> 
> No, that didn't work either. I've confirmed using #ifdef _CALL_AIX #error ERROR
> #endif that _CALL_AIX is *NOT* defined and _CALL_SYSV *is* defined.
> 
> I've also tried removing TCG_REG_R2 from tcg_target_reg_alloc_order[] and
> tcg_regset_set_reg() for TCG_REG_R2 from tcg_target_init() and I'm still generating
> bad code that writes to r2(!).
> 
> Since I can't find any other mentions of TCG_REG_TMP1 and TCG_REG_R2 that isn't
> inside an #ifdef _CALL_AIX ... #endif section I'm starting to get stuck. Is there any
> chance that the R_PPC_ADDR32 change could be causing this at all?

So after a lot more digging: the issue can be seen in tcg_out_ld() and tcg_out_st()
for the vector registers. Taking tcg_out_ld() as an example:

    case TCG_TYPE_V128:
        tcg_debug_assert(ret >= 32);
        assert((offset & 15) == 0);
        tcg_out_mem_long(s, 0, LVX, ret & 31, base, offset);
        break;

For the TCG_TYPE_V128 case we have ret = TCG_REG_V2 but (ret & 31) masks off the top
bit which converts this to TCG_REG_R2 and that's why tcg_out_mem_long() starts using
r2 to calculate offsets.

Assuming that rt is the temporary register used to calculate the address then the
patch below tentatively appears to get things working again by passing in
TCG_REG_TMP1 instead, but ultimately I still see a crash much later when trying to
boot MacOS 9:

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 61732c1f45..dd823447cc 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -1139,7 +1139,7 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
     case TCG_TYPE_V64:
         tcg_debug_assert(ret >= 32);
         assert((offset & 7) == 0);
-        tcg_out_mem_long(s, 0, LVX, ret & 31, base, offset & -16);
+        tcg_out_mem_long(s, 0, LVX, TCG_REG_TMP1, base, offset & -16);
         if (offset & 8) {
             tcg_out_vsldoi(s, ret, ret, ret, 8);
         }
@@ -1147,7 +1147,7 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
     case TCG_TYPE_V128:
         tcg_debug_assert(ret >= 32);
         assert((offset & 15) == 0);
-        tcg_out_mem_long(s, 0, LVX, ret & 31, base, offset);
+        tcg_out_mem_long(s, 0, LVX, TCG_REG_TMP1, base, offset);
         break;
     default:
         g_assert_not_reached();
@@ -1186,12 +1186,13 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
             tcg_out_vsldoi(s, TCG_VEC_TMP1, arg, arg, 8);
             arg = TCG_VEC_TMP1;
         }
-        tcg_out_mem_long(s, 0, STVEWX, arg & 31, base, offset);
-        tcg_out_mem_long(s, 0, STVEWX, arg & 31, base, offset + 4);
+        tcg_out_mem_long(s, 0, STVEWX, TCG_REG_TMP1, base, offset);
+        tcg_out_mem_long(s, 0, STVEWX, TCG_REG_TMP1, base, offset + 4);
         break;
     case TCG_TYPE_V128:
         tcg_debug_assert(arg >= 32);
-        tcg_out_mem_long(s, 0, STVX, arg & 31, base, offset);
+        assert((offset & 15) == 0);
+        tcg_out_mem_long(s, 0, STVX, TCG_REG_TMP1, base, offset);
         break;
     default:
         g_assert_not_reached();

Richard: even though it's still not perfect, does this look like it's fixing the
right problem? Presumably the reason this didn't break on your Power 9 box is because
the 64-bit ABI doesn't mark r2 as reserved?


ATB,

Mark.


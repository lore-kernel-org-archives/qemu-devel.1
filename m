Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A3CC31E49
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 07:45:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20FB62133D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 07:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20FB62133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37934 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcPqj-00034n-Hp
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 03:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50944)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hcPpp-0002Za-3w
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 03:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hcPpn-0008SB-5W
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 03:44:17 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:46090
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hcPpl-0005zk-6x; Sun, 16 Jun 2019 03:44:14 -0400
Received: from host86-173-229-95.range86-173.btcentralplus.com
 ([86.173.229.95] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hcPmJ-0000zu-3f; Sun, 16 Jun 2019 08:40:39 +0100
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190602110903.3431-1-mark.cave-ayland@ilande.co.uk>
 <20190602110903.3431-3-mark.cave-ayland@ilande.co.uk>
 <20190612010459.GD3998@umbus.fritz.box>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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
Message-ID: <412e0398-fabf-9f6e-481f-ba2bea148d28@ilande.co.uk>
Date: Sun, 16 Jun 2019 08:40:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190612010459.GD3998@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 86.173.229.95
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: Re: [Qemu-devel] [PATCH v2 02/15] target/ppc: remove
 getVSR()/putVSR() from mem_helper.c
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
Cc: gkurz@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/06/2019 02:04, David Gibson wrote:

> On Sun, Jun 02, 2019 at 12:08:50PM +0100, Mark Cave-Ayland wrote:
>> Since commit 8a14d31b00 "target/ppc: switch fpr/vsrl registers so all VSX
>> registers are in host endian order" functions getVSR() and putVSR() which used
>> to convert the VSR registers into host endian order are no longer required.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  target/ppc/mem_helper.c | 25 ++++++++++++++-----------
>>  1 file changed, 14 insertions(+), 11 deletions(-)
>>
>> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
>> index 5b0f9ee50d..17a3c931a9 100644
>> --- a/target/ppc/mem_helper.c
>> +++ b/target/ppc/mem_helper.c
>> @@ -417,26 +417,27 @@ STVE(stvewx, cpu_stl_data_ra, bswap32, u32)
>>  void helper_##name(CPUPPCState *env, target_ulong addr,                 \
>>                     target_ulong xt_num, target_ulong rb)                \
>>  {                                                                       \
>> -    int i;                                                              \
>> -    ppc_vsr_t xt;                                                       \
>> +    ppc_vsr_t *xt = &env->vsr[xt_num];                                  \
>> +    ppc_vsr_t t;                                                        \
>>      uint64_t nb = GET_NB(rb);                                           \
>> +    int i;                                                              \
>>                                                                          \
>> -    xt.s128 = int128_zero();                                            \
>> +    t.s128 = int128_zero();                                             \
>>      if (nb) {                                                           \
>>          nb = (nb >= 16) ? 16 : nb;                                      \
>>          if (msr_le && !lj) {                                            \
>>              for (i = 16; i > 16 - nb; i--) {                            \
>> -                xt.VsrB(i - 1) = cpu_ldub_data_ra(env, addr, GETPC());  \
>> +                t.VsrB(i - 1) = cpu_ldub_data_ra(env, addr, GETPC());   \
>>                  addr = addr_add(env, addr, 1);                          \
>>              }                                                           \
>>          } else {                                                        \
>>              for (i = 0; i < nb; i++) {                                  \
>> -                xt.VsrB(i) = cpu_ldub_data_ra(env, addr, GETPC());      \
>> +                t.VsrB(i) = cpu_ldub_data_ra(env, addr, GETPC());       \
>>                  addr = addr_add(env, addr, 1);                          \
>>              }                                                           \
>>          }                                                               \
>>      }                                                                   \
>> -    putVSR(xt_num, &xt, env);                                           \
>> +    *xt = t;                                                            \
>>  }
>>  
>>  VSX_LXVL(lxvl, 0)
>> @@ -447,26 +448,28 @@ VSX_LXVL(lxvll, 1)
>>  void helper_##name(CPUPPCState *env, target_ulong addr,           \
>>                     target_ulong xt_num, target_ulong rb)          \
>>  {                                                                 \
>> -    int i;                                                        \
>> -    ppc_vsr_t xt;                                                 \
>> +    ppc_vsr_t *xt = &env->vsr[xt_num];                            \
>> +    ppc_vsr_t t = *xt;                                            \
>>      target_ulong nb = GET_NB(rb);                                 \
>> +    int i;                                                        \
>>                                                                    \
>>      if (!nb) {                                                    \
>>          return;                                                   \
>>      }                                                             \
>> -    getVSR(xt_num, &xt, env);                                     \
>> +                                                                  \
>>      nb = (nb >= 16) ? 16 : nb;                                    \
>>      if (msr_le && !lj) {                                          \
>>          for (i = 16; i > 16 - nb; i--) {                          \
>> -            cpu_stb_data_ra(env, addr, xt.VsrB(i - 1), GETPC());  \
>> +            cpu_stb_data_ra(env, addr, t.VsrB(i - 1), GETPC());   \
>>              addr = addr_add(env, addr, 1);                        \
>>          }                                                         \
>>      } else {                                                      \
>>          for (i = 0; i < nb; i++) {                                \
>> -            cpu_stb_data_ra(env, addr, xt.VsrB(i), GETPC());      \
>> +            cpu_stb_data_ra(env, addr, t.VsrB(i), GETPC())  ;     \
>>              addr = addr_add(env, addr, 1);                        \
>>          }                                                         \
>>      }                                                             \
>> +    *xt = t;                                                      \
> 
> Is this correct?  AFAICT the original wasn't writing back, so why does
> the new version?

Ooops yes, this shouldn't be here at all. I'll fix it up in the next version of the
series, along with Richard's comments about using the xt pointer directly.

>>  }
>>  
>>  VSX_STXVL(stxvl, 0)


ATB,

Mark.


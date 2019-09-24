Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10365C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:54:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE56720872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE56720872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCthX-000447-OD
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 18:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1iCs2R-0000Uw-0F
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1iCs2P-0006XH-Nn
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:07:58 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:36386
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1iCs2M-0006WB-Tc; Tue, 24 Sep 2019 17:07:55 -0400
Received: from host86-138-245-63.range86-138.btcentralplus.com
 ([86.138.245.63] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1iCs0L-0000oA-V2; Tue, 24 Sep 2019 22:05:50 +0100
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, pc@us.ibm.com, david@gibson.dropbear.id.au
References: <20190924153556.27575-1-mark.cave-ayland@ilande.co.uk>
 <20190924153556.27575-2-mark.cave-ayland@ilande.co.uk>
 <e4e2220b-d23b-aa54-2c46-c937bd0efe86@linaro.org>
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
Message-ID: <e4ba6c27-e57a-de8f-c993-4172db2ea01a@ilande.co.uk>
Date: Tue, 24 Sep 2019 22:05:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e4e2220b-d23b-aa54-2c46-c937bd0efe86@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.138.245.63
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 1/7] target/ppc: introduce get_dfp{64,128}() helper
 functions
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/09/2019 20:21, Richard Henderson wrote:

> On 9/24/19 8:35 AM, Mark Cave-Ayland wrote:
>> +static void get_dfp64(uint64_t *dst, uint64_t *dfp)
>> +{
>> +    dst[0] = dfp[0];
>> +}
>> +
>> +static void get_dfp128(uint64_t *dst, uint64_t *dfp)
>> +{
>> +    dst[0] = dfp[HI_IDX];
>> +    dst[1] = dfp[LO_IDX];
>> +}
> 
> I'm not keen on this.  I would prefer some type difference that prevents you
> from getting the arguments the wrong way around.
> 
> I'm thinking that a combination helper like
> 
> static void get_dfp64(decNumber *out, uint64_t *in)
> {
>     union {
>        uint64_t i;
>        decimal64 d;
>     } u;
> 
>     u.i = *in;
>     decimal64ToNumber(&u.d, out);
> }
> 
>> @@ -129,7 +140,7 @@ static void dfp_prepare_decimal64(struct PPC_DFP *dfp, uint64_t *a,
>>      dfp->env = env;
>>  
>>      if (a) {
>> -        dfp->a64[0] = *a;
>> +        get_dfp64(dfp->a64, a);
>>          decimal64ToNumber((decimal64 *)dfp->a64, &dfp->a);
>>      } else {
>>          dfp->a64[0] = 0;
> 
> becomes
> 
>     get_dfp64(&dfp->a, a);
> 
> and that might clean up a lot of the code.

Right, and in fact I had a similar thought myself regarding type safety since one of
the issues with working with the existing code in dfp_helper.c is that everything
uses a uint64_t * which makes it really difficult to figure out why things are
crashing if you make a typo :/

Note that this patch simply introduces the helpers without making changes to the
existing logic which is why both arguments are still uint64_t *. The real work is
done in patch 3 where ppc_fptr_t type is introduced, and also see the switch from
uint64_t * to ppc_vsr_t in patch 5.

With the full patchset applied you'll see that get_dfp64() and friends are in exactly
the same form you show above, and if I swap the arguments then the compiler does
actually complain, although somewhat cryptically.

>> @@ -617,10 +626,12 @@ uint32_t helper_##op(CPUPPCState *env, uint64_t *a, uint64_t *b)         \
>>  {                                                                        \
>>      struct PPC_DFP dfp;                                                  \
>>      unsigned k;                                                          \
>> +    uint64_t a64;                                                        \
>>                                                                           \
>>      dfp_prepare_decimal##size(&dfp, 0, b, env);                          \
>>                                                                           \
>> -    k = *a & 0x3F;                                                       \
>> +    get_dfp64(&a64, a);                                                  \
>> +    k = a64 & 0x3F;                                                      \
>>                                                                           \
>>      if (unlikely(decNumberIsSpecial(&dfp.b))) {                          \
>>          dfp.crbf = 1;                                                    \
> 
> Whereas cases like this, where a scalar is being passed in, I don't think that
> re-using the same helper is appropriate.  Ideally, they would be passed in by
> value, and not by reference at all.  That, of course, requires changes to the
> translator beyond the scope of this patch.

Agreed. I was really keen to avoid any translator changes if possible since the PPC
translator code tends to be quite tricky which is why I went with the above approach.

>>  void helper_dctqpq(CPUPPCState *env, uint64_t *t, uint64_t *b)
>>  {
>>      struct PPC_DFP dfp;
>> +    uint64_t b64;
>>      dfp_prepare_decimal128(&dfp, 0, 0, env);
>> -    decimal64ToNumber((decimal64 *)b, &dfp.t);
>> +    get_dfp64(&b64, b);
>> +    decimal64ToNumber((decimal64 *)&b64, &dfp.t);
> 
> This would become
> 
>     get_dfp64(&dfp.t, b);
> 
> with no intermediate b64 temp.

Funnily enough that did cross my mind, but I wasn't 100% sure that this wasn't doing
something extra within libdecnumber. If you think it makes sense then I can easily
add it into a v2.


ATB,

Mark.


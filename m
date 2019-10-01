Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E238C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 18:26:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62B32215EA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 18:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B32215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFMrQ-00063H-HF
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 14:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1iFMpM-0004rY-SN
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 14:24:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1iFMpK-00082m-LZ
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 14:24:48 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:47904
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1iFMpK-00082Q-FX; Tue, 01 Oct 2019 14:24:46 -0400
Received: from host86-133-194-221.range86-133.btcentralplus.com
 ([86.133.194.221] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1iFMpb-0007ex-Lx; Tue, 01 Oct 2019 19:25:04 +0100
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <bf30baf5-4d75-dc6f-c30a-57b80714999b@ilande.co.uk>
 <CAL1e-=gcK2mdtrt9vibHGpbm4_FZgQWTA91+p=9ouuMYmZwPqQ@mail.gmail.com>
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
Message-ID: <c9679b01-91c3-3d69-fb38-dfef1602dcf4@ilande.co.uk>
Date: Tue, 1 Oct 2019 19:24:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=gcK2mdtrt9vibHGpbm4_FZgQWTA91+p=9ouuMYmZwPqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.133.194.221
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: target/ppc: bug in optimised vsl/vsr implementation?
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: stefan.brankovic@rt-rk.com, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Paul Clarke <pc@us.ibm.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/09/2019 18:45, Aleksandar Markovic wrote:

Hi Aleksandar,

Thanks for taking a look at this!

> Mark and Paul (and Stefan),
> 
> Thanks for spotting this and pinpointing the culprit commit. I guess Stefan is going
> to respond soon, but, in the meantime, I took a look at the commit in question:
> 
> https://github.com/qemu/qemu/commit/4e6d0920e7547e6af4bbac5ffe9adfe6ea621822
> 
> I don't have at the moment any dev/test environment handy, but I did manual
> inspection of the code, and here is what I found (in order of importance, perceived
> by me):
> 
> 1. The code will not work correctly if the shift ammount (variable 'sh') is 0. This
> is because, in that case, one of succeeding invocations of TCG shift functions will
> be required to shift a 64-bit TCG variable by 64 bits, and the result of such TCG
> operation is undefined (shift amount must be 63 or less) - see
> https://github.com/qemu/qemu/blob/master/tcg/README.

Yes I think you're right here - the old helper got around this by doing an explicit
copy from a to r if the shift value is zero. In fact the case that Paul reported is
exactly this:

   vsl VRT, VRA, VRB

=> 0x100006e0 <vec_slq+132>: vsl v0,v0,v1
(gdb) p $vr0.uint128
$21 = 0x10111213141516172021222324252650
(gdb) p $vr1.uint128
$22 = 0x0
(gdb) stepi
0x00000000100006e4 in vec_slq ()
1: x/i $pc
=> 0x100006e4 <vec_slq+136>: xxlor vs0,vs32,vs32
(gdb) p $vr0.uint128
$23 = 0x10111213141516172021222324252650

I guess the solution is check for sh == 0 and if this is the case, execute a copy
instead.

> 2. Variable naming is better in the old helper than in the new translator. In that
> light, I would advise Stefan to change 'sh' to 'shift', and 'shifted' to 'carry'.

It looks like the name "sh" comes from the ISA documentation, so whilst it's a little
tricky to compare with the previous implementation it does make sense when comparing
with the algorithm shown there. Note: this implementation also drops the check for
each byte of VRB having the same shift value - should we care about this?

> 3. Lines
> 
> tcg_gen_andi_i64(shifted, shifted, 0x7fULL);
> 
> and
> 
> tcg_gen_andi_i64(shifted, shifted, 0xfe00000000000000ULL);
> 
> appear to be spurious (albait in a harmless way). Therefore, they should be deleted,
> or, alternatevely, a justification for them should be provided.

I'm not sure why they are needed either - there's certainly no mention of it in the
ISA documentation. Stefan?

> 4. In the commit message, variable names were used without quotation mark, resulting
> in puzzling and unclear wording.
> 
> 5. (a question for Mark) After all recent changes, does get_avr64(..., ..., true)
> always (for any endian configuration) return the "high" half of an Altivec register,
> and get_avr64(..., ..., false) the "low" one?

Yes - the new functions always return the MSB (high) and LSB (low) correctly
regardless of host endian.

> Given all these circumstances, perhaps the most reasonable solution would be to
> revert the commit in question, and allow Stefan enough dev and test time to hopefully
> submit a new, better, version later on.

Given that it has been broken for 3 months now, I don't think we're in any major rush
to revert ASAP. I'd prefer to give Stefan a bit more time first since he does report
some substantial speed improvements from these new implementations.


ATB,

Mark.


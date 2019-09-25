Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C929BC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 20:45:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BB2821D79
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 20:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB2821D79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDEA6-0006DT-Nj
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 16:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1iDE3w-0002aO-Vd
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 16:39:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1iDE3u-0007PD-Je
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 16:39:00 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:38726
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1iDE3p-0007BU-HO; Wed, 25 Sep 2019 16:38:53 -0400
Received: from host86-138-245-63.range86-138.btcentralplus.com
 ([86.138.245.63] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1iDE2p-00060L-2q; Wed, 25 Sep 2019 21:37:51 +0100
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, pc@us.ibm.com, david@gibson.dropbear.id.au
References: <20190924153556.27575-1-mark.cave-ayland@ilande.co.uk>
 <20190924153556.27575-7-mark.cave-ayland@ilande.co.uk>
 <8a6dcdda-97b6-16f6-a95b-0c53d1e2d215@linaro.org>
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
Message-ID: <9b4860e8-917c-bb0e-4b0e-931f23102584@ilande.co.uk>
Date: Wed, 25 Sep 2019 21:37:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8a6dcdda-97b6-16f6-a95b-0c53d1e2d215@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.138.245.63
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 6/7] target/ppc: use existing VsrD() macro to eliminate
 HI_IDX and LO_IDX from dfp_helper.c
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

On 24/09/2019 22:46, Richard Henderson wrote:

> On 9/24/19 8:35 AM, Mark Cave-Ayland wrote:
>> Switch over all accesses to the decimal numbers held in struct PPC_DFP from
>> using HI_IDX and LO_IDX to using the VsrD() macro instead. Not only does this
>> allow the compiler to ensure that the various dfp_* functions are being passed
>> a ppc_vsr_t rather than an arbitrary uint64_t pointer, but also allows the
>> host endian-specific HI_IDX and LO_IDX to be completely removed from
>> dfp_helper.c.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  target/ppc/dfp_helper.c | 70 ++++++++++++++++++-----------------------
>>  1 file changed, 31 insertions(+), 39 deletions(-)
> 
> Ho hum, vs patch 5 that was me not realizing how many different places really
> want to manipulate a 128-bit value.  Do go ahead and keep ppc_vsr_t for now.

Yes, it's a little bit confusing in places as some operations are done on the
decNumber whilst others are done on the decimal representation. After trying a few
different approaches, using ppc_vsr_t seemed to be the easiest and most readable
solution here.

I see now that you've given R-b tags for patches 3-7, and having slept on it I'm
inclined to leave patches 1-2 as they are now, i.e. no code changes other than
introducing the get/set helpers to help keep the patchset as mechanical as possible.
Do you think that seems a reasonable approach?

> It does look like we might be well served by using Int128 at some point, so
> that these operations can expand to int128_t on appropriate hw so that the
> compiler can DTRT with these.

Certainly ppc_vsr_t already has __uint128_t and Int128 elements but the impression I
got from the #ifdef is that not all compilers would support it? Although having said
that, making such a change is not something that's really on my radar.


ATB,

Mark.


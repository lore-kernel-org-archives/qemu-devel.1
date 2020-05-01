Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62D1C47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:03:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6037206D6
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6037206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUWGY-0008HV-NR
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 10:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jUWFl-0007al-Kt
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:02:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jUWFk-0001Wx-Sr
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:02:57 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:43757)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jUWFk-0001UF-91
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:02:56 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MLQgv-1jn10S3SKJ-00IVIq; Fri, 01 May 2020 16:02:52 +0200
Subject: Re: [PATCH] target/m68k: Allow movec only on 68010+
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
References: <20200114202226.E859E745702@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2005011511210.62443@zero.eik.bme.hu>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <36b52da5-52f3-cc6e-8e76-36646e74c0e0@vivier.eu>
Date: Fri, 1 May 2020 16:02:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2005011511210.62443@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CwqkJuTDv0oahJd+Kh/sryCnE0Bq7ONPpeD135YLfZ8zq2Ln6kO
 wOwKTTAKROROfBcLMT7kJbp/GThD7XdEeQUqqJDvSlVYNPfCTLhZFU4Ghs+bwRJKrzAJSIp
 /d+gYhuVZN4AIVP8rtNeiCcK9acp5VIxLQBmrEZi4mZCjWUcXb6h+D8RID58QNnQsemAOm6
 /1oji/oY/Fa3e9+Eh1A4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yzHkymrO3vs=:By1jvHutRK1ETusgEByknh
 XUhD184KYPe5Tz78SLlNEvOovzGkZuPF1rjbReIRD/cVaYbd9ggImpA+Y0uekXaY9wvEMH2C4
 cJ250nhi5WsRlXqUJ1ouJJHOXBAnkSiXXsfH555tCOoHbyVI0iZBNx1I8ez2ZtgLlm0TydItZ
 mMPQZcPP8RBDKUsBGz2F1jG8jcsM3ckHxXIrqvDIgP9Tvtvx18gMIHFmLSV/1S/grOGr4+zfN
 80GlT3w7F481JNCFlLVCUrhy0r4/mY6o7r0X9VpSDfVbDVAOcTNsuk8i1PoEDaoWdhU33j/xQ
 aMQt+qrq6nhHG70ig/9tB0eiQhyQjPBx/kTtZ+ROgOLUDY9GY2e3eVEErWM4f0lzbcssOiGA8
 +chT2BhW08tx4+HXA5SvnoaSNSeOtGk68uq3fSwVCPrXz6RSgOSAKi1GsShIok2EEKKxX9VRf
 k9kkrh1iEzSOjxHbGS2YuH8CMfWVYTU7vPS5nJ+prTL9xTaS259KOniLk7AQqXPqNBj02a5+e
 dM4Bsb1tuxfEPFjDdLsgg8zO5hTX7MWVd48NUA7EZdSUkw/PBmQ53ALAfEAUbf1U4updlTgir
 Q/eVRpDc8CLgeDDB5mPAl7ykwSe2IrnLsmwJMHEepFJ2UnFCxkbUYyzC5eju6/QNZrcCvC2+I
 /YO05FADdehRqtOqYbHmQKBCxXAS9NcW/mkKfyrmz/ZzK8Zh/qpgAZZ1x1z7PshlQWyVHkxkY
 j3km+1MDkLm3tBc7iFkuGrFTp4FPYayR5vymCnI28JeUXOY4dNr3QTUlyhze/hFs2XIeauurN
 KjZkxYT1pG9OF/dV1VoO+zYChMP77Aq5QYXKHAAtlF7SC+fSW/4HEKNFBRj7yLut1IBiEhN
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 10:02:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 212.227.17.10
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

Le 01/05/2020 à 15:11, BALATON Zoltan a écrit :
> Ping?

I sent a comment:

https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg02840.html

Thanks,
Laurent

> 
> On Tue, 14 Jan 2020, BALATON Zoltan wrote:
>> The movec opcode does not exist on 68000 and should raise an
>> exception. Fix the feature mask to only allow movec on newer 68k CPUs.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>> target/m68k/translate.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
>> index fcdb7bc8e4..f19da064c8 100644
>> --- a/target/m68k/translate.c
>> +++ b/target/m68k/translate.c
>> @@ -5988,7 +5988,7 @@ void register_m68k_insns (CPUM68KState *env)
>>     BASE(stop,      4e72, ffff);
>>     BASE(rte,       4e73, ffff);
>>     INSN(cf_movec,  4e7b, ffff, CF_ISA_A);
>> -    INSN(m68k_movec, 4e7a, fffe, M68000);
>> +    INSN(m68k_movec, 4e7a, fffe, FPU);
>> #endif
>>     BASE(nop,       4e71, ffff);
>>     INSN(rtd,       4e74, ffff, RTD);
>>



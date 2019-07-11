Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662D7C74A51
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 09:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3047021019
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 09:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oeEJWo69"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3047021019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlVEW-00066m-2w
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 05:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41448)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hlVDt-0005GN-I6
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 05:18:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hlVDs-0001Zk-Am
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 05:18:41 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46460)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hlVDs-0001XG-2T
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 05:18:40 -0400
Received: by mail-wr1-x443.google.com with SMTP id z1so5397319wru.13
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 02:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=r54CdrpSuY7zS9bElZAV4WeTYN4hYu7B7/8ZwNdMmpU=;
 b=oeEJWo69Un3Jf4jYychp0nR+FA0eULcSRAuz6FAPx+RH3DdrjmgXKJA3FbTCCgk61B
 s1q5YBIFN7TbS8W0yIr8ebVyx5DeC1Jrl4N0cdqiKWj+DOC8i8C79K7EiDkHJ+a0U2pc
 W1Sg/e3FRj8G28be2TmJqIS1QuHYtQkK+7OAczzYIDecp/OYOhTYdSK3baU9xkNdnxcC
 9sQ9e3jtIo40+gK2lCMZRcdP/zjZsX7ArNbhkOSFHovQ/BrkeeN28Kp2/1bdgaoyf52z
 T2nkw3lcT5xTHA3VwEPXvHa131cYFtgRNisomMfp/jCkjl3tlplBaSqFSI7u7sUXV8W8
 KRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r54CdrpSuY7zS9bElZAV4WeTYN4hYu7B7/8ZwNdMmpU=;
 b=MWl5XWtpiFDhbDZmlPY7NLUnY0iEJk2EI/C7HERtq/ji7yQqzRJzKY74CBGAq2tk9b
 1aUCeVEbPdAOpCTxvPwm0ZILrNIy6UiVQADvjeTZ3OeG6ryoIiIhs4X5fwNoulYpn1LX
 t0Bj3js2b6lQ37jTPovuPLsHFOUgPK6n2Sk6jQUxqq67r7aLJp/c1aLW8Q/1Wwoliuge
 a+NFTFzAQwF/bCl6GU6USYwL0xcFbuzJGURYreHp4utHPGZlvGRlVzCdgbTdKMBbHeX8
 QKJY0CgVONgXYWrVI+5VeXkv7Hl2aaXTMWDWihNlNzJQKnSuFhPSHtMVZ4fI0cBjx62D
 ug3g==
X-Gm-Message-State: APjAAAVtYhvt4axKPykW+tEkyMpHCunRbK6YJP/7ISLokC0mHWTF1gf6
 MrRSg8brkz3KhnQ3190tOWTb1w==
X-Google-Smtp-Source: APXvYqyx0jz/U1mydNmV4irCk0LKqbKrZvrxXYWAij7hZMSnjCIkvnfNi66m2D0yMGtZ1O2Z0c0XTw==
X-Received: by 2002:a05:6000:3:: with SMTP id h3mr3915832wrx.114.1562836717980; 
 Thu, 11 Jul 2019 02:18:37 -0700 (PDT)
Received: from [172.16.96.70] (mob-31-157-172-216.net.vodafone.it.
 [31.157.172.216])
 by smtp.gmail.com with ESMTPSA id c78sm5314911wmd.16.2019.07.11.02.18.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Jul 2019 02:18:37 -0700 (PDT)
To: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
References: <2136180936.260219.1561641583358.ref@mail.yahoo.com>
 <2136180936.260219.1561641583358@mail.yahoo.com>
 <1079763171.281101.1561641752988@mail.yahoo.com>
 <e4c1fbc4-3e43-5df4-a17c-527d98d9763c@linaro.org>
 <20190628002713.GA19257@localhost.localdomain>
 <eadb57ae-256d-0bb7-5988-f493662a5caf@linaro.org>
 <20190628155030.GA34320@localhost.localdomain>
 <ea16a81c-5b94-8dd0-8339-2bd82733aed2@linaro.org>
 <20190629163621.GA111724@localhost.localdomain>
 <CAFEAcA9sfNisAz-zAZAx=ZNFmsEpP0Ec2DeRedtZSd9KQ4fvNA@mail.gmail.com>
 <1399218244.1210557.1561982640362@mail.yahoo.com>
 <CAFEAcA-0vGg_1nfkbq+o6JwoDsRyP=6mnv6ADi-atV0ROX269Q@mail.gmail.com>
 <CALvKS=GvAkNr3OKZzjGoTGG_Eys76zjcjodiN4hKXjFM5B0a4A@mail.gmail.com>
 <d9e5602c-bb33-1812-ebc2-b533e9dd5f25@linaro.org>
 <CALvKS=EbuQOvRx+bmRnqCD6JuHK87dnkx00EiH--aXYWuNF0VQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ba03e07a-6061-69f2-1042-020de8990929@linaro.org>
Date: Thu, 11 Jul 2019 11:18:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CALvKS=EbuQOvRx+bmRnqCD6JuHK87dnkx00EiH--aXYWuNF0VQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] RFC: Why does target/m68k RTE insn. use
 gen_exception
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Lucien Anti-Spam <lucienmp_antispam@yahoo.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/19 7:50 PM, Lucien Murray-Pitts wrote:
> 
> 
>> On Wed, Jul 10, 2019 at 4:04 AM Richard Henderson
> <richard.henderson@linaro.org <mailto:richard.henderson@linaro.org>> wrote:
> 
>     > I did have a suggestion.  It was fairly detailed.
>     > https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06522.html
> 
> Your solution is elegant at about 10 lines that return getl_ilen(pc), but it
> seems the s390 has a far simpler 
> instruction word format than the m68k. 

S390 is simpler, in that it encodes the total length into the first two bits of
the opcode.  That said, the same technique can apply.  The only difference is
the location at which you would record the length.

For s390, we do this immediately after loading the entire instruction, having
parsed the length as you saw.

For m68k, we would do this after decoding the entire instruction, as
pc_at_insn_end - pc_at_insn_start.

> However then that got me to thinking, it seems that we can call a portion of
> the TCG system to disassemble a single instruction.
>     TranslationBlock tb;
>     tb.pc = env->pc;
>     gen_intermediate_code(cs, &tb, /* max isn */ 1);
>     int ilen = tb.size;
>     printf( "PC: %08x sz:%08x\n", env->pc, tb, ilen ) ;
> 
> I am very new to TCG, so it does seem there is a lot of code in the
> translator_loop that appears to be interacting with the CPU model/state.
> Should I be worried about this, or is this a safe function to call outside of
> the translator core proper? 

No, it is not safe to call outside of the translator core, because of how this
interacts with emitting tcg opcodes.


r~


Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871C1C49EAD
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:49:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D2E720869
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2E720869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRvTD-0003P2-FN
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 04:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iRvSY-0002wI-PP
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:49:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iRvSW-0007CC-25
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:49:09 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:35033)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iRvSU-00079k-RE
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:49:07 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MHGPA-1ifB0x43wu-00DIc5; Tue, 05 Nov 2019 10:49:04 +0100
Subject: Re: [PATCH v2 04/12] linux-user/sparc: Use WREG constants in
 sparc/target_cpu.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191025113921.9412-1-richard.henderson@linaro.org>
 <20191025113921.9412-5-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <22579921-a656-3bb9-8f8e-09c43d377ab2@vivier.eu>
Date: Tue, 5 Nov 2019 10:49:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025113921.9412-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VI7GpKLL2G6WSH7Guauwg//kvUqoS5DA7cFyDGQhGVeWiMfNlKG
 gODdXBs+5cz2QUgSi3h6yX4TI5uiQJMjl7x1JhXzEdIUWMyrpIiCrhjlZVjUD71jhqONgJf
 KYJoHwitom8r70RZJd8Zsi1X4g91donX1SubZG4KYcVYdYB5SZF/6Iin/Y7GTLYnub98imA
 3Nu/aJjlJ2lohovOjjqBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gw4CNhvYm6g=:/8xNmAtl0gqvcuupi+4PzI
 5RwHLxv+g66SThgG0rT5uffSkrRYzIg9eG7sPF1IixfcPhi182/fwJbLVTiwFjToUs1glwwOn
 b3SzdqKHKFKlD9Db4voBeAJy8S5TcHhk1blMBxqGvL55gNoVBQiGYVpJUV5w2jAyJpZ37uT+m
 rZKgtW5JtohF7cLCrJWp2R7xJJTX+Pf8fETKje6EcuYNhTl+zrn36f+MXsG6eI7eqlUREiGlr
 Tq4FvOZ/Yjp8l8kfNS5jCFOjj1aCYxZSdPcue6RGvlJ9OCoZh4SZxh6DddS6+f2l8ZR/t2pj0
 VyZPviEOUHz9RQz3pc8hQZ3eTY4bSWS8uygAi5QDiBWbtUI+0GGpCZTOBaI1sK6PWoTzmpORg
 g2Q+qbXUDfdlFpgFrKCG3MW4mP20Ibud4RoZ41s+xlNlDhjVoImKi+x/3bGxCFp+mMZii7kgU
 edoHnsWhzb29wRo7KAqC9HiKASCCBOp8iGqFbyGPvuJQD1XTbrMXQV0N99xTJxmOoIyDCn6zE
 TNSA6y0ncMZ2BDiIrfsyxxCYYYxRZ4obUix1A2y8FatTnmmVi964LQTh9rAKKrXEv2D9vM271
 g6FaB7BXrB9Y74ic8wR0dq4XemMRPthyhHJ7fRjiNGem+mMeKUO4nMu4PB5sh5Ot0u2QBQQkZ
 BEqZnD9uF5O6CGm0WqX0mw58ra9mPV5RjTl8Gncab5QoeMzrpUyOyVOFbMvIZoRp085pzKlNl
 eayfCnWSEBOWsgdKjnQLbOG3Q2SnVZz/id7dEVcaUvujGmRbb+XiFSU9ReWoYRgk/6Rp2ljOZ
 0NK3rNiSeuCcyEQfCNK7YLH5QTwx1TZrhFHh/KJkxffmy513RiH1y8BAyd7HLTYmDfFK1DMBZ
 xgKzvkLrnciCxRWF8wo+nqLeywbQ08TlDwRXXq/+s=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.130
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 25/10/2019 à 13:39, Richard Henderson a écrit :
> This fixes a naming bug wherein we used "UREG_FP" to access the
> stack pointer.  OTOH, the "UREG_FP" constant was also defined
> incorrectly such that it *did* reference the stack pointer.
> 
> Note that the kernel legitimately uses the name "FP", because it
> utilizes the rolled stack window in processing the system call.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/sparc/target_cpu.h | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/linux-user/sparc/target_cpu.h b/linux-user/sparc/target_cpu.h
> index 1ffc0ae9f2..b30fbc72c4 100644
> --- a/linux-user/sparc/target_cpu.h
> +++ b/linux-user/sparc/target_cpu.h
> @@ -41,15 +41,9 @@ static inline void cpu_set_tls(CPUSPARCState *env, target_ulong newtls)
>      env->gregs[7] = newtls;
>  }
>  
> -#ifndef UREG_I6
> -#define UREG_I6        6
> -#endif
> -#ifndef UREG_FP
> -#define UREG_FP        UREG_I6
> -#endif
> -
>  static inline abi_ulong get_sp_from_cpustate(CPUSPARCState *state)
>  {
> -    return state->regwptr[UREG_FP];
> +    return state->regwptr[WREG_SP];
>  }
> +
>  #endif
> 

Applied to my linux-user branch.

Thanks,
Laurent


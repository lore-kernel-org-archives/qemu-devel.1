Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1135AC432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 10:59:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4BEA2073C
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 10:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4BEA2073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ib0TP-0002Yo-U5
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 05:59:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ib0Sf-0001qK-13
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 05:58:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ib0Sd-0006DG-Um
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 05:58:48 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:60631)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ib0Sd-000647-Lg
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 05:58:47 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MNbtF-1iPfVz2vV5-00P79y; Sat, 30 Nov 2019 11:58:40 +0100
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191130084602.10818-1-alex.bennee@linaro.org>
 <20191130084602.10818-8-alex.bennee@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v2 07/14] target/m68k: use gdb_get_reg helpers
Message-ID: <bbcf6745-764a-05c5-e835-e4d1fd84c093@vivier.eu>
Date: Sat, 30 Nov 2019 11:58:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191130084602.10818-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GIl1+3KjAW6F3o5Kl1xbwKVCOgHwx4rlAY4kbVOVtb5c0gePvEc
 6sOBV3dtJnV45a1oqkwbIiUJTUZqm15yDBtd4ftfyqWT4u57DTnf69i1XnzHpphSN1xjSNx
 lsUJ14xyKtkWlHcdIPUpKGJA9HVhby4JUOOcF5v3D+QWP5+Wsl7/kKVHitY89qT9w+9xew+
 U2H48QrtNV+Ih9VjoL2DQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zVrb4WqQnHY=:WcmSc0UHlZt5UGkdGewbwn
 YY/MFIdy0yJYpH5BF6r5Xq7GCrVZyBsVKukNrxKOe7YbKHE8+wqVWV1/gl4GXgOFLXyqacAIw
 cglEqiVSCSNxk/ZSuk+8reCqUlxdla87SEszfEf4aoaf8jO2Flb0PJAWq6V8oebvfNuqaITc8
 TeMykXEIAOvLhwiYA09Qo9pjz9BWCnBL8djeyR5wD0Un6eAVyVmc8/R9++UJgZejaXRr1pr/9
 uihdInVKKrE3s5NxSSWYjPyjEWpRtgr0k02v81wEDA6LrN5AIy6w8Hf2E8DHfqvYc9+BVSvWV
 vBk9bRHw3NdvINe7pM6wRTuRNYJJ2tPHSP9XlISHCUwczY69E7LPGbzArSSa5uT5JJ8qrK4r3
 h8K23E5hhwg2QKO5rVaWAg78n9P5Kzqfqc/WOWS6MlMZnGC+PkPKxM93KYDcr9ZQqF/G3Gqv4
 s4ug1QhjMBvb4X3hdYfc2Ut5iNvKaRlwF5d+X/C+95xFx0yoYIvVsnehkKW6iJeIsDNXY18KK
 CWknHAjzjcCFcDf6whN3XNSPw7puhtLt3c92u0ChW7NLzFq91zmtiXMR/5tqfrvSLE8eXEDzw
 WypGql+m9f0iozIZmVEaveazlBvl6wdL9GPtcnwQ2775xZcjlVz3vbGUFVWP70SEgwb6vXbWn
 sC3hWI8qIVvHcK6mrGetiJac1czqboMHB+oduN918g2jwZBl37TEtMCtWutLqjGq3A6s2T+6h
 Nqei9rfCC3gHXJWgu87qMdazI/NrD2KyGi/MrkFd4iuWSwoOJ9UyaMJF5aN/PADoFMfOwEWU7
 YPbZ5OVXvat9v35fNQFyZ9pS9o8IV1FRprXQGWLR/cogKPCKiwBNuTsHBNi3VQYvFfXY/cP/U
 rNPL5YaQwlm8z3Q7qJQVbllt0X49ZGhMiFTddCUlY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.74
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
Cc: damien.hedde@greensocs.com, richard.henderson@linaro.org,
 luis.machado@linaro.org, alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 30/11/2019 à 09:45, Alex Bennée a écrit :
> This is cleaner than poking memory directly and will make later
> clean-ups easier.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/m68k/helper.c | 29 +++++++++++------------------
>  1 file changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index ae766a6cb0b..70b0c0b5076 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c
> @@ -72,19 +72,15 @@ static int cf_fpu_gdb_get_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
>  {
>      if (n < 8) {
>          float_status s;
> -        stfq_p(mem_buf, floatx80_to_float64(env->fregs[n].d, &s));
> -        return 8;
> +        return gdb_get_reg64(buf, floatx80_to_float64(env->fregs[n].d, &s));

Where is coming from "buf"? We were using "mem_buf".

>      }
>      switch (n) {
>      case 8: /* fpcontrol */
> -        stl_be_p(mem_buf, env->fpcr);
> -        return 4;
> +        return gdb_get_reg32(buf, env->fpcr);
>      case 9: /* fpstatus */
> -        stl_be_p(mem_buf, env->fpsr);
> -        return 4;
> +        return gdb_get_reg32(buf, env->fpsr);
>      case 10: /* fpiar, not implemented */
> -        memset(mem_buf, 0, 4);
> -        return 4;
> +        return gdb_get_reg32(buf, 0);
>      }
>      return 0;
>  }
> @@ -112,21 +108,18 @@ static int cf_fpu_gdb_set_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
>  static int m68k_fpu_gdb_get_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
>  {
>      if (n < 8) {
> -        stw_be_p(mem_buf, env->fregs[n].l.upper);
> -        memset(mem_buf + 2, 0, 2);
> -        stq_be_p(mem_buf + 4, env->fregs[n].l.lower);
> -        return 12;
> +        int len = gdb_get_reg16(buf, env->fregs[n].l.upper);
> +        len += gdb_get_reg16(buf, 0);

len += gdb_get_reg16(buf + len, ...

> +        len += gdb_get_reg64(buf, env->fregs[n].l.lower);

len += gdb_get_reg64(buf + len, ...

> +        return len;
>      }
>      switch (n) {
>      case 8: /* fpcontrol */
> -        stl_be_p(mem_buf, env->fpcr);
> -        return 4;
> +        return gdb_get_reg32(buf, env->fpcr);
>      case 9: /* fpstatus */
> -        stl_be_p(mem_buf, env->fpsr);
> -        return 4;
> +        return gdb_get_reg32(buf, env->fpsr);
>      case 10: /* fpiar, not implemented */
> -        memset(mem_buf, 0, 4);
> -        return 4;
> +        return gdb_get_reg32(buf, 0);
>      }
>      return 0;
>  }
> 

Thanks,
Laurent


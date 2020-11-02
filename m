Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0146CC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:32:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50D57206B7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaKvh3BO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D57206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZWCP-0005l6-CB
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 04:32:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZWBh-0005LC-HB
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:31:41 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZWBf-0000RP-PS
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:31:41 -0500
Received: by mail-wm1-x342.google.com with SMTP id p22so8667457wmg.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 01:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LT2eZHCpn7AVUgH8RjETPO98k4ovPRHVLJolDXlFRyQ=;
 b=DaKvh3BOlfXjZwpyIBnoy1MQgSj9+AHKmC7Trmj92oAm+uBo/NUwhniuKZbBPbTsO4
 XvjMB7VmvRHcZlm5C8lP4j4f0vsp5VvqC7j0Mr4cCeZj1ifkBeTdk6p75sR387rStWkZ
 HE1YXGHlcEKt/YO4TDO4K7pFz2GrmqjLwtQ5k9a7c+jJ+hP5DMWqkNEh8NsvgMFpG66i
 7iEPtyift55/otKiwuFfNDZBIQDWFnuYpkTjNrTGWxQ2d9z35coov5AUF2Oy5WW7f5hm
 0WuM1swG8eVkCNBaruSbmSlMGmf8WV8aBfKvMwrE8gOf4Smo2gD2JWQKuG9yy9pAgm8j
 C1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LT2eZHCpn7AVUgH8RjETPO98k4ovPRHVLJolDXlFRyQ=;
 b=uZkd0FmPs8JwKGnpHoOU4wEbnyMDjIsnQaHfbYT9N35HFeZtBPNEG+WeisBQWgwE7R
 pQtGKvv2nuEBN0YlnN+0hkMSbhUYWgkMa+cte4Wx7VADb+of0wFiwOE6wD9VEo1kNtHw
 Er0zu5ro1h6SWgcxgqAcg04v7YK+H3NeP96hMQR0eOHGaPSwtASGotA5+zGuw7RXQKG/
 lg+GKzi9p/2td+/QxPbzUfUkmEsH5gKaMqZ0uzrKRUZrt0cnj+FHcfl6Kd+lo3dY8l5r
 fLx4yk9Qv/AfKg9rDYMVRHQgQhyZlN9ColQ+yHtQLL8z2GYJFKDcgKThB7Xkb8HXvl7c
 /m1w==
X-Gm-Message-State: AOAM531QJMLloXXTDejZibtnZwUUkgN581MttBf9eb82NqJuTZOV7DOU
 HU70hqQBQsysMTcPVksgrZg=
X-Google-Smtp-Source: ABdhPJwE9/TMPV1OUc62LMkQgrRicrvBMHcOaIKwG0tpDQ98wmzga2RLgXYgIg9TpDIMS2LesTyPSA==
X-Received: by 2002:a05:600c:28c1:: with SMTP id
 h1mr16701401wmd.30.1604309498433; 
 Mon, 02 Nov 2020 01:31:38 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id 90sm21552491wrh.35.2020.11.02.01.31.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 01:31:37 -0800 (PST)
Subject: Re: [PATCH v2] target/s390x: fix execution with icount
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>, qemu-devel@nongnu.org
References: <160430921917.21500.1486722139653938240.stgit@pasha-ThinkPad-X280>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0b690ed9-e31b-73fd-9489-8e7f78645219@amsat.org>
Date: Mon, 2 Nov 2020 10:31:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <160430921917.21500.1486722139653938240.stgit@pasha-ThinkPad-X280>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: thuth@redhat.com, cohuck@redhat.com, rth@twiddle.net, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 10:26 AM, Pavel Dovgalyuk wrote:
> This patch adds some gen_io_start() calls to allow execution
> of s390x targets in icount mode with -smp 1.
> It enables deterministic timers and record/replay features.
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
> 
> ---
> 
> v2:
>  - added IF_IO flag to reuse icount code in translate_one()
>    (suggested by Richard Henderson)

Suggested-by: Richard Henderson <richard.henderson@linaro.org>

> ---
>  target/s390x/insn-data.def |   70 ++++++++++++++++++++++----------------------
>  target/s390x/translate.c   |   15 +++++++++
>  2 files changed, 50 insertions(+), 35 deletions(-)
...

> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index ac10f42f10..7a8ff1f2de 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -1214,6 +1214,7 @@ typedef struct {
>  #define IF_DFP      0x0010      /* decimal floating point instruction */
>  #define IF_PRIV     0x0020      /* privileged instruction */
>  #define IF_VEC      0x0040      /* vector instruction */
> +#define IF_IO       0x0080      /* input/output instruction */
>  
>  struct DisasInsn {
>      unsigned opc:16;
> @@ -6369,6 +6370,7 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
>      const DisasInsn *insn;
>      DisasJumpType ret = DISAS_NEXT;
>      DisasOps o = {};
> +    bool icount = false;
>  
>      /* Search for the insn in the table.  */
>      insn = extract_insn(env, s);
> @@ -6435,6 +6437,14 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
>                  return DISAS_NORETURN;
>              }
>          }
> +
> +        /* input/output is the special case for icount mode */
> +        if (insn->flags & IF_IO) {
> +            icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
> +            if (icount) {
> +                gen_io_start();
> +            }
> +        }
>      }
>  
>      /* Check for insn specification exceptions.  */
> @@ -6488,6 +6498,11 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
>          tcg_temp_free_i64(o.addr1);
>      }
>  
> +    /* io should be the last instruction in tb when icount is enabled */
> +    if (icount && ret == DISAS_NEXT) {
> +        ret = DISAS_PC_STALE;
> +    }
> +
>  #ifndef CONFIG_USER_ONLY
>      if (s->base.tb->flags & FLAG_MASK_PER) {
>          /* An exception might be triggered, save PSW if not already done.  */
> 
> 

A bit too s390x-specific to me, but the generic approach looks great :)


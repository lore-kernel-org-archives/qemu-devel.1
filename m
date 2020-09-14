Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B265C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 05:55:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A6D620639
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 05:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpfjOI8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6D620639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHhSo-00088c-OI
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 01:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kHhS6-0007fZ-Gm
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 01:54:58 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kHhS5-0000zK-38
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 01:54:58 -0400
Received: by mail-wr1-x443.google.com with SMTP id w5so17217388wrp.8
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 22:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MdFDoppZup9jP/UUo3evqxbdOj26wOhAMDiv3SGY0gw=;
 b=HpfjOI8kH1ymuXp6oENBIZpdfJfRkyUL5td9zhbWl4gozhBiEzaHWrhjWThDlf5BBr
 oIdOeYem//cfoalaFA0BKRfDb0cOu0bipuN8NWtbwJjwHe8mGd/+m/hUwyMPj0qUF0HW
 LJHVxAFXR9UcYK3edHm2szoNB9J4YXn9tSOTu7k+q9MW+bd078QHprkcNp9aSNcP40uf
 Hvn0BSsL/fSPhA8q6MguxdeTYkkoI5xxSt6Z+s7ak2xp+YP/XrkK5JktkY9DXtWFWC54
 2ASkkomklhA8GgEJBF6yxzF0oDtWBswWne1cwRSHDAnDQv67c6hpFgyzAG/wPto+xJrw
 NSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MdFDoppZup9jP/UUo3evqxbdOj26wOhAMDiv3SGY0gw=;
 b=dyc8J2Il6kTCsVQclzlt8saSLszYpAaUW8irfRYokiU852g4GzJmbrNTiJueB1pC6a
 kMTiQAYoEHmNmf1ugN9XcOhDatQXcpMrdWUaT1WVH5HeBczgzUWXB3HVEt0OpfTtlLlR
 RzDbY00nqC/lET2uGo+aiXgZZsSGTXSwewhLyxhYadROfae31sN+FcI0gHXtamazmK+z
 24XqqBH/IGvsnWReZESFOgRvbgKFuP3X1uoxabWeQSQOa4dJzCrcwlHpD63Vnqg44Vb7
 Q1dnLviYIeTZXz+pQOrqhtoLijoARddUNGrw/55/Qx8Y6+1L9l6OYkXa5FiH7YQn7n1w
 8izA==
X-Gm-Message-State: AOAM531bmKrHoUR20DRv6oTYRbxJlcouGGq9kCb9U7OX9JuIb3h9RdvE
 8c8j+quzGlAjOOxMRiPk1HQ=
X-Google-Smtp-Source: ABdhPJxm00WJCDnhJAIe6BPdf7Yn6Seh+x/y2NtX8TiMGk5dp3DRBFEm4eTMiC0/qFjpQEW2zi1jaw==
X-Received: by 2002:adf:a4cc:: with SMTP id h12mr8852629wrb.123.1600062895130; 
 Sun, 13 Sep 2020 22:54:55 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id b194sm18345910wmd.42.2020.09.13.22.54.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2020 22:54:54 -0700 (PDT)
Subject: Re: [PATCH 10/11] disas/capstone: Add skipdata hook for s390x
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200914000153.1725632-1-richard.henderson@linaro.org>
 <20200914000153.1725632-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <45155b58-dcca-74e8-1467-a8b793357db1@amsat.org>
Date: Mon, 14 Sep 2020 07:54:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200914000153.1725632-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
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
Cc: luoyonggang@gmail.com, alex.bennee@linaro.org, thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/14/20 2:01 AM, Richard Henderson wrote:
> It is always possible to tell the length of an insn, even if the
> actual insn is unknown.  Skip the correct number of bytes, so that
> we stay in sync with the instruction stream.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  disas/capstone.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/disas/capstone.c b/disas/capstone.c
> index b48f83958d..0a9ef9c892 100644
> --- a/disas/capstone.c
> +++ b/disas/capstone.c
> @@ -16,6 +16,39 @@
>   */
>  static __thread cs_insn *cap_insn;
>  
> +/*
> + * The capstone library always skips 2 bytes for S390X.
> + * This is less than ideal, since we can tell from the first two bits
> + * the size of the insn and thus stay in sync with the insn stream.
> + */
> +static size_t CAPSTONE_API
> +cap_skipdata_s390x_cb(const uint8_t *code, size_t code_size,
> +                      size_t offset, void *user_data)
> +{
> +    size_t ilen;
> +
> +    /* See get_ilen() in target/s390x/internal.h.  */
> +    switch (code[offset] >> 6) {
> +    case 0:
> +        ilen = 2;
> +        break;
> +    case 1:
> +    case 2:
> +        ilen = 4;
> +        break;
> +    default:
> +        ilen = 6;
> +        break;
> +    }
> +
> +    return ilen;
> +}
> +
> +static const cs_opt_skipdata cap_skipdata_s390x = {
> +    .mnemonic = ".byte",
> +    .callback = cap_skipdata_s390x_cb
> +};
> +
>  /*
>   * Initialize the Capstone library.
>   *
> @@ -42,13 +75,20 @@ static cs_err cap_disas_start(disassemble_info *info, csh *handle)
>      /* "Disassemble" unknown insns as ".byte W,X,Y,Z".  */
>      cs_option(*handle, CS_OPT_SKIPDATA, CS_OPT_ON);
>  
> -    if (info->cap_arch == CS_ARCH_X86) {
> +    switch (info->cap_arch) {
> +    case CS_ARCH_SYSZ:
> +        cs_option(*handle, CS_OPT_SKIPDATA_SETUP,
> +                  (uintptr_t)&cap_skipdata_s390x);
> +        break;
> +
> +    case CS_ARCH_X86:
>          /*
>           * We don't care about errors (if for some reason the library
>           * is compiled without AT&T syntax); the user will just have
>           * to deal with the Intel syntax.
>           */
>          cs_option(*handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
> +        break;
>      }
>  
>      /* Allocate temp space for cs_disasm_iter.  */
> 



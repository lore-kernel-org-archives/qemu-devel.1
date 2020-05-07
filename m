Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A4FC38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 18:07:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C1A92063A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 18:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoX2EyiI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C1A92063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWkvX-0001F5-7A
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 14:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent.desnogues@gmail.com>)
 id 1jWkun-0000py-VR
 for qemu-devel@nongnu.org; Thu, 07 May 2020 14:06:36 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:38883)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent.desnogues@gmail.com>)
 id 1jWkul-0001iW-O9
 for qemu-devel@nongnu.org; Thu, 07 May 2020 14:06:33 -0400
Received: by mail-io1-xd43.google.com with SMTP id d7so3091835ioq.5
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 11:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SFTw9Y9RY7xQsfjqIaubev7qysRFd9x6c40Yxxi6gyM=;
 b=UoX2EyiI3jcVlT4IfJhkyOe49gw7LGAC7knHd77b5vKTsFXrHfNUxl0CxfcLB6EbT7
 IoJO8tZRUuZGvA3wBCMLO1wkr/CPPDiWX3yiedHYdnah6NS7NvDP1h2jBLBcmkvvokQ6
 v/4E7fQsZkHzc83lj3e8tupwKXA5qDX6CP1+lY05ayFSwUW9Yj16mdxQfzea8oj3XE6B
 FQn1Z9eXALchK0BQA0vvTfuO+ETohzWpBvauZlDzrcFrISUaT/UFcwKaMHVcj7+q7D6y
 uMkuvES4cY65Srv9ZMZMw3ovsihJAk5YCQVog17dyj/iA4/5aMSerJI61FNnkYgg/aHi
 jcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SFTw9Y9RY7xQsfjqIaubev7qysRFd9x6c40Yxxi6gyM=;
 b=c2tk17bPBVPYcCDhmiH5uPcFEPTfyZuZqZTZCN1iKleJnOBChoQ9gKATeFfcf8oJXV
 F3/Tl721gBYXLQ4mUb3lVsggMD56viX3z7zkV41N88rb/urXTpoFlSwU9Ie/CtI1TsQ/
 B6gpuADx0xqJCqN1nCKK3lGjbcasjvPXfl45y2gSJkhap7v0uDYSLARn+4yKFdyaQuBB
 Ze/jo8BFphUoMo7aZcDv8lK6YRI7tjOMJUfdFw/bc89aQpoXfaarSpsFVwXP2irQYTxZ
 07chM0/2Oc62FYqC/g1O7I+gvggus76FDCOOZ+wYtLD9PbG7yXrPL87ZBg6cwnPnaCir
 FiUQ==
X-Gm-Message-State: AGi0PuYZu6/AogINly/QjWZ1J5xWnABUeL6hvI5h5Nc/xH7UvjnS9O1C
 TLGA8mx72S1V2k6yxSQGELFiNK8cMqwTfbeL4eQ=
X-Google-Smtp-Source: APiQypLWdrmKVFNHUetrKGBJ/OlwRWJJKBcCfXV9PjzCIrqeBTXrODhbxNhQgM2Gwi0t+8V/nwpUbJiKhkea+WX/EkQ=
X-Received: by 2002:a02:2a47:: with SMTP id w68mr14819132jaw.76.1588874790351; 
 Thu, 07 May 2020 11:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200507172352.15418-1-richard.henderson@linaro.org>
 <20200507172352.15418-5-richard.henderson@linaro.org>
In-Reply-To: <20200507172352.15418-5-richard.henderson@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Thu, 7 May 2020 20:06:19 +0200
Message-ID: <CABoDooPHQismSRmM8bxDu8sSj1AQuVKR_1FgEWc4ScUc53jxPA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] target/arm: Fix tcg_gen_gvec_dup_imm vs DUP
 (indexed)
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=laurent.desnogues@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 7, 2020 at 7:23 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> DUP (indexed) can duplicate 128-bit elements, so using esz
> unconditionally can assert in tcg_gen_gvec_dup_imm.
>
> Fixes: 8711e71f9cbb
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>

I had the same fix locally.

Thanks,

Laurent


> ---
>  target/arm/translate-sve.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index c8649283be..83614e9e70 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -2044,7 +2044,11 @@ static bool trans_DUP_x(DisasContext *s, arg_DUP_x *a)
>              unsigned nofs = vec_reg_offset(s, a->rn, index, esz);
>              tcg_gen_gvec_dup_mem(esz, dofs, nofs, vsz, vsz);
>          } else {
> -            tcg_gen_gvec_dup_imm(esz, dofs, vsz, vsz, 0);
> +            /*
> +             * While dup_mem handles 128-bit elements, dup_imm does not.
> +             * Thankfully element size doesn't matter for splatting zero.
> +             */
> +            tcg_gen_gvec_dup_imm(MO_64, dofs, vsz, vsz, 0);
>          }
>      }
>      return true;
> --
> 2.20.1
>


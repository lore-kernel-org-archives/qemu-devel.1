Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EA9C4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 17:42:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3732206CD
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 17:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qqqk7Meg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3732206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOlYc-00083E-Tb
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 13:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOlUs-0006Kt-J2; Sat, 03 Oct 2020 13:39:03 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOlUq-0002o9-4P; Sat, 03 Oct 2020 13:39:02 -0400
Received: by mail-wm1-x342.google.com with SMTP id k18so4860546wmj.5;
 Sat, 03 Oct 2020 10:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NC3bF7aZX0Iu7vf2d5DjorTTdZbvXMK7gB/TFhdzfGs=;
 b=Qqqk7MegygPxzUMcAP4JeynFlXV4t0xN9qkvvA6MVi0AJFXysXT2aJTB/M1dFXU+4A
 DNVZAnRaiVCv3us+ESN5u8VwVPdcvNxPxdOxAetFsGCnSpzKwYnFAbd8DH5H2xL3l5Ms
 kvqDX0g3EQYWGNEgTqBnyWQQPyl2PhDmOlzcinfNPDKPvK99mPLipu/S+hkVwrnAkxmN
 4WW1U0qASu9gvHJsyq+NW5xh6FSAxT/qOWy2Y31RObYCazbPeKzBEVeWC9uSYTSF1Jan
 6cYpT0MJSg+iFwyiJ2cHj0KwzkPNITtADrMF4LpZp71hiTPdRc17zNm78XxHrR/nj36+
 evRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NC3bF7aZX0Iu7vf2d5DjorTTdZbvXMK7gB/TFhdzfGs=;
 b=QUfSzqczLrEW54f2qhVgvREM0J1NoBkpMwmGYqAh9kg5H40zX4ppYUKMNXOurT00yc
 X48nFc8fpNQqRRReWjflmO0Eft7uPE+kUdDQ6a2fPYArie7LjffcmAqzn/APQ3RWeIYs
 g2NcrnkxMI9Yq/BhsLmf+uu7Yy1EDTeidGKDHSywGGCRSZl3CajPFXllKLp887SB7fcL
 /Uu6qCchoobJutIEcKM+SOTyw7oQeL50hoZ6j2WsCmJa31V+ZQYbQ2PSuKKhO1Rzrmnd
 cXZNnt1h3jAN4PGmD5LYoasQuzlFP4UWTwnv4quWajq0R8eB+JoL6zuvvaGYWIYY1jOD
 AiNw==
X-Gm-Message-State: AOAM530B+UJW6D9anJcQXMf4plO2NPtW36fIZvt6C50IG4weeANhLW9r
 nEPLp2Z5vCWi107N27twfhI=
X-Google-Smtp-Source: ABdhPJx2GRRqUU2+Cr7yJ5YBhc6a0I5jNMyBZCulKu/nM79DyvyGoqI9sZDCK3pfgieyEPrSo8O/4g==
X-Received: by 2002:a7b:c345:: with SMTP id l5mr8509428wmj.123.1601746737573; 
 Sat, 03 Oct 2020 10:38:57 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id f5sm5863555wmh.16.2020.10.03.10.38.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 10:38:56 -0700 (PDT)
Subject: Re: [PATCH v10 6/8] linux-user/elfload: Move PT_INTERP detection to
 first loop
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20201002215955.254866-1-richard.henderson@linaro.org>
 <20201002215955.254866-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b5a451fa-2f1f-17af-fadc-218eab051329@amsat.org>
Date: Sat, 3 Oct 2020 19:38:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201002215955.254866-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.252,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/2/20 11:59 PM, Richard Henderson wrote:
> For BTI, we need to know if the executable is static or dynamic,
> which means looking for PT_INTERP earlier.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 60 +++++++++++++++++++++++---------------------
>  1 file changed, 31 insertions(+), 29 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 735ebfa190..6b422990ff 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2421,8 +2421,10 @@ static void load_elf_image(const char *image_name, int image_fd,
>  
>      mmap_lock();
>  
> -    /* Find the maximum size of the image and allocate an appropriate
> -       amount of memory to handle that.  */
> +    /*
> +     * Find the maximum size of the image and allocate an appropriate
> +     * amount of memory to handle that.  Locate the interpreter, if any.
> +     */
>      loaddr = -1, hiaddr = 0;
>      info->alignment = 0;
>      for (i = 0; i < ehdr->e_phnum; ++i) {
> @@ -2438,6 +2440,33 @@ static void load_elf_image(const char *image_name, int image_fd,
>              }
>              ++info->nsegs;
>              info->alignment |= eppnt->p_align;
> +        } else if (eppnt->p_type == PT_INTERP && pinterp_name) {
> +            char *interp_name;
> +
> +            if (*pinterp_name) {
> +                errmsg = "Multiple PT_INTERP entries";
> +                goto exit_errmsg;
> +            }
> +            interp_name = malloc(eppnt->p_filesz);
> +            if (!interp_name) {
> +                goto exit_perror;
> +            }
> +
> +            if (eppnt->p_offset + eppnt->p_filesz <= BPRM_BUF_SIZE) {
> +                memcpy(interp_name, bprm_buf + eppnt->p_offset,
> +                       eppnt->p_filesz);
> +            } else {
> +                retval = pread(image_fd, interp_name, eppnt->p_filesz,
> +                               eppnt->p_offset);
> +                if (retval != eppnt->p_filesz) {

Preexisting, free(interp_name)?

> +                    goto exit_perror;
> +                }
> +            }
> +            if (interp_name[eppnt->p_filesz - 1] != 0) {
> +                errmsg = "Invalid PT_INTERP entry";

Ditto, otherwise:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +                goto exit_errmsg;
> +            }
> +            *pinterp_name = interp_name;
>          }
>      }
>  
> @@ -2590,33 +2619,6 @@ static void load_elf_image(const char *image_name, int image_fd,
>              if (vaddr_em > info->brk) {
>                  info->brk = vaddr_em;
>              }
> -        } else if (eppnt->p_type == PT_INTERP && pinterp_name) {
> -            char *interp_name;
> -
> -            if (*pinterp_name) {
> -                errmsg = "Multiple PT_INTERP entries";
> -                goto exit_errmsg;
> -            }
> -            interp_name = malloc(eppnt->p_filesz);
> -            if (!interp_name) {
> -                goto exit_perror;
> -            }
> -
> -            if (eppnt->p_offset + eppnt->p_filesz <= BPRM_BUF_SIZE) {
> -                memcpy(interp_name, bprm_buf + eppnt->p_offset,
> -                       eppnt->p_filesz);
> -            } else {
> -                retval = pread(image_fd, interp_name, eppnt->p_filesz,
> -                               eppnt->p_offset);
> -                if (retval != eppnt->p_filesz) {
> -                    goto exit_perror;
> -                }
> -            }
> -            if (interp_name[eppnt->p_filesz - 1] != 0) {
> -                errmsg = "Invalid PT_INTERP entry";
> -                goto exit_errmsg;
> -            }
> -            *pinterp_name = interp_name;
>  #ifdef TARGET_MIPS
>          } else if (eppnt->p_type == PT_MIPS_ABIFLAGS) {
>              Mips_elf_abiflags_v0 abiflags;
> 



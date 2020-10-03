Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D17C4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 18:06:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF4992067D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 18:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdXMINkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4992067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOlvg-0003me-RC
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 14:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOluO-0003EG-Lv; Sat, 03 Oct 2020 14:05:24 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36168)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOluM-00063H-NR; Sat, 03 Oct 2020 14:05:24 -0400
Received: by mail-wr1-x444.google.com with SMTP id z1so5231466wrt.3;
 Sat, 03 Oct 2020 11:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=72ehRcK0clln3px6bII9j4YNKa4x7LRH5BqJVf5H+Ks=;
 b=VdXMINkKqX20wds90+soT0Tf1YTXFuyaSqA0N1zxNKW7j+RgtTYHinKsjzzUqsQkHJ
 Z1m3AaJm3cfy70p3OG3g6nlhJPtcd1IcnyFu1yZma2AJE8Ree328LKtkoqDGaSEjdPCw
 dnEHHD4J0hPA/YFyrh2h6dm82cV6C6ZyvAZp+t2v0ExkGvBp+tXaImx6M76NS9vY+QMM
 c+X99qpzkWokZK+CkWa4OYJ29f0pg6Dsb3cnbczxRn/oJxp+0phVK3zUbcdr6TZh7UNW
 cozwiRe87QOZb5wL4KMwaj2RyNSc9lvmyzNV+WXmEfdclQsa33g2A0t0MXoUGka3nOAU
 Kowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=72ehRcK0clln3px6bII9j4YNKa4x7LRH5BqJVf5H+Ks=;
 b=pAUtv4FDqDBQ4sCi1VLm/axEL49nXcRbyOSTmww2gBZyffOFy2oIcFj+1hJua4YAnD
 z66nHkYc6g3L6xIu5Kj1VFNADWiRKMnAM5z74w59L/o/JujNpl7WjLxAwo25RsXd+kg4
 StEaSfiZ2muWgXCObg5uCt7pbcVp9IJfWb/XblyfkMNrQ6KBNXQsGZZmvlxZu9tSX0G+
 70ux8OLZGdPUjUGl3mrHsbNnrKH7wXjtKNTz0faGeltehqUa5CVer9p/T0W12CzgPv1t
 aOZxQ6XvwQ7gGB6V6c2+JdkQ93K86/Lb0zEHp7dnAyK22knLVIPgrig6XGDoHiQK4oJj
 Jlow==
X-Gm-Message-State: AOAM533dgQ/S2geDToyK9ydRvYV0QK+2b26kdFzgjq+Aic2BZjL7ft8f
 qfB09E5cpHQ0o+KoWbcQT3Q=
X-Google-Smtp-Source: ABdhPJwA1BUZ/y3E6rM5/X60eZcsQLG4X5/Q68jFdg+/z0acnZOEnM7+6FY9k88VSC+LHGfz8TQEOg==
X-Received: by 2002:a5d:4d48:: with SMTP id a8mr3014161wru.318.1601748321023; 
 Sat, 03 Oct 2020 11:05:21 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id l8sm6131075wrx.22.2020.10.03.11.05.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 11:05:20 -0700 (PDT)
Subject: Re: [PATCH v10 6/8] linux-user/elfload: Move PT_INTERP detection to
 first loop
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20201002215955.254866-1-richard.henderson@linaro.org>
 <20201002215955.254866-7-richard.henderson@linaro.org>
 <b5a451fa-2f1f-17af-fadc-218eab051329@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <ff6fe92b-7b7f-7448-5db2-0be0768df8b7@amsat.org>
Date: Sat, 3 Oct 2020 20:05:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <b5a451fa-2f1f-17af-fadc-218eab051329@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/3/20 7:38 PM, Philippe Mathieu-Daudé wrote:
> On 10/2/20 11:59 PM, Richard Henderson wrote:
>> For BTI, we need to know if the executable is static or dynamic,
>> which means looking for PT_INTERP earlier.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  linux-user/elfload.c | 60 +++++++++++++++++++++++---------------------
>>  1 file changed, 31 insertions(+), 29 deletions(-)
>>
>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> index 735ebfa190..6b422990ff 100644
>> --- a/linux-user/elfload.c
>> +++ b/linux-user/elfload.c
>> @@ -2421,8 +2421,10 @@ static void load_elf_image(const char *image_name, int image_fd,
>>  
>>      mmap_lock();
>>  
>> -    /* Find the maximum size of the image and allocate an appropriate
>> -       amount of memory to handle that.  */
>> +    /*
>> +     * Find the maximum size of the image and allocate an appropriate
>> +     * amount of memory to handle that.  Locate the interpreter, if any.
>> +     */
>>      loaddr = -1, hiaddr = 0;
>>      info->alignment = 0;
>>      for (i = 0; i < ehdr->e_phnum; ++i) {
>> @@ -2438,6 +2440,33 @@ static void load_elf_image(const char *image_name, int image_fd,
>>              }
>>              ++info->nsegs;
>>              info->alignment |= eppnt->p_align;
>> +        } else if (eppnt->p_type == PT_INTERP && pinterp_name) {
>> +            char *interp_name;
>> +
>> +            if (*pinterp_name) {
>> +                errmsg = "Multiple PT_INTERP entries";
>> +                goto exit_errmsg;
>> +            }
>> +            interp_name = malloc(eppnt->p_filesz);
>> +            if (!interp_name) {
>> +                goto exit_perror;
>> +            }
>> +
>> +            if (eppnt->p_offset + eppnt->p_filesz <= BPRM_BUF_SIZE) {
>> +                memcpy(interp_name, bprm_buf + eppnt->p_offset,
>> +                       eppnt->p_filesz);
>> +            } else {
>> +                retval = pread(image_fd, interp_name, eppnt->p_filesz,
>> +                               eppnt->p_offset);
>> +                if (retval != eppnt->p_filesz) {
> 
> Preexisting, free(interp_name)?

I just sent a patch using g_steal_pointer() instead:
https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg00792.html
(Maybe I should have tagged it RFC as this is the first
time I try this API).

> 
>> +                    goto exit_perror;
>> +                }
>> +            }
>> +            if (interp_name[eppnt->p_filesz - 1] != 0) {
>> +                errmsg = "Invalid PT_INTERP entry";
> 
> Ditto, otherwise:
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
>> +                goto exit_errmsg;
>> +            }
>> +            *pinterp_name = interp_name;
>>          }
>>      }
>>  
>> @@ -2590,33 +2619,6 @@ static void load_elf_image(const char *image_name, int image_fd,
>>              if (vaddr_em > info->brk) {
>>                  info->brk = vaddr_em;
>>              }
>> -        } else if (eppnt->p_type == PT_INTERP && pinterp_name) {
>> -            char *interp_name;
>> -
>> -            if (*pinterp_name) {
>> -                errmsg = "Multiple PT_INTERP entries";
>> -                goto exit_errmsg;
>> -            }
>> -            interp_name = malloc(eppnt->p_filesz);
>> -            if (!interp_name) {
>> -                goto exit_perror;
>> -            }
>> -
>> -            if (eppnt->p_offset + eppnt->p_filesz <= BPRM_BUF_SIZE) {
>> -                memcpy(interp_name, bprm_buf + eppnt->p_offset,
>> -                       eppnt->p_filesz);
>> -            } else {
>> -                retval = pread(image_fd, interp_name, eppnt->p_filesz,
>> -                               eppnt->p_offset);
>> -                if (retval != eppnt->p_filesz) {
>> -                    goto exit_perror;
>> -                }
>> -            }
>> -            if (interp_name[eppnt->p_filesz - 1] != 0) {
>> -                errmsg = "Invalid PT_INTERP entry";
>> -                goto exit_errmsg;
>> -            }
>> -            *pinterp_name = interp_name;
>>  #ifdef TARGET_MIPS
>>          } else if (eppnt->p_type == PT_MIPS_ABIFLAGS) {
>>              Mips_elf_abiflags_v0 abiflags;
>>
> 
> 


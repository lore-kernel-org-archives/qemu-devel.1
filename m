Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8FCC2BB55
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2211F206F5
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJ9N7RvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2211F206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMbMf-0008Eb-Bq
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 13:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42005)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jMbLI-0006JQ-Ab
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:51:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jMbLH-0004YL-76
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:51:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26612
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jMbLH-0004Xy-2l
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586454714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xHAvMus4cQyELNp/evLoJilV3gIxx/6KnNzPAd0tDNw=;
 b=VJ9N7RvS3p8UMQXBfmkLr8uP7qsTEO6Q/1hNY0O8+fN3dm7UFy+QQTo8HSTQQ6L0WoCPgt
 6vGuEd7AQ+HLeosMGbU5RdSMq2i4UdwO8p36BMfRIX2swby6WhbToworHFz8Avq78+mH/R
 8FkrNqJUdLAgWZyIRNy7PIErgzI7dgU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-LLTWKHT-M3q9mbZKiG7m6A-1; Thu, 09 Apr 2020 13:51:52 -0400
X-MC-Unique: LLTWKHT-M3q9mbZKiG7m6A-1
Received: by mail-ed1-f71.google.com with SMTP id n15so598756edq.6
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 10:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xHAvMus4cQyELNp/evLoJilV3gIxx/6KnNzPAd0tDNw=;
 b=GU4B7GzX46nF2Sb80cntBJb0qlQ4dgAp70SYrivbwjYWw16zwqsBJHNoMoWP3QJ2Sw
 qVCM/PA897RS4ELUJub7wCrXM9TEJNtbFdjjqVXFmefnAe0vW4eXO3vm8c4kiKudOAze
 yPiDwNfjWsX18EjEDZBRx2KumPLWH4qv9rVciey+SFr27DqU1G+uH6VGD+vwcSNiOBgt
 1HIFpIce87R/JK1k4woF5haoXbWDOzMx/4to8J3XiI4UvAx7rn8pKQgWeVsBuB/PyQyu
 TBO/Pgz3REVcEEerDHr5mQO164nlw59u3ByQTTHKgQ3srwtHRw13vj6tJMJe39h6949c
 VvZg==
X-Gm-Message-State: AGi0PuaodOIC7MNo5x8k3vnru+C1dMV8Hgj2FyyvqUxaonj4OmQFtNYv
 cXX5Nn+hfbr5AgeN8teshCuOCxNY7OS5hc9bRAXXiJb6x5ri9IPmO5iq1gzwn/IOiKFWLMmJsBM
 vaVQl025ZFx7dsnU=
X-Received: by 2002:a17:906:5045:: with SMTP id
 e5mr166936ejk.325.1586454711272; 
 Thu, 09 Apr 2020 10:51:51 -0700 (PDT)
X-Google-Smtp-Source: APiQypJO+tzaZOEfMAMnu9wdAnFxtRXYuLhxEOWMpaRsrXVk6EV2sHII7FSSCfTusSMdyJuB1tjpvQ==
X-Received: by 2002:a17:906:5045:: with SMTP id
 e5mr166921ejk.325.1586454711040; 
 Thu, 09 Apr 2020 10:51:51 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id p11sm3868406ejg.64.2020.04.09.10.51.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2020 10:51:50 -0700 (PDT)
Subject: Re: [PATCH 1/2] gdbstub: Assert len read from each register
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20200409164954.36902-1-peterx@redhat.com>
 <20200409164954.36902-2-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0121e4b2-c6dd-d0c4-a7d5-490e08bee923@redhat.com>
Date: Thu, 9 Apr 2020 19:51:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200409164954.36902-2-peterx@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/9/20 6:49 PM, Peter Xu wrote:
> This can expose the issue earlier on which register returned the wrong
> result.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   gdbstub.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index 171e150950..f763545e81 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -911,17 +911,22 @@ static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
>       CPUClass *cc = CPU_GET_CLASS(cpu);
>       CPUArchState *env = cpu->env_ptr;
>       GDBRegisterState *r;
> +    int len = 0, orig_len = buf->len;
>   
>       if (reg < cc->gdb_num_core_regs) {
> -        return cc->gdb_read_register(cpu, buf, reg);
> +        len = cc->gdb_read_register(cpu, buf, reg);

This change the code flow. We could add ...:

            goto out;

>       }

... or use else?
>   
>       for (r = cpu->gdb_regs; r; r = r->next) {
>           if (r->base_reg <= reg && reg < r->base_reg + r->num_regs) {
> -            return r->get_reg(env, buf, reg - r->base_reg);
> +            len = r->get_reg(env, buf, reg - r->base_reg);
> +            break;
>           }
>       }
> -    return 0;
> +

   out:

> +    assert(len == buf->len - orig_len);
> +
> +    return len;
>   }
>   
>   static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
> 



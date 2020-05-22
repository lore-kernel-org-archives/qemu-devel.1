Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3189DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 09:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E77AE206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 09:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sjECViaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E77AE206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc46X-0003TX-2B
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 05:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jc45a-00028c-PC
 for qemu-devel@nongnu.org; Fri, 22 May 2020 05:35:38 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42534)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jc45a-0005Hq-2K
 for qemu-devel@nongnu.org; Fri, 22 May 2020 05:35:38 -0400
Received: by mail-wr1-x442.google.com with SMTP id s8so9479623wrt.9
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 02:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zAQG1IpH8KfOAxjSTLU1w8BZn2Tk2dM/AGSdE3VkbgY=;
 b=sjECViaWlC3E4Nb71aHVb3Bno3XUO4t+Qu18y9U4h2hVzglnVI3hnnNLovYo0VM3fs
 vqxoCZuU6BDD1SObA2cgrmQQ18QEAN0PzuFFqprLrfksfDielm/SRJk8BZGXTZCWbRGj
 t7ZrWqTrv7mKIjKF5gMftqOEAYnhcAPhoSbbuuxrsf8BiGRFXuxmoLluyAV6Zy7D7V7U
 JK9wtO79T5/CQQ0Cd5IQWjz3LWqzvFOxfPikxlUNtIPQYC96gMzKGWOO99J1PANEUeH5
 NSXBqk/9olF7tW9SWRG0mf+QeOFm9cL23Gx0jEQnu77nDcmu2eJFWtpsyY8zj++cLKgr
 /03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zAQG1IpH8KfOAxjSTLU1w8BZn2Tk2dM/AGSdE3VkbgY=;
 b=NWMjc10q6jlkdg7/8pF+ne07Tscbxz/vgcYgeHTstzdZsbkanHpjAmk26j+nAShE6l
 VS6MG5PL/EZpJoKfvlCPZnEeiMPFnviF9HwTLkjeT5BL40MJOKEUQZwA3h2FRklICowU
 cgEl+bYXwOyl+YRbgDi9vlIN5awPZlQ4Xrf0cN1ZdPU2Wu0yXtLZUjTaOc/1y2xZMG2w
 FE5tY4HnURAIwKthk8Bu1ljpiP1E6c2mWYTfcUtOZHCZn9YML1h1pmRHkVrwKEeEZQMC
 FVdyT/XVnZcxkTbYwyisALNpPTwaop677qegyskisbyWQ9vsk7ByIjYwk7ftFTk08ADI
 0BTg==
X-Gm-Message-State: AOAM533b2RObELdyn0tkHkxT9IvubzAa54jPTxsafImwkX4q+2RiVdoZ
 bHjEbqy5JhUsqFq/2r5snq0=
X-Google-Smtp-Source: ABdhPJyv4GmP49GSOqlV2EFYIEQ6l90Wy7f9fK97XAfa/KPEfHRDcY2Hxmbg8rrLpukHG5mpTNRULQ==
X-Received: by 2002:a5d:5404:: with SMTP id g4mr2611144wrv.310.1590140135806; 
 Fri, 22 May 2020 02:35:35 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id w15sm8797533wmi.35.2020.05.22.02.35.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2020 02:35:34 -0700 (PDT)
Subject: Re: [PATCH v1 6/8] linux-user: properly "unrealize" vCPU object
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200513173200.11830-1-alex.bennee@linaro.org>
 <20200513173200.11830-7-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c4e8691c-4a80-aade-383c-4319fc810112@amsat.org>
Date: Fri, 22 May 2020 11:35:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200513173200.11830-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Nikolay Igotti <igotti@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Paolo

On 5/13/20 7:31 PM, Alex Bennée wrote:
> We shouldn't be messing around with the CPU list in linux-user save
> for the very special case of do_fork(). When threads end we need to
> properly follow QOM object lifetime handling and allow the eventual
> cpu_common_unrealizefn to both remove the CPU and ensure any clean-up
> actions are taken place, for example calling plugin exit hooks.
> 
> There is still a race condition to avoid so use the linux-user
> specific clone_lock instead of the cpu_list_lock to avoid it.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Nikolay Igotti <igotti@gmail.com>

I dare to add:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

But I'd rather see someone else reviewing this too.

> ---
>   linux-user/syscall.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 05f03919ff0..7f6700c54e3 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7635,30 +7635,33 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>               return -TARGET_ERESTARTSYS;
>           }
>   
> -        cpu_list_lock();
> +        pthread_mutex_lock(&clone_lock);
>   
>           if (CPU_NEXT(first_cpu)) {
> -            TaskState *ts;
> +            TaskState *ts = cpu->opaque;
>   
> -            /* Remove the CPU from the list.  */
> -            QTAILQ_REMOVE_RCU(&cpus, cpu, node);
> +            object_property_set_bool(OBJECT(cpu), false, "realized", NULL);
> +            object_unref(OBJECT(cpu));
> +            /*
> +             * At this point the CPU should be unrealized and removed
> +             * from cpu lists. We can clean-up the rest of the thread
> +             * data without the lock held.
> +             */
>   
> -            cpu_list_unlock();
> +            pthread_mutex_unlock(&clone_lock);
>   
> -            ts = cpu->opaque;
>               if (ts->child_tidptr) {
>                   put_user_u32(0, ts->child_tidptr);
>                   do_sys_futex(g2h(ts->child_tidptr), FUTEX_WAKE, INT_MAX,
>                             NULL, NULL, 0);
>               }
>               thread_cpu = NULL;
> -            object_unref(OBJECT(cpu));
>               g_free(ts);
>               rcu_unregister_thread();
>               pthread_exit(NULL);
>           }
>   
> -        cpu_list_unlock();
> +        pthread_mutex_unlock(&clone_lock);
>           preexit_cleanup(cpu_env, arg1);
>           _exit(arg1);
>           return 0; /* avoid warning */
> 



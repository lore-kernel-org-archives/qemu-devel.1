Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABF5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:04:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0460320720
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDhRIC2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0460320720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtY6c-0003mf-AK
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 11:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtY5g-0002oO-5K
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:04:00 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39151)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtY5e-0007Pv-KQ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:03:59 -0400
Received: by mail-wm1-x341.google.com with SMTP id w3so2171219wmi.4
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 08:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vADevtxFhmWj3f8IZD4QnL2FeGMjwJbFL8FD0oWL1Jg=;
 b=cDhRIC2zLYFS1dWdVQ3Smkr9bmcpxSx9NeD3tbJqi/xLn0FQvnYj9smfIJNswBcSFu
 4C4GknGYN5CKx/eq+DMyFFBO9CLDWqbPcz04rKcu8ZfD7ZHsHDvD2nqZFDvRDwIYY9Sv
 DuONkncMFezFLe5u/N2x4Hp+RF9ZDVD0XUxLOYNgL3KJl1ob39Oy3H+MigubYm7NGJbk
 G8vjPS94V/kkJ/7Ebrvkixxxl504zTsSeyjFM8D+Bd/EsYLNdtmxLlT0bJbiZolK5/0Y
 jZxfjDB8L71w1DAFGf61T5J72n5Afti12dsbyUGT0qwq5ze7cNwtYxzcmdMmK/JMmstY
 dpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vADevtxFhmWj3f8IZD4QnL2FeGMjwJbFL8FD0oWL1Jg=;
 b=r5dlWR9HjC9vZC0C4VmkrtaGzecNHBwGU2hrIdP9v4rynIZXqPQpcUKY4qlboQs8NJ
 g0f6c5u7W6aSdRx+MndoPKQ1FFqF+DWIi+1UYYY1KDQS9EvcpRSfdOh3uWvrL4Pubs4X
 vAW5vv81qxGB8Mn2PBgovvpk+qD3aRvl2gbogFm5ttDuh+TEYunRElG4iWqAaEQAhOFi
 6eI7AKHE/FBia7PhXXvSXdy9/vzPWNuQKqgdorpGidu4pVkFYF05hKbMJ23YGzEzMJBP
 UUYidAfKHhb8DHOK18F5CVci3LcTqLBuvvEQbvWN1JbulVHKEWIu+TCGADwmumsfKjyO
 6GAw==
X-Gm-Message-State: AOAM532rvTM5Cpm20vu2zi+f/kY5aaAyDziwoYnGYgOFETZ4RWi5d1hQ
 MFoucXGjYxEZIndFbZdvzKY=
X-Google-Smtp-Source: ABdhPJxVNk8C8XyenzNEHP9kwSo8OBKfIeEnO6K3S7TbLmwaETJgchyPRQMhwGF/6gLWHION3tR1Hw==
X-Received: by 2002:a1c:bc8a:: with SMTP id m132mr442177wmf.1.1594307035943;
 Thu, 09 Jul 2020 08:03:55 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id p8sm6048381wrq.29.2020.07.09.08.03.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2020 08:03:55 -0700 (PDT)
Subject: Re: [PATCH v1 06/13] plugins: add API to return a name for a IO device
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200709141327.14631-1-alex.bennee@linaro.org>
 <20200709141327.14631-7-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <727b74da-1af1-400c-f2e8-2434fb842478@amsat.org>
Date: Thu, 9 Jul 2020 17:03:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200709141327.14631-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: fam@euphon.net, "Daniel P . Berrange" <berrange@redhat.com>,
 robert.foley@linaro.org, richard.henderson@linaro.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, peter.puhov@linaro.org,
 kuhn.chenqun@huawei.com, Clement Deschamps <clement.deschamps@greensocs.com>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 4:13 PM, Alex Bennée wrote:
> This may well end up being anonymous but it should always be unique.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> [r-b provisional given change to g_intern_string]
> Reviewed-by: Clement Deschamps <clement.deschamps@greensocs.com>
> Reviewed-by: Emilio G. Cota <cota@braap.org>
> 
> ---
> v3
>   - return a non-freeable const g_intern_string()
>   - checkpatch cleanups
> ---
>  include/qemu/qemu-plugin.h |  6 ++++++
>  plugins/api.c              | 20 ++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index bab8b0d4b3af..c98c18d6b052 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -335,6 +335,12 @@ struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
>  bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr);
>  uint64_t qemu_plugin_hwaddr_device_offset(const struct qemu_plugin_hwaddr *haddr);
>  
> +/*
> + * Returns a string representing the device. The string is valid for
> + * the lifetime of the plugin.
> + */
> +const char *qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *h);
> +
>  typedef void
>  (*qemu_plugin_vcpu_mem_cb_t)(unsigned int vcpu_index,
>                               qemu_plugin_meminfo_t info, uint64_t vaddr,
> diff --git a/plugins/api.c b/plugins/api.c
> index bbdc5a4eb46d..4304e63f0cf8 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -303,6 +303,26 @@ uint64_t qemu_plugin_hwaddr_device_offset(const struct qemu_plugin_hwaddr *haddr
>      return 0;
>  }
>  
> +const char *qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *h)
> +{
> +#ifdef CONFIG_SOFTMMU
> +    if (h && h->is_io) {
> +        MemoryRegionSection *mrs = h->v.io.section;
> +        if (!mrs->mr->name) {
> +            unsigned long maddr = 0xffffffff & (uintptr_t) mrs->mr;

Why not use uint32_t & PRIx32?

               uint32_t maddr = (uintptr_t) mrs->mr;

> +            g_autofree char *temp = g_strdup_printf("anon%08lx", maddr);
> +            return g_intern_string(temp);

Isn't this illegal? temp is definitively not const...

> +        } else {
> +            return g_intern_string(mrs->mr->name);
> +        }
> +    } else {
> +        return g_intern_string("RAM");
> +    }
> +#else
> +    return g_intern_string("Invalid");
> +#endif
> +}
> +
>  /*
>   * Queries to the number and potential maximum number of vCPUs there
>   * will be. This helps the plugin dimension per-vcpu arrays.
> 


Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882C4C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 16:10:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AC5A206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 16:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="gOUFDwme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC5A206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg9V7-00066W-EA
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 12:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.deschamps@greensocs.com>)
 id 1jg9RG-0002fC-34
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 12:06:54 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:56804)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.deschamps@greensocs.com>)
 id 1jg9RE-0003Ho-C5
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 12:06:53 -0400
Received: from [192.168.1.54] (32.0.26.109.rev.sfr.net [109.26.0.32])
 by beetle.greensocs.com (Postfix) with ESMTPSA id DF40996D3C;
 Tue,  2 Jun 2020 16:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1591114007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xkLke8EFAx/VbKDFCqb6NE+Gy7jsTCysfMVAVbTAIHU=;
 b=gOUFDwmeIsN9rQthWYXpj3ti5CpE2HYkwBmnnZFs2ciQ6ImcrM2MUD/CDLgkOzzL8Nr9YT
 o3SrM2QuqUNBPKmf3frSsVodWCmFm1iOX+cABUBBvOfg239aJBHLHsDlvAf3K6gnIfNq0n
 KEi6K9SmfziN5FqTFILZRHXPD9VXkgs=
Subject: Re: [PATCH v1 7/9] plugins: add API to return a name for a IO device
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200602154624.4460-1-alex.bennee@linaro.org>
 <20200602154624.4460-8-alex.bennee@linaro.org>
From: Clement Deschamps <clement.deschamps@greensocs.com>
Message-ID: <9d4cf569-4c6b-3800-d2b4-e84c5db0a85a@greensocs.com>
Date: Tue, 2 Jun 2020 18:06:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200602154624.4460-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.135.226.135;
 envelope-from=clement.deschamps@greensocs.com; helo=beetle.greensocs.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 12:06:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
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
Cc: robert.foley@linaro.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, peter.puhov@linaro.org,
 kuhn.chenqun@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 6/2/20 5:46 PM, Alex Bennée wrote:
> This may well end up being anonymous but it should always be unique.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   include/qemu/qemu-plugin.h |  5 +++++
>   plugins/api.c              | 18 ++++++++++++++++++
>   2 files changed, 23 insertions(+)
> 
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index bab8b0d4b3a..43c6a9e857f 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -335,6 +335,11 @@ struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
>   bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr);
>   uint64_t qemu_plugin_hwaddr_device_offset(const struct qemu_plugin_hwaddr *haddr);
>   
> +/*
> + * Returns a string representing the device. Plugin must free() it

s/free/g_free


> + */
> +char * qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *haddr);
> +
>   typedef void
>   (*qemu_plugin_vcpu_mem_cb_t)(unsigned int vcpu_index,
>                                qemu_plugin_meminfo_t info, uint64_t vaddr,
> diff --git a/plugins/api.c b/plugins/api.c
> index bbdc5a4eb46..3c73de8c1c2 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -303,6 +303,24 @@ uint64_t qemu_plugin_hwaddr_device_offset(const struct qemu_plugin_hwaddr *haddr
>       return 0;
>   }
>   
> +char * qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *haddr)
> +{
> +#ifdef CONFIG_SOFTMMU
> +    if (haddr && haddr->is_io) {
> +        MemoryRegionSection *mrs = haddr->v.io.section;
> +        if (!mrs->mr->name) {
> +            return g_strdup_printf("anon%08lx", 0xffffffff & (uintptr_t) mrs->mr);
> +        } else {
> +            return g_strdup(mrs->mr->name);
> +        }
> +    } else {
> +        return g_strdup("RAM");
> +    }
> +#else
> +    return g_strdup("Invalid");
> +#endif
> +}
> +
>   /*
>    * Queries to the number and potential maximum number of vCPUs there
>    * will be. This helps the plugin dimension per-vcpu arrays.
> 

Reviewed-by: Clement Deschamps <clement.deschamps@greensocs.com>


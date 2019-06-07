Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8266C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 14:17:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 906E2206E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 14:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906E2206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51604 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZFgq-0002gv-SO
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 10:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48741)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZFVM-0002Ol-J3
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZFVK-0002s1-Am
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:06:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37475)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZFVI-0000Hw-Aq
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:06:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id 22so2050546wmg.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 07:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QaEXhgGxTkEuUnt5fl83xiXadZpSnT3DsreXx9095N8=;
 b=AuQQ3ZJFkjzwy1oB4mFqRR1vRp2nCqcYycbyQX+oSNkK/vgP0wgQ8u0QdprA5HzV+j
 7rO2zfbUEZmxCamwMskvtOD/chRu5HH+4d7o4ZxP61nM1vc/ZhjC/sGVMrzBuHafXJqi
 znI8g/+t1mXo1DC+ZbX9r3KSZ0nf4kq49C4y94wfAlNcJLHAxTTO4kSM7A7uTOp9wmZt
 IWfmfqTE7ciCrxtSlsrvwBMGfLwQW/7HigYVTTD49ujiW2HTLTat90PRpVLKp1LbokM3
 5qAQoXR9rzuSh/cPKslp1oG/HblC0x9+OQgO0ASBnXjvTn2fjMBzuTjhBzqU5nXHoIGz
 Vaug==
X-Gm-Message-State: APjAAAVLmXqpdT3FYPNB10vKYwzEdHMGGVD2JSHUCAovllPiYeK8w0vA
 Wu6SQpHQw7X3F1uQ4WwDfCrgNQ==
X-Google-Smtp-Source: APXvYqzgLIkfiMmVJidTtXmlqkVFC+sKUYL7zMH1BSp1p8croif2srmm44Yn7mzTLWKCKw5gm52nDw==
X-Received: by 2002:a1c:f50f:: with SMTP id t15mr3924402wmh.95.1559916287895; 
 Fri, 07 Jun 2019 07:04:47 -0700 (PDT)
Received: from [192.168.0.156] ([78.192.181.46])
 by smtp.gmail.com with ESMTPSA id f21sm2205065wmb.2.2019.06.07.07.04.47
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 07:04:47 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190607091116.49044-1-ysato@users.sourceforge.jp>
 <20190607091116.49044-25-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <32bb6ea7-2bd3-5c48-095f-f0adf1205a2d@redhat.com>
Date: Fri, 7 Jun 2019 16:04:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607091116.49044-25-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v17 24/24] target/rx: Remove suffix in cpu
 class.
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/7/19 11:11 AM, Yoshinori Sato wrote:
> New CPUs should not be suffixed like other devices.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  include/hw/rx/rx62n.h | 2 +-
>  target/rx/cpu.h       | 3 +--
>  target/rx/cpu.c       | 8 ++------
>  3 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/rx/rx62n.h b/include/hw/rx/rx62n.h
> index 5f6912fe46..e57c5ec091 100644
> --- a/include/hw/rx/rx62n.h
> +++ b/include/hw/rx/rx62n.h
> @@ -30,7 +30,7 @@
>  #include "target/rx/cpu.h"
>  #include "qemu/units.h"
>  
> -#define TYPE_RX62N "rx62n"
> +#define TYPE_RX62N "rx62n-mcu"
>  #define TYPE_RX62N_CPU RX_CPU_TYPE_NAME(TYPE_RX62N)
>  #define RX62N(obj) OBJECT_CHECK(RX62NState, (obj), TYPE_RX62N)
>  
> diff --git a/target/rx/cpu.h b/target/rx/cpu.h
> index a0b6975963..080ea604a3 100644
> --- a/target/rx/cpu.h
> +++ b/target/rx/cpu.h
> @@ -164,8 +164,7 @@ static inline RXCPU *rx_env_get_cpu(CPURXState *env)
>  
>  #define ENV_OFFSET offsetof(RXCPU, env)
>  
> -#define RX_CPU_TYPE_SUFFIX "-" TYPE_RX_CPU
> -#define RX_CPU_TYPE_NAME(model) model RX_CPU_TYPE_SUFFIX
> +#define RX_CPU_TYPE_NAME(model) model
>  #define CPU_RESOLVING_TYPE TYPE_RX_CPU
>  
>  extern const char rx_crname[][6];
> diff --git a/target/rx/cpu.c b/target/rx/cpu.c
> index 41fe1de4bb..d8c662b231 100644
> --- a/target/rx/cpu.c
> +++ b/target/rx/cpu.c
> @@ -72,9 +72,8 @@ static void rx_cpu_reset(CPUState *s)
>  static void rx_cpu_list_entry(gpointer data, gpointer user_data)
>  {
>      const char *typename = object_class_get_name(OBJECT_CLASS(data));
> -    int len = strlen(typename) - strlen(RX_CPU_TYPE_SUFFIX);
>  
> -    qemu_printf("  %.*s\n", len, typename);
> +    qemu_printf("  %s\n",  typename);
>  }
>  
>  void rx_cpu_list(void)
> @@ -89,11 +88,8 @@ void rx_cpu_list(void)
>  static ObjectClass *rx_cpu_class_by_name(const char *cpu_model)
>  {
>      ObjectClass *oc;
> -    char *typename;
>  
> -    typename = g_strdup_printf(RX_CPU_TYPE_NAME("%s"), cpu_model);
> -    oc = object_class_by_name(typename);
> -    g_free(typename);
> +    oc = object_class_by_name(cpu_model);
>  
>      if (oc == NULL ||
>          object_class_is_abstract(oc) ||
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


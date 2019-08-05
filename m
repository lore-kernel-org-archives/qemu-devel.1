Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3378EC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:45:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 069D421871
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 069D421871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huXgG-0001qD-AR
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 03:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42398)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1huXfe-00010E-Ar
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:44:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1huXfc-0001Lh-Fx
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:44:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35918)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1huXfc-0001LX-49
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:44:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id g67so67862409wme.1
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 00:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=m03PCsGdvBc7fZAXLML0yzUU39qLu+S2NTitAiydaGs=;
 b=fsZ6gFbAFTRz9ip+QJ9yiUzfHRWPMr4tKJw5OsgfGNwKFrbCK7SjPnCf+oueAlXDhe
 oU3ho5k5oJyD+UIQ9OTngaAJpkNlTT5yLYhlyL1CiYEm+r4nK0sYDF4lDl2OH9B8GuI4
 oh75fTy57N7XgP9OWylw790ERhwf8jsRNDC7e8ByYM/7+sgmTQ1VVV7/xVzQ/v4wsoXB
 cya7X2kz8NdTDgCPlc/ZHhrs/lPmPBtdcKaZFpHQNiDZME9NzpMW8ZcFYLnQsqg2asrs
 HD31jDTLfcvCm3BEooYHWo0qzYS1ZOPkfVQfZAzfNCBUW7oaJ0IeaIaErb1ZDZLnFPDo
 B+Jg==
X-Gm-Message-State: APjAAAU7jTaY2XWgyUjLfb+ayJYqeOtNRsQLU8rBbsxAyTuFEQP1LvsT
 BLRyLdmEIamkoDprkBWBD14UaA==
X-Google-Smtp-Source: APXvYqwYLK5BBugfAKBuI3rNvaxWbmA1OglZiee9hA6CkSyT70dbB8FIp1YmtLsIEpuDt5hegMLSLA==
X-Received: by 2002:a7b:c383:: with SMTP id s3mr17198859wmj.44.1564991079173; 
 Mon, 05 Aug 2019 00:44:39 -0700 (PDT)
Received: from [192.168.178.40] ([151.21.165.91])
 by smtp.gmail.com with ESMTPSA id r123sm83872027wme.7.2019.08.05.00.44.38
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Aug 2019 00:44:38 -0700 (PDT)
To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190805071038.32146-1-alxndr@bu.edu>
 <20190805071038.32146-5-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <23fb91b9-0431-045f-dff1-1764bf751f72@redhat.com>
Date: Mon, 5 Aug 2019 09:44:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805071038.32146-5-alxndr@bu.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [RFC PATCH v2 04/17] fuzz: Skip modules that were
 already initialized
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
Cc: "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/08/19 09:11, Oleinik, Alexander wrote:
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  util/module.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/util/module.c b/util/module.c
> index 142db7e911..3d4380fd47 100644
> --- a/util/module.c
> +++ b/util/module.c
> @@ -30,6 +30,7 @@ typedef struct ModuleEntry
>  typedef QTAILQ_HEAD(, ModuleEntry) ModuleTypeList;
>  
>  static ModuleTypeList init_type_list[MODULE_INIT_MAX];
> +static bool modules_init_done[MODULE_INIT_MAX];
>  
>  static ModuleTypeList dso_init_list;
>  
> @@ -91,11 +92,17 @@ void module_call_init(module_init_type type)
>      ModuleTypeList *l;
>      ModuleEntry *e;
>  
> +    if (modules_init_done[type]) {
> +        return;
> +    }
> +
>      l = find_type(type);
>  
>      QTAILQ_FOREACH(e, l, node) {
>          e->init();
>      }
> +
> +    modules_init_done[type] = true;
>  }
>  
>  #ifdef CONFIG_MODULES
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>


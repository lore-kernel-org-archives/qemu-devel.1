Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96468C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 09:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A9C920B7C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 09:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9C920B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhsqq-0003uK-P4
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 05:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50629)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhsji-0005a5-Er
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhsjh-0004i2-I6
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:36:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36895)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hhsjh-0004O8-CJ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:36:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14so12997507wrr.4
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 02:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Q+oHhSEDVk1V3F4XlEadg1hm9TLVHLm0W+JZwisqOns=;
 b=BMqki8lOFxeEG2KwsLgvrO6XJ/aJsd5QfXUr58aouznXckx744yrah8QtqkrYFdZmO
 nabkg6sRmKDILcrfsUYnWbFjapPynYeNqGcT+mhm/cdfO2ErlNMYqpbyPsFxF4dQ7A8t
 LVRcALtXICDQyv+ewPGqdqszAlY8C0jXLiIEB6cJBRH4qnkfaTpNIRIta144DOek+h4m
 GiMJJaQdQh1gLfNPuywNnzKuglAMf0+UsQhcKGbw416ptu0G2dSvoD59uRVmXQQO6LXF
 9YbbVaFEX/a9zAOPjIQJu+7XSuauoOVUI4S6hKtVQzepOE3v+xkmIyRiWlg09TBH50AT
 w7Sg==
X-Gm-Message-State: APjAAAWKyPTNkVjbHj65Cf4PmZgxcFdtJrIzi7MITzDymvH+VuLApt5c
 G/HnieAj/29fRl0MBDEr/naO8A==
X-Google-Smtp-Source: APXvYqwbHlfkYHq20WzcJ+vbHfLlaZxs9OQYvgDCMCfV/fglvlx5IRL/wrwO4GuklFJ6fj+BrozByw==
X-Received: by 2002:adf:f38b:: with SMTP id m11mr18241660wro.79.1561973767995; 
 Mon, 01 Jul 2019 02:36:07 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id a84sm10609728wmf.29.2019.07.01.02.36.07
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jul 2019 02:36:07 -0700 (PDT)
To: Jan Kiszka <jan.kiszka@web.de>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
References: <fc5404f7-4d1d-c28f-6e48-d8799c82acc0@web.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <098adaad-e787-3d5d-a145-5c4999aa32fe@redhat.com>
Date: Mon, 1 Jul 2019 11:36:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <fc5404f7-4d1d-c28f-6e48-d8799c82acc0@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH] hw/arm/virt: Add support for Cortex-A7
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/19 5:13 PM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> No reason to deny this type.

Maybe add "As the A15, it supports the EL2/V7VE features."?

> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  hw/arm/virt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 431e2900fd..ed009fa447 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -176,6 +176,7 @@ static const int a15irqmap[] = {
>  };
> 
>  static const char *valid_cpus[] = {
> +    ARM_CPU_TYPE_NAME("cortex-a7"),
>      ARM_CPU_TYPE_NAME("cortex-a15"),
>      ARM_CPU_TYPE_NAME("cortex-a53"),
>      ARM_CPU_TYPE_NAME("cortex-a57"),

Should we list here all cpu with arm_feature(ARM_FEATURE_V7VE | V8)? or EL2?

> --
> 2.16.4
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


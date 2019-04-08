Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD803C282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 21:28:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADAB220857
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 21:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADAB220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59248 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDboA-0007WK-MU
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 17:28:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDbnM-0007DI-23
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 17:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDbnK-0006zC-SD
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 17:27:11 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:45400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDbnK-0006wf-IR
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 17:27:10 -0400
Received: by mail-wr1-f47.google.com with SMTP id s15so18074940wra.12
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 14:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=81POff/Hje0xCqGDhoAlt8sV20pWTtizAfln2Dwvhv4=;
	b=Thvk8v0muB77MQ/Fxnbk3P3eY8g8Xj/1+8nAuSioJlqo4t9TiOEvfZrT1el1V+GF+B
	2acqiDyQFgWprDomC3zjvp+0icu4YkdtHatB/CSSvXSOH7dUaPU6hP8HmZI/mAgbYati
	kdyqme6jSObWDZDwqK+hijvSAJBiaLpm3NX13jevm4nOFM8KVbKoirppFinnMBIY9zI3
	FYvBxYdMYxI95MO0oOq8WrVbL8gx6zq+DfOfIIzAPSyX9flKjHTev0zcc7yZTkfqsSuY
	Q7TeoaVKJupEYA7hf4rlqNs2lPFFai5VQF/rVkNLpXue2bLo6jBkdsGvG7SMi3Y46pOz
	EfWg==
X-Gm-Message-State: APjAAAVnYoy/k41ZG5Hep6AmYM//bHI30iCJhYgYS69VeB86s/Fni/WL
	n2teXehKSq7EBfbG7txgqraTNw==
X-Google-Smtp-Source: APXvYqwqyYBE7zW5RsMm/zw6t1xLXcxfWOtuooXeZzGh4HZIfUJgE5c80IPgIlbfF2WI/39KZiLbFQ==
X-Received: by 2002:adf:cf0e:: with SMTP id o14mr19432667wrj.182.1554758829228;
	Mon, 08 Apr 2019 14:27:09 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	a6sm25900055wrp.49.2019.04.08.14.27.08
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 Apr 2019 14:27:08 -0700 (PDT)
To: Lidong Chen <lidong.chen@oracle.com>, qemu-devel@nongnu.org
References: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d35048f6-44e7-46a0-3d70-51123896f1ef@redhat.com>
Date: Mon, 8 Apr 2019 23:27:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.47
Subject: Re: [Qemu-devel] [PATCH] sd: Fix out-of-bounds assertions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: darren.kenny@oracle.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408212707.vay78DRM8vGtvTuMQ8K4YQyc9VqSWjrUngac6dauwoo@z>

Hi Lidong

On 4/8/19 9:04 PM, Lidong Chen wrote:
> Due to an off-by-one error, the assert statements allow an
> out-of-bounds array access.

... which can't happen. Thus harmless for 4.0.

I suppose this is a static analysis warning and you didn't triggered it
while tracing.

Thanks for cleaning this :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Signed-off-by: Lidong Chen <lidong.chen@oracle.com>
> ---
>  hw/sd/sd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index aaab15f..818f86c 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -144,7 +144,7 @@ static const char *sd_state_name(enum SDCardStates state)
>      if (state == sd_inactive_state) {
>          return "inactive";
>      }
> -    assert(state <= ARRAY_SIZE(state_name));
> +    assert(state < ARRAY_SIZE(state_name));
>      return state_name[state];
>  }
>  
> @@ -165,7 +165,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
>      if (rsp == sd_r1b) {
>          rsp = sd_r1;
>      }
> -    assert(rsp <= ARRAY_SIZE(response_name));
> +    assert(rsp < ARRAY_SIZE(response_name));
>      return response_name[rsp];
>  }
>  
> 


Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87035C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 08:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60D2320866
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 08:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D2320866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37630 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYRf4-0000SE-CV
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 04:52:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hYReE-0008T0-AO
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 04:51:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hYReD-00088S-9f
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 04:51:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38137)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hYReD-00084z-49
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 04:51:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id t5so1387084wmh.3
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 01:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=kGzHtjP0mDkJOxTVm+4nhftlxU2ng0j2pNJCF/dElDI=;
	b=hHiGToHAj6FVQzPc9GyIxrOVkD1pXCLiQtGN9PlSLZATKISHavb3tpakHfYcLS+H/z
	GYVLwdMvL4ai5LQkh6p6mhMvitQSeK3EelZdHj5HymKDnr1EWjGtywzfVntlJtajpGA0
	Lzg1UN1J/aZp4Vm7kD5GEomOpoH+T4ILixqkmJTPO8C1NLWOgn6muS0pLTmLK400IGfp
	Xpehrta9J2oU79x0pQ+dwgJxbtWTszScy9re+zu4b4BjaftMYv8/U0f0m4tRA4qIefOr
	hp7A8mFEkPUQsNPSAtQl1EYCefohdDQE9OP8UnLJiHTTF8ZVEkMKuD1QKwRCskRJL59Z
	bIIQ==
X-Gm-Message-State: APjAAAXPKA+iST93Rl64umzXM78oU2Bv3UrmAe4M3kGO3rjGvSQumSKq
	nvSZvG9L3oidjesi/b1tRZm3Kw==
X-Google-Smtp-Source: APXvYqwzG87p3vncdRHnB48blkyVSRHGHK8rAjoHgEaPK3KqF1bmey4gWtf1OTGxSHZUksQa2kBkxA==
X-Received: by 2002:a1c:9c08:: with SMTP id f8mr3735844wme.143.1559724711070; 
	Wed, 05 Jun 2019 01:51:51 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183])
	by smtp.gmail.com with ESMTPSA id s9sm17316241wmc.1.2019.06.05.01.51.49
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 01:51:50 -0700 (PDT)
To: Lidong Chen <lidong.chen@oracle.com>, qemu-devel@nongnu.org
References: <cover.1559710447.git.lidong.chen@oracle.com>
	<6b19cb7359a10a6bedc3ea0fce22fed3ef93c102.1559710447.git.lidong.chen@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <0210503a-2309-4d6b-e956-d0d590076de3@redhat.com>
Date: Wed, 5 Jun 2019 10:51:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6b19cb7359a10a6bedc3ea0fce22fed3ef93c102.1559710447.git.lidong.chen@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [Qemu-devel PATCH v2 1/2] sd: Fix out-of-bounds
 assertions
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, liran.alon@oracle.com,
	liq3ea@gmail.com, armbru@redhat.com, darren.kenny@oracle.com,
	marcandre.lureau@gmail.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/19 8:21 AM, Lidong Chen wrote:
> Due to an off-by-one error, the assert statements allow an
> out-of-bound array access.

Not sure via which tree this patch is going (trivial?).
To the maintainer, please consider adding when applying:

"This access can not happen. Fix to silent static analyzer warnings."

As confirmed by Lidong in v1 here:
https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01337.html

Thanks,

Phil.

> Signed-off-by: Lidong Chen <lidong.chen@oracle.com>
> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Li Qiang <liq3ea@gmail.com>
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
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


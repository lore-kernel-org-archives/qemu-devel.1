Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CFEC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 12:49:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 879442184C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 12:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879442184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjNeW-0000Mb-P8
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 08:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56789)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hjNaf-0007My-Je
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 08:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hjNac-00066Y-Lc
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 08:45:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43631)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hjNab-0005pd-Ab
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 08:45:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so9785211wru.10
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 05:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5ZM4aqF6lfbJWO2ZTt7CeV3eGrZxp5R0ZeCOE1k4Nio=;
 b=o8vGxQb4fQHbloAOl93iF95OWLLP+ppq1dammO9gWsWXYXBDeE8tgi/pAc4eP0j4rU
 wnv/o3DgwPPQcix1aBKD0x7dtPDPsXFS7Es4BuqEvK0RvOUKeGNo4vbS5DjVO9h6o3WB
 0GSVnkGtIYePuINgaYzfZBz57TQw8pQ+0mnki1rQ8iWZaMakx95mMctAut8Qh5zockFR
 1sKcq0jTc0gt7dr2+vfApmWQA8/skwTOOXAKsbXt8FXYaKXNH6wM1Tglcuhy0l6mHjG4
 8fmq/lavKZ132ngwBtmh+3oo2pBmprccaFUUoCSL1Nj8A9CAgB/JuJtX57VTLooOuv66
 rHiw==
X-Gm-Message-State: APjAAAXQD2gjnsq2egHaFWwYURvlzLNNiqbocd4gC0If9AO+JHrB9q8o
 99v9tCVn9oIAIBNCcKnIISq11Q==
X-Google-Smtp-Source: APXvYqyWhluM5dF20uilV4CjoWUpOLf+gqGOkSsgMMl0GzNG8onBYAhbrOc+XovPnUV5/nK09PEKYQ==
X-Received: by 2002:adf:e708:: with SMTP id c8mr3031565wrm.25.1562330719332;
 Fri, 05 Jul 2019 05:45:19 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id x83sm8987408wmb.42.2019.07.05.05.45.18
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 05:45:18 -0700 (PDT)
To: qemu-devel@nongnu.org
References: <20190705124318.1075-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <db75031d-e9af-c349-903f-276ec92f850d@redhat.com>
Date: Fri, 5 Jul 2019 14:45:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190705124318.1075-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH] target/arm/vfp_helper: Call
 set_fpscr_to_host before updating to FPSCR
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Correct subject: "Call set_fpscr_to_host before updating FPSCR reg"
(or without "reg").

On 7/5/19 2:43 PM, Philippe Mathieu-Daudé wrote:
> In commit e9d652824b0 we extracted the vfp_set_fpscr_to_host()
> function but failed at calling it in the correct place, we call
> it after xregs[ARM_VFP_FPSCR] is modified.
> 
> Fix by calling this function before we update FPSCR.
> 
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  target/arm/vfp_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
> index 46041e3294..9710ef1c3e 100644
> --- a/target/arm/vfp_helper.c
> +++ b/target/arm/vfp_helper.c
> @@ -197,6 +197,8 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
>          val &= 0xf7c0009f;
>      }
>  
> +    vfp_set_fpscr_to_host(env, val);
> +
>      /*
>       * We don't implement trapped exception handling, so the
>       * trap enable bits, IDE|IXE|UFE|OFE|DZE|IOE are all RAZ/WI (not RES0!)
> @@ -217,8 +219,6 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
>      env->vfp.qc[1] = 0;
>      env->vfp.qc[2] = 0;
>      env->vfp.qc[3] = 0;
> -
> -    vfp_set_fpscr_to_host(env, val);
>  }
>  
>  void vfp_set_fpscr(CPUARMState *env, uint32_t val)
> 


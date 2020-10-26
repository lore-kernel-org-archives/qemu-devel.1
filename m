Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4D0C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:12:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93C6520706
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qGr20bG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C6520706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX62l-0007pn-LN
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kX5xN-0001F5-ST; Mon, 26 Oct 2020 13:06:53 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:47009)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kX5xM-0006hx-6a; Mon, 26 Oct 2020 13:06:53 -0400
Received: by mail-ed1-x543.google.com with SMTP id 33so10166666edq.13;
 Mon, 26 Oct 2020 10:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tIszaKGNqPIJV+sN1CBQl0wxddGCvwGIsfIqZ8Fa/m4=;
 b=qGr20bG/TSjViAUsd41E96HADy2RA3qz+0YtWTQw+NjlZB4iG4REj1/fqOsS2a1udB
 hfdk9qmHJUBWMIcDeqvqr09eGVOOr1aul5Dxse225fv1AeUvVFaJn42vnOBbtqMWQ2jd
 hebqxRKyewhgbrU+TGVlQteril8XxO997sS8xVEimo1Ze5K7ffft9a+8pv+duJLZ7gGr
 NYY7mw6XyotiNUaW104xl9pb4aBcsNL7Vu3Y0gYWSooRQp29+BHWiYOYeclIlPzw8RN/
 c6zsQMbPJzV90FOT7TdWDP0o7V6E9vvYbkNX5OlVXbatCXKEBYd030t3tSrIfwnOXcRg
 7DiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tIszaKGNqPIJV+sN1CBQl0wxddGCvwGIsfIqZ8Fa/m4=;
 b=LgCqrao73J1k6VReAFqQwQS9TCGGJvs2HbZAMYtJeewXm2xPmA24KHfo8HAwPVo8nh
 qAIg5z86Y1EO5Xp7Omf/OcfeiWR03oqkESvsD49l+TFjdxp7daVmOmjb0cX3pVCHSkFy
 kdQk6X75SDKRMbxjxELFgzIFjw9NWxZHKA39tANeASPPTqAIaRTGY4ShijpvxA1QiWnC
 CKEktCPnqcL8FxtE/E1Pct2L0idjv4GYGphBuJXF2eRj8K8iMxjmT0AOB6A5KUBGETXz
 GXGrOpFdY+9cZC8JJaQaC0AznJWZrfDW22SQvsPAp0yCQ3AmW01/tY7VLnNKkKxsEn3j
 A2AQ==
X-Gm-Message-State: AOAM531Tx84QvZ4pzJsr0oCnBpvuL1WejY9DUTt7WcHZcODpZcDV5A1U
 TbZBJLEc9BhbEqXvY8IB3Wg=
X-Google-Smtp-Source: ABdhPJzGpLanY7W/3/jo6V6CvgMvxrxB/JIpWsEuIL/nZJamhsCiyKE8jTXlJMNy8FGIuwFvuhSB5g==
X-Received: by 2002:a50:d69e:: with SMTP id r30mr16303216edi.383.1603732010427; 
 Mon, 26 Oct 2020 10:06:50 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id b6sm5777172edu.21.2020.10.26.10.06.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 10:06:49 -0700 (PDT)
Subject: Re: [PATCH] docs/system: Deprecate raspi2/raspi3 machine aliases
To: qemu-devel@nongnu.org
References: <20201019082121.1544550-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <490c9656-a7ee-6988-472f-e8e7d909d9e1@amsat.org>
Date: Mon, 26 Oct 2020 18:06:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201019082121.1544550-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-2.167,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: libvir-list@redhat.com, qemu-arm@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping? (patch Acked).

On 10/19/20 10:21 AM, Philippe Mathieu-Daudé wrote:
> Since commit aa35ec2213b ("hw/arm/raspi: Use more
> specific machine names") the raspi2/raspi3 machines
> have been renamed as raspi2b/raspi3b.
> 
> As more Raspberry Pi 2/3 models are emulated, in order
> to avoid confusion deprecate the raspi2/raspi3 machine
> aliases.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   docs/system/deprecated.rst | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 905628f3a0c..f0c7aaeb2ff 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -355,6 +355,11 @@ This machine has been renamed ``fuloong2e``.
>   These machine types are very old and likely can not be used for live migration
>   from old QEMU versions anymore. A newer machine type should be used instead.
>   
> +Raspberry Pi ``raspi2`` and ``raspi3`` machines (since 5.2)
> +'''''''''''''''''''''''''''''''''''''
> +
> +These machines have been respectively renamed ``raspi2b`` and ``raspi3b``.
> +
>   Device options
>   --------------
>   
> 


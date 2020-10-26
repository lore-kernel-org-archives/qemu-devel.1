Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1481EC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:58:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E5512085B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkoOl+PZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E5512085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX7hV-0001WZ-Hr
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 14:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kX7gV-0000Cn-Cb
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:57:35 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:45142)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kX7gS-0005bl-3M
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:57:35 -0400
Received: by mail-ej1-x642.google.com with SMTP id dt13so15190603ejb.12
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 11:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PQt+1UAu0EhyS1MHkLZRu+RHDoFpwb5kHsiBVf2Sujg=;
 b=hkoOl+PZy3z5YyTtCunpjlL+hcKZIW+OkmuEqpuIeYk5xX5mrANdubBXz81eUx1zAj
 a6yty1SLiVlKEAdBHfezbi44t0YYEDy9qkGiozOKRt2JQUxC9lwShKA8eubYQcGnyEqq
 tLQQOQ26AcOT23uhF3H/XjX166YBpEl6Lhfe1V+0T5fqzkf8tN4fci0A++xgXMkB4JuS
 iKFqU1/OLOlcYty4vkKwcFPETuJNZ9w1Xn/Xol7w99wjzq3u0y95O5G3FInKFGvZ1Hve
 aiTJ65BYIltiIEGjfmAGVWFJfhYLNE7IgY7BGQnfdpgIB5Pj8mTeZgcHJVhNcoDMc6bY
 dnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PQt+1UAu0EhyS1MHkLZRu+RHDoFpwb5kHsiBVf2Sujg=;
 b=SYiGs3Zt/kwpCWbMcoBFhNyr178nWh0Ji6Qpfrzw0hAqpcxg3A47SsgEDdEfgDATVr
 h4/DuLVAPgz2yol9DLHlLt2cMjz4lMW0nrNpbiTdN7nb0Vw18uO2BfBW0gUXm5Lu+tqa
 HTT6esFM39TXSKvHLjV1Sf/CBQ35UjINgXJlI32DE+d+lYYK9xZUeoS6BSWoVoP9YF+d
 +nbJbsQzgFbwWD5kI0B2AhagXFK6Fkbx+GB/XEtK5/jIQDcwPqwKbhnJJbIcf6bIhu1h
 3g2RZ/iQkIiLkNsAcJUo8sJd9S8IEztJNsB8C9de9m3h0BwuIBnjpeWUcyPijhXOJfh3
 l5nQ==
X-Gm-Message-State: AOAM532tkAr7X99V+qWWCRauYHW9mi5erVfcYLJ58GwahawSbDvUwlb5
 faxL8NmEBL8oEjy9qMpuMlk=
X-Google-Smtp-Source: ABdhPJz8buUYgEe8yyEXfOxmmAlJO2PUCXaDa7uli4votTD+uhPZ2q7f7elXJGUJgXW1exoGlftL2Q==
X-Received: by 2002:a17:906:c114:: with SMTP id
 do20mr14309064ejc.169.1603738650628; 
 Mon, 26 Oct 2020 11:57:30 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id n10sm5650530edo.55.2020.10.26.11.57.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 11:57:29 -0700 (PDT)
Subject: Re: [PATCH 14/15] sparc: remove bios_name
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201026143028.3034018-1-pbonzini@redhat.com>
 <20201026143028.3034018-15-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <58f0544b-bf13-4d73-b645-0ab1e4feefd8@amsat.org>
Date: Mon, 26 Oct 2020 19:57:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201026143028.3034018-15-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/20 3:30 PM, Paolo Bonzini wrote:
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/sparc/leon3.c   | 4 +---
>   hw/sparc/sun4m.c   | 2 +-
>   hw/sparc64/sun4u.c | 2 +-
>   3 files changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>



Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C262C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 08:10:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D497B20704
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 08:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/d74azI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D497B20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVs9m-0004HJ-PL
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 04:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVs7t-0002Pe-Kx
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 04:08:41 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35268)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVs7s-00076x-7u
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 04:08:41 -0400
Received: by mail-wm1-x341.google.com with SMTP id q5so512947wmq.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 01:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=u07NAUQ1EQ57f5kH7vZfMNdNnLKC5LZKIDjTu5ID12w=;
 b=q/d74azIO7i3y/+yuvXPKk/Tcn9yAqhmL4vGPnZV6eeNK4/JZXtbxwqxC4xFpJHSer
 weKOngyIKXy+xDcXxQHw/EttL7iv8E1FQxPH0wMyl8ilx7CdDw32RrjTa5qBrd4K9tTR
 YEaoB5LeUnYv6pWvcmRUc4s2b2L1OW5hhl1XqDYgroYrUjkl0SnbdmNFfftyfNEwDugH
 qlwqpvhQITxAboDU3kYwo+EdjK4/Nhk5wlG+kLihvI3H7lZVr8KAdX/bT80W6d4DgdHU
 wvzhZVMblptZObhteQvlBm8bYImjk3ttO+I6X7NVVnh04TG7uY7w1BucV4pJzdl4iFd7
 eyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u07NAUQ1EQ57f5kH7vZfMNdNnLKC5LZKIDjTu5ID12w=;
 b=R1o3ViBwPjN/CpU8o4hAEJcF407aipnel/obosXxPrqJsss9xWNAITFLZpoZS28BLt
 JSl2ndL9e+/0I7rBa9E4rOb2ZV3MR9iJ/tOlFyXwm09fVSl6LKN9q3H1xaNTZHIYy7Sr
 qxncgbw/6A188C84BOQbrNqCIji+8syX1NzVUZA3gPKZMnVeRwrcOHpLjQq83mM5Em5D
 H+vUotu8CLET7C6mAlYr8mm6KLPg+sLpgeQIccjbMGACPQwSGcWCzR3GJ+rEASE+74sW
 jOe5iPuIooYWTxtHFtn2QBc19NnKmgcZl3Y6tUt9mTo2fmXEl4IpXo1ubhXhUTksV1rg
 RNIA==
X-Gm-Message-State: AOAM532I0ASaTtZIvFPSEmcVqrqQRGJZNEn505xHgr3xfKBGtRGK1mkk
 ZozihFDEqJ30ySPheaCXtjoc+1xmpuA=
X-Google-Smtp-Source: ABdhPJxd3PLlZ/WLmluwPpjz0ruEIX9vUPFcYR5QGPxpQgKDQYbrNFRpu59DyEvdiidrgVDB6c4yXw==
X-Received: by 2002:a05:600c:218a:: with SMTP id
 e10mr996024wme.7.1603440518404; 
 Fri, 23 Oct 2020 01:08:38 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id a127sm1848404wmh.13.2020.10.23.01.08.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 01:08:37 -0700 (PDT)
Subject: Re: [PATCH] hw/arm: fix min_cpus for xlnx-versal-virt platform
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>, qemu-devel@nongnu.org
References: <160343854912.8460.17915238517799132371.stgit@pasha-ThinkPad-X280>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <33e044c6-6111-0066-8f82-52cdb419e6ac@amsat.org>
Date: Fri, 23 Oct 2020 10:08:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <160343854912.8460.17915238517799132371.stgit@pasha-ThinkPad-X280>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: edgar.iglesias@gmail.com, alistair@alistair23.me, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/20 9:35 AM, Pavel Dovgalyuk wrote:
> This patch sets min_cpus field for xlnx-versal-virt platform,
> because it always creates XLNX_VERSAL_NR_ACPUS cpus even with
> -smp 1 command line option.
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
> ---
>   hw/arm/xlnx-versal-virt.c |    1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


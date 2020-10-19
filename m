Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1C2C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:07:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CFB02224D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYJ3R02w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFB02224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUXgi-000403-V3
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 12:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUXaq-0007Iy-Vi; Mon, 19 Oct 2020 12:01:06 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45243)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUXan-00015l-8s; Mon, 19 Oct 2020 12:01:04 -0400
Received: by mail-wr1-x444.google.com with SMTP id e17so272745wru.12;
 Mon, 19 Oct 2020 09:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Bneo8FigEfUd8mjCAxsUkdNIUAlukKky9EXp0Ij034w=;
 b=lYJ3R02whAeUzoTlxLjcstIkjb1WFlbbA0vt4pjlTpVbVCuiOZcGWFVpiR/Xdl/+6h
 Fpg82HO5iQukEs49jhxnrnkm9mKxAhJz2C6+WJ21Dj3geIgGcmRxMkt7S0882Y+wnjbW
 g4y29QlKFVXOdTrmjw8no0A0AlbK2flTHnt4C0Xd61+cKp/DhP++2cjV3Q4XdVWXLdxN
 t1AHJyTUXwf2G9+wCkVmyx1T3zp3gZsj0IK9sj4/F+1h2NLNbq41+Xgk/GpkPKaDgmOh
 oetTeUHpKBOHLRkbi8OwXTe4LmIVJXhLRaCaybOZVVp+4egAjlKHeChHT5nYTxctNf+t
 6+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Bneo8FigEfUd8mjCAxsUkdNIUAlukKky9EXp0Ij034w=;
 b=XRi3k9R1pHpdUUqjAGEOr5hMRrbHBNubEQzyfylepA5OpJzXziVypig8Qf5aDikbqF
 zMFKS3QHygOSLRTVBNlGAQALaKA+mtoMdfME8nj5a16Ia4gr7rldlLVTpzajScUMVj4Q
 9ocJNNA3c8O9HkBt9hClXFpIeAX3F4WWhdgHEqgX24u/7zP0wyFe3BDrxj0R90+4Ma6V
 YvI1nF9a6O7qbC1QEfMZb31rYFppmjDjSNFbkUtKl1ZTDVBo6y3kjIQIuOWgESPuV15m
 iPoasYRX4P4j7gUO4Tx6i7Zw9G67gKDRTAqMjfqR8gCv8Zkgr4YNVSjJSS98aZ/22MRm
 bL/Q==
X-Gm-Message-State: AOAM530GRvUxvKo4IzZSVUsItTIi6aTz3DB2Gz8BIxqq1lTFzblx/x+B
 uudRqqmtsvo0A7DoZbsHKHg=
X-Google-Smtp-Source: ABdhPJxoxogN+p22JZCLkCMV3ImAEYdrNBxx9U0q0DQrB22Hkg4SyNR8K+6vgM7TVH+ibNErDAffvw==
X-Received: by 2002:a5d:4608:: with SMTP id t8mr193633wrq.231.1603123258901;
 Mon, 19 Oct 2020 09:00:58 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id m11sm38062wmf.10.2020.10.19.09.00.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 09:00:58 -0700 (PDT)
Subject: Re: [PATCH 2/6] Move npcm7xx_timer_reached_zero call out of
 npcm7xx_timer_pause
To: Havard Skinnemoen <hskinnemoen@google.com>, qemu-devel@nongnu.org
References: <20201008232154.94221-1-hskinnemoen@google.com>
 <20201008232154.94221-3-hskinnemoen@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9bee1d3e-d755-ae2d-443b-2edaf7098010@amsat.org>
Date: Mon, 19 Oct 2020 18:00:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201008232154.94221-3-hskinnemoen@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
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
Cc: peter.maydell@linaro.org, clg@kaod.org, qemu-arm@nongnu.org,
 Avi.Fishman@nuvoton.com, kfting@nuvoton.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/20 1:21 AM, Havard Skinnemoen via wrote:
> This allows us to reuse npcm7xx_timer_pause for the watchdog timer.
> 
> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> ---
>   hw/timer/npcm7xx_timer.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>



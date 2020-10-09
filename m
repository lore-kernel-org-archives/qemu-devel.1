Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49887C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:43:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF87922260
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3v2pAfT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF87922260
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQtbx-0004aW-DC
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 10:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQtb4-0003jU-Tz
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 10:42:14 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41811)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQtb3-0008HB-6i
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 10:42:14 -0400
Received: by mail-wr1-x442.google.com with SMTP id w5so10563273wrp.8
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 07:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FLiJF2GMh1mx19H/JE+HGjSmozMM0wqdCHoeOE4nMSQ=;
 b=L3v2pAfTMpV+1zU3v2/EV/xTTqSzx5M0bj0Fmbkgd1LtgVOs+e4OY3vvR5B0i8aKdG
 Y0+cFYhcwTeGJsVmaiWxkbzZ+EFemIhOLwn7cHYw+4mWkrcgfBslXGy3n37EHOcFw8Co
 BcyfyjEGxQGSD8JG+O/2p5ausXAysnk3ozwtoD7phaa4TfincAcAiIG5XiJN3/BlheuZ
 SAZ35VN1ZBu14FrvoQbgCYq+BeAcxkg0LvoH2xn8n272e0Qd/YoVyaxctOx/P7XcD2XJ
 g1cW/mDHRVUDNT99Z7RbDy/tAyxvmQ3x3dfGFzperaNw0yIwg2we2OhIYIeVmyrv0KLO
 UnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FLiJF2GMh1mx19H/JE+HGjSmozMM0wqdCHoeOE4nMSQ=;
 b=M+DyRz24AxMqKRyNDWBdNaXILIPFoCEeYMWU9mI2MV4s5giZMw99Tj+xEValF31PQ8
 3uwMJaO3cpb/noU3Loy+KN68VqEerpV5TNamTvMhQ+Uh/PSm+sq6XaUrmqYQQwRvUwm4
 X6280/RYnJhPiPHEmBuqx0C4d5lGEGtJCLNXlisdyrLNzewbnhyDEvhqsX2Lociie6JI
 8sxFhrKooW6RCZJk0GuXfYkFiuCl4rus+BkBkJylUYgeC2ZjKXzXJjTyMifc/OjV/lsJ
 y752O/xm9/6i65f2cguy70dsYcvIzzWmZ8DEcEDZMSf69lDdYStvhALltbCjT83ErC/I
 uIWA==
X-Gm-Message-State: AOAM532ElpGhy9wzqUDc0J75uT8tiB1tqLErJkdQY9Ir34e28ORG9Eku
 G1Ppr4gEtNSHDiexlhO8pPY=
X-Google-Smtp-Source: ABdhPJxuRTJblYITGoTk6DFnKc/slf/o4qhBHPn6FhUrUm/TxWWtamlWvk/S5yvtOFRVHqnZNa/7WA==
X-Received: by 2002:adf:fa02:: with SMTP id m2mr15012921wrr.273.1602254531940; 
 Fri, 09 Oct 2020 07:42:11 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id u63sm12390630wmb.13.2020.10.09.07.42.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 07:42:11 -0700 (PDT)
Subject: Re: [PATCH v2 2/5] target/mips: Demacro helpers for M<ADD|SUB>F.<D|S>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-devel@nongnu.org
References: <1602103041-32017-1-git-send-email-aleksandar.qemu.devel@gmail.com>
 <1602103041-32017-3-git-send-email-aleksandar.qemu.devel@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <022e59dd-adff-4ab4-df34-387ef3df1d2f@amsat.org>
Date: Fri, 9 Oct 2020 16:42:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1602103041-32017-3-git-send-email-aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.208,
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
Cc: peter.maydell@linaro.org, aleksandar.rikalo@syrmia.com,
 hpoussin@reactos.org, chenhc@lemote.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 10:37 PM, Aleksandar Markovic wrote:
> Remove function definitions via macros to achieve better code clarity.
> 
> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> ---
>   target/mips/fpu_helper.c | 63 +++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 46 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


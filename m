Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B44C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 21:22:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43AD92145D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 21:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ip/RCuTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43AD92145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFl4R-0000jZ-Ck
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 17:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFl3k-0000GH-BB
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 17:21:48 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44006)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFl3i-0005rn-M7
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 17:21:48 -0400
Received: by mail-wr1-x442.google.com with SMTP id k15so664028wrn.10
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 14:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RvO/9qexh31/zModhI0EAREYU8yXrq+vEN5SMgtdOB0=;
 b=Ip/RCuTGSa7RYxIq/FoXdvwd9MBoPuCQl9Er201aAqwUZ/sQQAjMgLG4b63vLJM8yi
 iM0YmU4mPIxdD2gleHn+vRcVdvbMeceM1wdiWCxd/U5IpaQSsRnuz8+y2nyX40mQ2pz5
 7yF8t+P7BqAl8dhQzXFs60cs1D6tGr8i4LN20XDSl2popnLRsJqhmAX0TKEZzT82jB/H
 7r3uM4J2lmHmvsTh9ZlS1yfPWz20x1BzDdq07RX0OvJ0wPIJZr/2dWxbUwFlccohQM3V
 EI6t7G1Tm4XalvZXgnFVxRe/W5GU7NVCkNMl5a4SZ+zkCuzdsD04/Vbt6FhvuNk+VN+b
 g6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RvO/9qexh31/zModhI0EAREYU8yXrq+vEN5SMgtdOB0=;
 b=UsYthFThy0YcUYK3PqgCcT+nM2GG/A/ln0Y9rLDthfnoAUZ1znAXu+/PvgcdDNQqRy
 hUT+q47gvAzcW+SneTwyiflwrae+oqiIdVNGJOe3LFUx1v+SHn0RFUZ0AXOVNvpchwJo
 OTqmDDVxkZzVYP6g2VmcBxAdeUq2EU2CIn7jBmleb0dIWo8F/ZUQt2hYhe9uwPopiQSS
 7GGzjob72VmKT1hY1n17FutFOyw8uwbtPsqT/pfaKroLYbhxL5QwP4UIcKmsknLRnuap
 9gSn8BDIi4N/teNGOAfDfsYe3G8JatomcbVjEWTajG82fqtSRTrH3kdmuzZn5u/gAKjl
 3Kwg==
X-Gm-Message-State: AOAM530FlEljkt9WRWFt+n/8k49LIpcjqZi9VQjOGFFSBQ+Td4oPqR3/
 LtPa7TrWSemyXwRZmkPhrHmJ6IkF0fc=
X-Google-Smtp-Source: ABdhPJzl/nOV8ZemIz3bsLwnm2A1buAWx+VJa5JJHwIl6ZdLrgXjHJ3lsEkoUD/k2krNAyMFAp1bqg==
X-Received: by 2002:a5d:6311:: with SMTP id i17mr379061wru.243.1599600105000; 
 Tue, 08 Sep 2020 14:21:45 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id h17sm1017374wro.27.2020.09.08.14.21.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 14:21:43 -0700 (PDT)
Subject: Re: [PATCH 20/20] MAINTAINERS: Update RX entry
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20200827123859.81793-1-ysato@users.sourceforge.jp>
 <20200827123859.81793-21-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0c8fac0d-2da1-0922-1575-c9df02ceb78b@amsat.org>
Date: Tue, 8 Sep 2020 23:21:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200827123859.81793-21-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.626,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/27/20 2:38 PM, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5a22c8be42..cee8448a73 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2054,9 +2054,11 @@ F: hw/char/renesas_sci.c
>  F: hw/char/sh_serial.c
>  F: hw/timer/renesas_*.c
>  F: hw/timer/sh_timer.c
> +F: hw/net/renesas_eth.c
>  F: include/hw/char/renesas_sci.h
>  F: include/hw/sh4/sh.h
>  F: include/hw/timer/renesas_*.h
> +F: include/hw/net/renesas_eth.h
>  
>  Renesas RX peripherals
>  M: Yoshinori Sato <ysato@users.sourceforge.jp>
> 

Please squash to patch 16 "Add Renesas On-chip Ethernet MAC".



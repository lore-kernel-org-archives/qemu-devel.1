Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8C2C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 15:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C55B22260
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 15:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qenIXCdu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C55B22260
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQtvs-00072w-DP
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 11:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQtsu-0005Ut-Ot
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 11:00:41 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42372)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQtsr-00022f-JP
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 11:00:40 -0400
Received: by mail-wr1-x442.google.com with SMTP id e18so10622494wrw.9
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 08:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ujeTRxc5EeOJ2MpOSbkGbBeREUiTWFqVyoS7ErtkEPo=;
 b=qenIXCdumV+e5yr1ys0DiNl3WhStDbx/q7E7Exsn1Oy0BqLqN7A8+mSHjClNrFZIpB
 CsM3duVxaDzfcz2pJ/ChVaU8W3J2WeHtHnDbGUy06+3HJIp7/xqOaDDyJtN5HFwW4emt
 nm9HTGNERMxMa++xSxwsl/eoQdtfQ2WeIPi3gQjlr59OadW3UnpQv+eBoU4LlNFuP7Rk
 vRtlNvlpf2OyV4qfEHcl220CSjQd7pIUbD6FPTqTndBDGX3myRd9NMB5e75muxgXZElp
 VLniSWH+v83sTbbw+tOwVZCi8qxXCEfrgkIANM6IfCgq+guRh6v07p25a2enQg7vaYlF
 TNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ujeTRxc5EeOJ2MpOSbkGbBeREUiTWFqVyoS7ErtkEPo=;
 b=Ebb1a7YLmHVFyaS/Vwx5vaZOmc6mr1dAREC3mtzdUGVlSQnMJSc5VLImWXy/fKePEa
 cgovOcYtlnrroo5qYoDhQfbLxINwHduFATR00/RElCd8u/4rK5PQzzIpqy4WUTjlc6Wd
 qtVj/gy3piCbB4Pvr+G6vMh/QMQ+tMMQRlTYwMas1cVX/s4LRjwvZSmQOI3TqpYk0wTo
 JPOa3R6xVoIQIY66gQMKlySnbCBW2U3y4PaDagpzSizKTRsYLDfVMesRNcEVuyZP2K3B
 KeATJmdAclqjR6ZAtWF42o/bR3rQGMMKo/hy2KC7t5z+Kn22BQLhQUMif8gtFsbJ3lb5
 etaw==
X-Gm-Message-State: AOAM533IVs0VHrcMgoUx5eiI+pINzCD64t5q/ciBhtxPtcfZOKzZ84yb
 R/Wic+HZuNoX2Wzg4i6TNlM=
X-Google-Smtp-Source: ABdhPJzDCeQ4lb5udkeThCP2O6z+nh+Ce0LUb6Hupksj7i6ELf2NzHmwdCD8cdz2RAblHiioamh0Mg==
X-Received: by 2002:adf:8484:: with SMTP id 4mr16133351wrg.334.1602255636057; 
 Fri, 09 Oct 2020 08:00:36 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id z5sm11722064wrw.37.2020.10.09.08.00.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 08:00:35 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] target/mips: Misc patches
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-devel@nongnu.org
References: <1602103041-32017-1-git-send-email-aleksandar.qemu.devel@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <61030837-67f8-5fdf-ed1b-9c160adc73ac@amsat.org>
Date: Fri, 9 Oct 2020 17:00:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1602103041-32017-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
> A set of several, mostly FP, refactorings and improvements.
> 
> v1->v2:
> 
>    - added a patch on MAINTAINERS
> 
> Aleksandar Markovic (5):
>    target/mips: Demacro helpers for <ABS|CHS>.<D|S|PS>
>    target/mips: Demacro helpers for M<ADD|SUB>F.<D|S>
>    target/mips: Demacro helpers for <MAX|MAXA|MIN|MINA>.<D|S>
>    target/mips: Refactor helpers for fp comparison instructions
>    MAINTAINERS: Remove myself

Thanks, patches 1-3 & 5 applied to mips-next tree.


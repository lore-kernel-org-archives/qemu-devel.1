Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9276C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 09:24:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D978206ED
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 09:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSPnWPcb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D978206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTiSQ-0008GF-D1
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 05:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTiPq-0006RT-Ca; Sat, 17 Oct 2020 05:22:18 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40661)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTiPo-00063I-KF; Sat, 17 Oct 2020 05:22:18 -0400
Received: by mail-wr1-x442.google.com with SMTP id h5so6094688wrv.7;
 Sat, 17 Oct 2020 02:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=b3KJVlv6ZKrLsLLJ38DkzIkbIH6u5WC5iTmysjHUCyI=;
 b=ZSPnWPcbJTXa6YZz2A3RqdnG/7H4ZNwwm+vmBnBVNotjldQyjUAPOObaRS2JkoGOcQ
 49naTMPhLA9N+mcbcIPzBkj4hlbZd4O6tzg3jLOCiZoMch5iVK6oBXqbdbMXdVJ52ZI1
 eMvUrKQIVDOaIfVrON9Xkr4oVQMuVvClvIv3Swl6B3i15ZkWXJxZWVSmlHjwaAz8SwDx
 Osib1RYeZSP2eFQUl9IAZttFkotOOwC78YPNvwKEVPebvIZl0L6zgme7jGkVS0xHvgr6
 1KUXDAuD4rs8iCoQm6r1bNdWoobXOAsZr/zk186SsfKnDYA9pYshthho0DngMCZLOT+X
 CFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=b3KJVlv6ZKrLsLLJ38DkzIkbIH6u5WC5iTmysjHUCyI=;
 b=ny/6mWPBZFkmeTENl9SttHC+KBIpoXfONyLUzJlf7n6V0liQzK+iyINbmvl0YMFqdr
 TPsHfQ0UPMOKmsp3reA8SmRjSfrR5Pa7KS5Ird1i9fnKKyDcgsP4vuKkLVX2QlkeB1Ou
 JvwEiYgZl8Svm7+9YgDswycVAK3vCgeNvww1fKHUfp970bOLs26OdsvnXs2sFYW/GjxW
 JtxKDs3mFMAvM17td6coOre3r3AaqJr3G/Nk7p69TVifIWhHsxlNRHwVe7Y5fyx+Kg/g
 77v8i17nX7ky8OXezsrtjhHSZyeQkhg0WWCg4Z3iwQ1SjdmGn7m4uMOKY7qjGAFD0bi8
 NsBA==
X-Gm-Message-State: AOAM531dkBMjmh0ok086IooVcOHcB1Aanp6WJ5pXmsbSXFrfRKLupA9P
 0Qf5keSNqu8KNTuKdiigo2Q=
X-Google-Smtp-Source: ABdhPJzCLXeQMfoHbkmsOcplyIJsSypU4v7fYCAXAG8vkt+ehPBQYDH0tvsfNNO9f7nWbXngGCi3mA==
X-Received: by 2002:adf:fd49:: with SMTP id h9mr9726694wrs.115.1602926534100; 
 Sat, 17 Oct 2020 02:22:14 -0700 (PDT)
Received: from [192.168.1.36] (117.red-83-52-172.dynamicip.rima-tde.net.
 [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id t124sm6556659wmg.31.2020.10.17.02.22.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2020 02:22:13 -0700 (PDT)
Subject: Re: [PATCH v11 09/12] linux-user/elfload: Use Error for
 load_elf_interp
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20201016184207.786698-1-richard.henderson@linaro.org>
 <20201016184207.786698-10-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d93a9d0d-1816-9f7a-e190-3e4a66679bc7@amsat.org>
Date: Sat, 17 Oct 2020 11:22:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201016184207.786698-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.253,
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/20 8:42 PM, Richard Henderson wrote:
> This is slightly clearer than just using strerror, though
> the different forms produced by error_setg_file_open and
> error_setg_errno isn't entirely convenient.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/elfload.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


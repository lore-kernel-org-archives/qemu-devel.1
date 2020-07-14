Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48A5C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:43:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FC9D22365
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sb5Ue6zh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC9D22365
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvLDK-00071Z-Qg
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 09:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jvLCG-00060C-Ah
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:42:12 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:53917)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jvLCE-0001L1-Mb
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:42:12 -0400
Received: by mail-pj1-x1041.google.com with SMTP id cm21so1604329pjb.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 06:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=65qUOt+pMEbQFzLQ25l1SuoFfwVW3zku4qERNetHfmA=;
 b=Sb5Ue6zhl0KxTJgpnuJUTXaEkWrdy9hLP5T6r22JhG86CPQi37IFRa48CFj4/RVUeN
 6LIQ3hGjjfL6NjhJjyV+fVTDrz29z/NKfxAL37XAnqeUEVgBBoO+4wzKAQn6eql9nBKV
 idmCuCxy60fQvjz8stdGD5NT9Zqn/mywPlqW75wWDcTDOSF5YCl+E3k9ZfpBxLE3msmY
 H7mKlZ5SJ7WZkH2A8N/IndjOrbK7EyLDhvvhB1JStxt9O0Xk2yZEyUUljifalFZJIbOd
 og/4cTQ4B71TuccdbMqNGgQ6Dqum4/w+gbUsjrX0C+zffIHrWqviwVmX1/lIgXLmWQOf
 Y6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=65qUOt+pMEbQFzLQ25l1SuoFfwVW3zku4qERNetHfmA=;
 b=MnDL8s4A1w3QSLgH/Wu+/6rfmPBhG++BMGun4gyvwoVJThT4yDVW4zxkjXj9rie2M9
 VZ2bF4G0tN7AqRe6wPvhEdg4rvDcIiaJo3qOTtzlMMhO1OEAjE9zPjmrP/+vwxIm7Kgw
 lD8LIeTbM9Io6nLB7+A3vVyKrArvSBnG/ALaoOoUBYOqpWr71Ic59mNAr466ccwhsahV
 XSk+NnQIc7i6zI/WnMv9yvFsbYAOC/624Qmr7L+QENHk3zKFlv1kIpwGqPT12XgoIXdc
 FYN8MJEAtadnqHjWJT5rZ8/OVBc5YS0CvPWNT/U3Apxs/a1hks2cwIpFHIZcLaKvOPut
 09YQ==
X-Gm-Message-State: AOAM533gsxuYvqrU6HI21FVxb6fBQtC2IPkO46ym6bVAkz2eBOm6L5j7
 yWcPh1nCHxg4aK6XinQpaqteQw==
X-Google-Smtp-Source: ABdhPJx5B8sBTH1jUAR3gOhYKgrvpSs7hT4W7Oun6VjbQ/MB2tdh/hZo6phV+GyBAluBm2q8hmqFuw==
X-Received: by 2002:a17:902:7688:: with SMTP id m8mr115836pll.12.1594734120997; 
 Tue, 14 Jul 2020 06:42:00 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id e6sm17190359pfh.176.2020.07.14.06.41.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 06:41:59 -0700 (PDT)
Subject: Re: [PATCH] target/ppc: Remove superfluous breaks
To: Yi Wang <wang.yi59@zte.com.cn>, qemu-devel@nongnu.org
References: <1594600412-22887-1-git-send-email-wang.yi59@zte.com.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7d0d9d34-eef4-4ec0-8be5-83a6b2651325@linaro.org>
Date: Tue, 14 Jul 2020 06:41:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1594600412-22887-1-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: xue.zhihong@zte.com.cn, qemu-trivial <qemu-trivial@nongnu.org>,
 wang.liang82@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/12/20 5:33 PM, Yi Wang wrote:
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
> 
> Remove superfluous breaks, as there is a "return" before them.
> 
> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
> ---
>  target/ppc/misc_helper.c | 5 -----
>  1 file changed, 5 deletions(-)

Cc: qemu-trivial
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


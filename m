Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A42C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:14:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C2C222202
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ufH/MAYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2C222202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb5JH-0003SC-4H
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 12:13:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kb5Fg-0007y9-SM
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:10:16 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:43899)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kb5Ff-00033s-9V
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:10:16 -0500
Received: by mail-pg1-x544.google.com with SMTP id r10so1391999pgb.10
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 09:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=y+nXdR2ve7Y2lgS18dXD4a/ToP1PEuiH8mhuotF4HfA=;
 b=ufH/MAYPvtCSS5Ws3auQs5zxS32MiErP5A4Zrjl5TIBXz/eiGtZxYZ2ELQ52ux9PMp
 cV7Eh6WxrFan2yZpGTI4am/ufXbYi8UlzF+0B9ReSumu9KOIuQnNLdOW/UzsA8nFJen0
 vOIlZYYlXY3w+qFRPVddf5QU7vCodB+XkRMwVUyfelc7qBas/hh6cB+5iPMdFuxfyDLD
 YsjcVtNa6/VO1wquT+jesNV4rLDYbLFCafLqhAKgRhU0u2QqUqmTt7A6zX6+zbyI9Zf6
 xBTrOKEeeQiX50h7ehRC8s4oDSYDhFJa59s9jcnYYFMzpfIIAbT8qEYUDbiDTNJrocL+
 fQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=y+nXdR2ve7Y2lgS18dXD4a/ToP1PEuiH8mhuotF4HfA=;
 b=SOzKFDJ1vPys/mHpgQAMZR/gIPzVlkFBQVICXHYY4ruYnweAZ9FvRgryOFBf/ia7fu
 Q5+NBHNf9VM5MmgmMvo4cnNMf13b7WYms/Lrbg+3eA7rEZNdTWo1pkLce9jx1v7zuvsK
 R6hXAc1OXUEgbBycWXHhZZ8HodnJqWheh4WK+tpHm3cdwUHxYCDsLQ4639QuF81sb6DB
 1qI/UJFp7izxUmN9ikAc///8CJWA5Qha4Gr/ZfhYiczwO+SBICCzmk9VyzK7FpSiRAJa
 PaDxKN417OFOyDrOGr8PqzbQ8H8lcw0o5+vPd4asH4TgDjSQ9MJiKgJMmshG7tz8HIPO
 qFSQ==
X-Gm-Message-State: AOAM5328hk2eU3UxPfbvLxW4r85amyi3Yaw/wcGQ1ayOl3LilkT+28/L
 tv+5l35jAgRjnPj7UiuTSn0ahA==
X-Google-Smtp-Source: ABdhPJzfIde+pvyvUPGelwjYD5I73iS80/90o0gCg5dG5YHoRl+Bx4S+QoQc7dqUD/NEZuw0ENwsuQ==
X-Received: by 2002:a63:c843:: with SMTP id l3mr2450685pgi.376.1604682613921; 
 Fri, 06 Nov 2020 09:10:13 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id jy19sm3183085pjb.9.2020.11.06.09.10.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2020 09:10:12 -0800 (PST)
Subject: Re: [PATCH v2 2/4] linux-user/sparc: Remove unneeded checks of 'err'
 from sparc64_get_context()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20201106152738.26026-1-peter.maydell@linaro.org>
 <20201106152738.26026-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c921cac7-92db-cbcb-b0c2-4d30d3c161bb@linaro.org>
Date: Fri, 6 Nov 2020 09:10:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201106152738.26026-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: Giuseppe Musacchio <thatlemon@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/6/20 7:27 AM, Peter Maydell wrote:
> Unlike the kernel macros, our __get_user() and __put_user() do not
> return a failure code.  Kernel code typically has a style of
>   err |= __get_user(...); err |= __get_user(...);
> and then checking err at the end.  In sparc64_get_context() our
> version of the code dropped the accumulating into err but left the
> "if (err) goto do_sigsegv" checks, which will never be taken. Delete
> unnecessary if()s.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/sparc/signal.c | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~



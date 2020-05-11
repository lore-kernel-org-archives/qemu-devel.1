Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C6DC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:09:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03DA7206B9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aYZmNgIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DA7206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYCrQ-0003Pp-5S
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 14:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYCpM-0000kM-QI
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:06:56 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:34204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYCpL-0003lC-6d
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:06:56 -0400
Received: by mail-pj1-x1044.google.com with SMTP id h12so7649897pjz.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 11:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uQg3dk1dcqkq8wLY3L2wO/TVKMBfc+kSyde7iV+E11g=;
 b=aYZmNgIk5PScUe6R6YK7CPabwsm3i9EKLilo1oGHDp8eCbHklA/oa9K1hlqU6iKYFr
 ZafTs3bAuPInj0fErwQn9A+hsBHACAxIQkjZbHq6Ic7vcKukEInaWsr3V8d3eWf+Dg2q
 seZYIYR3vJy9ZLkwT2S/3JWsnZdRO1YpG6RzlvcB53TWVEwz0kkuHDPliO7vmoigUDz+
 nY4uyMoUj8Fnl08pqDfoVY7IjBy/HjHnkGhXKseroulXPzSFBcJIZCOB/wCOolNfOF7n
 Si92YzAZ6SAdi3DIWRK+vMr1BGT3m37vImijOIruwdo4WVmG0CgNqhxFvbpNOAs/QXjr
 2NUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uQg3dk1dcqkq8wLY3L2wO/TVKMBfc+kSyde7iV+E11g=;
 b=lOvbA/85QaaQVDh6jYIR4VD547FJyLBx0xJmlQyz577wf97qqn1FMd+tBbwr4kPWLA
 7/CBDXHaALEwmha1JPs2bguI4AkiM9FW+dWI2AN/AmUQwAgaECVqpBb0RHQdCCVUodmZ
 XX7Oy3fQh6sXBEik4i1jykIVa6HxzRSYYxs3ijnPqzZLwilEzB0ILr8s5EFh2tfKxDJn
 LEY0Zt9TcUqQR8Hwi096wOEYwCUHegpfp5gwBWZWVswrfzE0wT3p7DQYQY90kVFKm7OH
 Sp1+KrSbP6b43ZAGupA2q2e4LqwRjBt5yqyJMLFLPRj1Rob8XHNVjRCP6jeN+lXs6BcG
 ieXQ==
X-Gm-Message-State: AGi0Pua/lHTZarfGbjllWLpqo1eDIXqG2BrPDXjL7ilqir25gaUha8/3
 rQTN7LL+trr9DjdhJFw4D13xyg==
X-Google-Smtp-Source: APiQypLOqG1cSWUB7b+5FsDbcM3AXgmP6wa4tBQtQ4Sj1PYXV8zO4m8o4KhEqAV0lSojnTr/WxYieA==
X-Received: by 2002:a17:902:8688:: with SMTP id
 g8mr16984894plo.268.1589220413721; 
 Mon, 11 May 2020 11:06:53 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id g9sm8539998pgj.89.2020.05.11.11.06.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2020 11:06:52 -0700 (PDT)
Subject: Re: [RFC PATCH 6/8] riscv: Add configure script
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, peter.maydell@linaro.org
References: <20200430072139.4602-1-zhiwei_liu@c-sky.com>
 <20200430072139.4602-7-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a434ed23-5102-b39b-8fff-0f60e493e488@linaro.org>
Date: Mon, 11 May 2020 11:06:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430072139.4602-7-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, wxy194768@alibaba-inc.com,
 wenmeng_zhang@c-sky.com, palmer@dabbelt.com, alistair23@gmail.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 12:21 AM, LIU Zhiwei wrote:
> +++ b/configure
> @@ -58,6 +58,8 @@ guess_arch() {
>          ARCH="m68k"
>      elif check_define __powerpc64__ ; then
>          ARCH="ppc64"
> +    elif check_define __riscv ; then
> +        ARCH="riscv64"
>      else
>          echo "This cpu is not supported by risu. Try -h. " >&2
>          exit 1

Why "riscv64" and not "riscv"?

You can't really say more without checking __riscv_xlen.


r~


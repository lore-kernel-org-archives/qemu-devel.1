Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B338C35240
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 23:35:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33D1A2071E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 23:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q0XfNlXl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D1A2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ium0h-0000Mo-EN
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 18:35:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ium06-0008H8-MN
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 18:35:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ium05-0001iS-KH
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 18:35:02 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37974)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ium05-0001gD-DP
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 18:35:01 -0500
Received: by mail-pl1-x643.google.com with SMTP id t6so2039962plj.5
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 15:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tt6ehp+Xt0YHdAnahiF95kNQWd8dbzh7qju1RrRwJPI=;
 b=q0XfNlXlOIj2YOncttfvXZcBL/NytBRTBs62CHugdvn4Giey2sTnqrKNq9lM9hj868
 e4n31lEcl/WUX3uedLXr6Nx/Znb1VE0kiXW3WypgsgOFUgLecepfT5pkvAKerudaELSL
 ExEKz/XyMx6yHbXHPUUYHUzPl/1rPtP9yJy7tgQ8RQV+EmMHkvdWvHZh1q1QypOmOFgB
 exy0xcZazqMy2yCxUjwDxYSVcS1p5IXbf5saFjDsy7rZ0xa62WgqXiFj9CQ70b2SnJi7
 ypKVnlu3sUO8O5QFg3U9uvNHmplwjrEVgSOkj8aBhPkCvJ+88XbEG5qQo4/GIpYNFAwt
 QNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tt6ehp+Xt0YHdAnahiF95kNQWd8dbzh7qju1RrRwJPI=;
 b=DAuDbcnTpLRs8i8Kvp/Q3q8MAcZQp3wPC/6v6yirvxn3tg1vY+nrgE7LG4/Xwujgxj
 Vm86luVmB8Du+Aw6hPutovdkdAdWDGyF9mLHPjjj2GREfOpfdBWjJwmgGxpcgKl9swAN
 rUWvVRfn/Gj914RlIGo9qk170G4rpLE5wm/rezpt+EyWFLQn1nq7OmsLzHfDCUWOyeD0
 0ZfzahlwgNzKTYAsvFx82Ulk0hAO/erNgA/63IUs8ZVQxaQ+2T9yvsD5HQhqS052kvUQ
 IZmKFFleOjNeiE3KV9p59LZ9dEDisFJ9yjkYd478tsCzq2jEHSd5UGZPQSsl/mQVUVZf
 liVQ==
X-Gm-Message-State: APjAAAWpjyCMv1ZwFjiliKmkOIxODX3BnzGLM9SzT9XCVkiG2lo4INye
 Qs8t60DYejIpigCvJ3gm+8YNoA==
X-Google-Smtp-Source: APXvYqxAXt1PTx0kJ62pguqQ/zezQs3hfZZkh+hdc/MoiMyIzcuEM7IffbiQvd+WUyGpy5mcGtVUSQ==
X-Received: by 2002:a17:90a:3aaf:: with SMTP id b44mr156666pjc.9.1579822499882; 
 Thu, 23 Jan 2020 15:34:59 -0800 (PST)
Received: from [10.5.50.117] (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id m14sm4133081pjf.3.2020.01.23.15.34.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2020 15:34:59 -0800 (PST)
Subject: Re: [PATCH] target/riscv: Disallow WFI instruction from U-mode
To: Jonathan Behrens <jonathan@fintelia.io>
References: <20200123195200.206355-1-jonathan@fintelia.io>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5d74dfd1-f1f5-df3d-e0b1-771781497553@linaro.org>
Date: Thu, 23 Jan 2020 13:34:55 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123195200.206355-1-jonathan@fintelia.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/23/20 9:52 AM, Jonathan Behrens wrote:
> +    if (!(env->priv >= PRV_S) ||

For integers, !(x >= y) is a poor way to write x < y.


r~


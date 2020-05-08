Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D658C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 20:29:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB8E221775
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 20:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H6g+CPJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8E221775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX9cS-0002kK-0D
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 16:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX9ZF-0007Mc-Dw
 for qemu-devel@nongnu.org; Fri, 08 May 2020 16:25:57 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39840)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX9ZB-0000Rf-UU
 for qemu-devel@nongnu.org; Fri, 08 May 2020 16:25:56 -0400
Received: by mail-pl1-x642.google.com with SMTP id s20so1227754plp.6
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 13:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lxw5IHXH7meg3SrMIDtx2FvU0tJPa/DrNR+wxpAD0c0=;
 b=H6g+CPJxdfnkp4vqWCk0u/Pz4Nf/EAZgIPYU4kEOED5n8hgyvmU2uwnFdElCSYx/oW
 fD31nbWMURE/ZqcJNy/WpORBKQovxjk2s5R293pE20GOOIxncQujfsI3O1w4bI1U94Vn
 me5qXW/0l0XYAc/GcqYCzg7Fxli3HznLVhQiXDanO7kdLaraFNmXTkUOoGnIHyCX99Rz
 LJcuqHfDR/jY2umvuV/IX7kLFBSRLphGF+TleD7Ye9ZNaIIo9itBSotoKbshUL0+Eq0j
 FwI9GBVJN1hPqClwRGrCJF6F+/I4rjvpcXVyFopRt0oUfGofv7BZHkAE8C+WzUWitY6r
 +lhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lxw5IHXH7meg3SrMIDtx2FvU0tJPa/DrNR+wxpAD0c0=;
 b=Z0+7nYfX2nfhCVw3NsADydWmkFgMQJbHXKL4F2DFEVOGnRazvtstMA/r2Xionp2EUf
 aJvn7RJwW5emcmumdT7xuZ7O2dINX9662aHFUZVVwoT7ZE1Gaz1TcE96s0FUgQkuId6p
 fofjgkff/JeN1HP+RtkZj6UCogsAu5OfL1okdQ8iuFRqZwAAxnHCNwvJBYxdtiLXBzfh
 9ebs/glLYs46Qv+oHP/d0OZXHRWFLHWTqei/6KDxmF762L2eMSIeI17Rm4TLqbImnWNx
 Qno+zZT9310+RV/mSLVcqcfdf15m2xDApLuFmULpXbH6xK+rGMRAxtqBlF1mGNajfvdC
 T+7g==
X-Gm-Message-State: AGi0PuYYGDQxw+R90s4FlCJmOiIo9WlMFsRlUm2sDbQmXTuKc+G0Stxc
 zj+1W3+cyJSpLzMZ3BCp96XIGA==
X-Google-Smtp-Source: APiQypJwgGdAJ1PDWNFiYy8ngYaYk0C0+10dqsqpP8VhkJLZQwCwnkEGunIc3VupYSwHwkMu/60fsQ==
X-Received: by 2002:a17:90a:d983:: with SMTP id
 d3mr3595883pjv.209.1588969552240; 
 Fri, 08 May 2020 13:25:52 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m4sm2558926pfm.26.2020.05.08.13.25.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2020 13:25:51 -0700 (PDT)
Subject: Re: [PATCH 4/4] exec: Rename qemu_ram_writeback() as qemu_ram_msync()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200508062456.23344-1-philmd@redhat.com>
 <20200508062456.23344-5-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eef8407f-55ad-9c1d-bfb2-48fe3707aec2@linaro.org>
Date: Fri, 8 May 2020 13:25:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508062456.23344-5-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Beata Michalska <beata.michalska@linaro.org>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/20 11:24 PM, Philippe Mathieu-Daudé wrote:
> Rename qemu_ram_writeback() as qemu_ram_msync() to better
> match what it does.
> 
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/exec/ram_addr.h | 4 ++--
>  exec.c                  | 2 +-
>  memory.c                | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


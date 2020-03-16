Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B60FC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C978120679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gwk6BbG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C978120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48151 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvoD-0005GS-2f
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDvnB-0003tZ-TB
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDvnB-0001EZ-02
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:52:53 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:36108)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDvnA-00016R-PV
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:52:52 -0400
Received: by mail-pg1-x543.google.com with SMTP id z72so481561pgz.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 12:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XSjEqM1pkBNOiCDD3KKMFDmPsx6HNqfksrbdlb11Ou8=;
 b=Gwk6BbG/T8f3eN13G9OnikR2IhbOtZYySgqLI6oGzGzX/SSL2N27F7fS4vW5XphLYL
 Lgoc7yfCuFcx8aWtqPTyy+8JQ9L4QSkEBfqFT7ULWWu8FsibH/2kRuWFeVG/bOLE1uhW
 xnXLOTObXStrqlbLkN1GKQPiXziVFs4slfjkMzSeMkrMZCuojJUtwSWkFPJRSOZX+d1z
 KdUajQP3fyNnjIkpVY8yIv8/xS3FgjoyQ5nsyaKb18JBYhYN8LfDyLyXgUroNC7sbB6r
 tum1yASvPUEnmC3qOwEYj572Nu5IOgyLlWvba0cLCU8PC2OJib8jzK2lomvL9EWtHhx3
 Mq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XSjEqM1pkBNOiCDD3KKMFDmPsx6HNqfksrbdlb11Ou8=;
 b=YzkTzffn7mMvA/3B/9kH4Z1s3+WCsZjY4CvNNmVYIPpqcG83spf3ezsOIPLuO5xBBL
 y3tyWEmcWeiY1xzFMt21oEG+LeQNuMu/tfIxnfEVNdnILAwcZPcyrPLeZ3FQoa3GscgH
 +WLlxSElf6ku1HNLVPMuGdzxc+4kiD7Z0Ht+gES0xQpigsuHFmjgj15YdmTFKGjvUYtj
 br75FeTinONITtd/qNHDOhCInJqjUEXrbMxrJv4Ri8Qrz71/RZ5hdKFpTKqS1rgLBd/o
 0N53LZ4P2KlaXfmIIqXpv+UTAfM9U9+xmi2nPkg91ItCG+naybBtnjIFO82iI4dR9CQF
 5vsg==
X-Gm-Message-State: ANhLgQ06KsClBFIr2srdL2AopTR8W7PmdoUVqM8Z3pxtH1o8vcha1YpU
 yohq+pRB98VBqeDQ0T5Jr8NbyA==
X-Google-Smtp-Source: ADFU+vvijoQC/afij+HOEtKUgij1P27ugBHOV9BUVP/3wT3gYK7jYSwQx2OzJQnwoRsS6W/O+au1/g==
X-Received: by 2002:a62:7d11:: with SMTP id y17mr1251492pfc.127.1584388371660; 
 Mon, 16 Mar 2020 12:52:51 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 o11sm558996pjb.18.2020.03.16.12.52.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 12:52:51 -0700 (PDT)
Subject: Re: [PATCH v3 11/19] target/arm: Restrict ARMv5 cpus to TCG accel
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200316160634.3386-1-philmd@redhat.com>
 <20200316160634.3386-12-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4ee60dab-8799-0174-65f0-3d516fa3de30@linaro.org>
Date: Mon, 16 Mar 2020 12:52:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200316160634.3386-12-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 9:06 AM, Philippe Mathieu-Daudé wrote:
> +static void arm_v5_cpu_register_types(void)
> +{
> +    const ARMCPUInfo *info = arm_v5_cpus;
> +
> +    while (info->name) {
> +        arm_cpu_register(info);
> +        info++;
> +    }
> +}

Similarly wrt ARRAY_SIZE.  Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



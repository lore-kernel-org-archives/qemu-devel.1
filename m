Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBBFC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAAB92255F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VYTcvoxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAAB92255F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIaCj-0000VA-Fd
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 12:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIaAz-0007ij-12
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:20:57 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:40747)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIaAv-0008PD-0q
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:20:56 -0400
Received: by mail-pj1-x1042.google.com with SMTP id gf14so1784338pjb.5
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 09:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cQy0aSJh2RAUVlyGB/Ezp5D9ncokCdOBVPu2B/g4kyk=;
 b=VYTcvoxzvy+6NMEk+cmZFSmynKepW2BxwXYwOixMKXtYCMDT8ee5njkIXXoSKFU+nN
 cuWy6hQMGVUhbrqyx5A7HYdD9jC0U6fGDQqPkAHVE25QM7fyceIRnSXzvrw1VCGhi2kR
 Xol23ygj1wcUd3RkRkqUy4ZPpb0WP2gYAvCC9iErxHK3wtUUR1aDBZKqf4iqb/mGVuIK
 bHWv0nDaPal8kV0f9Aiq2UbuYuO6/2jV+v4fd5eV8CAKxWA/oJCzo6goqHiWlVLNUx3c
 mRoyjd3tjq+pDy15cqwfyB6eAJW2hpth+jona02nMcvtFO14s0waRXlsXJ5UG0HfDv1H
 i/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cQy0aSJh2RAUVlyGB/Ezp5D9ncokCdOBVPu2B/g4kyk=;
 b=UZfqCAKdbq3OlSUxo1wgQBxVAGoTKD3TRY4ZFg/yJZlY0zWMj8tgSSDS75TCwKoG1e
 +WVr8krl8+JHVt2I3GFkcc9Vh/2jT+d97d3FAjxR1e18A3Raqm9ichJr2XGYD49nZnE1
 i7zrqvEwhXaXpaTT6mNh70bedSDURGekCXbgeKZtXAvPE0Ay/xnCkplIKELOzPNU3tba
 4bpnsnIcFYxDhNG5SUh1cFRQoLid70U+UQwlCyBDpbVOvi/4i4T46gPhkYGarDXtr1pv
 BJ3Li/98CEd0YTnZ9Sbw1+LwJ8gctpdTufw2EIFDDiaQW+dM10TLKNOm7260D1rYbxEm
 MvQg==
X-Gm-Message-State: AOAM532H0l+kxjCBeewaBlfN6TfZZcifp5hW5Wj8y6+gbgjFR8b/9o40
 Ss09eq+mn4jD2bZFCyGGPAcKDA==
X-Google-Smtp-Source: ABdhPJz1gu8Lr3jiFoih3OM6+XuvhJfAZnggANQjE5fPi/mhby/PRHOkNmhjZAwU6rPMWsiC3mGoeg==
X-Received: by 2002:a17:90a:ba91:: with SMTP id
 t17mr4837597pjr.83.1600273250992; 
 Wed, 16 Sep 2020 09:20:50 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id r144sm19077672pfc.63.2020.09.16.09.20.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2020 09:20:50 -0700 (PDT)
Subject: Re: [PATCH] configure: move cocoa option to Meson
From: Richard Henderson <richard.henderson@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200916081131.21775-1-pbonzini@redhat.com>
 <4a101a38-cf97-f155-9b89-cfd70a35fe8b@linaro.org>
Message-ID: <af429549-314b-ac71-5c14-380da9b78962@linaro.org>
Date: Wed, 16 Sep 2020 09:20:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4a101a38-cf97-f155-9b89-cfd70a35fe8b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.062,
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
Cc: Christophe de Dinechin <dinechin@redhat.com>, r.bolshakov@yadro.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/20 8:30 AM, Richard Henderson wrote:
> Isn't the error redundant with the required above?

Nevermind.  Obviously the required: is buried under the targetos check.  ENOCOFFEE.


r~


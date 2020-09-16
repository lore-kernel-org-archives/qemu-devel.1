Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1E6C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:26:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2A49223E4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U8ntD2ua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A49223E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIZKQ-0000cJ-Sv
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 11:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIZJL-0007vL-Qw
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 11:25:32 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIZJJ-0006WF-Un
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 11:25:31 -0400
Received: by mail-pf1-x443.google.com with SMTP id b124so4134857pfg.13
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 08:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=H0VcwmYrTjkgjIBA0EmJAiGrZgK8VRKn5y2/2rpjoSk=;
 b=U8ntD2uaroRERUvFP5Tm7OXB6dzrLFQY6R55sdUYgO48XpBXpYieQ6ueIoUtgBsLy9
 EqDWLuUta55CzLRD16addhWEfGc5Fh5L986hNbXyCiTF5PG1JDL0gzp3BkVGYb4v4ma2
 BYf4L173iNEXa17AxztaU06K9epIT287PZ8RGztnSgOV05NJUnwAuQQrEtQdi3NhZoYD
 khiOXFTwFAcMStJIj4+SZCNqC86Z8kwIlVv+aWnsXO2dNN/JF5ZMeBPZImo3tXSY4bzh
 LgPbuN5iycrGQOz9wCK9GQyRxRhEIc7OxPzb8VKq9LdDroihyoLJCoPv4aakhP9xAUu0
 K+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=H0VcwmYrTjkgjIBA0EmJAiGrZgK8VRKn5y2/2rpjoSk=;
 b=fC3t284+kLXeslzTgPzzdIE4PrSAyQN49jtH6TH2gU71p0/y4UP2SyLufY38fNtZ6P
 oJwRgBjjz7DqDh5qpDiOv7ST0togr0T+6j9ipaWWn5OnEd2O1I/9SGIw7/wIcllbVDuS
 /O9uJqu+VermScjrtffWU/5sSzZQ5XVL3LscqB3cp0db/xDPPVLnvTZTM/spmq7Ly0I8
 2nU6sj4voBQ0Tk8qqQBgtkHbl4ZEgJ2QJxC7NzJLJGDiUT14q7IcFXHG6mCiyMGtsPtK
 G+1IYPT3QadVWRJzLcXj/suBxO+LMq4fRloL8kKQgcdH1LYDSC9oIUme//D2SddHy95X
 8iGg==
X-Gm-Message-State: AOAM5312bfpBS3bKtxvlH07NiTkZeoGj3wUme9bxMUZ1Qux5u6D6mmxk
 gvisqv0CGkMced6WbH4jKCN7OaxNmbBVuQ==
X-Google-Smtp-Source: ABdhPJxo9JwkLomhBWDj7vvEs9HQWtmUdJq7m7R5me9kDk2L8fl+vSiHnd20afUaY/fvHC/T/a8vdw==
X-Received: by 2002:a63:4d48:: with SMTP id n8mr19612217pgl.70.1600269927244; 
 Wed, 16 Sep 2020 08:25:27 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id s9sm14841278pgm.40.2020.09.16.08.25.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2020 08:25:26 -0700 (PDT)
Subject: Re: [PATCH] configure: fix --meson=/path/to/meson
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200916080812.21479-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1ba5f240-c79a-c06c-534f-b24067d1d4b1@linaro.org>
Date: Wed, 16 Sep 2020 08:25:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200916080812.21479-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/20 1:08 AM, Paolo Bonzini wrote:
> Due to a cut-and-paste error, the path to a user-specified meson
> was ignored and replaced by whatever was in the path.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


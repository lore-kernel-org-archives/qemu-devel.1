Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BC5C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D0720758
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DKPhPr2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D0720758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb7GV-0001dI-S0
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 14:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb7Fk-0000v3-Lc
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:46:13 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:42307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb7Fj-0006fq-Dx
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:46:12 -0400
Received: by mail-pl1-x629.google.com with SMTP id k19so248270pll.9
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 11:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=n38bPi+A72/fnn3D/m6XEyTKzrMIN/c0GVcCr1F+ruQ=;
 b=DKPhPr2Dqs9QW3jyUiVjtabtsPXzgxjvasOE+tC3vGUmBm4LY2oszBl8GHgIbpSVth
 tAYQ2bTbr4tetdpvS9AqIWB0kiWzjHfoi9xedPLFQgRV4TIJ2MJVwMXGJdoBQMTj9oA/
 z4B+6epGVhMCciJnxeetgRpH2onhrVBkJNGyJxtJMV/slhAZUAsHxKS+EBolmg3eqpFX
 4VZk35tQ4fQcneWMhVK7J8PA//qUW+35tUt6r5flLWHH5JFTXMSRmLqA7yQzs34PA8OD
 0ck5oTUi6ClCGIlfp9ugMj8on/LKQB35VjS7u/t9p39tYAYGhYd+K9yEEk4sBTTnskJd
 IFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n38bPi+A72/fnn3D/m6XEyTKzrMIN/c0GVcCr1F+ruQ=;
 b=aO/jUKE56wrTBTiYVXT3SiEAi3q4/+uVEuHEKuPTAmh7izoLvMQ50lI6G2XVgStWNF
 qwpEXl52zMLhx4IMKe7rx/ZBdqSdv75g4fGOlCPsYscLr6iF1+/mQqMN1nPhV6nXeJFW
 mP5t9dYWUPH9p1PZtzhNeaf9O0ct9KNMoXFmImAd4iZ0b1IcgsyrLI0ycnndHU3U201h
 nlNSKhMlFggzF42UvKSkcmEhgxmQ9j+14coo1jVvcG98Ah7k1HP8df7pZXBnvapSr2/w
 RfEJCID5v8WczYx13pNSYYLO6d2JovhrWVlZXpAzy/J1K8HJO9tTQL9d7mDutYLISlTL
 c1zA==
X-Gm-Message-State: AOAM533W0Hboa5RjBr8tKl/bSXPJgsoU/OfzS4krLXjTgiPHZGtlq8ZL
 JZ0D4lNfKmWKFb97tucTOFiGkQ==
X-Google-Smtp-Source: ABdhPJyeT3o7acx2NS1+VZTGCzVPPh3FLwd/CswUifYXfQYe2EHjmq0PBKLtjkia1apTh2LWDVDghw==
X-Received: by 2002:a17:90a:4809:: with SMTP id
 a9mr963281pjh.196.1589913969814; 
 Tue, 19 May 2020 11:46:09 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id j124sm179902pfd.116.2020.05.19.11.46.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 11:46:09 -0700 (PDT)
Subject: Re: tst-arm-mte bug: PSTATE.TCO is cleared on exceptions
To: Szabolcs Nagy <szabolcs.nagy@arm.com>
References: <20200420102902.GE15401@arm.com>
 <a36c670a-5cef-f8c6-ce1d-4fbb28f9488d@linaro.org>
 <ec85fd40-229b-c965-1f58-d4cbe825419c@linaro.org>
 <20200506125709.GK23080@arm.com> <20200507095902.GA30635@arm.com>
 <5d0ae4c0-70a8-255c-9493-ca8b65e572fb@linaro.org>
 <20200518125901.GI27289@arm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <086d56cf-1aac-04b5-9e94-639c4bf005bd@linaro.org>
Date: Tue, 19 May 2020 11:46:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518125901.GI27289@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
Cc: nd@arm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 5:59 AM, Szabolcs Nagy wrote:
> i got some time to create a reproducer (with public code),

Thanks.  I've grabbed it.  I'll try it out soon.


r~


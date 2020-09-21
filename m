Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC190C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 00:42:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C28B207EA
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 00:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="acCcxDYz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C28B207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK9v0-0002q5-4Q
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 20:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kK9tX-0002NI-JP
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 20:41:27 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:34227)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kK9tT-0006dK-Mq
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 20:41:27 -0400
Received: by mail-pg1-x544.google.com with SMTP id u13so7465992pgh.1
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 17:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bThgqV1vPmuQWsE2nIu1KxJZM9sY62ci7n7uqidIXBw=;
 b=acCcxDYzD1i4eA6vJTmswqoUY+fDlTlut01RSWXUI79arSasJnQCkl4hM5APCNdP9H
 1gapqTuSyNWX0NRJ1XqX77AVFUVIBaZwZwitIwoEWgoDbUfLWy27xphtiiBHJ/5dkzOX
 JDVRwaZU0qcAMJI065hQM8mqWLax41qzmgpibcDlEjXupKaXNf0ABSgDEVGK0jemScKC
 n70/02LEUrLcjWs8s/wHm0GX9+UK5GzEac3kGE6TMJ/8O07Oango3G005ujbxmDCX21C
 BFu/0nQN7z5nbbqOl3mc6scDbg5t4KvMAqopIJvbjelIkAgDgBonZSwVBNev5os4+pc3
 MDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bThgqV1vPmuQWsE2nIu1KxJZM9sY62ci7n7uqidIXBw=;
 b=hWImJ2F50BFyiW2ne876aR7+S+PfW+qfzY7lr90MOJgv/3RNproWs9Of/jUEFYOtQ1
 RQXL/0Jl1+aR4ybjxxlQnXbqT0JQqUZX6zPlMvSp38IGh1iR5L+ds7baI5MeBpSGhCm5
 lt9JDycWDgF77ZiGieEKBY99zCzVQmyzgqAc73LZm+4lYq78WDHZM08yhOilN0sXCKME
 p9PExbnYzX3i6WakW/c60HUbytrNhnijjF9yjWb+SUocsK/u5S+w9bcAgMFnbeQbuY6u
 lI38WWz6JohlalHUFoNdTto1VCE1IAh/XIbkIqHNVPIb7jp0KhZMTs4iOMgRjEe8nVwv
 WPgA==
X-Gm-Message-State: AOAM531Q8+3t6D9a7hvz490BBCBpKDXs4DVxoTQCBTZe1PujwfMD2Qhg
 7BkuYjlIUHAeyeYM5tWrJ0pERg==
X-Google-Smtp-Source: ABdhPJzARGwze7VinhVF9ktv06VfJhay+L/QiGWtY5SX2gBDyfpkJtBumD+lFqwzCBnabQdk07VM3w==
X-Received: by 2002:aa7:9592:0:b029:13e:d13d:a054 with SMTP id
 z18-20020aa795920000b029013ed13da054mr41232709pfj.26.1600648880120; 
 Sun, 20 Sep 2020 17:41:20 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id l14sm8829435pjy.1.2020.09.20.17.41.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2020 17:41:19 -0700 (PDT)
Subject: Re: [PATCH] configure: fix performance regression due to PIC objects
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200919155639.1045857-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b4b24feb-e7e8-b4a0-2e82-7bb5e6633289@linaro.org>
Date: Sun, 20 Sep 2020 17:41:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200919155639.1045857-1-pbonzini@redhat.com>
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
Cc: Ahmed Karaman <ahmedkrmn@outlook.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/19/20 8:56 AM, Paolo Bonzini wrote:
> Because most files in QEMU are grouped into static libraries, Meson conservatively
> compiles them with -fPIC.  This is overkill and produces slowdowns up to 20% on
> some TCG tests.
> 
> As a stopgap measure, use the b_staticpic option to limit the slowdown to
> --enable-pie.  https://github.com/mesonbuild/meson/pull/7760 will allow
> us to use b_staticpic=false and let Meson do the right thing.
> 
> Reported-by: Ahmed Karaman <ahmedkrmn@outlook.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~



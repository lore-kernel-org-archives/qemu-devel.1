Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5407CC43463
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 23:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B792071A
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 23:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xw6fHPSs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B792071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK98e-0006dk-KJ
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 19:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kK97v-0006D4-JB
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 19:52:15 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:51748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kK97t-0001RS-Ab
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 19:52:15 -0400
Received: by mail-pj1-x1043.google.com with SMTP id a9so6432880pjg.1
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 16:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=F0AmU4JphKcNdTI/kSwUJNwBq2BYA4gUsj8EFG6qhMo=;
 b=xw6fHPSsD3e/RON5a/9zQV6UMq9AeKvXg9SENwaKNvcqfx7EHvFI4mEpZ/3VC99s2Y
 O2SQiSqLZJikF2TazoGnsDtyk+pEQXmrOnUdSwt9r5kM162vRarDVUpu5ynBK/9eRgh2
 6GuYcEIleWKJC/yASSKeWqv44LlnwV2IUDrIsIRMt/vmJ9jw+N9PGkEwH1nKsDbCxhbN
 GoYIMbOUFuZa5z6uLWJ+/sNhqRET0y/pAqtgI494ZCXdinyYzgdQdE9kgfStRDtKPJxB
 A3tIjdmlwDk6crkT5ClkRMoHpFauXhyvXFtfLtmeCBMlcRVk0IEp8TvQQeK/o/IcFe7U
 k1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=F0AmU4JphKcNdTI/kSwUJNwBq2BYA4gUsj8EFG6qhMo=;
 b=OaRodhxDznAwJA9B+f9gKysX9zJe6D/vm3I+S7UZWuKxjIjysjTEhV4Fh5mpfphvlO
 OQMyLWc3JjH1Sve8Lw+yO9yjXCJjAdjtt+OlMxkALuRXuqCVfdF+j2xwA/DyUx4cANqg
 7pBym3DezYaG0/Qp2g6kj7VX1uAhTBAgqgOKTWB1pzPwSPC0YAfs2qJbUNiluejPAS9D
 cyH8xPfqerTWxqcRd7nnx1uqN3owsp6saEvoWOUBheucJ3vXFoxln7kheZhhx4R5wE8U
 NllWCUdZaeYdlQrsP6SOn30E97j4C061GDDfiW4fNR0Z37SnNiXBhPeqa53P8TOcKHsK
 97tA==
X-Gm-Message-State: AOAM530AOF9LcrenzGF9wEav7PwgW5lKQYqgNcM2ADqCM0gH21tfaBuS
 XsGZvGI36k2nSKv52jI3dM5M0Nq0lbWhXQ==
X-Google-Smtp-Source: ABdhPJyMT5J5fEn6IjRFi1MIFxWbt7hdfuJfZzvcdQzzHVjC/fjLJ8f5684QofVR6q5Hzy2lw2Ljrg==
X-Received: by 2002:a17:90a:d90c:: with SMTP id
 c12mr22106109pjv.94.1600645931052; 
 Sun, 20 Sep 2020 16:52:11 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q20sm4671242pgm.24.2020.09.20.16.52.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2020 16:52:09 -0700 (PDT)
Subject: Re: [PATCH 4/4] configure: consistently pass CFLAGS/CXXFLAGS/LDFLAGS
 to meson
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200920093016.1150346-1-pbonzini@redhat.com>
 <20200920093016.1150346-5-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <94426ae5-3b09-b9c9-c83f-fa3d5716da95@linaro.org>
Date: Sun, 20 Sep 2020 16:52:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200920093016.1150346-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/20/20 2:30 AM, Paolo Bonzini wrote:
> Environment variables like CFLAGS are easy to accidentally change.  Meson
> warns if that happens, but in a project with a lot of configuration that
> is easy to lose.  It is also surprising behavior since meson caches -D
> options and remembers those on reconfiguration (which we rely on,
> since configure options become -D options).
> 
> By placing the user-provided CFLAGS, CXXFLAGS and LDFLAGS in the
> cross file, we at least get consistent behavior.  These environment
> variables are still ugly and not really recommended, but there are
> distros that rely on them.  For the gory details, refer to
> https://github.com/mesonbuild/meson/issues/4664.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure   |  4 ++++
>  meson.build | 14 ++++++++++++--
>  2 files changed, 16 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~



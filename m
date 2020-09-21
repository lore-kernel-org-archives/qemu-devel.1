Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2EDC43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 00:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD83320789
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 00:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="he6ROJK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD83320789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK9Mb-0002e8-U8
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 20:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kK9Ly-0002DX-A4
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 20:06:46 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:42463)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kK9Lw-00037o-Nq
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 20:06:46 -0400
Received: by mail-pg1-x52c.google.com with SMTP id k14so7365997pgi.9
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 17:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=IILPnMGtZw98+6Zg8D64Uj1K+yvutCJQ3UOimsjtc0E=;
 b=he6ROJK6kY1vRfFJMvXFbYpB7jUMHPWYNbcrBi5LPDNID99Vm7kWRo5wQXX0Kkc6Cb
 kGN6/MFFjTtIJ/2lMozSRsfLNCek4X6y/yB5CKxC4elD7tln9G7tjWWSs32ehc7024A6
 DfLMUpzzd9OoP8eIJagZ5kpp1cnKHr3YVEmcyrzsX5s6KK1bBWiah4UpMnwzlDk7Ppek
 2ZeikrddwGp1qP83gqo4Zi8omEZbVvzquJH98UsOFX4GpDY6WEx352RqXrUGP9YDc2J2
 v+GI9Apc5OoLz2zQB24JgQA/xg1Avv6QfilMwMmIpftaFGomd8mPs9T/cBSENoT89nAE
 AFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IILPnMGtZw98+6Zg8D64Uj1K+yvutCJQ3UOimsjtc0E=;
 b=jRMPvaYtTSiruwkqzpPUy9MnN1cTt/7CUwyetm9Mmb55ngO/k8pX7QyD9O+JQxBwc5
 kI067iKxtjjM0l0QF6FkG9K+sY/K2N7hyiz+fLzS3oDXbFBWxTZUHlU9YtfTUDs51O3a
 QqA6uApV3d6k3KmzYc+N/HvyJwNrEOPQcwC7bXXcNpSPTMRb7NVkZ4PJECxH8u1LN/qa
 QiBS2t8zG4ujvV8zMiSzEP6/F8ZsYSRfhPGkApjIg/qstGTZgjx3SX6aVFd+7SCous/g
 IDCwbGVcFts075Zt6F5Tvu3TgYxH1Z50uY95tA4hdRfQ7/KVLradi4/msmJ4g5xVO1mG
 Xh8A==
X-Gm-Message-State: AOAM532qbSY7OBy9l5unW6cSiC9e3j1AJeNRatSuPh61qwddrdz+AaaX
 48wge7vd54WMiKUB9j2waMc5MU03zQx3Kg==
X-Google-Smtp-Source: ABdhPJwWNhh/WbIZ7SOsMmvokSFhEiY9h3VZ8XSo2Bs+pBFckilNE5ikCOgmhU8Zw0lsOcbfc/XioQ==
X-Received: by 2002:a17:902:8341:b029:d2:29fc:c400 with SMTP id
 z1-20020a1709028341b02900d229fcc400mr754493pln.5.1600646802229; 
 Sun, 20 Sep 2020 17:06:42 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x13sm10217416pff.152.2020.09.20.17.06.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2020 17:06:41 -0700 (PDT)
Subject: Re: [PATCH 3/9] configure: rewrite accelerator defaults as tests
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200920130708.1156310-1-pbonzini@redhat.com>
 <20200920130708.1156310-4-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <becd5b09-a06a-3b19-79f7-bc03af7d76aa@linaro.org>
Date: Sun, 20 Sep 2020 17:06:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200920130708.1156310-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 9/20/20 6:07 AM, Paolo Bonzini wrote:
> +if test "$kvm" = "auto" ; then
> +  if test "$linux" = yes ; then
> +    kvm=enabled
> +  else
> +    if test "$kvm" = "enabled" ; then
> +      feature_not_found "kvm" "KVM is only available on Linux"

Can't get here, as enabled != auto.


r~


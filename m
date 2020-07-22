Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0ED1C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:04:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 763B2206F5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MTaFMEn7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763B2206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyHEY-0006hC-MO
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 12:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyHDH-0005OD-K2
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:03:24 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:43394)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyHDE-0001F3-Lt
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:03:23 -0400
Received: by mail-pg1-x541.google.com with SMTP id w2so1495693pgg.10
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 09:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=y3kMS8iT3vWBr+WQcTO+VksNvKcPULleRwx/OZniflM=;
 b=MTaFMEn7qYv+XE1dPQg9C4BujEPVbIA9zJPULBsfEEzmtOut1vJ4FE+w5ZYgLTUE5Q
 k8BMUOnMRAj8fW6CQaZ0GythGFsAWr13oVeYJkM9pqg0hRGUiEunzCpwTHHYZSbJ0pPU
 gMsgV6ULdh55zJXRiy9WTL8mqSr/70qNw42xgIJMP7F4dR0vsCoiGdfOW+g85XFVmUP1
 0RnFjY/AEJz7DZjFmv+iBJNqUb5bq/xYGG+ai059fkAOBlPbbkLMuMZ/cPaQ/FYRavUl
 XuwUVXUVVUQQjtsNuW/g9ftyXkGr0KqWrhtpplesiGiDcpvOV2Rn2yZYin30rojlV9A/
 DGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=y3kMS8iT3vWBr+WQcTO+VksNvKcPULleRwx/OZniflM=;
 b=MGMzQMVQ4trFiC0Ziysje+Cz3TCptbg1ECO/21hQDia9fNaNXiQSUiZdIECmLeRTOE
 02pH86LZieBgsZVllJc8PvAzjofaNwtkYVXERf/du3gQPNQKhm02R9KqKiDm7V1MakwQ
 uNhJJyg5VRPGRTD61YMwoRpMzXZLUcYK8KCQW8DCNTtYkHjk4wKGLLuiyw3QJ9XabyTr
 SCZEh2O8yezJhgiHA0fgnrGayLtKxk26WQdLCpG9PXZ3Kl5qLPrkdnozaaHPAaER2tab
 GuIUMPi/iUBdpFAF9koNBuad1QCtxz9v9IDaFL5hir8PLCrDrxCneWcWXfRgTi/w69Sf
 T5Tg==
X-Gm-Message-State: AOAM530IvSRBOi4bZmUNjMLKnWPHtG845Y+YI0465cDppUzIOZSs1+dO
 HJ2D4v6yxTRA0l+aMx6cDlehWA==
X-Google-Smtp-Source: ABdhPJzFD9FwcVuYMk21yN4RkD03xI7B1zKdQSVF7v+NhLr+95yjC9q9yPoLlFOJNjlEK8a8uHvH/g==
X-Received: by 2002:a63:6486:: with SMTP id y128mr475362pgb.82.1595433798725; 
 Wed, 22 Jul 2020 09:03:18 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id k8sm39609pfu.68.2020.07.22.09.03.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2020 09:03:17 -0700 (PDT)
Subject: Re: [PATCH v2 11/12] tests/docker: add support for DEB_KEYRING
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200722062902.24509-1-alex.bennee@linaro.org>
 <20200722062902.24509-12-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9b7f3c09-5d6a-ff3e-f872-e47ee5320404@linaro.org>
Date: Wed, 22 Jul 2020 09:03:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722062902.24509-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, f4bug@amsat.org,
 cota@braap.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/21/20 11:29 PM, Alex Bennée wrote:
> For installing stuff from sid or ports you may need to manually
> specify the location of the keyring. You can even import keys into
> your personal keyring and point it there, e.g.:
> 
>   gpg --keyserver keyring.debian.org --recv-keys 84C573CD4E1AFD6C
>   make docker-binfmt-image-debian-sid-hppa DEB_TYPE=sid DEB_ARCH=hppa \
>       DEB_URL=http://ftp.ports.debian.org/debian-ports/ \
>       EXECUTABLE=./hppa-linux-user/qemu-hppa V=1 \
>       DEB_KEYRING=${HOME}/.gnupg/pubring.kbx
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/dockerfiles/debian-bootstrap.pre | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


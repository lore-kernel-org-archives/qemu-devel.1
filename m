Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3474CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:30:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05F8220853
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q8MlOkPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F8220853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqhVA-0004AI-8Y
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 14:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jqhUA-0003fU-2P
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 14:29:30 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:35220)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jqhU8-0004Va-DZ
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 14:29:29 -0400
Received: by mail-pj1-x1042.google.com with SMTP id f16so993855pjt.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 11:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=SGGGhmdBRttWqp65C+GvmngAI4GTDFyswA+RF0iIQ6o=;
 b=Q8MlOkPasCUSUqOj5VgZ7s4pcZUt282r2MU2TpDwaiCc64LS/2NYs/ptbIU0CTnAVx
 lWKLTPRm7Ci7JiD0qTKIX+u0hmL2yw100ew56yRJE4zCo63RNX0IgK0nx3/KOsUCYOUV
 L29Eb3zPMa9+GudwidxSznQAmd+kZBoNq+Yy1K3m5VcnC6tu5S9gTFOPvW6tAAA7AesS
 g0dkWzHbXyr+vEIAgaLCI6tou/uUuUxxg6YbS5p6HFf92GDpsG6e/Yx2HxS9Z5uoS9Xx
 YVw41k6wBGN92fSamYWy9sAeHs0G0KTQtTn2fysbOEPv4cN0XCSoQjP2huFYaZ7m8NZp
 ZXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SGGGhmdBRttWqp65C+GvmngAI4GTDFyswA+RF0iIQ6o=;
 b=TC0bJNbo7Q0QMvHYj9n1sxAJu/3mCYsokbzcR/o/aZWMDK5IC0VTyIQeW1NVWljHp4
 7oSTKuDJ95O/UEUCW8wrD+xR+30QhmKbEoqwOHISHpV6B3QNv48iS48M2z4ckbrobGbf
 uFcky2238SNomm5KP1mdjBjSbw6jdvXd8osyOyc08bDz9WBhvBKf8YvoSv8qpTHZo9fj
 ITZ4iDMDW1KTT/LtPqU5nshqPEApM+lcgqkxlxtce0cDWyuzXTXgx4bCXAZqqvlHigD6
 WCO+wvGQyfp+NxWh7KHgFoI1dr7VDeYemUQQolsyAqipczJqDvbT37DRDpvIuAYm8G1N
 l50Q==
X-Gm-Message-State: AOAM531Pg0i2dhD91Y663fVi4VQkUofzQ154Lm19d+QrF3XhF5A8Et78
 3XJO/lp6cZZx4clxZ94zgJ1hmGIZUlY=
X-Google-Smtp-Source: ABdhPJyn+CJ6tl5+HzPqRqprx73DFnXPBEBSlSgVzdgkCP3u4PJp+F3od1Xs2f+lhc4xuIHkNwL3Ig==
X-Received: by 2002:a17:902:8b8a:: with SMTP id
 ay10mr23400435plb.235.1593628166189; 
 Wed, 01 Jul 2020 11:29:26 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id b4sm5786673pjn.38.2020.07.01.11.29.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 11:29:25 -0700 (PDT)
Subject: Re: [PATCH] target-i386: remove gen_io_end
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200626104419.15504-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c2415ac1-94eb-31d2-847b-3759fc9c12aa@linaro.org>
Date: Wed, 1 Jul 2020 11:29:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200626104419.15504-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 6/26/20 3:44 AM, Paolo Bonzini wrote:
> Force the end of a translation block after an I/O instruction in
> icount mode.  For consistency, all CF_USE_ICOUNT code is kept in
> disas_insn instead of having it in gen_ins and gen_outs.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/translate.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


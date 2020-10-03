Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D913C4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 10:06:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7001206CA
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 10:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HdJSC7mD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7001206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOeQc-00006s-17
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 06:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOeOb-0006sh-0S
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 06:04:05 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44775)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOeOY-00036J-IH
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 06:04:04 -0400
Received: by mail-oi1-x243.google.com with SMTP id y123so170256oie.11
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 03:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cG+rDiGufIRUZmngOUTf5V0P1gEN2vU/I0BKD4lYt1U=;
 b=HdJSC7mDbiLifLA6qFPvkUWJX0Cfc+6dls/6n6VrDuxJqkAIlTuLnRTeeccAZCwVEq
 WbRW1oCg1sZgeVV5YMgz5+gQR/KoLrI1UQvGKPwV5CEN2zoNmXM/Y8qqKPnnFkHjcBTN
 A4TW+urnAoa+fse2BW7gDWhVtwgWazBcDb8ZCYZVYH9dLDcFbePe6vObYCwKtSNiSffo
 ZVx77zc/+/D1RqLVe5T+pTqzja9KMwWUvT5fXgS3vmCV7lM2APa/mXGQxCyZhsewcmNV
 nO80LcoiyKmAzMqM6uqV7upkTS4QCMgJV7xAjrn90AiPr4B0Z5ywj8Iwwl71vldE3Nny
 owlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cG+rDiGufIRUZmngOUTf5V0P1gEN2vU/I0BKD4lYt1U=;
 b=j+/ylA49+CY9sO94ysn66Z0KwRCwmyVdY9wzTXi76MrJYVQ+/Ue8pbD4Mv6farzPhk
 LWOqdDQdBHq5zLPL5tp8Jq6oba1HvjrVv3dzX24T+2M1H6kvLInyOTz0EKml+YHWTno6
 nBzFGGE842DWeLPmg9KXNqpOnSPt6wUYVU51WYvSLpOMYGz2lLC5R+3yZtgLWIwjl8H4
 7FPNxgfzbHJ81X4JY90sasARxWShizMA+cPFKKVbNCzsIV3aTMy0wNM79mO1Yj9c1UAP
 QRIG8NccPynn/CJDenvbx2PEuHQ6u+LQdJfrHqvGMfoAulJpZSfmfYnUbjzM8TTLfE9B
 Tnow==
X-Gm-Message-State: AOAM5302QUL+7/adZneBMzVe02Okc+wz35DoC58BgxH2nQrD5BVUpREh
 yushorLcDWpIDkNo6X5CsTmDBQ==
X-Google-Smtp-Source: ABdhPJwIeDtlbvhrW+UehIVEor+MVHY96lsLif2Knq/6uJbUXaH4H8RsDWtuRdpkBSxiFT5aLe+D9A==
X-Received: by 2002:aca:ef03:: with SMTP id n3mr3457690oih.67.1601719441143;
 Sat, 03 Oct 2020 03:04:01 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id j21sm1162131otq.18.2020.10.03.03.03.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 03:04:00 -0700 (PDT)
Subject: Re: [PATCH v4 12/12] .travis.yml: Add a KVM-only Aarch64 job
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200929224355.1224017-1-philmd@redhat.com>
 <20200929224355.1224017-13-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bd4c4587-de23-7612-48c7-afc8b94ab9fb@linaro.org>
Date: Sat, 3 Oct 2020 05:03:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929224355.1224017-13-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.256,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/29/20 5:43 PM, Philippe Mathieu-Daudé wrote:
> Add a job to build QEMU on Aarch64 with TCG disabled, so
> this configuration won't bitrot over time.
> 
> We explicitly modify default-configs/aarch64-softmmu.mak to
> only select the 'virt' and 'SBSA-REF' machines.

I really wish we didn't have to do this.

Can't we e.g. *not* list all of the arm boards explicitly in default-configs,
but use the Kconfig "default y if ..."?

Seems like that would let --disable-tcg work as expected.
One should still be able to create custom configs with e.g.
CONFIG_EXYNOS4=n or CONIFIG_ARM_V4=n, correct?


r~


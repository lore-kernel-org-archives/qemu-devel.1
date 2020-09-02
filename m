Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A70BC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:12:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BF3720767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JlVfI1N3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF3720767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbvx-0008UE-GE
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 19:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDbuQ-0005vd-IQ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 19:11:18 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:38969)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDbuO-00036a-Ec
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 19:11:18 -0400
Received: by mail-pg1-x529.google.com with SMTP id v15so517400pgh.6
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 16:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=UB01ljHxHRV0ISpYabpX5ipY2fmsi9a+s4qhg+yDypY=;
 b=JlVfI1N3uiRmd2/qCTLBjqZxp/jm70rd5SsOASJwJ4SQNH8mUL2w1STjGQ9Fvx6ggS
 yFpM2CPUZ7iP6TMynf5JFq1u9s9KWy1y8yWGAFrmCZF32MgOMgCnv/uTXXGrpxILqAS+
 KjcPlcE6JP3tFnY8Ratl/2LEBeVpSU0qVCC5I7pJJay17yvd/f2IkyE6XvX7a5Q+oc4q
 oCyBD1cKWmUtQL+w4TS2COkstZQS51gTNSbEFpPL9yttwW8kHy3+CwBM3Y3N9khI2i9G
 3+Tf8BOyp39VHAyDHWMqEQhxNyt/PWuaopkxh+Ru2Po24lQA6Drl+0eeJyPYY3JmTgBB
 P8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UB01ljHxHRV0ISpYabpX5ipY2fmsi9a+s4qhg+yDypY=;
 b=kIhYyS6lz1z5ilXHhapydkIhh+6b/Q75b3d6Vbrmxph7j6Gghkw5rSV1pRnOYfgC7L
 6ntRGNMJ/qclQRQXMnEkSjiWGraQyWxnArmVMBVLOr1zIveMNyPRwZ9XRLskzbMXW49T
 oAEKou4CVvWeFGZKN/VoHo6CMyEDECNMLbhL3URAq4j3s0yctvruSxcgFeyBNrVRkG+9
 rLK9EV7tmO39I3JTJWcreaHeBchULSupMHfeAUelPcdQMF0Qm3BK0pTGR8bDx/ursfeU
 eEkhTgPOM2o7OB916UlRFxaaM3gPZEJ6UuCvOFIdrbpaoc7el0EIjPG8bFvXH2zQasjj
 UkNQ==
X-Gm-Message-State: AOAM532JCToEfkBivslAywDdrAd4LP05Sjf/7vciF4oJfBVi+dr8Mbb5
 U0eBe1PJqp6py1hbchhK80Sb3w==
X-Google-Smtp-Source: ABdhPJz57fHM1mj6bC8P6pJzCWrj3o+KAK7IfSSTSlpFegW0HifjnTVwqTteBr6eydFv4qAKNC8Nyw==
X-Received: by 2002:a62:79c7:: with SMTP id u190mr665199pfc.301.1599088274777; 
 Wed, 02 Sep 2020 16:11:14 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id bx22sm435346pjb.23.2020.09.02.16.11.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 16:11:14 -0700 (PDT)
Subject: Re: [PULL v2 00/76] target/microblaze improvements
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200901152054.922595-1-richard.henderson@linaro.org>
 <3eb9a404-b856-6337-680c-462a765e2b42@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ca9d4e58-3545-ca8e-6862-26efe81a0cc7@linaro.org>
Date: Wed, 2 Sep 2020 16:11:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3eb9a404-b856-6337-680c-462a765e2b42@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.324,
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/2/20 12:09 PM, Thomas Huth wrote:
> On 01/09/2020 17.20, Richard Henderson wrote:
>> Version 2.  Serves me right for not testing 32-bit host
>> when I knew there was a patch that mattered.
> 
>  Hi Richard,
> 
> I'm afraid, but I think this PR broke the
> tests/acceptance/replay_kernel.py:ReplayKernel.test_microblaze_s3adsp1800 acceptance
> test:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/716158589#L176
> 
> Could you please have a look?

That's odd.

Doesn't replay rely on migration (or at least VMStateDescription) to do its
job?  Microblaze doesn't implement that, so how could this have worked before?

I admit that I don't often run check-acceptance, because I rarely see a clean
bill of health, even for stuff I'm not working on.

Looking into it...


r~


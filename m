Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9799C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:40:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 961D8207D8
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fufoIZZi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 961D8207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg91S-0001Hu-Rf
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 11:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jg90s-0000oz-DK
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:39:38 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:40954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jg90r-0005eV-9Y
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:39:37 -0400
Received: by mail-pl1-x62a.google.com with SMTP id t16so1487723plo.7
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 08:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xvcgfKR+6pgasBZstlTudcR3v9VdAqKbHb2KVWHDeyI=;
 b=fufoIZZiDMy3lBcm6XnAys6Vj4Wl3FJNjdOST3sei7IxpDIuIpEL3CDspMtwgmIRIL
 8gibZt3lTkbDtJsd2E56xVAlYycvXvek4gg/t4x4xdRMZwVbttwqEWb9X89DzC9We1xV
 5dhP5ufApWkmdBnvZUenW3qyPiq5pP7FRO5wx0eo8OJjIiGXfoI5rjHbBnQ8vUflK/OS
 /Q1ck/EJQlmKqAulDN8z1NEOseWCtUK2Rl60xauxwSZawXK++OfuY8jRLHxVlgyRpgDx
 YkVzG4S8q1qLowbIXjMaIP4Gg99nTLl9tUzk3fgRLJ8Ze5vJJahkHDUOGS885rwpRPuq
 99aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xvcgfKR+6pgasBZstlTudcR3v9VdAqKbHb2KVWHDeyI=;
 b=T9/SldgZy2y2/W6htQgBjdsNlr8CPuWQjQhJDpGbk2LGKe7rJdJQMUat/IYm2COjw9
 /hgqOQQW9ZeU4jW7vfZS1+nhQuxIAGx1hqBlbAKNizc3HBTOMbare3WL+qFjw6zJ8Yvl
 WWryG/YelAan6j2KJ60cSZZ0hdTIjaWpyPrGR/B/3XxMWBvYbC2cipc2RAqEqpRNNT7y
 FCPGk1NfPny+072UAIx2/1d9AEW4nR4GZxOnNibJhfwMd1TimYJMOqNPJ5qeBAtCIaWM
 U8vVfLghRhn9FrvzwzP6ce9blSnM3fMVHaNCQYMKx7YklC4OEz+eEWo9s1nfDCIerWgh
 XmPQ==
X-Gm-Message-State: AOAM531wE32UwK55XGASqDCVQ3Rikra1TShpCqDrBlb2crfTGtEXFVd/
 NppWUdBUq5yUbuZw8iNTau/LlbzExz8=
X-Google-Smtp-Source: ABdhPJxF83sMjEvw7nmxuqY/OStjgDU6/iJMCWZZbfxM8nZqMj0s5kUKjyoCmvaEd/07aNKK/hntJw==
X-Received: by 2002:a17:902:8541:: with SMTP id
 d1mr4655707plo.234.1591112375323; 
 Tue, 02 Jun 2020 08:39:35 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id t25sm2501587pgo.7.2020.06.02.08.39.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 08:39:34 -0700 (PDT)
Subject: Re: [PATCH] .travis.yml: Temporarily disable the aarch64 job
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200602113702.28549-1-f4bug@amsat.org>
 <87lfl57aid.fsf@linaro.org> <2c6ad72e-c7c4-1a74-c16e-4183c9356c42@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <91b41018-f87f-bac9-3258-bfc32cf2f720@linaro.org>
Date: Tue, 2 Jun 2020 08:39:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <2c6ad72e-c7c4-1a74-c16e-4183c9356c42@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
Cc: Fam Zheng <fam@euphon.net>, "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/2/20 8:36 AM, Philippe Mathieu-Daudé wrote:
> Have you experienced problems with the s390x/powerpc jobs too?

I have, just yesterday.

r~


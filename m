Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863E5C433E6
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 23:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D0B620CC7
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 23:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N66Tzxel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0B620CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCWpS-0000cd-Fw
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 19:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCWov-0000BA-PM
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 19:33:09 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37934)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCWou-0005Kt-3l
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 19:33:09 -0400
Received: by mail-pl1-x643.google.com with SMTP id t11so2185341plr.5
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2020 16:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+E/Y/RY5EtZ/iGbcYFy08oilBl42FuKRNWOnNfg4QOk=;
 b=N66TzxelPaj43ZnWHsgSCBoHPfjmauD3rbR7uo/N8p1t2qazBBA50DC2XcEn+Bm2Te
 bXQJ77xBbdFT2VfR1yVRvLBX3EApT7q1sOmIst7Hqnirj1+Q8HLo3Ieqo7Dtt4A3Nts+
 2piEm0ionT58scwpGq5mA0ELS/vmXEuruw+QqYVe21xvYwpfNkARoDtO4CEeR61x76EM
 ecn9L3LVJ9Vhiki65vJ4pfKjwbOMzJkrWo0U4YiPkDKGA9AiZmWUH+Wn519RJjV5HSWg
 8CKfBapvgKbD+so5x1AstnUuO3xBwQJciWv3TIqwbE3UzchbzmwOZDvdav2cP9u/dSGx
 ccXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+E/Y/RY5EtZ/iGbcYFy08oilBl42FuKRNWOnNfg4QOk=;
 b=pirMuJC83aXGDGLG0D0yTmCt1TgS1LKAjQ2epDMBkoXQRf9WakD4C0tFnENQmDYOFf
 3ezCQ0Umnr43Uuyv+YgvOPf1BccTPi3AIgV8C1AgFdJEHp3ORkKL9BI+AmiltMK8fSwu
 1geecvbP4svbiw4fqTtOiHCWcgLjA7XU5e9HfoFyKBV4AGvxkP4oDUKPNeiQmkuWsuxQ
 1G/fHKVaVxT4abDpcehZH/BZob1tpP70q6LTZlBQaPqJG0S58e3T2iThEdfjKpFhK4NP
 8CplCn7UZ9XLyMLgCVVrq7GgqLNfmbfG6tCwl2XxCG7S+sWLCD+bQI0A8qQde4JlF94E
 cmrA==
X-Gm-Message-State: AOAM532U1t09hPwdNl345cDUgKor9Nf8lPAJ/PjrUOr+Kuat/UYV8uMS
 g+InD908E6Y60zwMxwBfBPFKlA==
X-Google-Smtp-Source: ABdhPJyFE6XF4y+lmU658P7c0VqSCjkt0Z66l6Zteu3nC/Jupz6SWlIh44dXo5DIOlS9aNQnlvnVyA==
X-Received: by 2002:a17:90b:30c6:: with SMTP id
 hi6mr8207977pjb.172.1598830386459; 
 Sun, 30 Aug 2020 16:33:06 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id t5sm5018298pji.51.2020.08.30.16.33.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2020 16:33:05 -0700 (PDT)
Subject: Re: [RFC PATCH v3 00/34] Hexagon patch series
To: Taylor Simpson <tsimpson@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <fbb5a85b-6208-1791-0d3e-7e741e674a70@linaro.org>
 <BYAPR02MB48862BC00AD7217B715EBFC7DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <78e5b8be-e7f4-a1b9-2810-e0855da23f00@linaro.org>
Date: Sun, 30 Aug 2020 16:33:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB48862BC00AD7217B715EBFC7DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.207,
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
Cc: "ale@rev.ng" <ale@rev.ng>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "philmd@redhat.com" <philmd@redhat.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/30/20 1:47 PM, Taylor Simpson wrote:
> Richard,
> 
> Thank you so much for the feedback.  I really appreciate it.
> 
> I'll get to work addressing the issues.  Since some of the items will take longer than others, please advise whether it's preferred to send intermediate updates or wait until they are all addressed.

I don't mind intermediate updates.  Just keep a list in the cover letter of the
things that are still on the to-do list, and I'll not focus on those.

We could also talk about what portions of the to-do list are blocker, and what
can be done via normal development.  Because neither you nor I want to carry
around this huge patch set forever.


r~


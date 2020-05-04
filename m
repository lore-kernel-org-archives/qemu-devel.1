Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D52C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFB7020705
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tfBd4rEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB7020705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdoF-0008Oh-Vf
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 12:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVdZI-0006Sh-O7
 for qemu-devel@nongnu.org; Mon, 04 May 2020 12:03:45 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034]:33819)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVdZG-0006yZ-7y
 for qemu-devel@nongnu.org; Mon, 04 May 2020 12:03:44 -0400
Received: by mail-pj1-x1034.google.com with SMTP id h12so7861pjz.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 09:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=78Vi7wgYsGyA8edkgjgPdtQTWASlUQd0e886regsz+A=;
 b=tfBd4rEc0Lp0DPuaiFs8IhuVBSQeIlzLB8Jz7KyAaHdNrfe3tMtYBwvfVf+zfv89v9
 jUH0820J6TO1zuNXsggMxX15X5FOWqW61Ifb4eLnrBWg5dLdSTjfLxvnJU4p09JrsJ3X
 ZNRL80W+rxykDm3MQ7OxUqWUeebn/aar2wfh+BWwiTzBDddZFuJdbZ/h8FyMNgLo5iZX
 suGM9IpI8QZBJeeWDwKgg45kMRmDkEhG7J/KNa7lTNqefasaXQ0CF0v2qkvyLErxSUUs
 Bh/o3gE4Lt7GNSXipzrJJ4DucY4yTjx2itA9g0Rt3cd8oBR55eoOROOu3OnBuKrykxTi
 JZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=78Vi7wgYsGyA8edkgjgPdtQTWASlUQd0e886regsz+A=;
 b=KbbaAzYiBj12SEd+useiZijJbm3Jl79vkw3+xM+jjDyPB1KILzCTDAIkrSVYN8IbBr
 R0RWzutAV8qfEnHT9M+708cGsiJoxluYo8bMnqrnY//giB5isQnUAUEwQAPbZPrGr785
 MJksV3X/fSgEbTqpfJdcOoHl3pMf1RC0D0x2pZx1jaaBHYs1/6CeeeRK9KLGJ9dC+0vi
 TZYh8iPKw1E7nt+Us4hufgnHo1PTCZPQgc5Mt28sjWSZ0Dr8U4Efzah7r4psdf3pwtrE
 DauKC/yizZ3agvLhTk0GSpTYkoqz7fG9zYFbZT4OaZ4MJExDhnQphFTQeNsXqwQMIIUC
 sUkw==
X-Gm-Message-State: AGi0PubJXKY9Zo/KM/Z119y/bsNDoFEZFY09fqW70hO7cRyjEhBx/pCx
 VNAA+NPTqs617yHCluTM+N3Ejw==
X-Google-Smtp-Source: APiQypIlvjVoAhniqQIQMq+KsNbA15QttD5IWbELtt8asgtim9qlzVRy7HXHkwpnIeC8ZwS/36XDUg==
X-Received: by 2002:a17:90a:cc9:: with SMTP id 9mr49241pjt.16.1588608220252;
 Mon, 04 May 2020 09:03:40 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id w125sm8131993pgw.22.2020.05.04.09.03.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 09:03:39 -0700 (PDT)
Subject: Re: [PATCH v4 00/18] target/arm: sve load/store improvements
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200430162813.17671-1-richard.henderson@linaro.org>
 <CAFEAcA8m33s7e2T0GrZJxb4EyczcEmtW6-tRPoUsiVLO9g8dVw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20e6093b-edcb-c0e4-f4d5-b6ff4d51783c@linaro.org>
Date: Mon, 4 May 2020 09:03:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8m33s7e2T0GrZJxb4EyczcEmtW6-tRPoUsiVLO9g8dVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 2:43 AM, Peter Maydell wrote:
> I've reviewed patch 13, but I still don't understand why you've
> made the size-related changes in patch 4, so I've continued
> our conversation in the thread on the v3 version of that patch.

I've changed that here in v4.  Please have another look at this one.


r~



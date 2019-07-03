Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC64C5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 22:03:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BC41218A0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 22:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DwOak0Cb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BC41218A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hinLB-0003pJ-22
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 18:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44619)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hin7l-0006v7-3k
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hin7k-0005jZ-9a
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:49:09 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35562)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hin7k-0005il-1v
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:49:08 -0400
Received: by mail-wm1-x343.google.com with SMTP id c6so3922312wml.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 14:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CJNKbdXP/gi9oOYEc8EYqhiJxg/BgXYE0FHy9DenRQU=;
 b=DwOak0CbmRip0bn3kAlEIsMGBxHGhDHwLu0L84nSaeTXd/mDNb5ys5rmlIk6G3yA59
 z1rclcCcHCQaIvOMha17d60lqEQuVvydOkyyyPoq28Otmx7uK/yNubk67S4DmYPkXTDh
 3m5A49A+bXvkUK8M1he9b9r/ZFKgO0LtYzp+Mygok7Ion1ngXNOasXzEiaxU3zFZiRIi
 TJ2e6bsUGkIv/jh93CRyPS3ivpZ0jYaJvuC5eG1NKKooRoUSxLvH49kAD2z8RQdUA3MR
 T1ba0GC5afsxClCG1dcfCpJn0CpcohILde6fCz4v+ugPuUFIYRiBDn5kS6Qt1xifAcSn
 +eMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CJNKbdXP/gi9oOYEc8EYqhiJxg/BgXYE0FHy9DenRQU=;
 b=mjvRETOQsTBB5nQwofZXdMVg5ppg0BwqKTs75lUnlttBQ9Y+CedG4Wt56+jCyhxQfY
 qOu8ivP+btcyGdbRQgXmL6mPXZ9MQG3i99msE03WauJm0PaF1PO2kkTDi2REOYBPzyCw
 /kduvKka1XyvjizWDESxrkUZYvJucavLRzCtWPYB2DQrxid+dRTKBWYj8mHCASkP4qxA
 bat0mJnE9vWZPY5zWGJT4rrWRAU20mLjHZkrRSoDiBajbZ7Ta52h+0R+AHlDnK5YjGLB
 qPHyFha8oAdVq9Gym+XvWbDbJDMvfeVlKpTCjjOHbqDBZpgIwbu9o7Yj7PqdGIQCSXgE
 a7qw==
X-Gm-Message-State: APjAAAWZ2coDGEUKoiuzi8MY2Ks5jqNEewzXnydHSQAzhtoLAaVSpOfU
 sPJwIIjwRfbWhFjRso+8l6mLzQ==
X-Google-Smtp-Source: APXvYqyNqZ/Z8MPuI3xo3olJqotMJmpoBVT0WfyaF6Bx0BWOY4umc1Jt4KP4p7csaaW+65aHvcZwxg==
X-Received: by 2002:a1c:b706:: with SMTP id h6mr8964586wmf.119.1562190546690; 
 Wed, 03 Jul 2019 14:49:06 -0700 (PDT)
Received: from [192.168.3.43] (93-34-153-63.ip50.fastwebnet.it. [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id j132sm4744779wmj.21.2019.07.03.14.49.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 14:49:06 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190701043536.26019-1-jan.bobek@gmail.com>
 <20190701043536.26019-7-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f1b0ff64-0c62-f1b0-8362-539d9d37156c@linaro.org>
Date: Wed, 3 Jul 2019 23:49:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190701043536.26019-7-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [RISU RFC PATCH v2 06/14] x86.risu: add MMX
 instructions
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/19 6:35 AM, Jan Bobek wrote:
> +MOVQ            MMX     00001111 011 d 1110 !emit { rex(w => 1); modrm(mod => MOD_DIRECT, rm => ~REG_ESP); }
> +MOVQ_mem        MMX     00001111 011 d 1110 !emit { rex(w => 1); modrm(mod => ~MOD_DIRECT); mem(size => 8); }

Oh, note that there are only 8 mmx registers, so the respective rex.{r,b} bit
can't be set.


r~


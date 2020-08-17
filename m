Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7D7C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 20:50:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF4222065D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 20:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oPdeQyM7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4222065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7m5J-0007cc-S8
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 16:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k7m4P-0006lm-84
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 16:49:29 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41657)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k7m4N-0003XX-Bp
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 16:49:28 -0400
Received: by mail-pl1-x641.google.com with SMTP id f10so8130937plj.8
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 13:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5abROdDTmuj85VF4WEfPtrb6vLbN8j7cinB2x35Lrj8=;
 b=oPdeQyM7cCWPAEUekXaLXV2NQ7Lbp02pYUO9/oQniTemDeUn6mBeLA2ElCBK54wLSG
 lCnMpoPr8lh2CFtpIr7rlqm0wD9Ez56ygr1FWgNzXGCcWdD66edZTV16NN4q5DwZKTZl
 /YKzQevL4m6neYKw5UAfvUPh+gtg3qBRPGrW5q/n8j6UVOy0Zh9QAgAEoXTGI6Y+uowA
 Y/W9wd/7tv4u24KBqLYfziDqjvP4AAsmrnN3ejypk8wMF3TelBcZBkZkf0VrQxvSmwWR
 0UNqwX82aQg1gfC2qtR79Jzo6bXCTsh9JoqVu3yI3bhH3qCC7jMEyz0lNC/QBQkncxOp
 tuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5abROdDTmuj85VF4WEfPtrb6vLbN8j7cinB2x35Lrj8=;
 b=NjGdP5znPFbwkOM0Q62IUz8F85YO2OewpRSP774TkBp1le8ZdZn02gtQC1FzsCu93i
 YClm5WEeBUBi3V5IhmiECy1VvDC0p8VFgFRFELTGa4l9dZNPkrzAAZRy/GWVP2w/WF/d
 IW6MnAMzcCV1YDFsP7ey3AdB4oQt1l8cqJT2hiBshKGaMPTeuwTXklsgUXHl3fvtlXZu
 sSMnYY6zeGzW0NNuuBSE9Aa6/Y7romkPCfVtsRDtiyBSCxkUKkBZsh14/GBiBilFrk2u
 3joUwZTG5GdAQUwCibh2ucKv4kPAQvkIuxrEQNiPaOtXSc3xdKTCz0oxfEGN1El8gCqU
 l4XA==
X-Gm-Message-State: AOAM533vvPUYCUDdcElGQgO/CCHvkKZZt5+Jc3xI3R5D3HHJ3E0sudsB
 rdyoHd4NscWHJunv2bMvLFkcZGJmEx/NEg==
X-Google-Smtp-Source: ABdhPJwDaBsP7kVj0IZ1urEKQDXm+WDktLARsd7PEOtDjlVKmoC4HLfGWYdsLpdeG4LRVsIftcNZbA==
X-Received: by 2002:a17:90a:ea13:: with SMTP id
 w19mr14643635pjy.18.1597697365304; 
 Mon, 17 Aug 2020 13:49:25 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j8sm21572927pfh.90.2020.08.17.13.49.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2020 13:49:24 -0700 (PDT)
Subject: Re: [PATCH 00/17] crypto/cipher: Class hierarchy cleanups
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200813032537.2888593-1-richard.henderson@linaro.org>
 <20200817170911.GX4775@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8d2e7ee0-a3b1-3a6c-ff1e-6d77269a5011@linaro.org>
Date: Mon, 17 Aug 2020 13:49:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817170911.GX4775@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 10:09 AM, Daniel P. Berrangé wrote:
> What were you measuring performance with ?  Did you use the
> benchmark-crypto-cipher  program or something else ?

Perf of a boot of an aarch64 kernel, which

  * debug enabled for regression testing,
  * the v8.3-pauth instructions enabled,
  * a local qemu patch to use aes128 for pauth.

I can dig up pointers if you want, but fairly niche.

Because of all the little debug-enabled functions, it meant we were doing a 1
block aes128 encrypt approximately every 40 guest instructions.


r~


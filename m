Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9810C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 21:59:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1A6E206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 21:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UJ5/znD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A6E206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgEwW-000797-W1
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 17:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgEvX-0005pQ-QH
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 17:58:31 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:44737)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgEvW-0002oj-Ju
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 17:58:31 -0400
Received: by mail-pg1-x535.google.com with SMTP id p30so196173pgl.11
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 14:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=f5Es8AmfC9ODcdf/F8pp+ZrbHC0X60XA4Dw45acfT+0=;
 b=UJ5/znD0PQivhRKBRTeIvSj8TdHYa5GeEtJTcNbdWuqEmUsG69IClULQISAAoIsiol
 R2c97nSoGPXwprgI0VOdqu6uYlq5RYuc6SEiqC2191KQZMqUKiCSzfb/OsFNcoahGgVx
 L9PTivtISbeBo1gmVhauCmaHnl3uspZ2qBOrOCG4zkqn7uwKXLyphco4qEeEwPPPbKdM
 RaDjRyDaYOIbE+WKYtO+ckNXI7keN6WXA4sTwo1xzAddQnao7Hu1cr6EUags6YNE27FJ
 G5K9/aUxK8OdM0Eh5pcMwQkIk1hYhFwc8x0hHh0n/jaVnLDZZFnBApgQ7qGshU30lmTo
 y6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=f5Es8AmfC9ODcdf/F8pp+ZrbHC0X60XA4Dw45acfT+0=;
 b=uRtimEhjXseip8NsQWSK6ITZHBsBBtfV7kWQyuSzaTzyiaTlj79nSbfYTdLRIcez3L
 aOZ+pcx3afj1p9fLS0SYuyIKXy7PpHKQmfDlHKo8ScinQ4TwWxFz8onqAFF2Uo71d48P
 DgCUEKLzt6xVm6TzG1wj5FtLbiTmON5MKMV2Ak1WnENuE5BtjmranATsH0yqxnk8T3v0
 IC+NR+6dH4h3b9a8/MGnZXhwAeBC41/WCjtxi0klICKwV2kAuXdgoDK3JNDViaWxI1uF
 lngew9NzTUx4tQLckzNW1p8ZMmxsu8bJY9hL/eG2NcZ34+nWRXRDgciOnvwVYjqzBzee
 Yuyg==
X-Gm-Message-State: AOAM532Z9DNRTlO3GfP0aqaW++2PR+/ORc2HJrFLY7mymakwptpHeJip
 r7HhFfnJHmpLA+PQ3bG0EqbONw==
X-Google-Smtp-Source: ABdhPJyJdt/XZKGZtP71TbY7/1hyXlqRoDvCHe4EgG/9UZEyYJlj9plXa7+aGfdNaTrKG0fxPNdKsA==
X-Received: by 2002:a65:45c2:: with SMTP id m2mr25046136pgr.201.1591135108986; 
 Tue, 02 Jun 2020 14:58:28 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id g18sm11221pgn.47.2020.06.02.14.58.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 14:58:28 -0700 (PDT)
Subject: Re: another tst-arm-mte bug: qemu-system segfaults
To: Szabolcs Nagy <szabolcs.nagy@arm.com>
References: <20200529120427.GB18623@arm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9aa721e6-e72f-20bc-73b4-19fc3f493241@linaro.org>
Date: Tue, 2 Jun 2020 14:58:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529120427.GB18623@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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
Cc: nd@arm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/20 5:04 AM, Szabolcs Nagy wrote:
> again i'm using the branch at
> 
> https://github.com/rth7680/qemu/tree/tgt-arm-mte
> 
> to test armv8.5-a mte, now qemu-system-aarch64 segfaults
> and it's easy to reproduce: minimal source and static
> linked binary is attached (should be executed on linux
> with mte support, i used mte-v4 kernel with reverted
> memory property check).

Now fixed on that branch.


r~


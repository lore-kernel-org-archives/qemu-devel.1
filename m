Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4BBC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 14:34:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B96392063A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 14:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DYkYLqBc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B96392063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsogV-0006f7-23
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 10:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jsofe-0006BQ-Ra
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 10:34:06 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:36696)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jsofZ-0005Jh-If
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 10:34:06 -0400
Received: by mail-pg1-x530.google.com with SMTP id p3so20091822pgh.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 07:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VkhryAMj56Ic41hCjigbkYozmz9svCwrLuCjmy3HJuQ=;
 b=DYkYLqBcx29MJAvF0DNnHnz/vi8bflv+uVDod2EXNxjX9mHzZCOfz0IGjwnQu609zj
 g8/8rF16onb+NBo5TTnEDsWWcC7hayOBTQLgX+KEYXyk7RHcE3QzhTeSZPhzyaN6nirW
 fYX9qblMUOO5xzuhFEfeVZXRKUOxBp+RhUQ7x7g32U4kK9gT5vU3l4H6Q3L4tf57zrTy
 Uq72y/rwwNiiuyLrhdwJNwVWaXbykHED1kafcg0mjyRc0pzDU6QBni4PaDz8U/3AvDV2
 EG7VtsQ2Y8/TfCPiwNYksGWUdynisgxD4G6Jb435mzv/pSa0wiDinRW4+osbBGD2NRdx
 0iLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VkhryAMj56Ic41hCjigbkYozmz9svCwrLuCjmy3HJuQ=;
 b=V3rP4GHcndhCG6YVYA6lqz3h0SyX3/bliZQNUtHPH3ZT6NwUktIWXoqyw4b43Qm79f
 ssjKeqZ+5lJGE2+3rV27fuAUhoNuIdHTSjVL3QsrZ7yYaopuqWWC1bexmfXuEOcvyQdG
 4XEAfZ2FQsfvth3hNx5FDOT+VN3CIkLwdXoAUhY8F/avFLxF0FJnrDzcaRYK6Cykd3o8
 JTF04rFqKRVFDw1MFmaY5P9PIvVGfSOmY20Kpp1uQyWbGDBnLrRc1A2IUyRsESyEGcmG
 Y2lpzd7Ys4xf3Hchqox2wvvSERTEQ6kiNGdE9uzhTp57l6Xw6IDr3cWuXZNHaafABl6p
 WwuA==
X-Gm-Message-State: AOAM531IXl0Gc5deOGHMIFeujCVvLy5JKUCnQWfJEL3Y9HGuFEiXAgzN
 sowr7sB4WTZFRzmQ7++aI5jUsg==
X-Google-Smtp-Source: ABdhPJzoZdp2gY7pPz/5w1chGwYc5LoTPXD73l5rU+z/n/yhTrSmbY4HaGsQOyEGzIZjXD0L8ITETg==
X-Received: by 2002:a63:b06:: with SMTP id 6mr43629858pgl.116.1594132440130;
 Tue, 07 Jul 2020 07:34:00 -0700 (PDT)
Received: from [192.168.149.206] (097-090-106-114.biz.spectrum.com.
 [97.90.106.114])
 by smtp.gmail.com with ESMTPSA id v28sm1240478pgc.44.2020.07.07.07.33.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2020 07:33:59 -0700 (PDT)
Subject: Re: [PULL v2 12/64] target/riscv: add vector amo operations
To: LIU Zhiwei <zhiwei_liu@c-sky.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20200702162354.928528-1-alistair.francis@wdc.com>
 <20200702162354.928528-13-alistair.francis@wdc.com>
 <CAFEAcA8b7Rk8ZDDu689tRDCqcSKRbCGVf=75e0f0WNd2GJ9dmg@mail.gmail.com>
 <e86ece6b-5295-dfb2-6fdb-bf0004ec9b70@linaro.org>
 <82652a07-e592-9d84-353d-5a0e94b77e84@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dfdea992-cb76-5cc7-0d02-71fe9daa6532@linaro.org>
Date: Tue, 7 Jul 2020 07:33:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <82652a07-e592-9d84-353d-5a0e94b77e84@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 7:26 AM, LIU Zhiwei wrote:
> As  there are not only the atomic instructions have this question, all
> instructions that use
> GEN_VEXT_TRANS have the same question too. It's some difficult to address this
> question by this way.

Oh yes, I missed that.  Ok, perhaps the simpler assert would be best right now
before softfreeze.


r~


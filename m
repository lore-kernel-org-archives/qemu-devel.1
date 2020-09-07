Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914C3C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 17:35:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09E59206E6
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 17:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zWN+BMco"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E59206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFL39-0001XM-VJ
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 13:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFL2b-00016e-Kb
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 13:34:53 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:42885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFL2Z-0006xF-Uw
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 13:34:53 -0400
Received: by mail-pl1-x643.google.com with SMTP id y6so2276717plt.9
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 10:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uKrAeMnVjRKh//62klxvhM6IBfN2e4kixT4Z+3MsN1A=;
 b=zWN+BMcomCU1FaO3cVN1MFZKYTZwRqKerDyqCQm8T8z0kRXZIHyDMSqjIy0Y3C/ACf
 KMGCN9G8lWHULYKsXoffOK/ewNznnpye0U5K0DI0eiiCKnZIyTWOB3egJI4ePUHmnsHe
 ouxasW/IoR0KToRICHL/UD0zzsaZXLilwhJJLUDfzv2qzq3INDCrc1wKvnJWo2kpXI5A
 zdJIXKPaZRg9GoIp8Po9UUi+zt9rbTihizVZyv/u5nHiTrFxosjOo4VciYMKSpWgfm9d
 Q2T630PZATlbyrhb13FlZ08y5hKWdTBJnqSAhgx3yDR6TXs0T2I5GhHQs+c1uvb2EAVu
 1E5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uKrAeMnVjRKh//62klxvhM6IBfN2e4kixT4Z+3MsN1A=;
 b=S4ATM/ziVOnTqhUiQ1OdkEGSTHMpuZZ3zoZn8XR/qZ6rfPfoA0znx0uu6mwDSIw+XL
 XkV1+iAhwbf8BpyjgeAg2nCZ4nqHnjj0jbfuaokoN3q6s69c6OUqs9uGgjLYi9p2QvMZ
 sa8zRPaRJ44Fsd61HGQ4Sq+L1YUBD1jEqOSxgng/pgXHIxHj+ZBFpf2qls1CUtkeI8K3
 WqBbVZNMBx7hS7ogcr7mxfrtFx2yHvodbCJhVLpldUYBwMvDKlo0bHMwWq0g4uPOxqLD
 2QFQ2ZbVuvsOHW7e2bhLbHkrJzveqeU3EYgASze0kIEXzre1xBPIV20L3zbB/qja40Rk
 Gv7A==
X-Gm-Message-State: AOAM533xznXL21tct4bC7cL6io8oM/XA5OOj87NpZMeNNGw8Pke2Eseb
 rdgepxKemDy7dtWBk8bx7pILtg==
X-Google-Smtp-Source: ABdhPJyeTE8rmKPMaWq0ZAABRFOUvGRDTHpFU4RgNen8XgCb4qd734/fgJwpEXku24cmE6eAxdOrOw==
X-Received: by 2002:a17:90a:55c8:: with SMTP id
 o8mr289208pjm.215.1599500089742; 
 Mon, 07 Sep 2020 10:34:49 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id n2sm15852420pfe.208.2020.09.07.10.34.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2020 10:34:49 -0700 (PDT)
Subject: Re: [RFC PATCH] docs/system/deprecated: mark ppc64abi32-linux-user
 for deprecation
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200904165140.10962-1-alex.bennee@linaro.org>
 <CAFEAcA9+hoPrkDNg21b03CT=YmTXuOLwKrornYn6J12bZ=B+OQ@mail.gmail.com>
 <87d02yrm7l.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3af6dfa1-208c-dd34-cb64-d7591de2b775@linaro.org>
Date: Mon, 7 Sep 2020 10:34:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87d02yrm7l.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.825,
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
Cc: "reviewer:Incompatible changes" <libvir-list@redhat.com>,
 Richard Henderson <rth@twiddle.net>, QEMU Developers <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/7/20 2:05 AM, Alex Bennée wrote:
> What about tweaking configure? Or should I just manually squash it in
> all our CI configs?

Squash in to CI, I would think.


r~



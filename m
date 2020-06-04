Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF082C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 16:58:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89D5820738
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 16:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gXa71s0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D5820738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgtBp-0002aJ-Pf
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 12:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgtBC-00029D-QV
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 12:57:22 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43664)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgtBA-0005l9-OJ
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 12:57:22 -0400
Received: by mail-pg1-x542.google.com with SMTP id 185so3711229pgb.10
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 09:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=UbOOWKaGQ52WG8kdiC0+rPCKpuxvfYwXwPimE6E740Y=;
 b=gXa71s0ekDT4nAcFXaKxoUs0CpBhQ0CqISfCyQ/3s+FPHydszZFBWpndog+QFqlAW4
 ZlRgcSDFq7p9omVEifG6hoyB/rJXFG+YmMW1qT4gW+tVDZIe15PvWe9piXf3pxGjKS4U
 CqXUzWAcbl3JtrvlWATEocR1rhrg9fB+g6kG9oqnCb15WoolTJK4PYcHuImTRZqTXT+8
 wo5TfwzVdytK+KKMqobvQH16PVwnkNRH6dxOhvoWmMbdF8oaJGj/UkedutXoIv04hcAJ
 xzJAzjJ09jsbnoicGq6RW8ww1h1h+TQVJDR7HYwYNXAeiw6va63bIxils6xIrBB2mnnn
 f/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UbOOWKaGQ52WG8kdiC0+rPCKpuxvfYwXwPimE6E740Y=;
 b=UB/A2yBLRrBelSxcQ3r6LGZVEXnhSimBH6uIk7Xyb9zHTQsNNWuZx6EuUMWJPVFni+
 Pku7Xwnfkj4O1YJ0MMbZT2XqqYUymi7RGiMKL9HSTtBXGs++RaAn3z/5PAZx0CQKVWog
 3fib2H+78imDVN+ItY/lknnMv9xbc6FexMD08eKn5EYX/+rJJKWNr202jr33ZDI4RGAQ
 nN9uqxAZVVoYcrR4Lu4qCMa22JwoM5Ok0uRWly6qy9wOsoy9AZvX5VLudHsmwkA7Kv0o
 D6HmuPoRdObDU43+kD3IO+RK1t0xf5pi0m096bcGWSms8ZQsBQfzMaX0gMbcdw/PIgPF
 cE+w==
X-Gm-Message-State: AOAM533H8GTqN7KBcB/29FsEgX6ZPAxINHTvVWN8cSIJw50JSt+l3+XS
 n7QGD+UImvh8KSvptlpkp61J8A==
X-Google-Smtp-Source: ABdhPJx4K03i+CQ+UNqPbZ5GxreG5agMZkcryy3OD+sdKy7ilmbVa+cku99daaosJEiy/VlVRB0STQ==
X-Received: by 2002:a63:e60a:: with SMTP id g10mr5523602pgh.210.1591289838455; 
 Thu, 04 Jun 2020 09:57:18 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id g21sm5651540pjl.3.2020.06.04.09.57.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 09:57:17 -0700 (PDT)
Subject: Re: [PATCH v3] migration/xbzrle: add encoding rate
To: Wei Wang <wei.w.wang@intel.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1588208375-19556-1-git-send-email-wei.w.wang@intel.com>
 <CAFXwXrm4R5nxk6ruTJ2kP5dUnF7Qm3TfRRiKVAUDNA1uwYf65w@mail.gmail.com>
 <5ED86344.4020505@intel.com>
 <4b9cd244-0d96-d1c8-11ec-b61a6bc2bfaa@linaro.org>
 <20200604093828.GB2851@work-vm> <5ED8CC78.90006@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <26a232a7-8ec6-da2c-348f-41da899cdc9a@linaro.org>
Date: Thu, 4 Jun 2020 09:57:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <5ED8CC78.90006@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
Cc: kevin.tian@intel.com, Juan Quintela <quintela@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, gloryxiao@tencent.com, yi.y.sun@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/20 3:27 AM, Wei Wang wrote:
> On 06/04/2020 05:38 PM, Dr. David Alan Gilbert wrote:
>> Hmm OK; I'll admit to not liking NaN/Inf in output.
>>
>> Dave
>>
> 
> OK. To deal with the reported issue, how about using FLT_MAX (as opposed to
> UINT64_MAX or inf):
> xbzrle_counters.encoding_rate = FLT_MAX;

So you'd rather see 340282346638528859811704183484516925440.00 printed?

It's arbitrary and not correct in any mathematical sense.

If you *really* insist on not printing Inf (which may have some diagnostic
value), then 0 is just as arbitrary, and at least smaller in the output.


r~


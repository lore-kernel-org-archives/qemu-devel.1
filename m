Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342A1C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 21:25:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE78520936
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 21:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mSZhtTcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE78520936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPYUO-0003Vj-9N
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 17:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jPYTJ-0002aB-0U
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jPYTH-0005NC-QN
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:24:24 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40930)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jPYTG-0005IU-7j
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:24:23 -0400
Received: by mail-pg1-x544.google.com with SMTP id n16so1698933pgb.7
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 14:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=o/HOXdmdZb0BmsCOpVAfwt8rIREjuInC2IMtHu75w7k=;
 b=mSZhtTcj02mbFxyrl/J74g3J7Dtn6D+HJQD04hw2I3+11Ai7qW3IQKk9feE/aCbRQN
 SZaqS/eEIG7bvQYKTiGak0rx2PvVulasmaF9Ff42GsF6xeB1p6xPrWRpW+kEJDBIWdxv
 lU4sKH8jIhPDmq5ktm7pH5UyWEfy9IRVtP5qi7EtS/6AJO78wPqsi3n47WdblxfCq4x6
 VMOyGf5OZXEuFaebHiQlpf2s2qRpR+2+08SIb/v9c0caMxtX29/7NMiIJbJCjCbbxGkw
 T5IZR9WQvdZQzpHSqENOp5B5XXP2kXSG+RlpK/lesdnHWEsggLB6P6ErS/XD8VfnBNUk
 gs4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=o/HOXdmdZb0BmsCOpVAfwt8rIREjuInC2IMtHu75w7k=;
 b=jhVmABEm9FDZsG6MT3+BY1cLMcrK4qNzWReIGRcVLgwqOr4AEqulVKpQLnE+a687mj
 //GQN/GDOVzlWX4TFIgxtNoKzNQhkYngi8a06Ms2/hLmv70GYPMLlPJalrvqmqeg0a3S
 v/yuGqarPB4rU0jInRMh7etYk7UucPkGAoxidqQJp0UfAXLlS8S8lTeUOHuRYANDAMwX
 3l8i+4p/f7wrffWJr8DtD8c+t6+KZepTXaC+ZCPobEEycn6b+GVN4rEIJcPSKVJk9VVO
 lo2lS77K2GDGYXngm8jM2tBwNjnzjQXJ8slg7kZZ3sje1VSkvu5elrzrycPygSmlUDVc
 5+Qw==
X-Gm-Message-State: AGi0PuZx9kVXvhNkwfDK8ycaFLrSfciWKrR7AabQHYXg5KrlPssel2kJ
 YLhMhj+BpUgTTH440tyyf7TFVw==
X-Google-Smtp-Source: APiQypJ2oDQD+04oow5iRTgjYZPRpX7dFVmzIfZwCkbhTlfkfD+uVDAq0Gd+tCPI4Atdqwemt5GRUg==
X-Received: by 2002:aa7:96c1:: with SMTP id h1mr5295521pfq.212.1587158660802; 
 Fri, 17 Apr 2020 14:24:20 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id j4sm16371665pfa.214.2020.04.17.14.24.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2020 14:24:20 -0700 (PDT)
Subject: Re: [PATCH 2/4] target/arm: Implement SVE2 RADDHNB, RADDHNT
To: Stephen Long <steplong@quicinc.com>, qemu-devel@nongnu.org
References: <20200417162231.10374-1-steplong@quicinc.com>
 <20200417162231.10374-3-steplong@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7593864c-828f-5c03-c3d5-8ba8eab8cd6a@linaro.org>
Date: Fri, 17 Apr 2020 14:24:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200417162231.10374-3-steplong@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: qemu-arm@nongnu.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/17/20 9:22 AM, Stephen Long wrote:
> +#define DO_RADDHN(N, M, SH) ((N + M + (1 << (SH - 1))) >> SH)

This formula will overflow.  See DO_RSHR -- with some added parenthesis, we
could actually reuse that macro.


r~


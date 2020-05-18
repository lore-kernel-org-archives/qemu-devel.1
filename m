Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B2CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:53:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13DBC20657
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="umZ3hOPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13DBC20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jalpP-000297-Am
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 15:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jalfN-0003u6-LP
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:43:13 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:45590)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jalfM-0004uw-Hn
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:43:13 -0400
Received: by mail-pl1-x633.google.com with SMTP id u22so4643006plq.12
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 12:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WjBsVqmqsW61rukNgTjlzeCpjl3qN8eIkL3edsWl7aE=;
 b=umZ3hOPftmXq4ROZS0ZULsDCmyV/OzLSIhJfV38TIJk7bSt1WSzQ4qbhCNVpkE29bu
 1+iMfvyg4DzhK9RiZaItRo8WjG4NC7l0UDFC8OTfAQFpcJhKPq/1zCJwIk3ZoV63nNXE
 qAplIewPCnpue74Vt0Uzm1HmphS86gKCc9bDyEdPX9/iMy2uwAUl1Ah+m3j87diLwjih
 DzjYE2E6RBK3E+4nx4stWMya8zOX1Bs/eD1uaTCXBWiHlT7aHFe0e9KMv6t9S/7sZSBl
 Vdm7KHU/fLQ7gRdUu39EzaD/XHC9Ip2HuIKpEYxdyvAQG0c16wHcy3HhQsUY7AGlhxKK
 urkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WjBsVqmqsW61rukNgTjlzeCpjl3qN8eIkL3edsWl7aE=;
 b=cUpFGu6pPw2Xg4/JXjS3UprWluAFUPD74Fka0CqYiwAumgB5d0PLVRZatnuSugmUlw
 GCbVrXNQl4UrmXTJCZKRMLKgizuUbsnB4L7f6881UPfC7gKQAnIThKksf7hxZHbDF89r
 VrFhhQc/bL8J74hskL0uehx5LcNk5R7+T6YwjdtTgtr8+vEI1GeUdsW/BRA4Jvt8IlF4
 SAlzCeGsDmzI0FtCZ/BUpbLGpa20n1ezgd+E03Qfa1ehAch/UPhvb4ObG+7TjzjFVjef
 HXOw7tofjzDmML+GsQcxflcjuI+MRYOmVpcCCrZoE/GFkI+qgFD3tbWq+SAw8uRRsSvX
 4Xwg==
X-Gm-Message-State: AOAM530G3xyBoN6jHnHNH2i8sBZs2OZo2qGaOiSNOdQh/eoE7IlRmbmy
 qJSmxpK0RIkBCTQ8oG8HSwBayQ==
X-Google-Smtp-Source: ABdhPJwKGYQDRXmIZtX8Pppbxs9vniUN5NFNSwdEA+MsdUaFPp5JAnhIsVcKcqDPBIXYfy+/tV0/3w==
X-Received: by 2002:a17:902:9693:: with SMTP id
 n19mr17923807plp.277.1589830990985; 
 Mon, 18 May 2020 12:43:10 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id q18sm2509898pgt.74.2020.05.18.12.43.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 12:43:09 -0700 (PDT)
Subject: Re: [RISU 0/9] risu cleanups and improvements
From: Richard Henderson <richard.henderson@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200513180953.20376-1-richard.henderson@linaro.org>
 <CAFEAcA_xBwNPWFd3w36JnuBsZSKb+q-aWXHfrLe1Rb-29eXpjQ@mail.gmail.com>
 <3cf98ff2-8256-eb3a-7ae0-3eeb1b27c331@linaro.org>
Message-ID: <4781e63a-0150-fc5e-46cc-5d4cdfa7880c@linaro.org>
Date: Mon, 18 May 2020 12:43:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3cf98ff2-8256-eb3a-7ae0-3eeb1b27c331@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 5/18/20 12:33 PM, Richard Henderson wrote:
> On 5/18/20 11:39 AM, Peter Maydell wrote:
>> Richard: if you feed an old trace file to the new risu, what
>> error message does it give?
> 
> Bah, it should have generated an error vs the magic number, but doesn't -- it
> silently exits with success.  Alex, expect a v2.

Double bah.  Typo in git checkout, so I didn't actually switch branches for the
test.  It does print an error, but not a useful one:

match status...
mismatch on regs!

I'll improve this.


r~



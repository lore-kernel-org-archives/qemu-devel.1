Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8BCC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 22:57:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E33E2081E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 22:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z8tDhmcR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E33E2081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33751 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irrbY-0007pB-Gt
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 17:57:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1irrOE-0007Uc-0R
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 17:43:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1irrOD-000194-41
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 17:43:53 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:33401)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1irrOC-000157-TU
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 17:43:53 -0500
Received: by mail-pl1-x62f.google.com with SMTP id ay11so7458416plb.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 14:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=un57dcIx5HObytcanXfgeTfwBeEsPp+Rk2OinvRYvgg=;
 b=z8tDhmcRvojP3laN7mukL6HMH24VYVGC55BpUC4xRunLgenll7Z8ReukFQuTfWSwBf
 MM2qw3uH+tFGNaOz95KQV0ZclbdQcpWD3x98ECg9r8V8NP570r+S3SJOQ54jGGaPYnZu
 TRmOgvkwTUnC0jiwJPrzonMC/DP1mVlw3SGznBsvW46TCQMf9xbUCrhaD97IwvQtdMsU
 o5y8Y5XcKYAYBCEkcFfkFmM6lUzOUzp4pTx9XXZM5EvSKLlkGb0IkyUUFk0MKUDYYEf8
 hqtIj9uX8lJOr+1HOt+x5MvaG9w4/4tEiavHbdPt4ha9VIB6PsBfC9RV8hnzCzEYNy4Z
 a2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=un57dcIx5HObytcanXfgeTfwBeEsPp+Rk2OinvRYvgg=;
 b=isAf0qpJPVyQ6RpA1CDl5f8I6LS4X6HMbeXZb6o6hrQh9FlP375de+y+xUYW7t8pST
 TchIfGQSDOQUeS6p31fc/QN31isM523Nft/IR7M9VuvPaPjlEGt8G2xQkG5K0ZfgRNyl
 Zqg7x+xav6RYCybllIHSaLT/dzMdGEsbobVOV1Piqxg0usXoZhNHYwAQVVqexdZZa2tB
 gX1ShbVAKGAlrn0BnGQ7jyYvpY59gF0cMzVu1lALnG4PEf9tuyNO0dDUDI+yu2juG04M
 dAaLMyarOiovjYI5BJM+c78Xtzs7hUUlhauOVguuj/20CEryps3yHqcO7Lu+j6cF/lWI
 nNyw==
X-Gm-Message-State: APjAAAXpXGaNl1hfRFzw482g7L8AqQWEwPKcSSBD4ii3T+osvSc+GiNG
 6U7UYXRo4mbYiaHjGETOnM0gaQ==
X-Google-Smtp-Source: APXvYqxkRAgcWXlkpbuNCz0tCzMIrTdeh9aZJfHtXK0NY/wf/N9lK9zNsfxvkUNQDol/2CneFJCgeg==
X-Received: by 2002:a17:90a:98d:: with SMTP id
 13mr2793552pjo.102.1579128231675; 
 Wed, 15 Jan 2020 14:43:51 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id r7sm23563614pfg.34.2020.01.15.14.43.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 14:43:50 -0800 (PST)
Subject: Re: [PATCH v5 17/22] tests/guest-debug: add a simple test runner
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200114150953.27659-1-alex.bennee@linaro.org>
 <20200114150953.27659-18-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f8d576d7-4d4f-fc29-3898-872848ef1aa7@linaro.org>
Date: Wed, 15 Jan 2020 12:43:43 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114150953.27659-18-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62f
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
Cc: qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/14/20 5:09 AM, Alex Bennée wrote:
> +    if "system" in args.qemu:
> +        cmd = "%s %s %s -s -S" % (args.qemu, args.qargs, args.binary)
> +    else:
> +        cmd = "%s %s -g 1234 %s" % (args.qemu, args.qargs, args.binary)

Oh, hard-coding of the port is going to cause failures.  Multiple users on the
system both running qemu tests.  Parallel make.  Anything.

I think we should really consider adding support for debugging over unix
sockets or named pipes, both of which work well with the file system to avoid
conflict.


r~


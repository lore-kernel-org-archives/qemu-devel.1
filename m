Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1BEC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86BC6216C4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZJq5voqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86BC6216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46546 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP8ZY-0001XX-Qp
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 12:40:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP8HV-0000ON-PJ
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:21:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP8HV-0005pG-12
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:21:57 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP8HU-0005oU-QG
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:21:56 -0400
Received: by mail-pg1-x542.google.com with SMTP id h17so3267405pgv.0
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 09:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=LYwXj/zIKGqLD1lzPG3utwcn8WPCNvZ+A5GG/rMQKTU=;
	b=ZJq5voqtjhaaVMisl5B7cEwu4L0v+QMhTuvb4Gx82D8PtmetqWaSPZuJxSshA9CMpH
	hfqjiaOBaoRxHxaM2YZBA2MuoAXBK05sR3muNh6ExAHsEAiAwkbmke0Zd7JZUW5+Xo+P
	S3VRBPYTbA6qDnt1F09iDizKt7i+Uev4nCZwYVJl8TiOgfnw2IWtiUcb5a/3UvnM4Ik4
	qEKAcGCK299At8s3GKdvYIvMP6GkQHPyutBSjiCi0Kso4WB/IDOHm2ZDtgjEJhFuTO7H
	e+dzTC/KP2N7gMbOcdBJKBtq+E58lWpUugEDkYpxJayiInQoJiqux3qDMi7TSOHf7v98
	9drg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=LYwXj/zIKGqLD1lzPG3utwcn8WPCNvZ+A5GG/rMQKTU=;
	b=cyB6JLlMILvWaPBL7hj27C7CyoXRzWPioWlLPtgYuAZPeZ2X+EjfhjISx+Xk/j5xkN
	4EGiFkdL8QKdri4aSQ2DjiSe5FpdEu6je2+KjIKt3BEzkyAuhdaAKW+Jw7gXEGnu0r36
	BavZIe6i56Fs1Ephvjr9drIhdJitLIN0NRladfPsPOA1/8AnwWbUnVw6bPW6rfbNkrM1
	N3q+GhEYiLey+Sqp7LasrTKoudZkH35m6dGP5XP8qIjZrFk/IvaPHGhz/qt7nq9EQ1Z6
	f+dub99z0K0ms1TGXDqSk9AOBkGHhkfpYxJgGy7ur23moOlDFcfmgydUS2HHkt7aujuT
	j0Lw==
X-Gm-Message-State: APjAAAXtjR3nS2ZyPeP/w3VVf8RiqsK2RYT1Ure2G9mDhLmd28d7nPt2
	/zYvkYb76KESDUcGKnHTtotXdg==
X-Google-Smtp-Source: APXvYqw40WVmTA1jf6NPiKD8Q59utQVpnYBztYbHMloPWhzYRUngFxQNMUiL+nwZqri2taBpwgYlng==
X-Received: by 2002:a62:579b:: with SMTP id i27mr15796721pfj.205.1557505315450;
	Fri, 10 May 2019 09:21:55 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	s78sm16069720pfs.187.2019.05.10.09.21.54
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 09:21:54 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190510012458.22706-1-richard.henderson@linaro.org>
	<20190510012458.22706-23-richard.henderson@linaro.org>
	<CAFEAcA9uwaev+Q=BgLBz+fgO6C7VGmw4Nxcozg2vm6TOm+LJww@mail.gmail.com>
	<dd180f6d-27e8-2f2b-a7ac-ed1d8bbc9498@linaro.org>
	<CAFEAcA-wXNKoen0bn8a7D=GzsyM38F1uummVbfVQ=B8haswCDA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <73e7038c-b40d-0f60-68ef-b3555c4e7576@linaro.org>
Date: Fri, 10 May 2019 09:21:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-wXNKoen0bn8a7D=GzsyM38F1uummVbfVQ=B8haswCDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v5 22/24] target/arm: Implement ARMv8.5-RNG
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/10/19 9:20 AM, Peter Maydell wrote:
> On Fri, 10 May 2019 at 17:17, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 5/10/19 9:01 AM, Peter Maydell wrote:
>>> Don't these need to be marked ARM_CP_IO for the benefit
>>> of -icount ?
>>
>> I don't think so.  There's no lock taken, as for mmio devices.  It's not not
>> related to time, virtual or otherwise.  There are no possible exceptions.  I
>> can't think of anything that would make icount care.
>>
>> Have I missed something?
> 
> If icount decides it needs to replay execution of the TB
> which the RNDR access is in, won't it get a different
> number back the second time it executes ?

Yes, it will.  I forgot about replay.


r~


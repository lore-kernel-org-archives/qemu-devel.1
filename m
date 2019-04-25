Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF290C43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 17:33:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D104206BF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 17:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hmPnb3C7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D104206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32999 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJiFr-0001Tn-L8
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 13:33:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJiEr-0001Cg-PI
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJiEq-00085G-5e
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:32:49 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:37493)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJiEp-00082w-R4
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:32:48 -0400
Received: by mail-pg1-x532.google.com with SMTP id e6so192138pgc.4
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 10:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:from:to:cc:references:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=DWOU2if98wQPT++E0rfxCN4CxLiQdLZrRfUTohULfUs=;
	b=hmPnb3C7+89eZChUShxDLqBfzvnS8brJSWo+jMOkY8fnoecfuV+9h53UeADe52EFfX
	p4X+4PTkJIjIHY5wNiPYptGaWvMmLFWlsvMDm13XwM6hZMIYksVJ3x+x8ZwzrEOaWji6
	AjjHtOhAdrkX2gtCv9woMgPikFbKn5SL+tZe/OmCwyc1HQ7zGV5ghSLjuGlJ/pythsil
	EenAvWFCxDs7RcCvHKaiWGk/0WH9gJx9E4TLlkwod9f+kdlZKZrcQj/uUqekuUo1xz+G
	8py6Yrj2vEmG7Xi1taSYDtg8A1LM+m7IU4KcvVQUQ5bq43TZmPNov9c7KJfSYxczdwni
	+S5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=DWOU2if98wQPT++E0rfxCN4CxLiQdLZrRfUTohULfUs=;
	b=BYyPdwBAvzD9rB3O1motOCUuG4kvIc8UJQNWW4VYjwa8vpaLwkOkzXe6DjnFpnT+S4
	pcq0bJsoHD8HardheMiqstqPtXJBT4Hpx0/TMUVRZfrOrKkujPwFr6YujrGppAh4OiPX
	e7t+mey8Hv/4MZYgWRItUIMsU3Et1ExoLe25n/lQUG8XUJRn1HtOpBPYJrDOd3RT5Yxh
	AEeJGDXJh2nq8MpfZAULcyW2fVaFe0wJ1cQ/R1rpwexCb3s1D6ZW72dibhgEUFQbrFqs
	BidsrF2O7epFIe1N6JaI7o2dTmpFMPqGARs5iHzG/YoVOIo3z5GU0Z12GKlrI1mwKRS2
	1IWQ==
X-Gm-Message-State: APjAAAXkZSQKoSUabEq7DPaeqjvnt4dCN0qwYJEL4IsHtlxU4j9dhQom
	PkwshMdzqn7O60ocaR1JExMOmQ==
X-Google-Smtp-Source: APXvYqxR4zuPdnf4hfn73BHHs34M8gODua/tMHdllcN7D7ZpakdhFOIJQqcEUvHNgrcfGJDP2/FeJg==
X-Received: by 2002:aa7:8145:: with SMTP id d5mr40098645pfn.215.1556213566346; 
	Thu, 25 Apr 2019 10:32:46 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	g63sm35665243pfc.127.2019.04.25.10.32.45
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 10:32:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20190425172636.11128-1-richard.henderson@linaro.org>
	<20190425172636.11128-3-richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <03ac8b9b-20ae-e6ec-5647-f679471f4d3b@linaro.org>
Date: Thu, 25 Apr 2019 10:32:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425172636.11128-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::532
Subject: Re: [Qemu-devel] [PATCH 2/2] target/riscv: Add checks for several
 RVC reserved operands
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
Cc: palmer@sifive.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425173243.3Q5yM3MxVSbiHn7twu_FzEYHM9kDQqKOahUiRyE54ek@z>

On 4/25/19 10:26 AM, Richard Henderson wrote:
>  {
> +  illegal         011 0  -----  00000 01 # c.addi16sp, RES nzimm=0
>    addi            011 .  00010  ..... 01 @c_addi16sp
>    lui             011 .  .....  ..... 01 @c_lui
>  }

Bah.  I just realized the comment should be more like

  # c.addi16sp and c.lui, RES nzimm=0

Otherwise one is led to believe that rd=2 is missing
from the illegal pattern.


r~


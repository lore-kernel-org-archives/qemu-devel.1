Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E53BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 21:05:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 386352071E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 21:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VxsgdaEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386352071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv68U-0002j2-8k
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 16:05:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51005)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iv67b-0002DY-0C
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 16:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iv67Z-00082w-QI
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 16:04:06 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45370)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iv67Z-0007xm-IB
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 16:04:05 -0500
Received: by mail-pf1-x444.google.com with SMTP id 2so1678286pfg.12
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 13:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=L60FfTZ1dmXXGxXdg0TZsBfhUCjmPL/yHlBR2HZw6b8=;
 b=VxsgdaEpHMWE1g1QLbWoF3O8p4Y5QyNJWM7DRiiuP5zlQ4R/gtSBJO21WeNtV/4hnn
 1TrQY9zd0HKVCZIf1zwq30GCDifYS+mjx7+5+GJKKi4dWiAHiim4te7Qcg3r8Vui2O8x
 53vkzBLHKPF52zbPYv++hWTg82+WSN1qMNQm9L5nypfea4eoArtfqJyAvPt5/nWw8V+J
 K51kZrAHyybdcn0+02R1voQhYEGWehNg6rcBDe4yanF0aHuehDJwMieH3oK2pHe5n86m
 YlnUypWfwTMUu4scubmhRZycWxIrvLwr6keLw1z6FBtQeFeWaKNslwl7AuP3d9NyNHNi
 Dpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L60FfTZ1dmXXGxXdg0TZsBfhUCjmPL/yHlBR2HZw6b8=;
 b=dwKyiTL+x5lZ2RV3Sw9LsHYNK2S1jMYne2u2IGNNVQGXZJhgLXcy7Wmn8RuvwsoZHW
 iHhfxpvvksucpuIv10msf3IkUjSPcHTzNOyAQf8bZum/wmNRnmJ2Zp8ryrClLSzXeO1v
 VdKgFWYbJyhTN3nh+WWVfI29mOqpUSUavC70f9hDFsENcD4IA5ETobE7F6Xjl1BTdN4q
 ZzB/iE+DHwcV3nG6jPwIpSxoSRZqc0EtaY/PfZ5ZZk956Ngvp8BmFpQC/H67iGEnvZYU
 jbD9IdisTSJPkUndBPrSNpaIkKRU3zfovU72iIF5l2B3rV4XZyV+9EX1C7fbSCGuUoRd
 Kb+g==
X-Gm-Message-State: APjAAAXdC5i/g2RLi/x23DepUzGojIQ9hREDXdEzYhGEROV6WTdp+S/E
 LI2iS3wnntknsya9dBkRtrJ5zg==
X-Google-Smtp-Source: APXvYqz9ejzyT5yzbtxALQ+//pLYMN2nqdleCAO54cN9z/YPRCG6iPRTK5YTo1eAlZ1M//Hz8QllBQ==
X-Received: by 2002:a63:5243:: with SMTP id s3mr5884950pgl.449.1579899844327; 
 Fri, 24 Jan 2020 13:04:04 -0800 (PST)
Received: from [10.5.50.117] (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id u18sm7972527pgn.9.2020.01.24.13.04.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2020 13:04:03 -0800 (PST)
Subject: Re: [PATCH v4 6/7] disas: mips: Add micromips R6 disassembler -
 infrastructure and 16-bit instructions
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <1579883929-1517-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1579883929-1517-7-git-send-email-aleksandar.markovic@rt-rk.com>
 <779b7b35-16a8-0538-ad87-fac218c93e82@linaro.org>
 <CAL1e-=hqgWesfm9f8fsSQ8JS54LybNMMGygbCNi0O+VyfSAJvg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c3c80f0a-e348-4c7c-e8c4-579b16ec22a4@linaro.org>
Date: Fri, 24 Jan 2020 11:03:59 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=hqgWesfm9f8fsSQ8JS54LybNMMGygbCNi0O+VyfSAJvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>,
 "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/24/20 10:56 AM, Aleksandar Markovic wrote:
> 
> 
> On Friday, January 24, 2020, Richard Henderson <richard.henderson@linaro.org
> <mailto:richard.henderson@linaro.org>> wrote:
> 
>     On 1/24/20 6:38 AM, Aleksandar Markovic wrote:
>     > The basic disassembly logic was obtained by somewhat modified script
>     > decodetree.py, and such output was further manually modified to
>     > handle numerous details of micromips 32R6 instruction coding scheme.
> 
>     What modifications to the script?
>     What manual modifications to the output?
> 
>     It's been a while since I looked at micromips, but I don't recall anything so
>     odd that it couldn't be handled with the current output of decodetree.py.
> 
> 
> I don't have dev setup at hand right now, but I can look it up in few days.
> Some of the changes are purely of cosmetic nature (like outputing binary
> instead of hex codes), but some are not. I can send you the whole modified
> script, once I come back to my desk. There are some not-so-obvious micromips
> oddities, if one delves enough into the coding scheme.

The thing I'm concerned about here is any future maintenance of this file.  One
would surely prefer to edit the original decodetree input than this output.


r~


Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08E8C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 21:11:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68B9F206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 21:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+vod87O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B9F206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir6zx-0006VQ-CD
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 16:11:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56289)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ir6zC-00064n-66
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 16:10:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ir6zA-0003GA-VF
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 16:10:57 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:38232)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ir6zA-0003Fb-Ob
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 16:10:56 -0500
Received: by mail-pg1-x52a.google.com with SMTP id a33so5302604pgm.5
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 13:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IhYsl/daq9PWkxyOLaQgLx1OJYA7dCqOcGoLfjUufCY=;
 b=C+vod87Ov74OFq9ohhVlZz5LVRgiktDZIMZq44R+nnp+ViNyxyxiA3V9EwL521HZrZ
 1XQsi/fKcVpAnBRJYq7n0L+0uKCPeKclaaG7zMGxf1h7W8t6VSmfcCdGielQdcACEgli
 Ty8q06DgOGD+R8LmoaQfd1lGlS3YEAU7gj3EjAK8mEkXH7CA4IYkps0aeg6jJrA49NX9
 2izEaSLhbIq74jGnnzxZJmTBQJBcBUfdoyGV+TVNt+Lv4E3eA9giEtft7csSbsgEYLTj
 0JHKalK2mZFJoN5uI8l0Np4URh9o2JWoY0TOCttnPx6VDpuFW0lXYeX5Jiu52apsRGEN
 0sBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IhYsl/daq9PWkxyOLaQgLx1OJYA7dCqOcGoLfjUufCY=;
 b=nf7xClVpT4X6/+qSjIpmQg4N9ebJt57wnGSeDpTdPswGgND6WJbVjNiSD37pwkzZbf
 /ZZBGZPSWtkgBjnpXeOXrrZQW0PTidCztXv+3wfLgGclTXGiYIOmcQL6T27kEi6R67NE
 AjteiFa0YgaP1u9LFS/4ha/3TpscDiKN/6shgRpaXof4MrmTxfFLzrhCUbHWH6wu8wXt
 ikN0/+bonP/vAAFF1+BwZrabr4tET24ovevxnBUn764PDqB0AvyeXabeFv72IgRHDLBu
 07zpj+rsfv0nPTHJZuNPwaW7Q1TZR2Cn8swVmQeS16xwvQb3Oj/j6WLiFXmqLtmbfuTA
 Fyjw==
X-Gm-Message-State: APjAAAXhBhQlh50Q+gMLYSErKr7Nk5A0yOAlz8ZPWvyFRfnq+c1tGM/H
 ynp2dusoJIBk5GK5jM9W+edEIzReRFc=
X-Google-Smtp-Source: APXvYqxq9rO5uAXNqXO55ajQp/RiZ2NpxfMl9GxM62L02IHWdG6j0aRqkMJxnfm7fRlymAtsL1tWKg==
X-Received: by 2002:a65:52ca:: with SMTP id z10mr23395546pgp.47.1578949855034; 
 Mon, 13 Jan 2020 13:10:55 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id y128sm14927807pfg.17.2020.01.13.13.10.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2020 13:10:54 -0800 (PST)
Subject: Re: [PULL 00/41] tcg patch queue
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
 <CAFEAcA9P_3enu_M-55aoqWScFFAhw=Jfs92+vCc+yY-2nXUehA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <df405ec5-190e-946d-fc2f-b52c695a39d4@linaro.org>
Date: Mon, 13 Jan 2020 11:10:47 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9P_3enu_M-55aoqWScFFAhw=Jfs92+vCc+yY-2nXUehA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52a
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/10/20 5:51 AM, Peter Maydell wrote:
>> Improve -static and -pie linking
>> Add cpu_{ld,st}*_mmuidx_ra
>> Remove MMU_MODE*_SUFFIX
>> Move tcg headers under include/
> 
> This makes the x86-64 'ls' binary in the linux-user-tests
> tarball segfault:
> 
> /home/petmay01/linaro/qemu-for-merges/build/all-linux-static/x86_64-linux-user/qemu-x86_64
> -L ./gnemul/qemu-x86_64 x86_64/ls -l dummyfile
> qemu: uncaught target signal 11 (Segmentation fault) - core dumped
> 
> (probably
> http://people.linaro.org/~peter.maydell/linux-user-test-modified-pmm.tgz
> if you don't have a copy to hand)

I do have a copy, and it works for me.  I tried with a rebase vs master, just
in case, and don't see it there either.

Details of this test system?

I suppose I'll grab your tarball just to see if the binaries are different...


r~


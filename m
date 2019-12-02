Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157BFC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 17:31:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2BB8206ED
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 17:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SucIvI/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2BB8206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibpXV-0005Ml-W2
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 12:31:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibpWQ-0004Ju-DQ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 12:30:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibpWP-00038v-3P
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 12:30:06 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39489)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibpWO-00038g-Si
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 12:30:05 -0500
Received: by mail-pf1-x442.google.com with SMTP id x28so18774765pfo.6
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 09:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Cz9E3oMGDh1rZ7hzIsCm3nkYNB1OenF7rFRYFLvNmF4=;
 b=SucIvI/9GK8v+AiaCDhsjbgkexLveOCBWcIFjf4RZlQj+/j2Xc+eSKa4JD1gMg3F8P
 HR8v1XM26V2Oor6qD+mFuxaIOW2EKtvwaEEaVRAT3hXUAphuvWrrQgkxxj+yEvWrN7DA
 nmDWXo1w5B/uRSXHcWeoqhQc4N1tTrNQUBqA0lR6wZUTTUr2iprDQXzpE28YTMQp1+k7
 mnFnrncWIV6NCdxgznE67v8HB7cgp0Gz1599il73ouXpfuTa7g9fKHjc9AArHzWoqu0A
 LXlPdhaqYipybMJec8AVaTzJf9Cv7Y8AHk73vnB7PQlVZdsbBE/PRcoJsG7QLlqTbFTq
 V8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Cz9E3oMGDh1rZ7hzIsCm3nkYNB1OenF7rFRYFLvNmF4=;
 b=Ll/Rho4I0k7IXiIYUA+agWbyIhhybPywwqbyC3TpBaePIsdV4fJfOlCLuBqwpdkJIs
 fxVvgpM/u+SEnoU0V1tdIZpuQXgc6/RUrMWFEGKRmtaeWo/oRfCDpxxOMzateVF/gxcz
 YpqTnlP63CczvE954Yn9EPYY13b03Rbyiq1mBSn0o6QEerNJKYxSVOC0IQE52pn9Dsn0
 7DZBE2S+D3KgCIIzUqUQSw5bthiqqbWcbFe80kePjiZy87si00224YXYIVKYp8e8lm8B
 AKMBbvs5NBFE1vaokjOikBxgyLu17fUQgAKW+ADB2/T04jqlMJuxzRftDApANp0yks8W
 pk6w==
X-Gm-Message-State: APjAAAWtUUHKn0VMDslYLceytvV85O2xNRPoBJ2TRyVgemZFpE/bVHPg
 zDJPd5els3zI/JWdn70ODy9avEr+Va4=
X-Google-Smtp-Source: APXvYqwCNjZVqRKj35kRilezLBaTxGMZTJag7pCMNCS0nKcmu+KqCCjDr41ngeIaHH1cfW442HOFnQ==
X-Received: by 2002:a65:5683:: with SMTP id v3mr161577pgs.190.1575307803085;
 Mon, 02 Dec 2019 09:30:03 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z19sm77282pfn.49.2019.12.02.09.30.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 09:30:01 -0800 (PST)
Subject: Re: [Bug 1853826] Re: ELF loader fails to load shared object on
 ThunderX2 running RHEL7
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Bug 1853826 <1853826@bugs.launchpad.net>
References: <157468002661.30952.10642264809488923382.malonedeb@wampee.canonical.com>
 <157495565236.22072.12895340025547390627.malone@soybean.canonical.com>
 <CAHDbmO26ZNB4CJ0b_w+e3w8vTDFVcZQXMvchjsU32ng2JfNdQw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <812ed58a-fe53-5275-f927-8dd3b7dbcb2a@linaro.org>
Date: Mon, 2 Dec 2019 09:30:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAHDbmO26ZNB4CJ0b_w+e3w8vTDFVcZQXMvchjsU32ng2JfNdQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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

On 11/28/19 5:47 PM, Alex Bennée wrote:
> Do binaries have to be page size aware? I thought it was a runtime thing.
> However if the aarch64-linux-user is hardwired to 4k it might explain it's
> confusion on a 64k machine.

Binaries do have to be built for a minimum page size.

Most aarch64 binaries are built so that they can run on a 64k host.  This is of
course compatible with a 4k host.

But it is possible to build binaries that will only run on a 4k host.  This
appears to be one of them.  I'm surprised that the armclang lld is so configured.

Indeed, it's possible with linker scripts to force binaries to be built that
are completely mis-aligned and won't run at all on a paged operating system.
This kind of thing used to be done for building kernels, where we were
interested in minimizing "wasted" memory between the segments.


r~


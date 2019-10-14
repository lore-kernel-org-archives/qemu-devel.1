Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2ABC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:25:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD05520663
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VOCFqXGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD05520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54469 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK46I-00079h-Ed
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iK3j2-0002Iy-41
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 13:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iK3j1-0005qu-0p
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 13:01:40 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:34656)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iK3j0-0005ph-RK
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 13:01:38 -0400
Received: by mail-pl1-x635.google.com with SMTP id k7so8287076pll.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 10:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eblkwcZW3JEeU+VtoWSF8yuiTYILJ+fT8OPZ3vIl3yk=;
 b=VOCFqXGJC2C59aQTk7reoS8VnQL4LFzuB1kyqLHkX6AK2mhPoezEaTizMJjIVZkKED
 i+mr9VMy7lV5sZ3HaopzJDEMkgaUvnC7EHxJHCOwLAeAXrUviELuj1HR/qfjeC1qnKFi
 CknFRP+nfxm1f1NnbtFuTJG531CD4ruWJS4+19g3UfO0UhEUoUgYlqNP+pJch3X0AiCn
 Nn50ji5hmE4nNEkE63lrR6KuBiv5bxllB5UJM3hsXZm/XnnXePgChE6d9iKPMzitUoWu
 6mJSlm5ESxBlxMK2WRbRYfS/yRSna7xHHTLuenOG3S04ZqKc2lc7mV9LQIQU0ZeLJ73h
 iZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eblkwcZW3JEeU+VtoWSF8yuiTYILJ+fT8OPZ3vIl3yk=;
 b=jbmCKgu5A8+Uit4WPuDO872bD6sSjY//wq0NfhkOii23oTaV/ORioyhLGfQ7HOCUSo
 omQROnUBDDv/c6tAb0y5ytCoopfdxzWykZpeycuo77GB+Du95bbZ22iiiY6dwHEs67XQ
 NQwQJ7i2JOXYJ1Q/ruCflbIdivU6U6W7GWjdyuxGGJRIOcCc8Q8/DIcrzz9H4C9yMZoB
 2Dt0TE0FRy9GyGse28fGnvusk7UIqZlr03UoEyu01m80ZcRgr5eQALi2HhGW2Yt6Mpbx
 wthnqyHVbJ+EPCi3SXZH7kPRIrfCz9s1tdACFPm57uSt+oqlDUu6KBwPw7TuuHlq5w07
 qDTQ==
X-Gm-Message-State: APjAAAUY+0t0W5aSq2tXs8am4gJXHqk3lapkv+jB8qlNYwPko09ZRRfi
 2boVGU0g4GPLme9wMcrgR39saw==
X-Google-Smtp-Source: APXvYqxS6u+EcFQS7m1a5j/gCNyckmd8bzRHeJgOwfKJelreytalp5hwjRNEwJA4HNv37bUlSRZ5qQ==
X-Received: by 2002:a17:902:a712:: with SMTP id
 w18mr31555947plq.304.1571072497480; 
 Mon, 14 Oct 2019 10:01:37 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 20sm19603285pfp.153.2019.10.14.10.01.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Oct 2019 10:01:36 -0700 (PDT)
Subject: Re: [PATCH v5 53/55] plugins: add sparc64 instruction classification
 table
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191014104948.4291-1-alex.bennee@linaro.org>
 <20191014104948.4291-54-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <3ce497fe-9dc1-5fa3-acf6-155ae16e0793@linaro.org>
Date: Mon, 14 Oct 2019 10:01:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014104948.4291-54-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::635
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
Cc: aaron@os.amperecomputing.com, cota@braap.org, robert.foley@futurewei.com,
 peter.puhov@futurewei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/19 3:49 AM, Alex Bennée wrote:
> +InsnClassExecCount sparc32_insn_classes[] = {
> +    { "Call",                "call",   0xc0000000, 0x40000000, COUNT_CLASS},
> +    { "Branch ICond",        "bcc",    0xc1c00000, 0x00800000, COUNT_CLASS},
> +    { "Branch Fcond",        "fbcc",   0xc1c00000, 0x01800000, COUNT_CLASS},
> +    { "SetHi",               "sethi",  0xc1c00000, 0x01000000, COUNT_CLASS},
> +    { "FPU ALU",             "fpu",    0xc1f00000, 0x81a00000, COUNT_CLASS},
> +    { "ALU",                 "alu",    0xc0000000, 0x80000000, COUNT_CLASS},
> +    { "Load/Store",          "ldst",   0xc0000000, 0xc0000000, COUNT_CLASS},
> +    /* Unclassified */
> +    { "Unclassified",        "unclas", 0x00000000, 0x00000000, COUNT_INDIVIDUAL},
> +};
> +

Unused.  You'd see this if they were static.


r~


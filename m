Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A116EC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 20:06:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F63420890
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 20:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2YDwabk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F63420890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jroQE-0005Il-HY
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 16:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jroPD-0004o2-Ek
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 16:04:59 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38409)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jroPB-0003we-Pq
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 16:04:59 -0400
Received: by mail-wm1-x344.google.com with SMTP id f18so37640395wml.3
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 13:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IpuPZ/xQ4lfO2SMNqj/H7bsjvYRbNe1+zRXkxu8VnpM=;
 b=B2YDwabkRkW745VgGTYaPZ8oSdzpMfXWk5S8T3W0/1AZspLw5iZLKQs1Xb6DXbNPDU
 k5yFkdxQT7r+LwaW2m96tTZwTil+X5vtflbqgtH1cAMDp1eEbB5Did6vNkfErsRRyX6B
 DZV6y+pXD98KSf8QA73oF4PaPeLoqaEYtQ1vgIsoQ5m8ZDZKzex1OpY1J+R3vDRYU1s4
 0u0iX7I59omduNlMw8EQWOZUZcDzlIBj+zbYdJzy8qI7leASksWlyccawiMDH13ZfBDl
 1Cy9TkasDvFkSJLeQ5SSjU9UiCrqbOG59NzHEk0KEAQUlT74MZqXu2HqoovOdGHVzzI4
 4+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IpuPZ/xQ4lfO2SMNqj/H7bsjvYRbNe1+zRXkxu8VnpM=;
 b=p5ovd07a53oSKlcSnH5hGegkAPlcJhpEu//TDuvBoXHhZTvwBY3QBl4YSnXNlPBdQg
 /VvT0AtkyI9mlzjQnLxnSCZ8bT0qvPyyMlT78cHfymCVrsoMMXWbu1vYeLkc7WxSgy31
 SFi5GcF8YeDnIpYkPOJeW0CGqSsh7LX3lefY8PB5VwLSRBCp4CAIRPvKjct4LIYNP7lh
 xHACJhwj2wcdpJ7PZPB+khyWFbDZDQLM9g3V7c04q/bsttYFANrCD84+kzNt9/FU1f9r
 vwuOS4eImgFJK+sXyNWD3soUOZ5F9jwnDHYV0w4HOwvX8q5cqmFipMnJCfRxB2eJQHJd
 XR0A==
X-Gm-Message-State: AOAM5317tWooaqZqzrvhqJdv+qofkbm2UYFZTSevKdV+lao3JYey7osl
 +o45lkTpIbkKO/n66JZlHSw=
X-Google-Smtp-Source: ABdhPJw0N9pIHRJ1zAKU9G8WFT8GF2vXobsUWtogAEg4oUlTbz68ArMYgxnvunfKdniCz3v1y3g6Jw==
X-Received: by 2002:a05:600c:2f17:: with SMTP id
 r23mr40151138wmn.167.1593893096154; 
 Sat, 04 Jul 2020 13:04:56 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id z16sm17733107wrr.35.2020.07.04.13.04.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2020 13:04:54 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] disas: mips: Add Loongson 2F disassembler
To: Stefan Brankovic <stefanbrankovic96@gmail.com>, qemu-devel@nongnu.org
References: <20200703104409.6986-1-stefan.brankovic@syrmia.com>
 <20200703104409.6986-2-stefan.brankovic@syrmia.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <93277e29-001d-824e-5b5e-93a928290a30@amsat.org>
Date: Sat, 4 Jul 2020 22:04:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200703104409.6986-2-stefan.brankovic@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: thuth@redhat.com, aleksandar.rikalo@syrmia.com,
 aleksandar.qemu.devel@gmail.com, stefan.brankovic@syrmia.com,
 chenhc@lemote.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

On 7/3/20 12:44 PM, Stefan Brankovic wrote:
> Add disassembler for Loongson 2F instruction set.
> 
> Testing is done by comparing qemu disassembly output, obtained by
> using -d in_asm command line option, with appropriate objdump output.
> 
> This disassembler is written as a generic disassembler that can be
> integrated into other projects. In this case, it is integrated into
> QEMU. One of initial key requirements was that it uses C++ as its
> language.

Wow, this is a huge contribution!

QEMU uses the libcapstone as backend to disassemble some architectures.
I see the project [1] do support MIPS [2], but they don't support
neither nanoMIPS nor the Loongson 2F instruction set. As the library is
used by other projects, it might be worthwhile have a look if your
disassembler could fit there instead.
Don't take this as a negative comment please, this is the opposite:
more users would be able to use your work.
My comment doesn't say neither that I am against your proposal. I
wanted to be sure you are aware of the capstone engine project.

I cc'ed Jiaxun Yang who has more experience with the Loongson 2F ISA
and might be able to test your patch.

Regards,

Phil.

[1] http://www.capstone-engine.org/
[2] http://www.capstone-engine.org/arch.html

> 
> Signed-off-by: Stefan Brankovic <stefan.brankovic@syrmia.com>
> ---
>  MAINTAINERS             |    1 +
>  configure               |    1 +
>  disas/Makefile.objs     |    1 +
>  disas/loongson2f.cpp    | 8154 +++++++++++++++++++++++++++++++++++++++
>  disas/loongson2f.h      | 2562 ++++++++++++
>  include/disas/dis-asm.h |    1 +
>  include/exec/poison.h   |    1 +
>  target/mips/cpu.c       |    4 +
>  8 files changed, 10725 insertions(+)
>  create mode 100644 disas/loongson2f.cpp
>  create mode 100644 disas/loongson2f.h


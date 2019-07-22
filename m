Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FB4C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 16:00:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C5EC218EA
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 16:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iPbss/mK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5EC218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpajP-0003sQ-Pf
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 12:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56700)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hpajA-0003EJ-Gw
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:59:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hpaj9-0007lR-Kg
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:59:52 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:46315)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hpaj9-0007kR-Bs
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:59:51 -0400
Received: by mail-pl1-x633.google.com with SMTP id c2so19356261plz.13
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 08:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=53qxnmFCQleCgbRBd+QvrrBbXVy7x90TNzmGsFo5nJU=;
 b=iPbss/mK0jszMYof/8qtEi33fitz9HC8eD/BndxwmPj/LtJj21fdl1api2UB53TVJ3
 LiO/y1lhicz2hfPj5jnw3buDx9l0NVfuG8XWs6sgxIxkgeh6ofJg+rI9vKUAUHFyi+c/
 ug5ndyKNnPX6tDf11y2fxK3chMQvVwuXqhlhlvN351ntAyuvxP95hpiQUZdskVFXNm8S
 /+JSbRug7VVg9zxK0h9re0oMGark5HNwNNigLHKEX2GcEoUZzHqsv1alZOVnM1IeNmYK
 eUvzBNFoIl8UsEOqM62/C1mB7Mq4baSo8laFlWCeZ4XMs17DBlLRSW91MabPlGM68JxT
 w6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=53qxnmFCQleCgbRBd+QvrrBbXVy7x90TNzmGsFo5nJU=;
 b=VQjmKXze3GOt5bRXo6UJ87hhO3WG2FhthuzvqiPMeni/5y0SVtXCH/0/fDaam2oaQa
 6EdMe8+AArzKqtEijE29qDA3dykiJTg7UXY54jJGdotHtxttF2iJW/aSajqDq839eD8X
 vQKZOONZLn/xGhUzZUCZzxryfIjKqIXOhjVkSn85ZYVFyb62wy/DVKaliNkF8hFTrHy2
 HuZ2j9ZPmpm/ta/O4XZTCP139fNKFrYju6DCnVZX4adHZP28am1ZLRUCRvCpeoq5YpDi
 2FOZT7b5dKmqQKulKHAJbt1PhurqGXL91RD56+X49PW5oGy10WbU8qA8wVi96F3OCz4q
 8Mmg==
X-Gm-Message-State: APjAAAWBC5xUcBAGA+TWGsNbcFoQk+JQVjLR1OsbmcGHb73Knx7C/M5S
 QmblB+u9gcCwzLCLMDBXEA5tIw==
X-Google-Smtp-Source: APXvYqy/RcnjVKmOcjR9YkoxmsldkT0VMHLcPieshCXhxmcgxnYEhbB1VLUfu3mSkg1P/Zg2xZBPtw==
X-Received: by 2002:a17:902:b582:: with SMTP id
 a2mr77224778pls.128.1563811190327; 
 Mon, 22 Jul 2019 08:59:50 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id y128sm58626865pgy.41.2019.07.22.08.59.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jul 2019 08:59:49 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <e9c6e5310b1a4863be45d45bf087fc3d@tpw09926dag18e.domain1.systemhost.net>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <2b6eb033-4b6e-4d64-c57e-a3257088d0dd@linaro.org>
Date: Mon, 22 Jul 2019 08:59:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e9c6e5310b1a4863be45d45bf087fc3d@tpw09926dag18e.domain1.systemhost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::633
Subject: Re: [Qemu-devel] [PATCH v2 00/20] Invert Endian bit in SPARCv9 MMU
 TTE
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
Cc: peter.maydell@linaro.org, walling@linux.ibm.com, mst@redhat.com,
 palmer@sifive.com, mark.cave-ayland@ilande.co.uk, Alistair.Francis@wdc.com,
 arikalo@wavecomp.com, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, rth@twiddle.net, atar4qemu@gmail.com,
 ehabkost@redhat.com, sw@weilnetz.de, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, david@gibson.dropbear.id.au, qemu-riscv@nongnu.org,
 cohuck@redhat.com, claudio.fontana@huawei.com, alex.williamson@redhat.com,
 qemu-ppc@nongnu.org, amarkovic@wavecomp.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/19 8:34 AM, tony.nguyen@bt.com wrote:
> Tony Nguyen (20):
>   tcg: Replace MO_8 with MO_UB alias
>   tcg: Replace MO_16 with MO_UW alias
>   tcg: Replace MO_32 with MO_UL alias
>   tcg: Replace MO_64 with MO_UQ alias
>   tcg: Move size+sign+endian from TCGMemOp to MemOp

I don't like any of these first 5 patches.
I don't understand your motivation here.  Why?


r~


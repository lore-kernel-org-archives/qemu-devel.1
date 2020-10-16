Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D5CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 23:59:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43A64221FD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 23:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pw83+Kdp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A64221FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTZcx-0003nI-66
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 19:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTZbR-0002Uj-Uf
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 19:57:41 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42909)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTZbQ-0000R1-Da
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 19:57:41 -0400
Received: by mail-pf1-x441.google.com with SMTP id x13so2377447pfa.9
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 16:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PnAQoAA0RyXXesZLG7QmJadfGKel9RciOTxBkb0RJK8=;
 b=pw83+KdpVWwdrJ/YSTHKM4pwfGmfvsmhl7mzXe64t3iQJzsCkxZPyRjUkwj9BnfBLn
 fDgoEXaYCBIl++JYu0gn3ffHI7VWImPNF0eCd6AsBjByRriZuvqURNQQxGumgOjp1Ljw
 Rm7/cQoo+wzGMhoq1S6jZLsR1HOW/zKKbbpnHqShwkEkfITzLqT6RvhocsAkjbRXGjju
 KE8tFN037MENzBT10cPfkPNA75YKyxZNIoYeS1F8y3vzudjUfQRhCZPKoFoPfeHzsPcD
 9glS6ZH/arcANKT6bPQ4uSwzdl0mMvGuwqZToj1ybdre075hOSoRA0EAK0OwPtaiSrYA
 Csqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PnAQoAA0RyXXesZLG7QmJadfGKel9RciOTxBkb0RJK8=;
 b=NudWoePAda+d6JBChTrYhr2JYj2c6OVXAww6z+0uOwCN+1HFk6M5qQORTk5gmhn/uc
 tX9NiHQZAminD0dDEelcTuCY5gdzOwMjJYnGwMOX3TO6AN3wFCzZGRUyRvzvA9ELQTnA
 PoPflkI/jtQakAuTXkTWpryIRGeS+sWGyYft6TLCo+jDVRQP7OUPGaiGwhJDLbGcazo3
 76AOHymUg/rTlp3jSV0t+DdY42mjKh4f8FUxv3ZH7m7EuytRCMAl1tEfLWVqGKeaI3Lt
 UZHxnReffsyufFAV0hWgY116ozGDrAaOH7O0PlJo3GaFLmlScYR4sTU8luSpC2RJ2rHz
 VzbQ==
X-Gm-Message-State: AOAM53129oqpq1TDV6xbYyhVUW2YvUBydnXH4ln07nCdjAkU3SV9DbtG
 uvyjCkns95kBlZXDjbbj7TN22w==
X-Google-Smtp-Source: ABdhPJy8R+0M00dh9v/PSfxouPe7cRvgUCvEwlz834E7NiwJvyuavfuF0AS6mkFDxiyC5VXhHl4DUA==
X-Received: by 2002:a63:185a:: with SMTP id 26mr5087285pgy.408.1602892659214; 
 Fri, 16 Oct 2020 16:57:39 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y137sm4109314pfc.77.2020.10.16.16.57.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 16:57:38 -0700 (PDT)
Subject: Re: [PATCH v3 1/5] [RISCV_PM] Add J-extension into RISC-V
To: Alexey Baturo <baturo.alexey@gmail.com>
References: <20201016221138.10371-1-space.monkey.delivers@gmail.com>
 <20201016221138.10371-2-space.monkey.delivers@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <423141e1-4f5c-823f-89b4-4a94ca7b41ae@linaro.org>
Date: Fri, 16 Oct 2020 16:57:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016221138.10371-2-space.monkey.delivers@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.253,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 space.monkey.delivers@gmail.com, Alistair.Francis@wdc.com,
 kupokupokupopo@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/20 3:11 PM, Alexey Baturo wrote:
> Signed-off-by: Alexey Baturo <space.monkey.delivers@gmail.com>
> ---
>  target/riscv/cpu.c | 4 ++++
>  target/riscv/cpu.h | 2 ++
>  2 files changed, 6 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~



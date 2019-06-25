Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513FCC48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 14:43:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B9AE208CB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 14:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VamNt7Vi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9AE208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60966 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfmf9-0002SC-EE
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 10:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47794)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hfmaK-0008H6-NP
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:38:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hfmaJ-0006wR-KC
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:38:12 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:32829)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hfmaJ-0006fK-8l
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:38:11 -0400
Received: by mail-wr1-x442.google.com with SMTP id n9so18236162wru.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 07:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XNc8byr0X7oATn/GXl4yJhUfNYcq99R2rU9eGSct7qk=;
 b=VamNt7ViCR7spmBHojRpr5NoYXCFqWu9vfvpvK16IislxdKrKjBzF3z7gPBgLlYJ3J
 SgDiLRGc9L0MnPDO0E5mcBZ3gr1wApi0rcQ7Gtq8PaRBuxfckKKMaCuih8+JBjmMHCZi
 LoiIkNctjLv8n3QTZJh3+o/A66OKjstHqMiASR6ZVr5pTmm1LHKgqRVmY2poGYmdLZbz
 UuC/XC6nbiWQKjXn88J5ZPpHUmEfyhk6n4aapNuFLslVN1DaxC2ohMLoLWPpdSxF1cGp
 zr1rkOsxZsxkjWP5D30HmEiyFchtj3YDOOhVhEA1wDSRQILQp9B9HLIqKoe86O2vrpMH
 8Mnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XNc8byr0X7oATn/GXl4yJhUfNYcq99R2rU9eGSct7qk=;
 b=lrFFnFrtM4MavhFikw1mvtctNa8AU/F3eA2veVbG8bh+tcRH5fPOlpDa70y14Og0r6
 Yuye0GP0Ei0deSLw+5sbk6jDYWkxdx+UghkDMraNHiQHmsRUJUWKGKRA2hsWhzv+ZHhb
 1/UvngAs7o0nicbFdWp9S0gC23Xe7xUC2aZqd/rkzyj16wa5AaCkf6TUycNfMw9yp6w5
 al+Mipmu2B+C1GBTxIAqLF8mB+l0msiZh2ZxLI/g/Pk+b+dYocjIlVrVghd4g1cwH/5A
 26OVADzP+6db1RGn3RM61fkOfGJkEjX7UH/rWr75hH3plH3FiJxpTpRKR+ORq0Qm0XEY
 Y0oA==
X-Gm-Message-State: APjAAAVk/6DNb2vaTddtUcN1o+DM1cJqo2DN2SPoyAjN6wzHNg6CN/Ch
 ntlCpeRc8EaOS+bGcjRR/bG57Q==
X-Google-Smtp-Source: APXvYqy/C2SXIUWOwTqWZJhwku0ILR7aqVtBKGArwRbuz4f/Gn4U8BWgPZryQZNxkMHfZTwKngVCNA==
X-Received: by 2002:adf:ea45:: with SMTP id j5mr21942482wrn.281.1561473475677; 
 Tue, 25 Jun 2019 07:37:55 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id h14sm12476282wrs.66.2019.06.25.07.37.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 07:37:55 -0700 (PDT)
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <79729cc88ca509e08b5c4aa0aa8a52847af70c0f.1561039316.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0bcb1b80-8a22-4e2f-b761-f9297ceff8ec@linaro.org>
Date: Tue, 25 Jun 2019 16:37:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <79729cc88ca509e08b5c4aa0aa8a52847af70c0f.1561039316.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v1 1/1] tcg/riscv: Fix RISC-VH host build
 failure
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
Cc: alistair23@gmail.com, palmer@sifive.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/20/19 4:04 PM, Alistair Francis wrote:
> Commit 269bd5d8 "cpu: Move the softmmu tlb to CPUNegativeOffsetState'
> broke the RISC-V host build as there are two variables that are used but
> not defined.
> 
> This patch renames the undefined variables mask_off and table_off to the
> existing (but unused) mask_ofs and table_ofs variables.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Oops.  Thanks, queued.


r~


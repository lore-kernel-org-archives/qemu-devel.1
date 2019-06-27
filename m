Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6CCC48BD9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 17:08:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B6F2205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 17:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EtP5PnZk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6F2205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgXtK-00021p-S4
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 13:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56775)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hgXlb-0004f8-Ez
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 13:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hgXlZ-00039T-TT
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 13:00:59 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:36404)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hgXlZ-00038J-JF
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 13:00:57 -0400
Received: by mail-wr1-x436.google.com with SMTP id n4so3409407wrs.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 10:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SnSainN7M3Jy3O1rgRnoNBqbG4J9t9BpOQidGj9hFwY=;
 b=EtP5PnZk571qKEmx7oyF0sYqGj3PXCw7XpKQ+9ORcJiqQK2uCURDIA8ecVTG1WYT6C
 6PE/7YRbOmmX0QvjLGmw1nrl6gHCnVpdbdGnhQFEoxr1kRn8yLHXZBQ4Be90gigdtcl/
 HzFiJRh4P6Y/WJCMw9iEzalL5nn2hRzHRw6ajk8octp1qmEvrK6mh6fBLVyagVngUsE+
 b3RSnYVT1L2fSScIP8hRKmIXB54bAd/uhz8ZAtyTJLjna6DkB9HyLtmB6PmSmXKx46qE
 8cJnk5GcIyEIuLJzDv1Q7FxuVLTO8/rwiAzbH9tz48esWGBu4CTKKSHuqA0rW2umz65J
 /QTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SnSainN7M3Jy3O1rgRnoNBqbG4J9t9BpOQidGj9hFwY=;
 b=LVnVs2J57Rur8DgWjwzHwNpLCxczLaxxkf2b4IwakwEuc5wszC47AD/eFK3hTVdWR2
 dgxrqyUflbT2E8N7VQebkN8JH8BuewaThmQDtgEzLqxOdkdZGR2NjsakQA2DHILjgdMr
 xTIkNfmE3ek8V7WXq82DYT2NOmf1MvHm5VXv/Odoxau0wusOcnrg0+C9pPQ36lsILT8n
 HtGWDUe4m0xQxZSZIVLKrd9oRO8LcTgcNlGiw8Hw4i/iK8TH/KJ9zW+3tfvMPzSuAFNl
 5mqX0/5v9PZ8Q1XFSJepVI5wymP7qBrTa4MijZ+0KRvSwSpspWuRvWARyZBSpmJNu0ta
 7RDA==
X-Gm-Message-State: APjAAAUArsrkvkZbl9BKkzqAgEyp30oSyTeQz5KDgMuiOndrLtN82kX1
 siJu5n+U5NvfaPp2CT2HPQzSCA==
X-Google-Smtp-Source: APXvYqxWsHKtIWMoWUp6unAcBKIkpxQuCFIsm2HWhI5LMEWf0lHUskV1L+M5/hC6+ze0dxi6+dBetA==
X-Received: by 2002:a5d:5542:: with SMTP id g2mr3982796wrw.232.1561654856051; 
 Thu, 27 Jun 2019 10:00:56 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id u18sm4918271wmd.19.2019.06.27.10.00.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Jun 2019 10:00:55 -0700 (PDT)
To: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>, qemu-riscv@nongnu.org
References: <20190627121828.8376-1-Hesham.Almatary@cl.cam.ac.uk>
 <20190627121828.8376-3-Hesham.Almatary@cl.cam.ac.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <77c4044f-93dc-0608-496e-edf8bd8f77d7@linaro.org>
Date: Thu, 27 Jun 2019 19:00:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190627121828.8376-3-Hesham.Almatary@cl.cam.ac.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
Subject: Re: [Qemu-devel] [PATCHv4 3/6] RISC-V: Check for the effective
 memory privilege mode during PMP checks
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/27/19 2:18 PM, Hesham Almatary wrote:
> @@ -392,19 +392,27 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>      int prot;
>      bool pmp_violation = false;
>      int ret = TRANSLATE_FAIL;
> +    int mode = mmu_idx;
> 
>      qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
>                    __func__, address, access_type, mmu_idx);
> 
>      ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx);
> 
> +    if (mode == PRV_M && access_type != MMU_INST_FETCH) {
> +        if (get_field(env->mstatus, MSTATUS_MPRV)) {
> +            mode = get_field(env->mstatus, MSTATUS_MPP);
> +        }
> +    }

This hunk looks like it belongs in riscv_cpu_mmu_index instead.
Passing the (corrected) mmu_idx on to pmp_hart_has_privs looks right.


r~


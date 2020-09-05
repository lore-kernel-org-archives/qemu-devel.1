Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281E5C43461
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 21:41:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F53D2073B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 21:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ur/PAbuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F53D2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEfve-00028B-Fv
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 17:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kEfuT-0001CM-HD
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 17:39:45 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34260)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kEfuS-00019v-2c
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 17:39:45 -0400
Received: by mail-wm1-x344.google.com with SMTP id c19so9764679wmd.1
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 14:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rf5+Ceq5l3MrUIFpiyezEUxGc4x7maq3uj6yV0Dblsw=;
 b=ur/PAbuw2nclJnjQiRgmL/J9FbSEdDCw57XqTsZsGj59HeNIVthhkfWNZQb7BDzUaa
 V6JACVKVd2voM3+r8asXB6ctF6QaqBgbHo2qpNDtr+2l5P3m0TZb7hCTKkKeWt3Ix9oU
 YDd7h3/U42ye3gtTgH8LLxVdFoGrTpzBaAAm5IWLE2ofyV2vOc7QszhsFnVIY8CNq48y
 +AjQSP48w+6PHBJ9m0p74W3Sk8sEmSs/BKwoBbl+MDODC71rjDkHDG4S5DOnBwkbfHok
 CQ9W+esPW0c060q/jeBu8zuXqG7vrv8EDlpEh/8SZUYdcPUWYeg7kX5Ve5zOooX9fraF
 r3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rf5+Ceq5l3MrUIFpiyezEUxGc4x7maq3uj6yV0Dblsw=;
 b=sPaxYw7+QiTbMoHzKYUVoKbqhp/DGEUfJozyFRj/YSo4UsYwVv9DO2PPhnCcR2Tm3e
 /SntQYLMm7uySg9xakeeOL7wzf0TWKkhuOQzxhm7iYMRBsOXORaqNiJ54cYsZpFVaXjn
 bscX92Jd10rNfd1U5EfGSSEwe/Xcyo/QlPJswlk2ZjUrqjmEQcWQ1i10uI64/xe14gC1
 0PqIULQPE1l8HL8A01JgDBlxjnqZcEN8UMHhJHLwUGYjJmSp8vd4xnjcHrwVfxLbtTkX
 mj2EQBcBExXoADHS502zY/Ige8hjoQoFzhqV88xb6RWWxImpwC1K+9Em8XKBsj8ePagl
 UHzw==
X-Gm-Message-State: AOAM533tvkYYvZBdyFn6/x87lyJQ7PSbgrPgjXOCjsdl2WE088AjJ/no
 idIT+1SDzoXFOrSlOFx53Sc=
X-Google-Smtp-Source: ABdhPJwiUaGipJI56DAbIfNeqr+K7pav0HjYMFNwEiBFPXyAyVvA+EbqsKAWtN1HCs1mL8uRRYe+aw==
X-Received: by 2002:a1c:ed16:: with SMTP id l22mr12790965wmh.80.1599341982478; 
 Sat, 05 Sep 2020 14:39:42 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id u16sm19671182wmc.7.2020.09.05.14.39.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Sep 2020 14:39:41 -0700 (PDT)
Subject: Re: [PATCH v3 14/19] target/microblaze: Move pvr regs to
 MicroBlazeCPUConfig
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200904190842.2282109-1-richard.henderson@linaro.org>
 <20200904190842.2282109-15-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e3bf615f-d96a-8255-2a90-dae8c78d7a3c@amsat.org>
Date: Sat, 5 Sep 2020 23:39:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904190842.2282109-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-0.107,
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/20 9:08 PM, Richard Henderson wrote:
> These values are constant, and are derived from the other
> configuration knobs.  Move them into MicroBlazeCPUConfig
> to emphasize that they are not variable.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/microblaze/cpu.h             |  5 +-
>  hw/microblaze/petalogix_ml605_mmu.c |  6 +-
>  target/microblaze/cpu.c             | 92 ++++++++++++++---------------
>  target/microblaze/gdbstub.c         |  4 +-
>  target/microblaze/helper.c          |  2 +-
>  target/microblaze/op_helper.c       |  2 +-
>  target/microblaze/translate.c       |  3 +-
>  7 files changed, 54 insertions(+), 60 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


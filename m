Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E6DC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 15:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 565CA22251
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 15:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAwbwIM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 565CA22251
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQuWR-0005kG-32
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 11:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQuVL-0004fH-9j
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 11:40:23 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46594)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQuVJ-00078t-JX
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 11:40:23 -0400
Received: by mail-wr1-x441.google.com with SMTP id n6so10470741wrm.13
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 08:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=i7Vm4mlZfUfiYbKBPEOiJfTpX3ebVobSJe68dmMqJFA=;
 b=dAwbwIM3BNmVwrqfsblj/9fVdfVmjIK77tcb65JNvPdXLrh+/dNM+ptZuw3aWKODBH
 bdknZXYijAkiKC6AiYrNxP3fFNgz0FUdAQXqDJeopFcvkzvdz/7aM9LbRkHkV8WFAGXu
 N805bfajRuYGJu7ZFUT+8WGlx8+kQ8JAu7lVuOh8Fcu9EYcVZT7D1O8/QO68jheSr6sk
 H9P+EB4hOKEFemnJEFkH6r3kp0O1QQJrIoXDzH8Qm4E1GtAExvexfv1F0f/kToLVy0HK
 /XJCOTu7ytPhnYUqLIJOtg3w9zX3uwMn08TfwsXsykce7uiWRH8YD5wySYy4o/p5MHpq
 Iv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i7Vm4mlZfUfiYbKBPEOiJfTpX3ebVobSJe68dmMqJFA=;
 b=UoQzMvbM8xsYkGzeFPqus1tiPOz6mat7XDW8J8IyqNqH2Y/9+1bdsGp0DqaxiFyOee
 +4A4sQOck3UtMFtNRiuPWR/SbBqjQ/WLHxDYw9hZdjwRrsB38/SRP9DJus8BprYYs7P3
 1V2RX28aVhJgXDzns72nrtGgAiLjJqv0OgymoeRkHUrG2fURUC6uJTxyg9Oqu/pdxGvs
 6qf4isH2IOoJ6p6s5Yyq4CFxxizcnCgmzmigl1V7fJ7qpzhJSiz+KtLncWCAGUSzywQa
 9LfNADPtY1cpYvDVj+B1ytnduCfiRso/PLk+nLiH/DpNZak80qfkSW929+njYCMiW6zd
 ZAAg==
X-Gm-Message-State: AOAM5325CWn8jFnhPRL1oFQdBxPiYKN+Whz4NlDm1gvG2AiSgZWHfGLF
 CZckdtQ1bqZCFaUMl0y6vtg=
X-Google-Smtp-Source: ABdhPJyimpAC5xhbL8abVjCT1sS7238tsGoywO+TUwW04QXRnkGF5CtMtP5UyUTw29A9p47MhEsBDA==
X-Received: by 2002:adf:bc0f:: with SMTP id s15mr15795104wrg.83.1602258020225; 
 Fri, 09 Oct 2020 08:40:20 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id y23sm12952768wra.55.2020.10.09.08.40.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 08:40:19 -0700 (PDT)
Subject: Re: [PATCH 00/16] hw/mips: Set CPU frequency
To: qemu-devel@nongnu.org
References: <20200928171539.788309-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2bcc2022-767e-66b1-22b5-4874492283bf@amsat.org>
Date: Fri, 9 Oct 2020 17:40:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200928171539.788309-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.208,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/28/20 7:15 PM, Philippe Mathieu-Daudé wrote:
> All the MIPS cores emulated by QEMU provides the Coproc#0
> 'Count' register which can be used as a free running timer.
> 
> Since it's introduction in 2005 this timer uses a fixed
> frequency of 100 MHz (for a CPU freq of 200 MHz).
> While this is not an issue with Linux guests, it makes
> some firmwares behave incorrectly.
> 
> The Clock API allow propagating clocks. It is particularly
> useful when hardware dynamicly changes clock frequencies.
> 
> To be able to model such MIPS hardware, we need to refactor
> the MIPS hardware code to handle clocks.
> 
> This series is organized as follow:
> 
> - let all CPU have an input clock,
> - MIPS CPU get an input clock
> - when the clock is changed, CP0 timer is updated
> - set correct CPU frequencies to all boards
> - do not allow MIPS CPU without input clock
> 
> I used a MIPSsim test suggested by Thomas. It is also included
> as bonus at the end.
> 
> Possible follow up:
> - QOM'ify the GIC
> - let the GIC handle dynamic clock changes
> 
> Regards,
> 
> Phil.
> 
> Philippe Mathieu-Daudé (16):
>    hw/core/cpu: Let CPU object have a clock source
>    target/mips: Move cpu_mips_get_random() with CP0 helpers
>    target/mips/cp0_timer: Explicit unit in variable name
>    target/mips/cpu: Introduce mips_cpu_properties[]
>    target/mips/cpu: Set default CPU frequency to 200 MHz
>    target/mips: Keep CP0 counter in sync with the CPU frequency
>    hw/mips/r4k: Explicit CPU frequency is 200 MHz
>    hw/mips/fuloong2e: Set CPU frequency to 533 MHz
>    hw/mips/mipssim: Correct CPU frequency
>    hw/mips/jazz: Correct CPU frequencies
>    hw/mips/cps: Expose input clock and connect it to CPU cores
>    hw/mips/boston: Set CPU frequency to 1 GHz
>    hw/mips/malta: Set CPU frequency to 320 MHz
>    hw/mips/cps: Do not allow use without input clock
>    target/mips/cpu: Do not allow system-mode use without input clock
>    tests/acceptance: Test the MIPSsim machine

I'm queuing patches 2 and 3 to mips-next. The others depend
of #1 which has been asked for changes.

Thanks,

Phil.


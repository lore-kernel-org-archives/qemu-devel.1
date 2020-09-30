Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB12AC4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:18:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87FAE206CA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRvI3tRj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87FAE206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZBQ-0000Av-KF
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNZ72-0003CT-03
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:13:28 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42997)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNZ6z-00060k-MT
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:13:27 -0400
Received: by mail-wr1-x441.google.com with SMTP id c18so1114732wrm.9
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 03:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bkD1no1s3oj/8Ok/IL4HGI3X0PbmTkfoEMwBfl3SJ0M=;
 b=lRvI3tRjWr/QtpC0NMw5oT8TKpZXIyjKLxiOduh8ZVSVMmkMEKhZBj/LX1LNEHYFy1
 mBz0RAI+pYylzotbzTlW1JFYXjVAO3zRwb7FZTuhKgI6afh+PN0n9Kn+UlMpFZXB1/uh
 c9bHPFV+Kx+VDouF7RkHxw4hPxXSunrYM/H5m3lQruLYd96SMQk/KZ37Ey+A2sZELUOo
 4UGr4TP6JnYPFc3Lypj65xXW+xjmMXWj77F/6yMwj7hsmEq6GeTUZsADVYEfXbB4L82G
 YKRrRytHLunz6B2uVYtFM7x1Visqr7MmxjntcIhK2N75ZO4MX1oJIF4ha+h1gHS0Gq/k
 D11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bkD1no1s3oj/8Ok/IL4HGI3X0PbmTkfoEMwBfl3SJ0M=;
 b=NPzZ3GmSjsKIITqkeiRhZ852xAkdfnYLhh4F/0sJlQVybrT5IntS090cwNZzDX5Id/
 agGtYx3v6IairkNcJaxG8KkHHfZqXqnh32Al1F4g8bs0ELIp54NaFdxFr/fXFMiSqMjw
 wIEpUncdAgXGeLB1y+7Wf22l4j1h9OwAQGiE+DJdWz9yPIK02RZGwGax1eBEe8b5exAs
 hoOigzpv8NcoIXFX/XTAo6osjX/oUYj0ZnyAuibVp9K9lj+oSitfBdDLwT0TMsKm/s3q
 zK6YL6zj7d0roHoPy7bm0Npkhq4AaWhwhRGYLL6cXcIru/d86acKFqwLpGGzdQSHuWiX
 pndQ==
X-Gm-Message-State: AOAM531vhA2wWfEyTlwJj0iI2E21v7F+cbvR9iyDwCgGIRoQ8shgoUmw
 LwK1b4BNTK7MCA+USwQuJa8=
X-Google-Smtp-Source: ABdhPJxiTjYGzEAhI96Bsfyum8YgMJvar9mTF1ddady08E41L6WCOlEW+gKRCSPDTXDsOI5A+QKoTg==
X-Received: by 2002:a5d:5307:: with SMTP id e7mr2230255wrv.215.1601460802815; 
 Wed, 30 Sep 2020 03:13:22 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id 70sm1964417wmb.41.2020.09.30.03.13.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 03:13:22 -0700 (PDT)
Subject: Re: [PATCH 00/16] hw/mips: Set CPU frequency
To: Igor Mammedov <imammedo@redhat.com>
References: <20200928171539.788309-1-f4bug@amsat.org>
 <20200930094048.739faff1@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <acb5fe5c-85ee-b124-96e9-98fc1996f443@amsat.org>
Date: Wed, 30 Sep 2020 12:13:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200930094048.739faff1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 9:40 AM, Igor Mammedov wrote:
> On Mon, 28 Sep 2020 19:15:23 +0200
> Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
> 
>> All the MIPS cores emulated by QEMU provides the Coproc#0
>> 'Count' register which can be used as a free running timer.
>>
>> Since it's introduction in 2005 this timer uses a fixed
>> frequency of 100 MHz (for a CPU freq of 200 MHz).
>> While this is not an issue with Linux guests, it makes
>> some firmwares behave incorrectly.
>>
>> The Clock API allow propagating clocks. It is particularly
>> useful when hardware dynamicly changes clock frequencies.
>>
>> To be able to model such MIPS hardware, we need to refactor
>> the MIPS hardware code to handle clocks.
>>
>> This series is organized as follow:
>>
>> - let all CPU have an input clock,
>> - MIPS CPU get an input clock
>> - when the clock is changed, CP0 timer is updated
>> - set correct CPU frequencies to all boards
>> - do not allow MIPS CPU without input clock
> 
> is this clock an integral part of MIPS cpus or it's an external device?

CPU cores are clocked via an external clock.
This clock can be on the board (from a crystal oscillator to
complex PLL) or on-chip for some system-on-chip.

In all the (current) QEMU MIPS machines it is external although.

Regards,

Phil.


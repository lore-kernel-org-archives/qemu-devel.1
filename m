Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E77C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3049D2074B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3VKt83B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3049D2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNGpN-00056Z-08
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 10:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNGnv-0004UT-D1
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 10:40:31 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34043)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNGnt-0001rr-Ku
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 10:40:31 -0400
Received: by mail-wr1-x443.google.com with SMTP id t10so5718774wrv.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 07:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tFD8QIhVLL4N2C4xaQPmVjay5jPu/SATrPbVDF6/thQ=;
 b=K3VKt83BGJuh1nJrWrmKyY+T1qkpaB45rFd5wDnlJsBKEIhNR+OG9DrbDuCrAeRaJm
 zUO909a3AS7pSWLT4YqhkXqeJrM8L6KJvE4F/fX/93zKannQ9ewoGm6nbDibm+ukj4oX
 HUJRWs+EaeY+yOm3gJqbSyv9rbAwFB1H5UBz4nOidtmZywFuWj5XP5BhTZmdVBo+pUhf
 ZGJG6WvD5o5jFqhSB3qkmaWHNubAaLh+nrHg/Wh9IyUNzE3jJJrdRHipIuRPsLFLZg7W
 JTMarJ14RWFfv6GrTX4TJSJJ9iqw1TjfOdpquw33ZbpwH5mq6qwb2wdj0geyhXxL8wUb
 b6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tFD8QIhVLL4N2C4xaQPmVjay5jPu/SATrPbVDF6/thQ=;
 b=lBC4CKAYtunfyp5C/enzqfFYPBrWPSC148jse/yTlYcRHZB3Z14cq9wcyTr4TjO5rt
 qtQw9r9TtMB8i4ioDth2V5I17Rjh+W8Uj1dlpatvtJBUKhEskUFMjaIyh5JzsHa2WKJU
 bL8eHxUz0MR4WzhgUT4XBkCGqzTCqrUW5FG+jzrINJL4QIEYpEwzcahuQirVMrvtZApi
 Ie60cYbzjgIvvBdZbUcRY0o7Ko4Urb5EBw6Skf+WH3+7xHKgfIdS8oBv+PKLaqlkvSeN
 skjG0iIic1+fzRHOFY5RFTVv0cCQP+ipzZJBB4ls53lh++1TyAg4RYYFfHxZBaGS2rBE
 Kdcg==
X-Gm-Message-State: AOAM5305J6EP+f4KTQWLiFmJt9GE2FSBGIkECOPvnQbBmM5LTC/DjJMD
 jYrGr00wkem1w5EQLJiyfe0=
X-Google-Smtp-Source: ABdhPJw9sOPMXVL0gQq5dLGAtu1pJN6xGs0j5hMP44k3O8OueXfJcoXJCRVoHwQmlxAc4S5+dc/CVA==
X-Received: by 2002:adf:e7c4:: with SMTP id e4mr4648846wrn.113.1601390427337; 
 Tue, 29 Sep 2020 07:40:27 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id c16sm6745887wrx.31.2020.09.29.07.40.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 07:40:26 -0700 (PDT)
Subject: Re: [PATCH 15/16] target/mips/cpu: Do not allow system-mode use
 without input clock
To: Igor Mammedov <imammedo@redhat.com>
References: <20200928171539.788309-1-f4bug@amsat.org>
 <20200928171539.788309-16-f4bug@amsat.org>
 <20200929150154.04f77949@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <35db3210-8165-6fe8-c835-22970fb31c93@amsat.org>
Date: Tue, 29 Sep 2020 16:40:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200929150154.04f77949@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/29/20 3:01 PM, Igor Mammedov wrote:
> On Mon, 28 Sep 2020 19:15:38 +0200
> Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
> 
>> Now than all QOM users provides the input clock, do not allow
>> using a CPU core without its input clock connected on system-mode
>> emulation. For user-mode, keep providing a fixed 200 MHz clock,
>> as it used by the RDHWR instruction (see commit cdfcad788394).
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> Cc: Igor Mammedov <imammedo@redhat.com>
>>
>> We need the qtest check for tests/qtest/machine-none-test.c
>> which instanciate a CPU with the none machine. Igor, is it
>> better to remove the MIPS targets from the test cpus_map[]?
> 
> I don't get idea, could you rephrase/elaborate?

cpu_class_init sets:

    /*
     * Reason: CPUs still need special care by board code: wiring up
     * IRQs, adding reset handlers, halting non-first CPUs, ...
     */
    dc->user_creatable = false;

but the CPUs are created via another path in vl.c:

        current_machine->cpu_type = parse_cpu_option(cpu_option);

The machine-none-test assumes CPU objects are user-creatable.

With this patch I enforce MIPS CPU to have an input clock
connected, so they are not user-creatable anymore.

I tried this code ...:

--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -229,7 +229,11 @@ static const TypeInfo mips_cpu_type_info = {
 static void mips_cpu_cpudef_class_init(ObjectClass *oc, void *data)
 {
     MIPSCPUClass *mcc = MIPS_CPU_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
     mcc->cpu_def = data;
+    /* Reason: clock need to be wired up */
+    dc->user_creatable = false;
 }

... but it is ignored, the CPU can still be created.

Not sure how to handle this.

> 
>> ---
>>  target/mips/cpu.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
>> index 2f75216c324..cc4ee75af30 100644
>> --- a/target/mips/cpu.c
>> +++ b/target/mips/cpu.c
>> @@ -25,6 +25,7 @@
>>  #include "kvm_mips.h"
>>  #include "qemu/module.h"
>>  #include "sysemu/kvm.h"
>> +#include "sysemu/qtest.h"
>>  #include "exec/exec-all.h"
>>  #include "hw/qdev-clock.h"
>>  #include "hw/qdev-properties.h"
>> @@ -159,11 +160,18 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
>>      Error *local_err = NULL;
>>  
>>      if (!clock_get(cs->clock)) {
>> +#ifdef CONFIG_USER_ONLY
>>          /*
>>           * Initialize the frequency to 200MHz in case
>>           * the clock remains unconnected.
>>           */
>>          clock_set_hz(cs->clock, 200000000);
>> +#else
>> +        if (!qtest_enabled()) {
>> +            error_setg(errp, "CPU clock must be connected to a clock source");
>> +            return;
>> +        }
>> +#endif
>>      }
>>      mips_cpu_clk_update(cs);
>>  
> 


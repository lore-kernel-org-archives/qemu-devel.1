Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36E7C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 16:56:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A90BB20722
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 16:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o17p05i6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A90BB20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2dlA-0000DL-Vk
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 12:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k2dkY-00082p-51; Mon, 03 Aug 2020 12:55:46 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33358)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k2dkW-0000YP-5V; Mon, 03 Aug 2020 12:55:45 -0400
Received: by mail-wr1-x443.google.com with SMTP id f18so34880235wrs.0;
 Mon, 03 Aug 2020 09:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OdU3OIPc/dC2w8YYahqTvKhi6bDWVIDrEhuH8xNTago=;
 b=o17p05i6RbpQZsILA7t7zJZh1ijEj+4rgUefAFUGirVxpWQk0mBJhzP8BDGg3pmCQv
 U0vmhCkqv1cFPaZmV+g1LoM8gdGpwvXM7VjyeXN8SZzFrn70ZiE+uWYfDplk7gCd2zZp
 luPOLJLZ6vSELd6XRLrTg41pdQe7cySOdk5ZWGsuDOG2LbtcVLTHhhkZY+My2PAOr29P
 A+zXlM2UC07J9+rg2DQRX0FxZq/paVfX67gwQdxjxyTI3abyr+LQ+moWaFjlyB0cXF+B
 4Q7Gj94uq4/iVHvYrTK3dgGNpTelbWxIFh69hJN8bfUy7Jg2KcbHMrEma2w494IS9GuD
 YhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OdU3OIPc/dC2w8YYahqTvKhi6bDWVIDrEhuH8xNTago=;
 b=P5azHF4740B1sP38ZDdzSBkMb/r39n8gI6Q2xrFpvcVCCYYQvBQT0sJfufp0Mmpohd
 roXsJz21E0K4yusos4Q8eFEZHnPQGx3ZgYntZ1dtlc0A8WiDWNnlRdI60Ej6oEWOIOcC
 RKj+2NNGgWx8uADI8aih3dzEXIMmmFuU5IREIouZiOSa1Zjh14zjM/kVp4GU5ix3898j
 /+ULG3hVnr1Aa4udQH7K+KfYjx09jiGPvODr3C3rraQ8ITwiJz6WNbQ7gXEpECDAe5A7
 /2s//O/ItzMh3hsm45Ua+ZK/Mq4B1wyZHOc56P9T71N+gq/PW7ODwZj2HJ1GMaB1b6lm
 mm/w==
X-Gm-Message-State: AOAM531SMWegj+HX3kXBY1vK8dm5SVhEHvXbV0jOL4I8SjJPvePNfDDV
 +uhMTEphP3nHRV8ej9VBsBc=
X-Google-Smtp-Source: ABdhPJzlSpQU+LhdaiD3jYPY5g+skO4rjhiGuCwcUcCqn4ByIfUSs0BK/zPDdTs+Xaya3ghBIyJVhA==
X-Received: by 2002:adf:82f6:: with SMTP id 109mr17395503wrc.25.1596473742077; 
 Mon, 03 Aug 2020 09:55:42 -0700 (PDT)
Received: from [192.168.1.43] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id p6sm327446wmg.0.2020.08.03.09.55.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2020 09:55:41 -0700 (PDT)
Subject: Re: [PATCH-for-5.2] default-configs: Remove ACPI_CPU_HOTPLUG from
 MIPS machines
To: Igor Mammedov <imammedo@redhat.com>
References: <20200724165259.19939-1-f4bug@amsat.org>
 <20200730133441.39257618@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b93b9ca8-eb7a-4d9e-87c2-6d9d61872639@amsat.org>
Date: Mon, 3 Aug 2020 18:55:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200730133441.39257618@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/30/20 1:34 PM, Igor Mammedov wrote:
> On Fri, 24 Jul 2020 18:52:59 +0200
> Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
> 
>> No MIPS machine uses the ACPI cpu-hotplug feature
>> (QEMU implementation is X86 specific).
> 
> if I recall correctly we were building it to satisfy symbol dependencies
> due to hw/acpi/piix4.c being shared between x86 and mips.
> 
> It no longer the case?

Unfortunately you are right, it is still the case :(

> 
> 
>> Fixes: 135a67a692 ("ACPI: split CONFIG_ACPI into 4 pieces")
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  default-configs/mips-softmmu-common.mak | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
>> index da29c6c0b2..e9c208da3d 100644
>> --- a/default-configs/mips-softmmu-common.mak
>> +++ b/default-configs/mips-softmmu-common.mak
>> @@ -21,7 +21,6 @@ CONFIG_ACPI=y
>>  CONFIG_ACPI_X86=y
>>  CONFIG_ACPI_MEMORY_HOTPLUG=y
>>  CONFIG_ACPI_NVDIMM=y
>> -CONFIG_ACPI_CPU_HOTPLUG=y
>>  CONFIG_APM=y
>>  CONFIG_I8257=y
>>  CONFIG_PIIX4=y
> 
> 


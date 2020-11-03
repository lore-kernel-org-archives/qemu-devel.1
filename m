Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89382C388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 07:05:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 044FC22277
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 07:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3FzQuHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044FC22277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZqNg-0008OM-Uz
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 02:05:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZqMs-0007xH-Eg
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 02:04:34 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55161)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZqMq-0002Tk-QE
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 02:04:34 -0500
Received: by mail-wm1-x344.google.com with SMTP id d142so2977171wmd.4
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 23:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qnVu6sKNwgi1H/SmUalCnj5Ha9defTSQ6cGC6p4hRDc=;
 b=G3FzQuHd8u7Io4sfIQ+XnwpWe/namflOwkFEYp32GVQ96XwFZ7smqQqIOQHrsMk5zz
 +2XWlNJ+Hyl/afTncisEAmspOuN1+wy1RwTQ05e78JXylH4eqcdIW97TzBj/xyRUK0Ts
 LBhCQfFOPvG16bmFuNOHgpKX3sU115QYFFm6pWtXxVFy2JMTrRRGFjz3v7w1yLLn9YdR
 Mzy3+calP/b6tLA80YldA/Wc5FsTf1sCT7yu80pu+KFMY37N7ozOauD5TWyexsT332dj
 B7BJ/CmOgko707dFn+6z778InjVsZkSPaEC1ltuE9g+euB4Dg3FFlEhm4glWK9ficO1r
 VVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qnVu6sKNwgi1H/SmUalCnj5Ha9defTSQ6cGC6p4hRDc=;
 b=Wp+ccYsnPmEE4P8isGvdJMwIWybVMD2otrW6bVXDSzyA9IWl8GAsoVtobX8HvVWFGG
 FnxS9zcJtYhJOvQgY9O7lFYUGwUhJrN/4E/ywYEN7kIhB6KSC+cTlN4+WXdQfmf8xtRg
 cFJfaEhXfa35AJvqW0GiYZOCVM+54WA5GMGfqkW+TN1sgGRqGEnC88cg1S6Hs44Lweh5
 zS0fj0iH6boZiuYlKbkQeRhNRHX1+o4vmTdT5mhKXnrQj7/5sn3oMYN8flYK1Dbf3/7L
 QPcm3+CNib7bh3yU/g+9N40sVwQvlI4/8mKXu4Q7oeVoZlyeW43G9YkOgCxuKBsyAV7I
 YVAg==
X-Gm-Message-State: AOAM531qRD3IXFro7U4f2nDGzbJH9l7JOarTBkyOXSF/Q02LkNFCVMHI
 nBW8szLdfF1dMfr1g+/nT6Y=
X-Google-Smtp-Source: ABdhPJxpSjQvdimwiOEOTsJjnfV1G2JgQM44LHwaRVKtDkFStxHqLmnPbOzd+1/NzRzCHTZQzAOEYg==
X-Received: by 2002:a7b:c384:: with SMTP id s4mr1898828wmj.77.1604387071086;
 Mon, 02 Nov 2020 23:04:31 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id v8sm1933878wmg.28.2020.11.02.23.04.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 23:04:30 -0800 (PST)
Subject: Re: [PATCH-for-5.2 v3] hw/mips: Remove the 'r4k' machine
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20201102201311.2220005-1-f4bug@amsat.org>
 <b79011dc-db5f-ec86-96f6-852a9d32bed7@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3ae591f9-7a41-6887-e8ac-8490d0560a57@amsat.org>
Date: Tue, 3 Nov 2020 08:04:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <b79011dc-db5f-ec86-96f6-852a9d32bed7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
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
Cc: libvir-list@redhat.com, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/3/20 7:58 AM, Thomas Huth wrote:
> On 02/11/2020 21.13, Philippe Mathieu-Daudé wrote:
>> We deprecated the support for the 'r4k' machine for the 5.0 release
>> (commit d32dc61421), which means that our deprecation policy allows
>> us to drop it in release 5.2. Remove the code.
>>
>> To repeat the rationale from the deprecation note:
>> - this virtual machine has no specification
>> - the Linux kernel dropped support for it 10 years ago
>>
>> Users are recommended to use the Malta board instead.
>>
>> Acked-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> v3: Move to "Recently removed features" section
>> ---
>>  docs/system/deprecated.rst                    |  12 +-
>>  .../devices/mips-softmmu-common.mak           |   1 -
>>  hw/mips/r4k.c                                 | 318 ------------------
>>  MAINTAINERS                                   |   6 -
>>  hw/mips/Kconfig                               |  13 -
>>  hw/mips/meson.build                           |   1 -
>>  6 files changed, 6 insertions(+), 345 deletions(-)
>>  delete mode 100644 hw/mips/r4k.c
>>
>> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
>> index 0ebce37a191..e5b7cf274d3 100644
>> --- a/docs/system/deprecated.rst
>> +++ b/docs/system/deprecated.rst
>> @@ -327,12 +327,6 @@ The 'scsi-disk' device is deprecated. Users should use 'scsi-hd' or
>>  System emulator machines
>>  ------------------------
>>  
>> -mips ``r4k`` platform (since 5.0)
>> -'''''''''''''''''''''''''''''''''
>> -
>> -This machine type is very old and unmaintained. Users should use the ``malta``
>> -machine type instead.
>> -
>>  mips ``fulong2e`` machine (since 5.1)
>>  '''''''''''''''''''''''''''''''''''''
>>  
>> @@ -575,6 +569,12 @@ The version specific Spike machines have been removed in favour of the
>>  generic ``spike`` machine. If you need to specify an older version of the RISC-V
>>  spec you can use the ``-cpu rv64gcsu,priv_spec=v1.10.0`` command line argument.
>>  
>> +mips ``r4k`` platform (removed in 5.2)
>> +''''''''''''''''''''''''''''''''''''''
>> +
>> +This machine type is very old and unmaintained. Users should use the ``malta``
>> +machine type instead.
> 
> Ah, just spotted this v3 - that's better now indeed :-)
> Maybe change "is very old" into "was very old"?

OK.

> 
> Anyway:
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks!


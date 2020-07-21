Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C1DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:30:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE93C2080D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QALqcWfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE93C2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxrPH-0005jI-3b
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 08:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxrOk-0005Kb-BA
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:29:30 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33178)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxrOi-00034I-MI
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:29:30 -0400
Received: by mail-wm1-x341.google.com with SMTP id a6so2107722wmm.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 05:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3a+AsUJK5XwKootfnSt6zrOLEOIC8E4QPfTI2oEOfhk=;
 b=QALqcWfYR4P74hKmM5kU+HOR6DL8pCk1rbDNcN7nK2W4wKgsIUpNAzh+CpaJ8Lw8TT
 fhMGe861M4H9GafFgmaK4oWEayyOU29sYeLfi7hYW7kCB1fqgo9L2IXd6WVN9BuQKfyw
 rhLVoUCrQwb97gsOzJHTa2f5SpWJlW3TbiGZgMBSnYX6hgR+uZfV+msseYUv4fDUOI5P
 2pwAluhUCShAcP8fc+jgsOqanaT9Hnt3fwwQVsinKBH6U8Wi/g43Z2VaB5u3/jvQjFPG
 IuKMoJ10Zjqs6hJAZGgEHfcxlcGEhjrn2Rp02thHsFtEUwlaX1q5OwW1DnbkJJysjIY3
 Rufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3a+AsUJK5XwKootfnSt6zrOLEOIC8E4QPfTI2oEOfhk=;
 b=OBGmv8BHCZUXS77spGZPY1gRY9GZwV3Krg0T8nMPfSAlY7HMAy3Hcp1CfMgra22dmJ
 ncdx1hxhWrHVW3kVcNr0+VkFg/Z5OToyOUkat9xfBZ2e5pLCy5IfQud87E6Q5OMGLvD9
 HWyRWtVXrPjCe8E0o3bdcol9lKUlUWeHu/u8cXENrk4Vy5vEB+Xi9OxNCCSOGlWn1Kez
 7mYc0QeDP9oH6C/kFONtAAvjgijUaGv/W9v5t6ZW+BYNKcNcMA7DXOWava5SoHmIizlU
 jRdAs+1ixlBX3oXD4HXFYnC1l/YSc74mDLxSTUfSQ/sfCRv+JKrURAEwEctTfIFYQTN0
 t+GQ==
X-Gm-Message-State: AOAM533E5P+hhs05kJejZYMZMo7FsaT7hJGWB9jS/ULPJLV9zeGCTHHU
 A/jYwSoz9Lc06aiyWtXhRO8=
X-Google-Smtp-Source: ABdhPJwSxeiQPLkiP0VFuUw668LpRUBlzC9PfQD2cLnPdGu7B3QhxwGrMlT6P9gsF2W/m03nurG92g==
X-Received: by 2002:a1c:286:: with SMTP id 128mr3242705wmc.37.1595334566541;
 Tue, 21 Jul 2020 05:29:26 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id b23sm3502011wmd.37.2020.07.21.05.29.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2020 05:29:25 -0700 (PDT)
Subject: Re: [RFC PATCH-not-for-5.1? v2] hw/isa/isa-bus: Ensure ISA I/O
 regions are 8/16-bit accessible
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
References: <20200720185758.21280-1-f4bug@amsat.org>
 <d4fbf384-91cd-2820-abd8-157f9849ef53@msgid.tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c4388215-aee7-f609-9f19-8e2a66675971@amsat.org>
Date: Tue, 21 Jul 2020 14:29:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d4fbf384-91cd-2820-abd8-157f9849ef53@msgid.tls.msk.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/20/20 9:45 PM, Michael Tokarev wrote:
> 20.07.2020 21:57, Philippe Mathieu-Daudé пишет:
>> Since commit 5d971f9e67 we don't accept mismatching sizes
>> in memory_region_access_valid(). This gives troubles when
>> a device is on an ISA bus, because the CPU is free to use
>> 8/16-bit accesses on the bus (or up to 32-bit on EISA bus),
>> regardless what range is valid for the device.
>>
>> Add a check to ensure devices plugged on the ISA bus can
>> accept 8/16-bits accesses.
>>
>> Related bug reports:
>>
>> - https://lore.kernel.org/xen-devel/20200630170913.123646-1-anthony.perard@citrix.com/T/
>> - https://bugs.debian.org/964793
>> - https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=964247
>> - https://bugs.launchpad.net/bugs/1886318
> 
> Here's the output (of a similar patch), after I fixed the 3 acpi core
> devies, of one of my windows7 test VMs. I guess we need to fix either
> these devices or the registration, before 5.1 is out, or else more
> difficult-to-catch breakage like the above will pop up..
> 
> For now we don't have any released qemu version with this situation
> so not many project enabled workarounds for broken qemu behavour
> like the xen-devel link above.
> 
> qemu-system-x86_64: ISA device 'kvm-i8259' requires I/O max_access_size of 2
> qemu-system-x86_64: ISA device 'kvm-i8259' requires I/O max_access_size of 2
> qemu-system-x86_64: ISA device 'kvm-i8259' requires I/O max_access_size of 2
> qemu-system-x86_64: ISA device 'kvm-i8259' requires I/O max_access_size of 2
> qemu-system-x86_64: ISA device 'mc146818rtc' requires I/O max_access_size of 2
> qemu-system-x86_64: ISA device 'kvm-pit' requires I/O max_access_size of 2
> qemu-system-x86_64: ISA device 'isa-pcspk' requires I/O max_access_size of 2
> qemu-system-x86_64: ISA device 'isa-serial' requires I/O max_access_size of 2
> qemu-system-x86_64: ISA device 'i8042' requires I/O max_access_size of 2
> qemu-system-x86_64: ISA device 'i8042' requires I/O max_access_size of 2
> qemu-system-x86_64: ISA device 'vmport' requires I/O max_access_size of 2
> qemu-system-x86_64: ISA device 'port92' requires I/O max_access_size of 2

This is better to find the full list:

$ git grep -l isa_register_ioport
hw/audio/cs4231a.c
hw/audio/pcspk.c
hw/char/serial-isa.c
hw/i386/port92.c
hw/i386/vmport.c
hw/input/pckbd.c
hw/intc/i8259_common.c
hw/ipmi/isa_ipmi_bt.c
hw/ipmi/isa_ipmi_kcs.c
hw/isa/isa-bus.c
hw/isa/pc87312.c
hw/misc/applesmc.c
hw/misc/pvpanic.c
hw/net/ne2000-isa.c
hw/rtc/m48t59-isa.c
hw/rtc/mc146818rtc.c
hw/timer/i8254_common.c
include/hw/isa/isa.h

> 
> Thanks,
> 
> /mjt


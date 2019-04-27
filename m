Return-Path: <SRS0=rME2=S5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB27DC43219
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 17:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCDE920693
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 17:08:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCDE920693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34411 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKQo9-0005d2-U0
	for qemu-devel@archiver.kernel.org; Sat, 27 Apr 2019 13:08:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKQnI-0005Jb-3n
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 13:07:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKQnH-0007e9-9D
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 13:07:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hKQnH-0007cg-3O
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 13:07:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id o25so7842035wmf.5
	for <qemu-devel@nongnu.org>; Sat, 27 Apr 2019 10:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=iGmtoyxMHLuwslYHVpb39PUOrrd3V8HNAQo++8Pe3yk=;
	b=BFuHc7LSCmMDQhQeXuktywpLQMZXwnHAwHeZzvQ0meJKQ1VPCgOzFLoJA9x8XsXOA2
	dzfuhmmSSf+QhjgOmKB3SerLu0MKxlrT7tsQTrltIX0j5HMaoU/qWlrXcPHVWuWMmYno
	+3+Jn4ge3XXZ3LJbPD6YcgwKLKy4+FDxwML6tUy/vdN+c/+ZE3wS1qoX6RUZzNZ9ZItU
	cklAgs92fgWxZvFv7RG8Trv/r3zF7s3S/VyfwOeVWAR/rPBVUYzdAZkxulUUNXQPHlIl
	XDbwELeiHm20PjCIAJcoRH8YnxFLND8Wg1L/gvmi+p5yKo5EJsxuA9onmMPHUhhgOWD6
	76MQ==
X-Gm-Message-State: APjAAAXesL+HpHNa4GB8YL5ZJJrza4NLWEK7iGROodtCEkQS3L/1nN7C
	asqyo5OMTYsTnAteKBvUf1l5YQ==
X-Google-Smtp-Source: APXvYqzvT0/Sc7LKfHRI/0Z7rapH6cgCQ1RDhluDw/hLnTIENWSPdMZkdPHx+whyrPTdCIEpp8wRnQ==
X-Received: by 2002:a1c:7d92:: with SMTP id y140mr11706477wmc.54.1556384837823;
	Sat, 27 Apr 2019 10:07:17 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	s9sm12215346wrm.22.2019.04.27.10.07.16
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Sat, 27 Apr 2019 10:07:17 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190427141905.20393-1-philmd@redhat.com>
	<2f8710be-0005-a8dc-ac28-c572e55f2d20@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6a887505-c8f1-8bdf-fd6a-ec87a60841c2@redhat.com>
Date: Sat, 27 Apr 2019 19:07:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2f8710be-0005-a8dc-ac28-c572e55f2d20@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH] hw/i386: The i440fx is not a machine,
 remove it from the machine list
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190427170716.PSrjSDcXcaED0jLfv_vjbWtMxX2Zff5sR1h_VV6io8c@z>

On 4/27/19 4:49 PM, Thomas Huth wrote:
> On 27/04/2019 16.19, Philippe Mathieu-Daudé wrote:
>> When building with CONFIG_ISAPC=n and CONFIG_I440FX=y we get:
>>
>>   $ make subdir-x86_64-softmmu
>>   [...]
>>   /usr/bin/ld: hw/i386/pc_piix.o: in function `pc_init1':
>>   /source/qemu/hw/i386/pc_piix.c:261: undefined reference to `isa_ide_init'
>>   /usr/bin/ld: /source/qemu/hw/i386/pc_piix.c:261: undefined reference to `isa_ide_init'
>>   collect2: error: ld returned 1 exit status
>>   make[1]: *** [Makefile:204: qemu-system-x86_64] Error 1
>>
>> This is because the I440FX device is a North Bridge, not a machine.
> 
> Really? I thought CONFIG_I440FX was there to configure the
> "pc-i440fx-x.y" machine types?

Ah, I just found in hw/i386/pc_piix.c:

    if (pcmc->pci_enabled) {
        pci_bus = i440fx_init(host_type,
                              pci_type,
                              &i440fx_state, &piix3_devfn,
                              &isa_bus, pcms->gsi,
                              system_memory, system_io,
                              machine->ram_size,
                              pcms->below_4g_mem_size,
                              pcms->above_4g_mem_size,
                              pci_memory, ram_memory);
        pcms->bus = pci_bus;
    } else {
        pci_bus = NULL;
        i440fx_state = NULL;
        isa_bus = isa_bus_new(NULL, get_system_memory(), system_io,
                              &error_abort);
        no_hpet = 1;
    }

So I guess I'll have to figure it out from here ;)

Thanks,

Phil.


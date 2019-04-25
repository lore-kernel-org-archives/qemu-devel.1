Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D236CC28E99
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:20:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E74206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E74206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57037 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJeIl-0002HH-Bj
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:20:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJeHi-0001mS-3Y
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:19:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJeHh-0001wU-0V
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:19:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJeHg-0001vm-QB
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:19:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id o25so9237032wmf.5
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=o6G3SSPdCjH99oZB80vEaOpCCos0mBuC1H9vt+CMlQI=;
	b=m0OP2jMcd3CoaDtVlcOtXWLUpkWqETrGm0biG5BfKTWJfEFPwffgr2ciGBRhpDdLqg
	x+/uZ2SkUbzyUQ7HXlPHfh3Tta/tGAlDx93rG3mlUeRh7AEyhxVcw4MhnxGPhwq/10wI
	djcaDWYdze/1CkOU9smwPcVWrFT80oBwSnWEpNcnkVFLzTMpz7KjPZD/JBsm9PuewNzR
	wzlcXJgjJxz+b7IqKFH4/xbJMjZYxTY4OunKdKAdgh/7CJy0s07yizTa5jwYFyNYTNMf
	pKXhBwN+bb6z3vs7ojtbHvsT4obIJqFwRu8cUizMwP9/rR4AxNEU+AQrYqEwhnvL9iRO
	O8oA==
X-Gm-Message-State: APjAAAXhOqEuHnvOI/1GOnGS3oqFQmUtdDi2p2cni3CTqGGvJRtOr/wb
	3FROR+3hvZbK0FF6GQAQNo3JIg==
X-Google-Smtp-Source: APXvYqyDXoM4G61PfFANpv2CmPQMu3zbGNjt2PPnZWmUhLNr5YRgzHPpLXOPO5FIqfnunarJbUm/Ew==
X-Received: by 2002:a1c:2ed7:: with SMTP id u206mr3444913wmu.5.1556198366310; 
	Thu, 25 Apr 2019 06:19:26 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122]) by smtp.gmail.com with ESMTPSA id
	17sm17044344wrk.91.2019.04.25.06.19.24
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 06:19:25 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	pbonzini@redhat.com
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-3-thuth@redhat.com>
	<9f1355f2-3508-3f0a-512b-8b97fbda9ae1@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ca065ba9-45b4-2272-538b-67ad0b6df3a3@redhat.com>
Date: Thu, 25 Apr 2019 15:19:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9f1355f2-3508-3f0a-512b-8b97fbda9ae1@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 02/29] hw/ide/ahci: Add a
 Kconfig switch for the AHDI-ICH9 device
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
Cc: Rob Herring <robh@kernel.org>, Jan Kiszka <jan.kiszka@web.de>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-block@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Alistair Francis <alistair@alistair23.me>,
	Philippe Mathieu-Daude <f4bug@amsat.org>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Beniamino Galvani <b.galvani@gmail.com>, Andrew Jeffery <andrew@aj.id.au>,
	Cedric Le Goater <clg@kaod.org>, qemu-arm@nongnu.org,
	Peter Chubb <peter.chubb@nicta.com.au>, Gerd Hoffmann <kraxel@redhat.com>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>,
	John Snow <jsnow@redhat.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425131923.TRdXu366KHfbJ7uxtWaSKjrajzVyn5bp7UtB8iYUb4g@z>

On 4/20/19 12:31 PM, Philippe Mathieu-Daudé wrote:
> On 4/18/19 8:00 PM, Thomas Huth wrote:
>> Some of our machines (like the ARM cubieboard) use CONFIG_AHCI for an AHCI
>> sysbus device, but do not use CONFIG_PCI since they do not feature a PCI
>> bus. With CONFIG_AHCI but without CONFIG_PCI, currently linking fails:
>>
>>     ../hw/ide/ich.o: In function `pci_ich9_ahci_realize':
>>     hw/ide/ich.c:124: undefined reference to `pci_allocate_irq'
>>     hw/ide/ich.c:126: undefined reference to `pci_register_bar'
>>     hw/ide/ich.c:128: undefined reference to `pci_register_bar'
>>     hw/ide/ich.c:131: undefined reference to `pci_add_capability'
>>     hw/ide/ich.c:147: undefined reference to `msi_init'
>>     ../hw/ide/ich.o: In function `pci_ich9_uninit':
>>     hw/ide/ich.c:158: undefined reference to `msi_uninit'
>>     ../hw/ide/ich.o:(.data.rel+0x50): undefined reference to `vmstate_pci_device'
>>
>> We must only compile ich.c if CONFIG_PCI is available, too, so introduce a
>> new config switch for this device.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Oops, "AHCI" in patch subject (D -> C).


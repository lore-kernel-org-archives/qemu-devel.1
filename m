Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10011C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 10:06:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAFC92133F
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 10:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAFC92133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyZ8M-0000XQ-15
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 06:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1hyZ7a-0008Ap-1H
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 06:06:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hyZ7Y-0003CD-F9
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 06:06:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43729)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hyZ7Y-0003BH-8P
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 06:06:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id y8so995133wrn.10
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 03:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4nmllPcEhYaEJs68tgHuQ5qqmn++ZDafoOXvJZcokHk=;
 b=O+BrIonn3k3Q7UVx/JxfQdiqn9hpFNJMZqZfz6WG1e7gxh2HptNqvvlcW0OwhfTbNr
 bIXw3uDJfp8BNlumnGe1fsU5LRrU8yi3MO1aFnDFF0fgVSLyJSQdCQw2MspQejyFIcZi
 rvqZ4EKJyQA6tqVlsrKXUh+u8KxVUDZAlp6c6ztzBSWKcJiNo09F/gECir38yvzkWh3A
 YAbd1/F7UJkXotKGvFb7vLyx3nQ+iG7JBWorR6gViM0zUpsbrPSKOLvxpcpcQG17TRbr
 6J3Z0lrEJQcQ5ToEMC2zDLsl1dC+tRYqkn1L1h30QY0ZWpOIqbG6bnUW83QADalxQLsI
 +xMQ==
X-Gm-Message-State: APjAAAVl0I0he3zR5LZ7mp0IcMpnyW7jiubRsgldE0L3md2JRcq06pG0
 VsZL5X73SSeVbKWR76aNKUwRpA==
X-Google-Smtp-Source: APXvYqz+oIj1oEb5S9Wcb1SdPyATJ1ItG3ZInp8JTtTW+nFG+aYKAl8f6PS/MrJCfAiBLINYgwP9ow==
X-Received: by 2002:adf:dd01:: with SMTP id a1mr9597279wrm.12.1565949967319;
 Fri, 16 Aug 2019 03:06:07 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id u130sm8566224wmg.28.2019.08.16.03.06.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2019 03:06:06 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <43bc5e07ac614d0e8e740bf6007ff77b@tpw09926dag18e.domain1.systemhost.net>
 <1565940916012.8169@bt.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <22d6f51c-c734-3976-2fc1-34c9c74a075e@redhat.com>
Date: Fri, 16 Aug 2019 12:06:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1565940916012.8169@bt.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v7 27/42] hw/pci-host: Declare device
 little or big endian
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
Cc: frederic.konrad@adacore.com, berto@igalia.com, qemu-block@nongnu.org,
 arikalo@wavecomp.com, pasic@linux.ibm.com, hpoussin@reactos.org,
 anthony.perard@citrix.com, xen-devel@lists.xenproject.org, jasowang@redhat.com,
 jiri@resnulli.us, ehabkost@redhat.com, b.galvani@gmail.com,
 eric.auger@redhat.com, alex.williamson@redhat.com, stefanha@redhat.com,
 jsnow@redhat.com, rth@twiddle.net, kwolf@redhat.com, andrew@aj.id.au,
 claudio.fontana@suse.com, crwulff@gmail.com, laurent@vivier.eu,
 sundeep.lkml@gmail.com, michael@walle.cc, qemu-ppc@nongnu.org,
 kbastian@mail.uni-paderborn.de, imammedo@redhat.com, fam@euphon.net,
 peter.maydell@linaro.org, david@redhat.com, palmer@sifive.com,
 keith.busch@intel.com, jcmvbkbc@gmail.com, hare@suse.com,
 sstabellini@kernel.org, andrew.smirnov@gmail.com, deller@gmx.de,
 magnus.damm@gmail.com, atar4qemu@gmail.com, minyard@acm.org, sw@weilnetz.de,
 yuval.shaia@oracle.com, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 jan.kiszka@web.de, clg@kaod.org, shorne@gmail.com, qemu-riscv@nongnu.org,
 i.mitsyanko@gmail.com, cohuck@redhat.com, amarkovic@wavecomp.com,
 peter.chubb@nicta.com.au, aurelien@aurel32.net, pburton@wavecomp.com,
 sagark@eecs.berkeley.edu, green@moxielogic.com, kraxel@redhat.com,
 edgar.iglesias@gmail.com, gxt@mprc.pku.edu.cn, robh@kernel.org,
 borntraeger@de.ibm.com, joel@jms.id.au, antonynpavlov@gmail.com,
 chouteau@adacore.com, lersek@redhat.com, Andrew.Baumann@microsoft.com,
 mreitz@redhat.com, walling@linux.ibm.com, dmitry.fleytman@gmail.com,
 mst@redhat.com, mark.cave-ayland@ilande.co.uk, jslaby@suse.cz, marex@denx.de,
 proljc@gmail.com, marcandre.lureau@redhat.com, alistair@alistair23.me,
 paul.durrant@citrix.com, david@gibson.dropbear.id.au,
 xiaoguangrong.eric@gmail.com, huth@tuxfamily.org, jcd@tribudubois.net,
 pbonzini@redhat.com, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/16/19 9:35 AM, tony.nguyen@bt.com wrote:
> For each device declared with DEVICE_NATIVE_ENDIAN, find the set of
> targets from the set of target/hw/*/device.o.
> 
> If the set of targets are all little or all big endian, re-declare
> the device endianness as DEVICE_LITTLE_ENDIAN or DEVICE_BIG_ENDIAN
> respectively.
> 
> This *naive* deduction may result in genuinely native endian devices
> being incorrectly declared as little or big endian, but should not
> introduce regressions for current targets.
> 
> These devices should be re-declared as DEVICE_NATIVE_ENDIAN if 1) it
> has a new target with an opposite endian or 2) someone informed knows
> better =)
> 
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> ---
>  hw/pci-host/q35.c       | 2 +-
>  hw/pci-host/versatile.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index 0a010be..fd20f72 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -288,7 +288,7 @@ static void tseg_blackhole_write(void *opaque,
> hwaddr addr, uint64_t val,
>  static const MemoryRegionOps tseg_blackhole_ops = {
>      .read = tseg_blackhole_read,
>      .write = tseg_blackhole_write,
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .endianness = DEVICE_LITTLE_ENDIAN,

OK.

>      .valid.min_access_size = 1,
>      .valid.max_access_size = 4,
>      .impl.min_access_size = 4,
> diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
> index 791b321..e7017f3 100644
> --- a/hw/pci-host/versatile.c
> +++ b/hw/pci-host/versatile.c
> @@ -240,7 +240,7 @@ static uint64_t pci_vpb_reg_read(void *opaque,
> hwaddr addr,
>  static const MemoryRegionOps pci_vpb_reg_ops = {
>      .read = pci_vpb_reg_read,
>      .write = pci_vpb_reg_write,
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
>      .valid = {
>          .min_access_size = 4,
>          .max_access_size = 4,
> @@ -306,7 +306,7 @@ static uint64_t pci_vpb_config_read(void *opaque,
> hwaddr addr,
>  static const MemoryRegionOps pci_vpb_config_ops = {
>      .read = pci_vpb_config_read,
>      .write = pci_vpb_config_write,
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .endianness = DEVICE_LITTLE_ENDIAN,

Eh hard to say, PCI is not clear about endianess...

>  };
>  
>  static int pci_vpb_map_irq(PCIDevice *d, int irq_num)
> -- 
> 1.8.3.1
> 
> ​
> 
> 


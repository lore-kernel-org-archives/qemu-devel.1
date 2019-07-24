Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED77C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 14:37:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 771EE2147A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 14:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771EE2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqIOs-0004K0-N2
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 10:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60974)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqIOg-0003vl-Fs
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 10:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqIOf-00010q-5I
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 10:37:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53905)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqIOW-0000uj-A6
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 10:37:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so42071483wmj.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 07:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yLaf5lBCiiBPlylKP5yFhx3hq1CXGj9apo/ZNRVP9iw=;
 b=BhK4Eg2jTliWukkpzO0dhsrz1OmScMKt+uFHvCCC6ftq7eoEQri1lUvcWHh7XG/61Q
 PCOuSWlFnhNp5M+7AFe25YpekI75vCarsWo+8FUbVaO+kvMUVSj5ditQGtRMedhUuzfB
 LRCmQXgZOxh9eBmuV1Qtgja6GqmTxHxbGRYRhW/1iB2ug9yz6j6sxxH4P2xli/NGpY+c
 mQv9Q9MjmUEtxtmPh7ipdm7uA3XhC83iwPL/ZFgwrCvUSKvoSfGijmiHJs2KWVb/+LSY
 CviWSKgrUipbHESgRbBSxr8moFafV+ofamk5h0v7+KTHSSYpYVlyPbNPzEHq+3M1J5Sf
 HaNg==
X-Gm-Message-State: APjAAAVtvz7mKZY186sLYuo2s2+Sl2ynbcbiPx59ifuz5cpjymy8gAZG
 1coQuJ1ZT1HWwaAJNEsfNDbB2A==
X-Google-Smtp-Source: APXvYqyAq2PADuogJSvgYchRFM8uVEfvoMvlIbPK36hsnnxOLgp15xDjUg3lG7YtvsNEupqexis1rg==
X-Received: by 2002:a1c:3:: with SMTP id 3mr75618891wma.6.1563979039477;
 Wed, 24 Jul 2019 07:37:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:10f7:67c8:abb4:8512?
 ([2001:b07:6468:f312:10f7:67c8:abb4:8512])
 by smtp.gmail.com with ESMTPSA id f70sm55259475wme.22.2019.07.24.07.37.18
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Jul 2019 07:37:18 -0700 (PDT)
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
References: <20190724143105.307042-1-sgarzare@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8a03b88f-db64-1873-04e0-397aa0fdd78f@redhat.com>
Date: Wed, 24 Jul 2019 16:37:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724143105.307042-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v4 0/3] pc: mmap kernel (ELF image) and
 initrd
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
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julio Montes <julio.montes@intel.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/07/19 16:31, Stefano Garzarella wrote:
> In order to reduce the memory footprint when PVH kernel and initrd
> are used, we map them into memory instead of reading them.
> In this way we can share them between multiple instances of QEMU.
> 
> v4:
>   - Patch 1: fix the rom_add_elf_program() comment [Paolo]
>   - Patch 2:
>     ~ fix the missing of g_mapped_file_unref() in the success case [Paolo]
>     ~ fix the rom_add_elf_program() comment [Paolo]
> 
> v3: https://patchew.org/QEMU/20190724112531.232260-1-sgarzare@redhat.com/
> v2: https://patchew.org/QEMU/20190723140445.12748-1-sgarzare@redhat.com/
> 
> These are the results using a PVH kernel and initrd (cpio):
> - memory footprint (using smem) [MB]
>         QEMU              before                   now
>     # instances        USS      PSS            USS      PSS
>          1           102.0M   105.8M         102.3M   106.2M
>          2            94.6M   101.2M          72.3M    90.1M
>          4            94.1M    98.0M          72.0M    81.5M
>          8            94.0M    96.2M          71.8M    76.9M
>         16            93.9M    95.1M          71.6M    74.3M
> 
>     Initrd size: 3.0M
>     Kernel
>         image size: 28M
>         sections size [size -A -d vmlinux]:  18.9M
> 
> - boot time [ms]
>                           before                   now
>  qemu_init_end:           63.85                   55.91
>  linux_start_kernel:      82.11 (+18.26)          74.51 (+18.60)
>  linux_start_user:       169.94 (+87.83)         159.06 (+84.56)
> 
> QEMU command used:
> ./qemu-system-x86_64 -bios /path/to/seabios/out/bios.bin -no-hpet \
>     -machine q35,accel=kvm,kernel_irqchip,nvdimm,sata=off,smbus=off,vmport=off \
>     -cpu host -m 1G -smp 1 -vga none -display none -no-user-config -nodefaults \
>     -kernel /path/to/vmlinux -initrd /path/to/rootfs.cpio \
>     -append 'root=/dev/mem0 ro console=hvc0 pci=lastbus=0 nosmap'
> 
> Stefano Garzarella (3):
>   loader: Handle memory-mapped ELFs
>   elf-ops.h: Map into memory the ELF to load
>   hw/i386/pc: Map into memory the initrd
> 
>  hw/core/loader.c     | 38 +++++++++++++++++++-----
>  hw/i386/pc.c         | 17 ++++++++---
>  include/hw/elf_ops.h | 71 ++++++++++++++++++++++++++------------------
>  include/hw/i386/pc.h |  1 +
>  include/hw/loader.h  |  5 ++--
>  5 files changed, 89 insertions(+), 43 deletions(-)
> 

Queued, thanks.

Paolo


Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9866C4646B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 06:23:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E5EA2085A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 06:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E5EA2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg1Kd-0005iO-NJ
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 02:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45534)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hg1JX-0005Gz-Go
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 02:21:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hg1JW-0008RA-9o
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 02:21:51 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37316)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hg1JV-0008NP-1T
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 02:21:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id bh12so839080plb.4
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 23:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=aN/2Vh9ZPP07h/k99QUK7ZDOeVOUlatwM53Z7anOO8Y=;
 b=HE/aPBPaL00sgbusvMLC5d7sbndH8zw7vxisZmpDuuoBKYwXAzGEKSt4UBikOj4fmx
 RP6pKezEWs9kNEJbyPXbYv7QoHDLiOGQeLSpDsZd2y5q20w5EVN1gPC2421dBETHC8xi
 gsojYz6AAIaFInpB9VXLIznovVsJUwTJXltXku3tXbjIztKD4LpecgaWUqWlik2Q9FNh
 phVtkixmqIHWT9qbyloA110ap5f+wuDY6TMIqSiZoG7GNYxTqpiPUJ2W+9Kt0yu48u0l
 c/8SOWalxbWXhFH5QN+nGxsZoiZNX8qTQVU4Fyh6u+qB7GAww6q5UjTqIz+5x/jBJNOk
 NrTA==
X-Gm-Message-State: APjAAAX8sWfNhySLtT5EAy661lHXXqg9SJU34QmI06GSLG9bS7vM7N0H
 ygYMxsb5HW/8dgJHJqnOxqoKow==
X-Google-Smtp-Source: APXvYqwZ3pqAieQDr0pnACRWILhi/vtTWGA+7orzvEjTwYWQXh4K+NVg+kh60ATp9sUxHOZtiRC7VA==
X-Received: by 2002:a17:902:7041:: with SMTP id
 h1mr3368287plt.133.1561530106195; 
 Tue, 25 Jun 2019 23:21:46 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id y193sm15990683pgd.41.2019.06.25.23.21.45
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 25 Jun 2019 23:21:45 -0700 (PDT)
Date: Tue, 25 Jun 2019 23:21:45 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2019 23:20:59 PDT (-0700)
In-Reply-To: <CAKmqyKOpxtB7SrT2i_UjVsE38=nzf1_q0fmYPhJ4D716j3ZriQ@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: alistair23@gmail.com
Message-ID: <mhng-3fc228c8-dcb7-4353-af88-1b6e038cb6f0@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.194
Subject: Re: [Qemu-devel] [PATCH v1 0/5] RISC-V: Add firmware loading
 support and default
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
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Jun 2019 10:06:33 PDT (-0700), alistair23@gmail.com wrote:
> On Mon, Jun 24, 2019 at 3:14 PM Alistair Francis
> <alistair.francis@wdc.com> wrote:
>>
>> This series consolidates the current RISC-V kernel loading
>> impelementation while also adding support for the -bios option and more
>> advanced kernel image types.
>>
>> After consolidating the kernel loading we can extend the boot loader to
>> support a -bios option. We can also extend the kernel loading options to
>> support not just ELF files but other standard formats.
>>
>> Finally we can include the OpenSBI firmware for QEMU users.
>>
>> To avoid breakages we have not changed the default behaviour of QEMU.
>> The plan is to change the default though, which is why an entry to the
>> qemu-deprecated.texi file has been added as well as a new warning.
>>
>> After this series QEMU 4.1 has three options:
>>  1. ``-bios none`` - This is the current default behavior if no -bios option
>>       is included. QEMU will not automatically load any firmware. It is up
>>       to the user to load all the images they need.
>>  2. ``-bios default`` - In a future QEMU release this will become the default
>>       behaviour if no -bios option is specified. This option will load the
>>       default OpenSBI firmware automatically. The firmware is included with
>>       the QEMU release and no user interaction is required. All a user needs
>>       to do is specify the kernel they want to boot with the -kernel option
>>  3. ``-bios <file>`` - Tells QEMU to load the specified file as the firmwrae.
>>
>> All users should transition to using a -bios option. We can start
>> updating all documentation after the release of 4.1.
>>
>> At the end of this series and the transition period we are in the good
>> place of no longer requiring users to build firmware to boot a kernel.
>> Instead users can just run QEMU with the -kernel option and everything
>> will work. They can also override the firmware with their own using
>> the -bios option. Using "-bios none" will result in no firmware being
>> loaded (as it is today).
>>
>
> @Palmer Dabbelt can this go in your 4.1 PR? It has been reviewed and tested.

I don't see any reason why not.  It's top of my list, after I get through my
first pass at email.

>
> Alistair
>
>>
>> Alistair Francis (5):
>>   hw/riscv: Split out the boot functions
>>   hw/riscv: Add support for loading a firmware
>>   hw/riscv: Extend the kernel loading support
>>   roms: Add OpenSBI version 0.3
>>   hw/riscv: Load OpenSBI as the default firmware
>>
>>  .gitmodules                                  |   3 +
>>  Makefile                                     |   5 +-
>>  hw/riscv/Makefile.objs                       |   1 +
>>  hw/riscv/boot.c                              | 154 +++++++++++++++++++
>>  hw/riscv/sifive_e.c                          |  17 +-
>>  hw/riscv/sifive_u.c                          |  22 +--
>>  hw/riscv/spike.c                             |  21 +--
>>  hw/riscv/virt.c                              |  60 ++------
>>  include/hw/riscv/boot.h                      |  32 ++++
>>  pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin 0 -> 28848 bytes
>>  pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin 0 -> 28904 bytes
>>  pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin 0 -> 28904 bytes
>>  qemu-deprecated.texi                         |  20 +++
>>  roms/Makefile                                |  48 ++++--
>>  roms/opensbi                                 |   1 +
>>  15 files changed, 278 insertions(+), 106 deletions(-)
>>  create mode 100644 hw/riscv/boot.c
>>  create mode 100644 include/hw/riscv/boot.h
>>  create mode 100644 pc-bios/opensbi-riscv32-virt-fw_jump.bin
>>  create mode 100644 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
>>  create mode 100644 pc-bios/opensbi-riscv64-virt-fw_jump.bin
>>  create mode 160000 roms/opensbi
>>
>> --
>> 2.22.0
>>


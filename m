Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237B4C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:09:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF3DC206B6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3DC206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIJCh-0002gk-KF
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 17:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iIHbX-0002PW-6m
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iIHbV-00033K-EO
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:26:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50694)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iIHbV-000334-4w
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:26:33 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0861361D25
 for <qemu-devel@nongnu.org>; Wed,  9 Oct 2019 19:26:32 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id f15so3179276qth.6
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 12:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=cRJfSXhNqcvqJqNZ1LKHHBkk71JEqBnTH1rClqGo4gE=;
 b=SxOA77SjXfTPVsjczcfPMB1sCBwlQokhL6QcnlXGh0GwKM4KM2n5hoYPy6RiA5eFq5
 6Al1aNvbA7q2B8oh31Ocxt7WngnW+IverTwZnFPMQiuoXdrSfUHAD9XhaeZ9LbxjDG4b
 3WXf1Cbc3rBBQs+dqQgB5cI/SP70Y8RR7lP11R+mXkf8bSz8D73T7JbDyUCyTQ4Z5hwi
 ghOuZHNX1UZFt2KI6rlW684q/7C0qKK9P5RbJZ1JNTZW2wTT5s0m6toJKyKDsXY8Z1ho
 PIXH8wi/uMdPwnk/ocMMA0Xy+5gID2XAZW3YB7bZb0yx8ke9NaPvCNJ2tg+itv9wPfwZ
 DboA==
X-Gm-Message-State: APjAAAXW9j066hlqoNIMksMNTxiUbOhoDc7XsnnPJJtT4uaQ3NpculiD
 YVtE0RqjueR8qrQnREWSoMx8KtYqgoyibc22BQVu1VLFX0O3adR4SncZeffbpug/P69ihcajZzA
 PB/lcDDH+4J2BzR0=
X-Received: by 2002:a37:e50f:: with SMTP id e15mr5358075qkg.192.1570649191241; 
 Wed, 09 Oct 2019 12:26:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyIjoeDWVsEsgb5QbDgyFuCbkCVcTcfxKW/L7w1ocOglLe39NIEyVVeWzq0+wGBS3zcAT1lfg==
X-Received: by 2002:a37:e50f:: with SMTP id e15mr5358053qkg.192.1570649190954; 
 Wed, 09 Oct 2019 12:26:30 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 63sm1435500qkh.82.2019.10.09.12.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2019 12:26:30 -0700 (PDT)
Date: Wed, 9 Oct 2019 15:26:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH v7 00/12] Introduce the microvm machine type
Message-ID: <20191009152542-mutt-send-email-mst@kernel.org>
References: <20191008135537.197867-1-slp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20191008135537.197867-1-slp@redhat.com>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, lersek@redhat.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, pbonzini@redhat.com, imammedo@redhat.com,
 sgarzare@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 08, 2019 at 03:55:26PM +0200, Sergio Lopez wrote:
> Microvm is a machine type inspired by Firecracker and constructed
> after the its machine model.
>=20
> It's a minimalist machine type without PCI nor ACPI support, designed
> for short-lived guests. Microvm also establishes a baseline for
> benchmarking and optimizing both QEMU and guest operating systems,
> since it is optimized for both boot time and footprint.

Looks good overall. I think coding style needs to
be fixed but that's a patch on top.

series:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Paolo I assume you will be merging this?


> ---
>=20
> Changelog
> v7:
>  - Fix code style issues on already present code touched by this patch
>    series (Michael S. Tsirkin, Philippe Mathieu-Daud=E9)
>  - Add new files to MAINTAINERS (Michael S. Tsirkin, Philippe
>    Mathieu-Daud=E9)
>  - Allow starting a microvm machine without a kernel image, fixing
>    "qom-test" (Michael S. Tsirkin)
>  - Change "bios-microvm.bin" mode to 0644 (Stefano Garzarella)
>  - Remove unneeded "hw/i386/pc.h" include from x86.c (Stefano
>    Garzarella)
>=20
> v6:
>  - Some style fixes (Philippe Mathieu-Daud=E9)
>  - Fix a documentation bug stating that LAPIC was in userspace (Paolo
>    Bonzini)
>  - Update Xen HVM code after X86MachineState introduction (Philippe
>    Mathieu-Daud=E9)
>  - Rename header guard from QEMU_VIRTIO_MMIO_H to HW_VIRTIO_MMIO_H
>    (Philippe Mathieu-Daud=E9)
>=20
> v5:
>  - Drop unneeded "[PATCH v4 2/8] hw/i386: Factorize e820 related
>    functions" (Philippe Mathieu-Daud=E9)
>  - Drop unneeded "[PATCH v4 1/8] hw/i386: Factorize PVH related
>    functions" (Stefano Garzarella)
>  - Split X86MachineState introduction into smaller patches (Philippe
>    Mathieu-Daud=E9)
>  - Change option-roms to x-option-roms and kernel-cmdline to
>    auto-kernel-cmdline (Paolo Bonzini)
>  - Make i8259 PIT and i8254 PIC optional (Paolo Bonzini)
>  - Some fixes to the documentation (Paolo Bonzini)
>  - Switch documentation format from txt to rst (Peter Maydell)
>  - Move NMI interface to X86_MACHINE (Philippe Mathieu-Daud=E9, Paolo
>    Bonzini)
>=20
> v4:
>  - This is a complete rewrite of the whole patchset, with a focus on
>    reusing as much existing code as possible to ease the maintenance bu=
rden
>    and making the machine type as compatible as possible by default. As
>    a result, the number of lines dedicated specifically to microvm is
>    383 (code lines measured by "cloc") and, with the default
>    configuration, it's now able to boot both PVH ELF images and
>    bzImages with either SeaBIOS or qboot.
>=20
> v3:
>   - Add initrd support (thanks Stefano).
>=20
> v2:
>   - Drop "[PATCH 1/4] hw/i386: Factorize CPU routine".
>   - Simplify machine definition (thanks Eduardo).
>   - Remove use of unneeded NUMA-related callbacks (thanks Eduardo).
>   - Add a patch to factorize PVH-related functions.
>   - Replace use of Linux's Zero Page with PVH (thanks Maran and Paolo).
>=20
> ---
>=20
> Sergio Lopez (12):
>   hw/virtio: Factorize virtio-mmio headers
>   hw/i386/pc: rename functions shared with non-PC machines
>   hw/i386/pc: fix code style issues on functions that will be moved out
>   hw/i386/pc: move shared x86 functions to x86.c and export them
>   hw/i386: split PCMachineState deriving X86MachineState from it
>   hw/i386: make x86.c independent from PCMachineState
>   fw_cfg: add "modify" functions for all types
>   hw/intc/apic: reject pic ints if isa_pic =3D=3D NULL
>   roms: add microvm-bios (qboot) as binary and git submodule
>   docs/microvm.rst: document the new microvm machine type
>   hw/i386: Introduce the microvm machine type
>   MAINTAINERS: add microvm related files
>=20
>  docs/microvm.rst                 |  98 ++++
>  default-configs/i386-softmmu.mak |   1 +
>  include/hw/i386/microvm.h        |  83 ++++
>  include/hw/i386/pc.h             |  28 +-
>  include/hw/i386/x86.h            |  96 ++++
>  include/hw/nvram/fw_cfg.h        |  42 ++
>  include/hw/virtio/virtio-mmio.h  |  73 +++
>  hw/acpi/cpu_hotplug.c            |  10 +-
>  hw/i386/acpi-build.c             |  29 +-
>  hw/i386/amd_iommu.c              |   3 +-
>  hw/i386/intel_iommu.c            |   3 +-
>  hw/i386/microvm.c                | 572 ++++++++++++++++++++++
>  hw/i386/pc.c                     | 781 +++---------------------------
>  hw/i386/pc_piix.c                |  46 +-
>  hw/i386/pc_q35.c                 |  38 +-
>  hw/i386/pc_sysfw.c               |  60 +--
>  hw/i386/x86.c                    | 795 +++++++++++++++++++++++++++++++
>  hw/i386/xen/xen-hvm.c            |  28 +-
>  hw/intc/apic.c                   |   2 +-
>  hw/intc/ioapic.c                 |   2 +-
>  hw/nvram/fw_cfg.c                |  29 ++
>  hw/virtio/virtio-mmio.c          |  48 +-
>  .gitmodules                      |   3 +
>  MAINTAINERS                      |  10 +
>  hw/i386/Kconfig                  |   4 +
>  hw/i386/Makefile.objs            |   2 +
>  pc-bios/bios-microvm.bin         | Bin 0 -> 65536 bytes
>  roms/Makefile                    |   6 +
>  roms/qboot                       |   1 +
>  29 files changed, 1982 insertions(+), 911 deletions(-)
>  create mode 100644 docs/microvm.rst
>  create mode 100644 include/hw/i386/microvm.h
>  create mode 100644 include/hw/i386/x86.h
>  create mode 100644 include/hw/virtio/virtio-mmio.h
>  create mode 100644 hw/i386/microvm.c
>  create mode 100644 hw/i386/x86.c
>  create mode 100644 pc-bios/bios-microvm.bin
>  create mode 160000 roms/qboot
>=20
> --=20
> 2.21.0


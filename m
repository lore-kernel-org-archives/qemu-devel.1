Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9166DC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 13:59:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67B842077B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 13:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B842077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGO71-00065l-G6
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 09:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iGO5J-00058J-Pw
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 09:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iGO5H-0001Sh-Vh
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 09:57:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36324)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iGO5H-0001S9-Mk
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 09:57:27 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AEDCA7FDEE
 for <qemu-devel@nongnu.org>; Fri,  4 Oct 2019 13:57:25 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id d25so6333661qkk.17
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 06:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=52myUMkbUdrDYwRnEPkiQ4KOXXEAEQ20Z3yP8g2njHg=;
 b=NcTMvkdlsa0YawMGRADl35L+40gVgXfyPIrKwFevGGi3H39bW8cZ/ULLVZscI68SIB
 xf3eC85tfCPtpxpIYBoiStpLLHRHbKtH7j87IOU7UTOArva3cX/7ypLAhmhYqvs2axMa
 ljL2FHiOJzI+dJuOFrCQdPp50XjtM7YGM2r+tEGiaz3gMi1b9mhtKJDDMUs1lgw+GPhT
 eHJxoq4IOy/hEh3YP/0bnLpbQ815eQ9UkU/1Dlt1ZLdimaipC7TGRflvLEGZF8aY2V0h
 SNfjvY3oJVTxXGKBj15VByaeYNLzO50jtKRZbLfEzqNHvONlgb01shZ5/AcblKO7wuB2
 ot1A==
X-Gm-Message-State: APjAAAVzNxbVckXIyQptrQCyB5qf3oYrTcg9aN/gxpdv2cts2sgZKmNn
 ZZ9BKxbeP6/CafzfMWsdxzLhqYEH5RHTvvoxZKkLyfIzRtfVKvu7WdjY+zS5L0klzPMBVzYDES1
 IwldHIwRs++53tyY=
X-Received: by 2002:a05:620a:78f:: with SMTP id
 15mr10565376qka.167.1570197444886; 
 Fri, 04 Oct 2019 06:57:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyyCI3LlVH7HKgX3gmHeDhoLuO870NBF4PSgvCKffnvh6uKZFyjXcYGIeUeBjzMkrbfquUQvQ==
X-Received: by 2002:a05:620a:78f:: with SMTP id
 15mr10565334qka.167.1570197444518; 
 Fri, 04 Oct 2019 06:57:24 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 t73sm2706323qke.113.2019.10.04.06.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2019 06:57:23 -0700 (PDT)
Date: Fri, 4 Oct 2019 09:57:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH v6 00/10] Introduce the microvm machine type
Message-ID: <20191004095539-mutt-send-email-mst@kernel.org>
References: <20191004093752.16564-1-slp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20191004093752.16564-1-slp@redhat.com>
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

On Fri, Oct 04, 2019 at 11:37:42AM +0200, Sergio Lopez wrote:
> Microvm is a machine type inspired by Firecracker and constructed
> after the its machine model.
>=20
> It's a minimalist machine type without PCI nor ACPI support, designed
> for short-lived guests. Microvm also establishes a baseline for
> benchmarking and optimizing both QEMU and guest operating systems,
> since it is optimized for both boot time and footprint.
>=20
> ---
>=20
> Changelog
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
> Sergio Lopez (10):
>   hw/virtio: Factorize virtio-mmio headers
>   hw/i386/pc: rename functions shared with non-PC machines
>   hw/i386/pc: move shared x86 functions to x86.c and export them
>   hw/i386: split PCMachineState deriving X86MachineState from it
>   hw/i386: make x86.c independent from PCMachineState
>   fw_cfg: add "modify" functions for all types
>   hw/intc/apic: reject pic ints if isa_pic =3D=3D NULL
>   roms: add microvm-bios (qboot) as binary and git submodule
>   docs/microvm.rst: document the new microvm machine type
>   hw/i386: Introduce the microvm machine type
>=20
>  docs/microvm.rst                 |  98 ++++
>  default-configs/i386-softmmu.mak |   1 +
>  include/hw/i386/microvm.h        |  83 ++++
>  include/hw/i386/pc.h             |  28 +-
>  include/hw/i386/x86.h            |  94 ++++
>  include/hw/nvram/fw_cfg.h        |  42 ++
>  include/hw/virtio/virtio-mmio.h  |  73 +++
>  hw/acpi/cpu_hotplug.c            |  10 +-
>  hw/i386/acpi-build.c             |  29 +-
>  hw/i386/amd_iommu.c              |   3 +-
>  hw/i386/intel_iommu.c            |   3 +-
>  hw/i386/microvm.c                | 574 ++++++++++++++++++++++
>  hw/i386/pc.c                     | 780 +++---------------------------
>  hw/i386/pc_piix.c                |  46 +-
>  hw/i386/pc_q35.c                 |  38 +-
>  hw/i386/pc_sysfw.c               |  58 +--
>  hw/i386/x86.c                    | 790 +++++++++++++++++++++++++++++++
>  hw/i386/xen/xen-hvm.c            |  23 +-
>  hw/intc/apic.c                   |   2 +-
>  hw/intc/ioapic.c                 |   2 +-
>  hw/nvram/fw_cfg.c                |  29 ++
>  hw/virtio/virtio-mmio.c          |  48 +-
>  .gitmodules                      |   3 +
>  hw/i386/Kconfig                  |   4 +
>  hw/i386/Makefile.objs            |   2 +
>  pc-bios/bios-microvm.bin         | Bin 0 -> 65536 bytes
>  roms/Makefile                    |   6 +
>  roms/qboot                       |   1 +

So I guess we want to add new files for x86 machines MAINTAINERS entry.

Otherwise looks good.
Which tree is this going to be merged through? Mine?


>  28 files changed, 1963 insertions(+), 907 deletions(-)
>  create mode 100644 docs/microvm.rst
>  create mode 100644 include/hw/i386/microvm.h
>  create mode 100644 include/hw/i386/x86.h
>  create mode 100644 include/hw/virtio/virtio-mmio.h
>  create mode 100644 hw/i386/microvm.c
>  create mode 100644 hw/i386/x86.c
>  create mode 100755 pc-bios/bios-microvm.bin
>  create mode 160000 roms/qboot
>=20
> --=20
> 2.21.0


Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2126C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:21:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8786C21929
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8786C21929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIJOl-00076r-Cu
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 17:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iIHX4-0005sO-By
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iIHX1-0000Mq-RA
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:21:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38178)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iIHX1-0000MW-Ga
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:21:55 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6902DC004E8D
 for <qemu-devel@nongnu.org>; Wed,  9 Oct 2019 19:21:54 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id t25so3174695qtq.9
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 12:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=N4uoZzBO5CnLv2KeKzzKQ6kDn9fOIMaU+y41RB4s4N8=;
 b=sdSFA9xTGHB9ItVtINZI3WXY0LL0DPT4sw3ZLbejw9PI4mQL/xvzyxNwcKC9aAm5DE
 k6bkn5i1H+BBXpeXKqXi3sojjS/dOL1czed5zsGvg8D+Ymy47vqTq4FSiKr0Pf6fuaTx
 TCiHNJ+Rv9Nf8iiba2M+6ZoQGRZBaWfe9IA1hrxEEqyZ4KBtr+523e7gwZW9VARdEGUI
 5XRfci1nmKq2/CQQdVhZAgiXSZo+J5gAinVxyPCkKYnTG5sBwZYCvZ4tXa1yF4w6TzJI
 ARgr4OrX3yzA057bWlDrGY/6brBnu/xyfA6rOU5X1vc2z9X2JtkL1WfUdAvRw/el6WuM
 YAYw==
X-Gm-Message-State: APjAAAXtlbfqlt6TqL7oIihbwoB8+gA2qli2O1Oxw/67M8sNry5+sTAg
 jbZHVvtgUeNNiLnK+d5Z4P7ZGuMkJ1YFnTfhktQKtvNoxw6tVZ126+stY5zRC7rLlu/RzluPjNS
 Ct/qkTAFe56pJqwI=
X-Received: by 2002:a0c:e7ce:: with SMTP id c14mr5476328qvo.187.1570648913611; 
 Wed, 09 Oct 2019 12:21:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwkvQpCrwdSHtlAWwP5YFhdUvotYDlsA2lLLkGUSSPkg/hH8B/J/GEHhS7mmHYYBlMmWmkokw==
X-Received: by 2002:a0c:e7ce:: with SMTP id c14mr5476309qvo.187.1570648913277; 
 Wed, 09 Oct 2019 12:21:53 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 131sm1402754qkg.1.2019.10.09.12.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2019 12:21:52 -0700 (PDT)
Date: Wed, 9 Oct 2019 15:21:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH v6 00/10] Introduce the microvm machine type
Message-ID: <20191009152109-mutt-send-email-mst@kernel.org>
References: <20191004093752.16564-1-slp@redhat.com>
 <20191005180721-mutt-send-email-mst@kernel.org>
 <87sgo4oek7.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87sgo4oek7.fsf@redhat.com>
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

On Mon, Oct 07, 2019 at 03:44:40PM +0200, Sergio Lopez wrote:
>=20
> Michael S. Tsirkin <mst@redhat.com> writes:
>=20
> > On Fri, Oct 04, 2019 at 11:37:42AM +0200, Sergio Lopez wrote:
> >> Microvm is a machine type inspired by Firecracker and constructed
> >> after the its machine model.
> >>=20
> >> It's a minimalist machine type without PCI nor ACPI support, designe=
d
> >> for short-lived guests. Microvm also establishes a baseline for
> >> benchmarking and optimizing both QEMU and guest operating systems,
> >> since it is optimized for both boot time and footprint.
> >
> > Pls take a look at patchew warnings and errors.
> > Both coding style issues and test failures need to be
> > addressed somehow I think.
>=20
> I've fixed the issue with the test suite, but I'm not sure what to do
> about the coding style errors. Every one of them (except perhaps one at
> xen-hvm.c) comes from code I've moved from pc.c to x86.c. I'd say fixin=
g
> those are outside the scope of the corresponding patches, but please
> correct me if I'm wrong.

Yea if you refactor code you have to kick it into shape
at the same time. Can be a separate patch to ease review.

> On the other hand, I haven't touched MAINTAINERS, because I'm not sure
> about the actual policies that apply while doing so. Should I add the
> new files to it?
>=20
> Thanks,
> Sergio.
>=20
> >> ---
> >>=20
> >> Changelog
> >> v6:
> >>  - Some style fixes (Philippe Mathieu-Daud=E9)
> >>  - Fix a documentation bug stating that LAPIC was in userspace (Paol=
o
> >>    Bonzini)
> >>  - Update Xen HVM code after X86MachineState introduction (Philippe
> >>    Mathieu-Daud=E9)
> >>  - Rename header guard from QEMU_VIRTIO_MMIO_H to HW_VIRTIO_MMIO_H
> >>    (Philippe Mathieu-Daud=E9)
> >>=20
> >> v5:
> >>  - Drop unneeded "[PATCH v4 2/8] hw/i386: Factorize e820 related
> >>    functions" (Philippe Mathieu-Daud=E9)
> >>  - Drop unneeded "[PATCH v4 1/8] hw/i386: Factorize PVH related
> >>    functions" (Stefano Garzarella)
> >>  - Split X86MachineState introduction into smaller patches (Philippe
> >>    Mathieu-Daud=E9)
> >>  - Change option-roms to x-option-roms and kernel-cmdline to
> >>    auto-kernel-cmdline (Paolo Bonzini)
> >>  - Make i8259 PIT and i8254 PIC optional (Paolo Bonzini)
> >>  - Some fixes to the documentation (Paolo Bonzini)
> >>  - Switch documentation format from txt to rst (Peter Maydell)
> >>  - Move NMI interface to X86_MACHINE (Philippe Mathieu-Daud=E9, Paol=
o
> >>    Bonzini)
> >>=20
> >> v4:
> >>  - This is a complete rewrite of the whole patchset, with a focus on
> >>    reusing as much existing code as possible to ease the maintenance=
 burden
> >>    and making the machine type as compatible as possible by default.=
 As
> >>    a result, the number of lines dedicated specifically to microvm i=
s
> >>    383 (code lines measured by "cloc") and, with the default
> >>    configuration, it's now able to boot both PVH ELF images and
> >>    bzImages with either SeaBIOS or qboot.
> >>=20
> >> v3:
> >>   - Add initrd support (thanks Stefano).
> >>=20
> >> v2:
> >>   - Drop "[PATCH 1/4] hw/i386: Factorize CPU routine".
> >>   - Simplify machine definition (thanks Eduardo).
> >>   - Remove use of unneeded NUMA-related callbacks (thanks Eduardo).
> >>   - Add a patch to factorize PVH-related functions.
> >>   - Replace use of Linux's Zero Page with PVH (thanks Maran and Paol=
o).
> >>=20
> >> ---
> >> Sergio Lopez (10):
> >>   hw/virtio: Factorize virtio-mmio headers
> >>   hw/i386/pc: rename functions shared with non-PC machines
> >>   hw/i386/pc: move shared x86 functions to x86.c and export them
> >>   hw/i386: split PCMachineState deriving X86MachineState from it
> >>   hw/i386: make x86.c independent from PCMachineState
> >>   fw_cfg: add "modify" functions for all types
> >>   hw/intc/apic: reject pic ints if isa_pic =3D=3D NULL
> >>   roms: add microvm-bios (qboot) as binary and git submodule
> >>   docs/microvm.rst: document the new microvm machine type
> >>   hw/i386: Introduce the microvm machine type
> >>=20
> >>  docs/microvm.rst                 |  98 ++++
> >>  default-configs/i386-softmmu.mak |   1 +
> >>  include/hw/i386/microvm.h        |  83 ++++
> >>  include/hw/i386/pc.h             |  28 +-
> >>  include/hw/i386/x86.h            |  94 ++++
> >>  include/hw/nvram/fw_cfg.h        |  42 ++
> >>  include/hw/virtio/virtio-mmio.h  |  73 +++
> >>  hw/acpi/cpu_hotplug.c            |  10 +-
> >>  hw/i386/acpi-build.c             |  29 +-
> >>  hw/i386/amd_iommu.c              |   3 +-
> >>  hw/i386/intel_iommu.c            |   3 +-
> >>  hw/i386/microvm.c                | 574 ++++++++++++++++++++++
> >>  hw/i386/pc.c                     | 780 +++-------------------------=
--
> >>  hw/i386/pc_piix.c                |  46 +-
> >>  hw/i386/pc_q35.c                 |  38 +-
> >>  hw/i386/pc_sysfw.c               |  58 +--
> >>  hw/i386/x86.c                    | 790 ++++++++++++++++++++++++++++=
+++
> >>  hw/i386/xen/xen-hvm.c            |  23 +-
> >>  hw/intc/apic.c                   |   2 +-
> >>  hw/intc/ioapic.c                 |   2 +-
> >>  hw/nvram/fw_cfg.c                |  29 ++
> >>  hw/virtio/virtio-mmio.c          |  48 +-
> >>  .gitmodules                      |   3 +
> >>  hw/i386/Kconfig                  |   4 +
> >>  hw/i386/Makefile.objs            |   2 +
> >>  pc-bios/bios-microvm.bin         | Bin 0 -> 65536 bytes
> >>  roms/Makefile                    |   6 +
> >>  roms/qboot                       |   1 +
> >>  28 files changed, 1963 insertions(+), 907 deletions(-)
> >>  create mode 100644 docs/microvm.rst
> >>  create mode 100644 include/hw/i386/microvm.h
> >>  create mode 100644 include/hw/i386/x86.h
> >>  create mode 100644 include/hw/virtio/virtio-mmio.h
> >>  create mode 100644 hw/i386/microvm.c
> >>  create mode 100644 hw/i386/x86.c
> >>  create mode 100755 pc-bios/bios-microvm.bin
> >>  create mode 160000 roms/qboot
> >>=20
> >> --=20
> >> 2.21.0
>=20




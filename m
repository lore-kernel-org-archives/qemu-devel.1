Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97759ECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 14:00:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BD5D20684
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 14:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD5D20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHTYS-0006dW-I9
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 10:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHTXc-0005v6-Vb
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:59:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHTXa-0006aY-1A
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:59:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51382)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iHTXZ-0006Yi-Os
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:59:09 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 25CBF73A69
 for <qemu-devel@nongnu.org>; Mon,  7 Oct 2019 13:59:08 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id g67so3370570wmg.4
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 06:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FZfNJCSMV9mwLzNZhCQiSlHy2Yf5EssNWC5oz89kWi8=;
 b=oJGV1/mHdcWWjO7ngL7iKJiL/pYv8YOyJEB6X0k19TwWAAXTz70SkatNv8Ugqxropi
 ZB5OUUt0xjKa9st1+mBtzyNl5snnwL+qJ1/+xOQqSJN6mxnTZ51rbZ6VX9P6rxUKxno0
 sS2MUm2rJhJuvyHWRkT0UodWPunBa8DaS9Lx6tuzOqviZShGSMCuG1yMy/Ft1mt9YfnJ
 dSV6apwUW9uBZeSP25zju8YTcz2ZonvvyAMZ6eZpzNA7uUcddz1KfiEgRMVOXfh9IG7o
 HinPub0UQA7uKsfSVpKvQCnGbfEhlqFvryM+I2bBMG2hWkydrAL163z9DR9MHBgG83xJ
 DTzQ==
X-Gm-Message-State: APjAAAVyQtakz6EVqd/UYpQoJkG9+xNhTNzZf6NUVZzFHHietnFwhBSE
 VkP8LeIuPvsS6pgYnMM2+xfILYYyLKQflRyJ7NlMpP9N5tIA8wP5nulsi2AJR+YsMOJS/gkIzeh
 Ax+/HVNJxA2RXfMc=
X-Received: by 2002:a5d:63cb:: with SMTP id c11mr21214260wrw.281.1570456746825; 
 Mon, 07 Oct 2019 06:59:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyO9sClDLCodtanU58VHoNHNkOfHBdWy/bphjEz4DQ+QoAUn730WDP3IkF7xkfTdhbCiqT56w==
X-Received: by 2002:a5d:63cb:: with SMTP id c11mr21214232wrw.281.1570456746534; 
 Mon, 07 Oct 2019 06:59:06 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id d10sm15876478wma.42.2019.10.07.06.59.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2019 06:59:05 -0700 (PDT)
Subject: Re: [PATCH v6 00/10] Introduce the microvm machine type
To: Sergio Lopez <slp@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20191004093752.16564-1-slp@redhat.com>
 <20191005180721-mutt-send-email-mst@kernel.org> <87sgo4oek7.fsf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e9b14000-6558-10c2-299f-b4171d40708f@redhat.com>
Date: Mon, 7 Oct 2019 15:59:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <87sgo4oek7.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 pbonzini@redhat.com, imammedo@redhat.com, sgarzare@redhat.com,
 lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/19 3:44 PM, Sergio Lopez wrote:
> Michael S. Tsirkin <mst@redhat.com> writes:
>=20
>> On Fri, Oct 04, 2019 at 11:37:42AM +0200, Sergio Lopez wrote:
>>> Microvm is a machine type inspired by Firecracker and constructed
>>> after the its machine model.
>>>
>>> It's a minimalist machine type without PCI nor ACPI support, designed
>>> for short-lived guests. Microvm also establishes a baseline for
>>> benchmarking and optimizing both QEMU and guest operating systems,
>>> since it is optimized for both boot time and footprint.
>>
>> Pls take a look at patchew warnings and errors.
>> Both coding style issues and test failures need to be
>> addressed somehow I think.
>=20
> I've fixed the issue with the test suite, but I'm not sure what to do
> about the coding style errors. Every one of them (except perhaps one at
> xen-hvm.c) comes from code I've moved from pc.c to x86.c. I'd say fixin=
g
> those are outside the scope of the corresponding patches, but please
> correct me if I'm wrong.

What makes reviews easier for me is to split in 2 patches: 1 fixing the=20
lines I'm going to move, then the patch that simply move.

You can add checkpatch as a pre-commit hook:
http://blog.vmsplice.net/2011/03/how-to-automatically-run-checkpatchpl.ht=
ml

In a temporary branch, git mv/commit will call checkpatch and display=20
warnings; discard your commit and fix the warnings in the original code.

> On the other hand, I haven't touched MAINTAINERS, because I'm not sure
> about the actual policies that apply while doing so. Should I add the
> new files to it?

The new "hw/virtio/virtio-mmio.h" is covered by the "virtio" section:

F: hw/*/virtio*
F: include/hw/virtio/

Now I think the MicroVM files deserve an entry, probably with Paolo/you=20
listed:

- docs/microvm.rst
- hw/i386/microvm.c
- include/hw/i386/microvm.h
- pc-bios/bios-microvm.bin

>>> ---
>>>
>>> Changelog
>>> v6:
>>>   - Some style fixes (Philippe Mathieu-Daud=C3=A9)
>>>   - Fix a documentation bug stating that LAPIC was in userspace (Paol=
o
>>>     Bonzini)
>>>   - Update Xen HVM code after X86MachineState introduction (Philippe
>>>     Mathieu-Daud=C3=A9)
>>>   - Rename header guard from QEMU_VIRTIO_MMIO_H to HW_VIRTIO_MMIO_H
>>>     (Philippe Mathieu-Daud=C3=A9)
>>>
>>> v5:
>>>   - Drop unneeded "[PATCH v4 2/8] hw/i386: Factorize e820 related
>>>     functions" (Philippe Mathieu-Daud=C3=A9)
>>>   - Drop unneeded "[PATCH v4 1/8] hw/i386: Factorize PVH related
>>>     functions" (Stefano Garzarella)
>>>   - Split X86MachineState introduction into smaller patches (Philippe
>>>     Mathieu-Daud=C3=A9)
>>>   - Change option-roms to x-option-roms and kernel-cmdline to
>>>     auto-kernel-cmdline (Paolo Bonzini)
>>>   - Make i8259 PIT and i8254 PIC optional (Paolo Bonzini)
>>>   - Some fixes to the documentation (Paolo Bonzini)
>>>   - Switch documentation format from txt to rst (Peter Maydell)
>>>   - Move NMI interface to X86_MACHINE (Philippe Mathieu-Daud=C3=A9, P=
aolo
>>>     Bonzini)
>>>
>>> v4:
>>>   - This is a complete rewrite of the whole patchset, with a focus on
>>>     reusing as much existing code as possible to ease the maintenance=
 burden
>>>     and making the machine type as compatible as possible by default.=
 As
>>>     a result, the number of lines dedicated specifically to microvm i=
s
>>>     383 (code lines measured by "cloc") and, with the default
>>>     configuration, it's now able to boot both PVH ELF images and
>>>     bzImages with either SeaBIOS or qboot.
>>>
>>> v3:
>>>    - Add initrd support (thanks Stefano).
>>>
>>> v2:
>>>    - Drop "[PATCH 1/4] hw/i386: Factorize CPU routine".
>>>    - Simplify machine definition (thanks Eduardo).
>>>    - Remove use of unneeded NUMA-related callbacks (thanks Eduardo).
>>>    - Add a patch to factorize PVH-related functions.
>>>    - Replace use of Linux's Zero Page with PVH (thanks Maran and Paol=
o).
>>>
>>> ---
>>> Sergio Lopez (10):
>>>    hw/virtio: Factorize virtio-mmio headers
>>>    hw/i386/pc: rename functions shared with non-PC machines
>>>    hw/i386/pc: move shared x86 functions to x86.c and export them
>>>    hw/i386: split PCMachineState deriving X86MachineState from it
>>>    hw/i386: make x86.c independent from PCMachineState
>>>    fw_cfg: add "modify" functions for all types
>>>    hw/intc/apic: reject pic ints if isa_pic =3D=3D NULL
>>>    roms: add microvm-bios (qboot) as binary and git submodule
>>>    docs/microvm.rst: document the new microvm machine type
>>>    hw/i386: Introduce the microvm machine type
>>>
>>>   docs/microvm.rst                 |  98 ++++
>>>   default-configs/i386-softmmu.mak |   1 +
>>>   include/hw/i386/microvm.h        |  83 ++++
>>>   include/hw/i386/pc.h             |  28 +-
>>>   include/hw/i386/x86.h            |  94 ++++
>>>   include/hw/nvram/fw_cfg.h        |  42 ++
>>>   include/hw/virtio/virtio-mmio.h  |  73 +++
>>>   hw/acpi/cpu_hotplug.c            |  10 +-
>>>   hw/i386/acpi-build.c             |  29 +-
>>>   hw/i386/amd_iommu.c              |   3 +-
>>>   hw/i386/intel_iommu.c            |   3 +-
>>>   hw/i386/microvm.c                | 574 ++++++++++++++++++++++
>>>   hw/i386/pc.c                     | 780 +++-------------------------=
--
>>>   hw/i386/pc_piix.c                |  46 +-
>>>   hw/i386/pc_q35.c                 |  38 +-
>>>   hw/i386/pc_sysfw.c               |  58 +--
>>>   hw/i386/x86.c                    | 790 ++++++++++++++++++++++++++++=
+++
>>>   hw/i386/xen/xen-hvm.c            |  23 +-
>>>   hw/intc/apic.c                   |   2 +-
>>>   hw/intc/ioapic.c                 |   2 +-
>>>   hw/nvram/fw_cfg.c                |  29 ++
>>>   hw/virtio/virtio-mmio.c          |  48 +-
>>>   .gitmodules                      |   3 +
>>>   hw/i386/Kconfig                  |   4 +
>>>   hw/i386/Makefile.objs            |   2 +
>>>   pc-bios/bios-microvm.bin         | Bin 0 -> 65536 bytes
>>>   roms/Makefile                    |   6 +
>>>   roms/qboot                       |   1 +
>>>   28 files changed, 1963 insertions(+), 907 deletions(-)
>>>   create mode 100644 docs/microvm.rst
>>>   create mode 100644 include/hw/i386/microvm.h
>>>   create mode 100644 include/hw/i386/x86.h
>>>   create mode 100644 include/hw/virtio/virtio-mmio.h
>>>   create mode 100644 hw/i386/microvm.c
>>>   create mode 100644 hw/i386/x86.c
>>>   create mode 100755 pc-bios/bios-microvm.bin
>>>   create mode 160000 roms/qboot
>>>
>>> --=20
>>> 2.21.0
>=20


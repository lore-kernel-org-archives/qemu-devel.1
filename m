Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906C2C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:31:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 678F3206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678F3206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIJYP-00012E-7C
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 17:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iIJHV-000059-4Q
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 17:14:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iIJHT-0002QE-Gj
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 17:14:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49280)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iIJHT-0002Pr-7E
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 17:13:59 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2978588302
 for <qemu-devel@nongnu.org>; Wed,  9 Oct 2019 21:13:58 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id f63so1134608wma.7
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 14:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5F7UXkncyxGAfMh3Wz10NUiUtNBn39o1cxpgCQcu9og=;
 b=eCw7AZu6fb4zqxDpVujGjVg3+uDfmK0uSEon1DYOCVGgqoOZb+JDxYoAXYZ74sAq+v
 dOMSezMo3uiNKcPkLPm/jy5Lu3SGVpQ6mq+fibbHrNVeIzwx1G3qPX+Zz9aJN3HC4sph
 tHWOODzZVclPEVrAULztks5gY+KgJYl8zGyK6FlpdjvP+JzMb/s/OaoFLQ1oeVHW5lsj
 dOB9GGJM1Nj/nsiFpfR9YbSt8JZ3uyyxnCJho70lpBrHnSCz0GmOQZAbsY6r67oOv+vU
 k7eHcVSKKkRcBp9c915GJlKrmqkkDHZj2weqXk07xinh5qF2Dwl1gw/TCHQVgCm+C+Ul
 rqDQ==
X-Gm-Message-State: APjAAAWb1tdDLn1tFNqfcxCeUhjP0vM7f3j/MLk8l5pCvv0oE15KXGKx
 PNPs6tVHcdfwvV5hA5ZO1GYo8ntFxUaL4hVB4UJCkVCb2hkxMy3QwdKQNGuTn2IdtvAHMg8dNsX
 yHuJvPX/g6B7D6Xw=
X-Received: by 2002:a1c:a8c7:: with SMTP id r190mr4194418wme.162.1570655636671; 
 Wed, 09 Oct 2019 14:13:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxN+T4UUvH9Y2Pi3ES6Jac3aRIvsJ7FE8572r6Bi7fysblmtqJtAEMyQbFhZy0Crw7rC2dKUw==
X-Received: by 2002:a1c:a8c7:: with SMTP id r190mr4194386wme.162.1570655636304; 
 Wed, 09 Oct 2019 14:13:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1032:7ea1:7f8f:1e5?
 ([2001:b07:6468:f312:1032:7ea1:7f8f:1e5])
 by smtp.gmail.com with ESMTPSA id q19sm7822293wra.89.2019.10.09.14.13.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2019 14:13:55 -0700 (PDT)
Subject: Re: [PATCH v7 00/12] Introduce the microvm machine type
To: "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>
References: <20191008135537.197867-1-slp@redhat.com>
 <20191009152542-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2b479fb3-c9e1-3185-7a22-41bf59e85171@redhat.com>
Date: Wed, 9 Oct 2019 23:13:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191009152542-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
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
Cc: ehabkost@redhat.com, lersek@redhat.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, imammedo@redhat.com, sgarzare@redhat.com, philmd@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/10/19 21:26, Michael S. Tsirkin wrote:
> On Tue, Oct 08, 2019 at 03:55:26PM +0200, Sergio Lopez wrote:
>> Microvm is a machine type inspired by Firecracker and constructed
>> after the its machine model.
>>
>> It's a minimalist machine type without PCI nor ACPI support, designed
>> for short-lived guests. Microvm also establishes a baseline for
>> benchmarking and optimizing both QEMU and guest operating systems,
>> since it is optimized for both boot time and footprint.
>=20
> Looks good overall. I think coding style needs to
> be fixed but that's a patch on top.
>=20
> series:
>=20
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> Paolo I assume you will be merging this?

Yes, but if Sergio could send me a pull request it would be nice too.

Paolo

>=20
>=20
>> ---
>>
>> Changelog
>> v7:
>>  - Fix code style issues on already present code touched by this patch
>>    series (Michael S. Tsirkin, Philippe Mathieu-Daud=C3=A9)
>>  - Add new files to MAINTAINERS (Michael S. Tsirkin, Philippe
>>    Mathieu-Daud=C3=A9)
>>  - Allow starting a microvm machine without a kernel image, fixing
>>    "qom-test" (Michael S. Tsirkin)
>>  - Change "bios-microvm.bin" mode to 0644 (Stefano Garzarella)
>>  - Remove unneeded "hw/i386/pc.h" include from x86.c (Stefano
>>    Garzarella)
>>
>> v6:
>>  - Some style fixes (Philippe Mathieu-Daud=C3=A9)
>>  - Fix a documentation bug stating that LAPIC was in userspace (Paolo
>>    Bonzini)
>>  - Update Xen HVM code after X86MachineState introduction (Philippe
>>    Mathieu-Daud=C3=A9)
>>  - Rename header guard from QEMU_VIRTIO_MMIO_H to HW_VIRTIO_MMIO_H
>>    (Philippe Mathieu-Daud=C3=A9)
>>
>> v5:
>>  - Drop unneeded "[PATCH v4 2/8] hw/i386: Factorize e820 related
>>    functions" (Philippe Mathieu-Daud=C3=A9)
>>  - Drop unneeded "[PATCH v4 1/8] hw/i386: Factorize PVH related
>>    functions" (Stefano Garzarella)
>>  - Split X86MachineState introduction into smaller patches (Philippe
>>    Mathieu-Daud=C3=A9)
>>  - Change option-roms to x-option-roms and kernel-cmdline to
>>    auto-kernel-cmdline (Paolo Bonzini)
>>  - Make i8259 PIT and i8254 PIC optional (Paolo Bonzini)
>>  - Some fixes to the documentation (Paolo Bonzini)
>>  - Switch documentation format from txt to rst (Peter Maydell)
>>  - Move NMI interface to X86_MACHINE (Philippe Mathieu-Daud=C3=A9, Pao=
lo
>>    Bonzini)
>>
>> v4:
>>  - This is a complete rewrite of the whole patchset, with a focus on
>>    reusing as much existing code as possible to ease the maintenance b=
urden
>>    and making the machine type as compatible as possible by default. A=
s
>>    a result, the number of lines dedicated specifically to microvm is
>>    383 (code lines measured by "cloc") and, with the default
>>    configuration, it's now able to boot both PVH ELF images and
>>    bzImages with either SeaBIOS or qboot.
>>
>> v3:
>>   - Add initrd support (thanks Stefano).
>>
>> v2:
>>   - Drop "[PATCH 1/4] hw/i386: Factorize CPU routine".
>>   - Simplify machine definition (thanks Eduardo).
>>   - Remove use of unneeded NUMA-related callbacks (thanks Eduardo).
>>   - Add a patch to factorize PVH-related functions.
>>   - Replace use of Linux's Zero Page with PVH (thanks Maran and Paolo)=
.
>>
>> ---
>>
>> Sergio Lopez (12):
>>   hw/virtio: Factorize virtio-mmio headers
>>   hw/i386/pc: rename functions shared with non-PC machines
>>   hw/i386/pc: fix code style issues on functions that will be moved ou=
t
>>   hw/i386/pc: move shared x86 functions to x86.c and export them
>>   hw/i386: split PCMachineState deriving X86MachineState from it
>>   hw/i386: make x86.c independent from PCMachineState
>>   fw_cfg: add "modify" functions for all types
>>   hw/intc/apic: reject pic ints if isa_pic =3D=3D NULL
>>   roms: add microvm-bios (qboot) as binary and git submodule
>>   docs/microvm.rst: document the new microvm machine type
>>   hw/i386: Introduce the microvm machine type
>>   MAINTAINERS: add microvm related files
>>
>>  docs/microvm.rst                 |  98 ++++
>>  default-configs/i386-softmmu.mak |   1 +
>>  include/hw/i386/microvm.h        |  83 ++++
>>  include/hw/i386/pc.h             |  28 +-
>>  include/hw/i386/x86.h            |  96 ++++
>>  include/hw/nvram/fw_cfg.h        |  42 ++
>>  include/hw/virtio/virtio-mmio.h  |  73 +++
>>  hw/acpi/cpu_hotplug.c            |  10 +-
>>  hw/i386/acpi-build.c             |  29 +-
>>  hw/i386/amd_iommu.c              |   3 +-
>>  hw/i386/intel_iommu.c            |   3 +-
>>  hw/i386/microvm.c                | 572 ++++++++++++++++++++++
>>  hw/i386/pc.c                     | 781 +++---------------------------
>>  hw/i386/pc_piix.c                |  46 +-
>>  hw/i386/pc_q35.c                 |  38 +-
>>  hw/i386/pc_sysfw.c               |  60 +--
>>  hw/i386/x86.c                    | 795 ++++++++++++++++++++++++++++++=
+
>>  hw/i386/xen/xen-hvm.c            |  28 +-
>>  hw/intc/apic.c                   |   2 +-
>>  hw/intc/ioapic.c                 |   2 +-
>>  hw/nvram/fw_cfg.c                |  29 ++
>>  hw/virtio/virtio-mmio.c          |  48 +-
>>  .gitmodules                      |   3 +
>>  MAINTAINERS                      |  10 +
>>  hw/i386/Kconfig                  |   4 +
>>  hw/i386/Makefile.objs            |   2 +
>>  pc-bios/bios-microvm.bin         | Bin 0 -> 65536 bytes
>>  roms/Makefile                    |   6 +
>>  roms/qboot                       |   1 +
>>  29 files changed, 1982 insertions(+), 911 deletions(-)
>>  create mode 100644 docs/microvm.rst
>>  create mode 100644 include/hw/i386/microvm.h
>>  create mode 100644 include/hw/i386/x86.h
>>  create mode 100644 include/hw/virtio/virtio-mmio.h
>>  create mode 100644 hw/i386/microvm.c
>>  create mode 100644 hw/i386/x86.c
>>  create mode 100644 pc-bios/bios-microvm.bin
>>  create mode 160000 roms/qboot
>>
>> --=20
>> 2.21.0



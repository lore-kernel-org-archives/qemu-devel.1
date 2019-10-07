Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0C5C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:50:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B91E20867
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B91E20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHTPV-0001i7-BS
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 09:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iHTJm-0005S5-3o
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iHTJk-00037W-Kr
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:44:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41548)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iHTJk-000327-C8
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:44:52 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9990D757C7
 for <qemu-devel@nongnu.org>; Mon,  7 Oct 2019 13:44:47 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id m14so7551818wru.17
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 06:44:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=PxvdHt61xVnbvo02bBwEkpU6PNJYvStVkXcyUJCs2jc=;
 b=n0efZ0d5xOA0B70t4mIbp+gfCJ6PvYmcB1us2AQK1yUCcmKgt0gEA5zKjVsKfJgUrg
 j649KcLAnR+z4rbz5PxOEZ1SOH12T7XU2uLBnt1vKPigmqlCrfLmzAgP0XKkZejEpQLJ
 mwLSGWQaP0o9vl/5ARkl1O44T4aGCzriUYOUeWDb2VUZu5Fgx9Lous5J8aTCpPRTOlx6
 y2NQo1pRCrQrjns60SKwWTr1lGMZjvrl715oYJTzuw4P3zZ+sHX1fUfCQvxsmGpU23Yo
 8OjBtu3vBMffb55iLugdnVGEzR7xoXI22J72/56hNFegN/hnLhmntgP/F1NeEUshTdoQ
 P44g==
X-Gm-Message-State: APjAAAVEEENNJPUb2Xh7pLlE8nwb+p7mBeO1XFSkYMJ86mApTkBUAFMw
 IpYNh5kNtWc9YVDGdop/ZqdNs8JD3axgyHV333Tpj+gX70wx0QXxD/wRdncpxVQLtDMcX2dLgOm
 x+Mr90XoaaQEUW/c=
X-Received: by 2002:a1c:7ed7:: with SMTP id
 z206mr22116452wmc.124.1570455886292; 
 Mon, 07 Oct 2019 06:44:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxewlrCRjxvyPpYaC8lpqR43jQngQPOFdBULlLRNvDa1xpvcAEb3QD1Pr8wNy05AMp2Mj460A==
X-Received: by 2002:a1c:7ed7:: with SMTP id
 z206mr22116426wmc.124.1570455886024; 
 Mon, 07 Oct 2019 06:44:46 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id d193sm18332960wmd.0.2019.10.07.06.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2019 06:44:45 -0700 (PDT)
References: <20191004093752.16564-1-slp@redhat.com>
 <20191005180721-mutt-send-email-mst@kernel.org>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6 00/10] Introduce the microvm machine type
In-reply-to: <20191005180721-mutt-send-email-mst@kernel.org>
Date: Mon, 07 Oct 2019 15:44:40 +0200
Message-ID: <87sgo4oek7.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
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

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Michael S. Tsirkin <mst@redhat.com> writes:

> On Fri, Oct 04, 2019 at 11:37:42AM +0200, Sergio Lopez wrote:
>> Microvm is a machine type inspired by Firecracker and constructed
>> after the its machine model.
>>=20
>> It's a minimalist machine type without PCI nor ACPI support, designed
>> for short-lived guests. Microvm also establishes a baseline for
>> benchmarking and optimizing both QEMU and guest operating systems,
>> since it is optimized for both boot time and footprint.
>
> Pls take a look at patchew warnings and errors.
> Both coding style issues and test failures need to be
> addressed somehow I think.

I've fixed the issue with the test suite, but I'm not sure what to do
about the coding style errors. Every one of them (except perhaps one at
xen-hvm.c) comes from code I've moved from pc.c to x86.c. I'd say fixing
those are outside the scope of the corresponding patches, but please
correct me if I'm wrong.

On the other hand, I haven't touched MAINTAINERS, because I'm not sure
about the actual policies that apply while doing so. Should I add the
new files to it?

Thanks,
Sergio.

>> ---
>>=20
>> Changelog
>> v6:
>>  - Some style fixes (Philippe Mathieu-Daud=C3=A9)
>>  - Fix a documentation bug stating that LAPIC was in userspace (Paolo
>>    Bonzini)
>>  - Update Xen HVM code after X86MachineState introduction (Philippe
>>    Mathieu-Daud=C3=A9)
>>  - Rename header guard from QEMU_VIRTIO_MMIO_H to HW_VIRTIO_MMIO_H
>>    (Philippe Mathieu-Daud=C3=A9)
>>=20
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
>>  - Move NMI interface to X86_MACHINE (Philippe Mathieu-Daud=C3=A9, Paolo
>>    Bonzini)
>>=20
>> v4:
>>  - This is a complete rewrite of the whole patchset, with a focus on
>>    reusing as much existing code as possible to ease the maintenance bur=
den
>>    and making the machine type as compatible as possible by default. As
>>    a result, the number of lines dedicated specifically to microvm is
>>    383 (code lines measured by "cloc") and, with the default
>>    configuration, it's now able to boot both PVH ELF images and
>>    bzImages with either SeaBIOS or qboot.
>>=20
>> v3:
>>   - Add initrd support (thanks Stefano).
>>=20
>> v2:
>>   - Drop "[PATCH 1/4] hw/i386: Factorize CPU routine".
>>   - Simplify machine definition (thanks Eduardo).
>>   - Remove use of unneeded NUMA-related callbacks (thanks Eduardo).
>>   - Add a patch to factorize PVH-related functions.
>>   - Replace use of Linux's Zero Page with PVH (thanks Maran and Paolo).
>>=20
>> ---
>> Sergio Lopez (10):
>>   hw/virtio: Factorize virtio-mmio headers
>>   hw/i386/pc: rename functions shared with non-PC machines
>>   hw/i386/pc: move shared x86 functions to x86.c and export them
>>   hw/i386: split PCMachineState deriving X86MachineState from it
>>   hw/i386: make x86.c independent from PCMachineState
>>   fw_cfg: add "modify" functions for all types
>>   hw/intc/apic: reject pic ints if isa_pic =3D=3D NULL
>>   roms: add microvm-bios (qboot) as binary and git submodule
>>   docs/microvm.rst: document the new microvm machine type
>>   hw/i386: Introduce the microvm machine type
>>=20
>>  docs/microvm.rst                 |  98 ++++
>>  default-configs/i386-softmmu.mak |   1 +
>>  include/hw/i386/microvm.h        |  83 ++++
>>  include/hw/i386/pc.h             |  28 +-
>>  include/hw/i386/x86.h            |  94 ++++
>>  include/hw/nvram/fw_cfg.h        |  42 ++
>>  include/hw/virtio/virtio-mmio.h  |  73 +++
>>  hw/acpi/cpu_hotplug.c            |  10 +-
>>  hw/i386/acpi-build.c             |  29 +-
>>  hw/i386/amd_iommu.c              |   3 +-
>>  hw/i386/intel_iommu.c            |   3 +-
>>  hw/i386/microvm.c                | 574 ++++++++++++++++++++++
>>  hw/i386/pc.c                     | 780 +++---------------------------
>>  hw/i386/pc_piix.c                |  46 +-
>>  hw/i386/pc_q35.c                 |  38 +-
>>  hw/i386/pc_sysfw.c               |  58 +--
>>  hw/i386/x86.c                    | 790 +++++++++++++++++++++++++++++++
>>  hw/i386/xen/xen-hvm.c            |  23 +-
>>  hw/intc/apic.c                   |   2 +-
>>  hw/intc/ioapic.c                 |   2 +-
>>  hw/nvram/fw_cfg.c                |  29 ++
>>  hw/virtio/virtio-mmio.c          |  48 +-
>>  .gitmodules                      |   3 +
>>  hw/i386/Kconfig                  |   4 +
>>  hw/i386/Makefile.objs            |   2 +
>>  pc-bios/bios-microvm.bin         | Bin 0 -> 65536 bytes
>>  roms/Makefile                    |   6 +
>>  roms/qboot                       |   1 +
>>  28 files changed, 1963 insertions(+), 907 deletions(-)
>>  create mode 100644 docs/microvm.rst
>>  create mode 100644 include/hw/i386/microvm.h
>>  create mode 100644 include/hw/i386/x86.h
>>  create mode 100644 include/hw/virtio/virtio-mmio.h
>>  create mode 100644 hw/i386/microvm.c
>>  create mode 100644 hw/i386/x86.c
>>  create mode 100755 pc-bios/bios-microvm.bin
>>  create mode 160000 roms/qboot
>>=20
>> --=20
>> 2.21.0


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2bQUgACgkQ9GknjS8M
AjXzxhAAs0y+xOAqLfX6TQ2Xq8FV1U2gGjkYV3Ia43vxdeYcZSRfGsIDWC23KGOL
qoF7+pVHPk4h0OmGoAMAd/I0um3igssIRgQ6vPFFgDJCGAomAJ2J/hWZKhvBX3Ld
i1n2Oe15mKg0tH7TyaoM3DZaiWsiFef4GwCyDwJuqZsxobrVHAXW0a7YevGMh/lJ
DfwlQdsqTg7DehbAP8qxzla6qw7gwQrQU/2Zlo/qOhrGD5Z1RBMzeLj2wQ26d2ey
LNWOJKXjVZuBQrjc5BMzzyrEZa5yKFDYOhIbDkadzS6R5nZ+XQj++u2PP26Hev9c
IlYPQYc4qjz9Ff5VrhjS9C+S+IOlkP8f+8ABLdYo5+DuPG6pYAp3hByQDcAAvAgw
DIXOYjc/DeDrxZsrMw/w44HJz9JjHrKQ27XReHVs7CvmLefOV9fAdqQe8nAC4DRz
X91++wYQApcMAgiiPVmjmQ7q7iexKGqaXHUk1MNYn1X7nZaP6yFfjpzhzY25AiKu
sM2EzwO2A5e1x3e8+8N8v+MjXAtm2goFhj4Qpk1JJSzLgMUcigGI8hcEl2GsdCv+
BRGwLIz26yeh9o/24JLoPy/1VFGEiAhoOrjmGWX1I1WvYR9x/P6N7VJtD9VIuaEf
Rb1oLnqLgwHElmtMTM3QsWsBkTN6NJu8F/mSDzsqaGCftiXAp0Q=
=EtPC
-----END PGP SIGNATURE-----
--=-=-=--


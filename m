Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C1DC10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 09:16:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F9E2067B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 09:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F9E2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIUYU-0007rU-RH
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 05:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iIUXT-00078r-CL
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 05:15:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iIUXR-0000Ly-E1
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 05:15:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35736)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iIUXR-0000Il-5E
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 05:15:13 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 145A38E584
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 09:15:11 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id y18so2434926wrw.8
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 02:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=uAj8ZgJA0/Wne9MKUd7Krp3v+SVQnHVQW7VqyTNIiyU=;
 b=RJPzJhGjm+QmQY3GVl5cZhC2Xcarr/NEY/WVXbM1kPj7OS3K/REstyT/0Zzsgkna1i
 Hxp29Ah/y9F79UL+SAgAZArwiBuxs6I6FOeeVYC/AHs7EEN5o1sSQCO/iuIj8Lyq8ZGF
 vPfAePeKppesdnvO2fnrXkdWLhBlK4eLBKQ5kHs4ZRDWyPegzpOo5tYz6VMfG1UzNz69
 oc/cN3mRteJiv5O+HOi04hqaVWmRP3hxrKumbS84HRDa049r/2b4OpTvsJtapAKYOg64
 lZS2N/PlAfX/0vp1hNXEOUPOusQ1n8ISF6N7Qdk6tUogb5GOMId5hm8xPyyRUpjcXuH1
 looA==
X-Gm-Message-State: APjAAAWFyK4J0nOwJkw0pxAYe0OioIC1eJi42/RjK627ripRp1T5C/VJ
 vsDcclc5/d/bnU0wsjJT3+n+idlt2CisQjXOeZeh92xUfymDx5dAN1ZzD+0QiD0ieOJu/73qoM1
 tgyAdVyhnsTLb7MQ=
X-Received: by 2002:a5d:6551:: with SMTP id z17mr7304560wrv.386.1570698909709; 
 Thu, 10 Oct 2019 02:15:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxerRii7Lrc3BkzrZ0n1ouz1cuzw+2AgnsVw6o2zFxy6dcPD9CENLtvoC3WJAIKC0h9W393aA==
X-Received: by 2002:a5d:6551:: with SMTP id z17mr7304531wrv.386.1570698909461; 
 Thu, 10 Oct 2019 02:15:09 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id q19sm11283995wra.89.2019.10.10.02.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2019 02:15:08 -0700 (PDT)
References: <20191008135537.197867-1-slp@redhat.com>
 <20191009152542-mutt-send-email-mst@kernel.org>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v7 00/12] Introduce the microvm machine type
In-reply-to: <20191009152542-mutt-send-email-mst@kernel.org>
Date: Thu, 10 Oct 2019 11:15:06 +0200
Message-ID: <87woddrmg5.fsf@redhat.com>
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

> On Tue, Oct 08, 2019 at 03:55:26PM +0200, Sergio Lopez wrote:
>> Microvm is a machine type inspired by Firecracker and constructed
>> after the its machine model.
>>=20
>> It's a minimalist machine type without PCI nor ACPI support, designed
>> for short-lived guests. Microvm also establishes a baseline for
>> benchmarking and optimizing both QEMU and guest operating systems,
>> since it is optimized for both boot time and footprint.
>
> Looks good overall. I think coding style needs to
> be fixed but that's a patch on top.

v7 includes patch "[PATCH v7 03/12] hw/i386/pc: fix code style issues on
functions that will be moved out". Or do you mean some other coding
style issues?

Thanks,
Sergio.

> series:
>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>
> Paolo I assume you will be merging this?
>
>
>> ---
>>=20
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
>>=20
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
>>=20
>> Sergio Lopez (12):
>>   hw/virtio: Factorize virtio-mmio headers
>>   hw/i386/pc: rename functions shared with non-PC machines
>>   hw/i386/pc: fix code style issues on functions that will be moved out
>>   hw/i386/pc: move shared x86 functions to x86.c and export them
>>   hw/i386: split PCMachineState deriving X86MachineState from it
>>   hw/i386: make x86.c independent from PCMachineState
>>   fw_cfg: add "modify" functions for all types
>>   hw/intc/apic: reject pic ints if isa_pic =3D=3D NULL
>>   roms: add microvm-bios (qboot) as binary and git submodule
>>   docs/microvm.rst: document the new microvm machine type
>>   hw/i386: Introduce the microvm machine type
>>   MAINTAINERS: add microvm related files
>>=20
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
>>  hw/i386/x86.c                    | 795 +++++++++++++++++++++++++++++++
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
>>=20
>> --=20
>> 2.21.0


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2e9poACgkQ9GknjS8M
AjWoxg//fogBr5Oc2joIUBYO+j71LhoU5/8fGrV9ZiAW8L/hOVhWrHiYr0AHI1Mc
h2sQrCbmcj5TGWyXkpeCQN+ZtZ3RWfI98Fd0Zimdz8n7CSH5COZpkijqz6O7Ba+G
buxq/xzCiopkQ8U06VVkFVnjJHsnLNuwcNai8+oOE7spdb3mNJ9KQeDOgNuLEZbJ
WrDJyBJxcwQr+fav0TpoaYRJvXby/b3yhpk/kFQYIhXa1slW75B8GhzfBQT8VObr
RW1x32tNfc/a1PIQW/N198gK5jAJLnkzqTad36cHyLSg/pwm7Mgbti14AkrFJslW
Ru+t5eDGPtKzGn9+OUK3GNu1eFjwQ0jazWoskGLlUaQwdim6znui19w7BzE2NtRy
TD/kZ3JFF+NzCHOohQJBgVMdMDD/jpKLQ1woW8L7QTDCPCOHxByW5mwHg5V3+++r
kgsITJZyXzC+tek/MD3o/Jq4aCy/DOdB3yFW/WH5wBE9t/o5r80/xkS5OrY6NyuR
/kGWMPrEb6Dbo6JJZHnGQ3sKyyNdw9OHBxXr/NZFcQX0leDVeHVHv2b9LtLbn+vq
t1jntDST+i0+wRMv2ub7X5zqqDyF7T9MDB+Rjq0r6CyrC9mW4z0GT4G8aUHG/FLW
t7ch1wGbkzkSmungVoP883lTsuuqpsMobNRNJRe0KgAZqU0Xs7Y=
=KtGr
-----END PGP SIGNATURE-----
--=-=-=--


Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE76C4BA24
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 21:01:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 108CF21D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 21:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MpbbY2j5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108CF21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j73oG-0008F7-6o
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 16:01:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j73ml-0006MA-JU
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 16:00:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j73mj-00024x-9J
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 16:00:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39704
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j73mj-000240-0o
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 16:00:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582750800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0YKMlyGuoIcwWg/c6bXsYuxY7W4Gnue7WrH8sG32TrY=;
 b=MpbbY2j5UrnXnTIuUYs/ggJc80RfUK/VeIm2nL/27qKP7vFvCg7W9a0E21PDH+qRM5FGjk
 IS2Af8djBsPo4y4ZgKzGR0Ai2vpAv3iNld1G5HvMMwQzm64WckAm1/V2vKGWBkbrefWCgY
 TiehG/mHs46Mp4szfoy/LDhX/bQVPi4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-E3tT7AL8M7GgzTNvOlWObQ-1; Wed, 26 Feb 2020 15:59:57 -0500
X-MC-Unique: E3tT7AL8M7GgzTNvOlWObQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90BC6800D5A;
 Wed, 26 Feb 2020 20:59:56 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D6605C578;
 Wed, 26 Feb 2020 20:59:48 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, stefanb@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Subject: [PATCH v4 00/10] vTPM for aarch64
Date: Wed, 26 Feb 2020 21:59:32 +0100
Message-Id: <20200226205942.11424-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: marcandre.lureau@redhat.com, lersek@redhat.com, ardb@kernel.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds the capability to instantiate an MMIO TPM TIS
in ARM virt. It is candidate to qemu 5.0.

The existing TPM TIS code is reshuffled into a generic part,
the ISA device and the sysbus device. The sysbus TPM-TIS
device gets dynamically instantiated in machvirt on the
platform bus.

ACPI boot is not yet supported on ARM. Note that the UEFI
firmware is itself a consumer of the DT description, so we
need the DT related changes regardless of whether the VM
boots in DT or ACPI mode.

Related qtests are reshuffled to allow the reuse of existing
tests for both the ISA and the sysbus devices: Adaption
consists in changing the qemu command line (change in the
device name and provide explicit machine options) and adapt
to the relocation of the TPM-TIS device in the memory map.

The series was tested with the swtpm/libtpms emulator.
Automatic guest LUKS volume unlocking (tpm2) was successful.
EDK2 support is under development [3]. Thanks to Ard
for supporting me when setting up the test environment.

Best Regards

Eric

Testing:

mkdir /tmp/tpm
swtpm socket \
--tpm2 \
-t -d \
--tpmstate dir=3D/tmp/tpm \
--ctrl type=3Dunixio,path=3D/tmp/swtpm-sock

qemu command line must be augmented with the following options:

-chardev socket,id=3Dchrtpm,path=3D/tmp/swtpm-sock \
-tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
-device tpm-tis-device,tpmdev=3Dtpm0 \

References:
[1] libtpms: https://github.com/stefanberger/libtpms/wiki
[2] swtpm: https://github.com/stefanberger/swtpm/wiki
[3] [PATCH v3 0/9] ArmVirtPkg: implement measured boot for ArmVirtQemu

This series can be found at:
https://github.com/eauger/qemu/tree/v4.2.0-tpm-patch-v4

History:

v3 -> v4:
- collect additional R-b's
- add 'Not used but needed for linking' mention related to
  tpm_tis_base_addr in CRB test files
- fix comment style

RFCv2 -> PATCH v3:
- Updated the doc for ARM
- Adapted existing tests for ARM
- use qemu_fdt_setprop_string in add_tpm_tis_fdt_node
- Collected R-b's
- Comments not taken into account:
  - I have kept the tpm-tis-device name for now despite Stefan's
    suggestion to rename it into tpm-tis-sysbus. This is not
    frozen though
  - Common state still is not a QOM object (no double inheritence)

RFC v1 -> RFC v2:
- restructure the existing code with common, ISA and sysbus part.
- both ARM and x86 integration were tested.

Eric Auger (10):
  tpm: rename TPM_TIS into TPM_TIS_ISA
  tpm: Use TPMState as a common struct
  tpm: Separate tpm_tis common functions from isa code
  tpm: Separate TPM_TIS and TPM_TIS_ISA configs
  tpm: Add the SysBus TPM TIS device
  hw/arm/virt: vTPM support
  docs/specs/tpm: Document TPM_TIS sysbus device for ARM
  test: tpm: pass optional machine options to swtpm test functions
  test: tpm-tis: Get prepared to share tests between ISA and sysbus
    devices
  test: tpm-tis: Add Sysbus TPM-TIS device test

 default-configs/i386-softmmu.mak        |   2 +-
 docs/specs/tpm.rst                      |  25 +-
 hw/arm/Kconfig                          |   1 +
 hw/arm/sysbus-fdt.c                     |  33 ++
 hw/arm/virt.c                           |   7 +
 hw/i386/Kconfig                         |   2 +-
 hw/i386/acpi-build.c                    |   6 +-
 hw/tpm/Kconfig                          |  12 +-
 hw/tpm/Makefile.objs                    |   4 +-
 hw/tpm/tpm_tis.h                        |  91 +++++
 hw/tpm/{tpm_tis.c =3D> tpm_tis_common.c}  | 181 +---------
 hw/tpm/tpm_tis_isa.c                    | 170 +++++++++
 hw/tpm/tpm_tis_sysbus.c                 | 159 +++++++++
 include/sysemu/tpm.h                    |   7 +-
 tests/qtest/Makefile.include            |  11 +-
 tests/qtest/tpm-crb-swtpm-test.c        |   9 +-
 tests/qtest/tpm-crb-test.c              |   3 +
 tests/qtest/tpm-tests.c                 |  10 +-
 tests/qtest/tpm-tests.h                 |   5 +-
 tests/qtest/tpm-tis-device-swtpm-test.c |  76 ++++
 tests/qtest/tpm-tis-device-test.c       |  87 +++++
 tests/qtest/tpm-tis-swtpm-test.c        |   8 +-
 tests/qtest/tpm-tis-test.c              | 414 +---------------------
 tests/qtest/tpm-tis-util.c              | 451 ++++++++++++++++++++++++
 tests/qtest/tpm-tis-util.h              |  23 ++
 tests/qtest/tpm-util.c                  |  11 +-
 tests/qtest/tpm-util.h                  |   8 +-
 27 files changed, 1207 insertions(+), 609 deletions(-)
 create mode 100644 hw/tpm/tpm_tis.h
 rename hw/tpm/{tpm_tis.c =3D> tpm_tis_common.c} (85%)
 create mode 100644 hw/tpm/tpm_tis_isa.c
 create mode 100644 hw/tpm/tpm_tis_sysbus.c
 create mode 100644 tests/qtest/tpm-tis-device-swtpm-test.c
 create mode 100644 tests/qtest/tpm-tis-device-test.c
 create mode 100644 tests/qtest/tpm-tis-util.c
 create mode 100644 tests/qtest/tpm-tis-util.h

--=20
2.20.1



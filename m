Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5F0C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 23:02:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB35920830
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 23:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB35920830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50205 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDzl2-0006Io-Oo
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 19:02:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDzjJ-0005B5-H2
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:00:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDzjI-00016O-0b
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:00:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hDzjH-00015W-NG
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:00:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9EA30C05B1CD;
	Tue,  9 Apr 2019 23:00:34 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-114.rdu2.redhat.com
	[10.10.120.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 611A51001DC0;
	Tue,  9 Apr 2019 23:00:25 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: berrange@redhat.com, eblake@redhat.com, f4bug@amsat.org,
	imammedo@redhat.com, kraxel@redhat.com, mprivozn@redhat.com,
	mst@redhat.com, peter.maydell@linaro.org, philmd@redhat.com,
	qemu-devel@nongnu.org
Date: Wed, 10 Apr 2019 01:00:10 +0200
Message-Id: <20190409230022.6462-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Tue, 09 Apr 2019 23:00:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.1 v4 00/12] bundle edk2 platform firmware
 with QEMU
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409230010.TPqHO_KptTaUHt4OTGM5KMPRhhDXr6Bn6eybNfqkgM4@z>

Repo:   https://github.com/lersek/qemu.git
Branch: edk2_build_v4

Posting a v4 is necessary because patch #6 needs
- manual conflict resolution against some commits between v4.0.0-rc2 and
  v4.0.0-rc3,
- and corresponding commit message updates.

These are noted in more detail on the patch itself:

  [PATCH for-4.1 v4 06/12]
  roms/Makefile: replace the $(EDK2_EFIROM) target with "edk2-basetools"

Due to this update, I had to drop all previous feedback tags on this
patch. I plan to send a pullreq as soon as 4.0 is released, so please
re-review / retest the above patch (and *only* the above patch) soon.
(The notes on the patch list the tags individually that I've now
dropped.)

Version 3, that is:

  [Qemu-devel] [PATCH for-4.1 v3 00/12] bundle edk2 platform firmware wit=
h QEMU

was posted at:

  https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg06148.html
  http://mid.mail-archive.com/20190321113408.19929-1-lersek@redhat.com

Thanks,
Laszlo

Laszlo Ersek (12):
  roms: lift "edk2-funcs.sh" from "tests/uefi-test-tools/build.sh"
  roms/edk2-funcs.sh: require gcc-4.8+ for building i386 and x86_64
  tests/uefi-test-tools/build.sh: work around TianoCore#1607
  roms/edk2: advance to tag edk2-stable201903
  roms/edk2-funcs.sh: add the qemu_edk2_get_thread_count() function
  roms/Makefile: replace the $(EDK2_EFIROM) target with "edk2-basetools"
  roms: build edk2 firmware binaries and variable store templates
  pc-bios: add edk2 firmware binaries and variable store templates
  pc-bios: document the edk2 firmware images; add firmware descriptors
  tests: add missing dependency to build QTEST_QEMU_BINARY, round 2
  Makefile: install the edk2 firmware images and their descriptors
  MAINTAINERS: add the "EDK2 Firmware" subsystem

 .gitignore                                     |   1 +
 MAINTAINERS                                    |  12 +
 Makefile                                       |  29 ++-
 configure                                      |   1 +
 pc-bios/README                                 |  11 +
 pc-bios/descriptors/50-edk2-i386-secure.json   |  34 +++
 pc-bios/descriptors/50-edk2-x86_64-secure.json |  35 +++
 pc-bios/descriptors/60-edk2-aarch64.json       |  31 +++
 pc-bios/descriptors/60-edk2-arm.json           |  31 +++
 pc-bios/descriptors/60-edk2-i386.json          |  33 +++
 pc-bios/descriptors/60-edk2-x86_64.json        |  34 +++
 pc-bios/edk2-aarch64-code.fd.bz2               | Bin 0 -> 1177603 bytes
 pc-bios/edk2-arm-code.fd.bz2                   | Bin 0 -> 1173662 bytes
 pc-bios/edk2-arm-vars.fd.bz2                   | Bin 0 -> 263 bytes
 pc-bios/edk2-i386-code.fd.bz2                  | Bin 0 -> 1688659 bytes
 pc-bios/edk2-i386-secure-code.fd.bz2           | Bin 0 -> 1881979 bytes
 pc-bios/edk2-i386-vars.fd.bz2                  | Bin 0 -> 190 bytes
 pc-bios/edk2-licenses.txt                      | 209 ++++++++++++++++
 pc-bios/edk2-x86_64-code.fd.bz2                | Bin 0 -> 1669280 bytes
 pc-bios/edk2-x86_64-secure-code.fd.bz2         | Bin 0 -> 1901210 bytes
 roms/Makefile                                  |   9 +-
 roms/Makefile.edk2                             | 148 ++++++++++++
 roms/edk2                                      |   2 +-
 roms/edk2-build.sh                             |  55 +++++
 roms/edk2-funcs.sh                             | 253 +++++++++++++++++++=
+
 tests/Makefile.include                         |   2 +-
 tests/uefi-test-tools/build.sh                 | 100 +-------
 27 files changed, 934 insertions(+), 96 deletions(-)
 create mode 100644 pc-bios/descriptors/50-edk2-i386-secure.json
 create mode 100644 pc-bios/descriptors/50-edk2-x86_64-secure.json
 create mode 100644 pc-bios/descriptors/60-edk2-aarch64.json
 create mode 100644 pc-bios/descriptors/60-edk2-arm.json
 create mode 100644 pc-bios/descriptors/60-edk2-i386.json
 create mode 100644 pc-bios/descriptors/60-edk2-x86_64.json
 create mode 100644 pc-bios/edk2-aarch64-code.fd.bz2
 create mode 100644 pc-bios/edk2-arm-code.fd.bz2
 create mode 100644 pc-bios/edk2-arm-vars.fd.bz2
 create mode 100644 pc-bios/edk2-i386-code.fd.bz2
 create mode 100644 pc-bios/edk2-i386-secure-code.fd.bz2
 create mode 100644 pc-bios/edk2-i386-vars.fd.bz2
 create mode 100644 pc-bios/edk2-licenses.txt
 create mode 100644 pc-bios/edk2-x86_64-code.fd.bz2
 create mode 100644 pc-bios/edk2-x86_64-secure-code.fd.bz2
 create mode 100644 roms/Makefile.edk2
 create mode 100755 roms/edk2-build.sh
 create mode 100644 roms/edk2-funcs.sh

--=20
2.19.1.3.g30247aa5d201



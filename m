Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57F0C10F03
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 10:53:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8872A217D7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 10:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8872A217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55172 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJc0i-0004bZ-Iv
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 06:53:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hJbyr-0003TK-36
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 06:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hJbqs-0000SQ-Mn
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 06:43:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hJbqs-0000QT-HW
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 06:43:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CD77CC0528AC
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 10:43:37 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-105.rdu2.redhat.com
	[10.10.120.105])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A16FC5D9C5;
	Thu, 25 Apr 2019 10:43:35 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu devel list <qemu-devel@nongnu.org>
Date: Thu, 25 Apr 2019 12:43:26 +0200
Message-Id: <20190425104326.12835-3-lersek@redhat.com>
In-Reply-To: <20190425104326.12835-1-lersek@redhat.com>
References: <20190425104326.12835-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Thu, 25 Apr 2019 10:43:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/2] tests/uefi-boot-images: report the SMBIOS
 entry point structures
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
Cc: Igor Mammedov <imammedo@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425104326.hTZrRz0BOf2_ncU3prJmxQI8qp_z7-x7rpgNiiYfWLc@z>

Rebuild the "bios-tables-test" UEFI boot images with the SMBIOS entry
point reporting that has been added in the previous patch.

Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Launchpad: https://bugs.launchpad.net/qemu/+bug/1821884
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---
 tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2 | Bin 117=
76 -> 12288 bytes
 tests/data/uefi-boot-images/bios-tables-test.arm.iso.qcow2     | Bin 117=
76 -> 11776 bytes
 tests/data/uefi-boot-images/bios-tables-test.i386.iso.qcow2    | Bin 128=
00 -> 13312 bytes
 tests/data/uefi-boot-images/bios-tables-test.x86_64.iso.qcow2  | Bin 133=
12 -> 13312 bytes
 4 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qco=
w2 b/tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2
index ac0b7b1b8f89..d588cf3ebd7d 100644
Binary files a/tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.q=
cow2 and b/tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2=
 differ
diff --git a/tests/data/uefi-boot-images/bios-tables-test.arm.iso.qcow2 b=
/tests/data/uefi-boot-images/bios-tables-test.arm.iso.qcow2
index d20fa7c81925..552c7a7ddce6 100644
Binary files a/tests/data/uefi-boot-images/bios-tables-test.arm.iso.qcow2=
 and b/tests/data/uefi-boot-images/bios-tables-test.arm.iso.qcow2 differ
diff --git a/tests/data/uefi-boot-images/bios-tables-test.i386.iso.qcow2 =
b/tests/data/uefi-boot-images/bios-tables-test.i386.iso.qcow2
index 26c882baeaba..c66ad155196d 100644
Binary files a/tests/data/uefi-boot-images/bios-tables-test.i386.iso.qcow=
2 and b/tests/data/uefi-boot-images/bios-tables-test.i386.iso.qcow2 diffe=
r
diff --git a/tests/data/uefi-boot-images/bios-tables-test.x86_64.iso.qcow=
2 b/tests/data/uefi-boot-images/bios-tables-test.x86_64.iso.qcow2
index 9ec3c1f20bb2..f59e07c85415 100644
Binary files a/tests/data/uefi-boot-images/bios-tables-test.x86_64.iso.qc=
ow2 and b/tests/data/uefi-boot-images/bios-tables-test.x86_64.iso.qcow2 d=
iffer
--=20
2.19.1.3.g30247aa5d201



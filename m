Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE71C282DA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 23:11:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF44420857
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 23:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF44420857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50354 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDztZ-0005hm-Qe
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 19:11:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDzkJ-00067A-Io
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDzkI-0001rJ-Lj
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:01:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hDzkI-0001qu-Ev
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:01:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C20132D7FE;
	Tue,  9 Apr 2019 23:01:37 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-114.rdu2.redhat.com
	[10.10.120.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 938E11001DC0;
	Tue,  9 Apr 2019 23:01:33 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: berrange@redhat.com, eblake@redhat.com, f4bug@amsat.org,
	imammedo@redhat.com, kraxel@redhat.com, mprivozn@redhat.com,
	mst@redhat.com, peter.maydell@linaro.org, philmd@redhat.com,
	qemu-devel@nongnu.org
Date: Wed, 10 Apr 2019 01:00:22 +0200
Message-Id: <20190409230022.6462-13-lersek@redhat.com>
In-Reply-To: <20190409230022.6462-1-lersek@redhat.com>
References: <20190409230022.6462-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Tue, 09 Apr 2019 23:01:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.1 v4 12/12] MAINTAINERS: add the "EDK2
 Firmware" subsystem
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
Message-ID: <20190409230022.-fRqglCqbA9JdSqBdZvRV-a6IVRr-BuSwPl1wFKTV80@z>

We now have the edk2 submodule, somewhat elaborate build helpers for it,
and even a UEFI application written against edk2 whose genuine home is th=
e
QEMU repository. Add the "EDK2 Firmware" subsystem such that all relevant
pathnames be covered.

Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---

Notes:
    v4:
   =20
    - no change
   =20
    v3:
   =20
    - pick up Michal's R-b
   =20
    - pick up Phil's R-b/T-b
   =20
    - pick up Igor's T-b
   =20
    - pick up Michael's R-b
   =20
    v2:
   =20
    - new patch [Dan, Michael, Phil]
   =20
    - compared to the suggestions, upgrade the maintenance status ("S") f=
rom
      Maintained to Supported

 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 56139ac8ab05..d7505e074a0d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2222,6 +2222,18 @@ F: include/hw/i2c/smbus_master.h
 F: include/hw/i2c/smbus_slave.h
 F: include/hw/i2c/smbus_eeprom.h
=20
+EDK2 Firmware
+M: Laszlo Ersek <lersek@redhat.com>
+M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
+S: Supported
+F: pc-bios/descriptors/??-edk2-*.json
+F: pc-bios/edk2-*
+F: roms/Makefile.edk2
+F: roms/edk2
+F: roms/edk2-*
+F: tests/data/uefi-boot-images/
+F: tests/uefi-test-tools/
+
 Usermode Emulation
 ------------------
 Overall
--=20
2.19.1.3.g30247aa5d201



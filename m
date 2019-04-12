Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3459EC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 16:57:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07FAC2075B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 16:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FAC2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40073 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEzUR-0003SO-71
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 12:57:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEzRi-0000nK-0I
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEzRf-0006Sn-VE
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:54:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hEzRZ-00065U-TA; Fri, 12 Apr 2019 12:54:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 318E6308FC4D;
	Fri, 12 Apr 2019 16:54:23 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-66.brq.redhat.com [10.40.204.66])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9627360BFC;
	Fri, 12 Apr 2019 16:54:18 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Date: Fri, 12 Apr 2019 18:54:04 +0200
Message-Id: <20190412165416.7977-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Fri, 12 Apr 2019 16:54:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 00/12] hw: Remove "hw/devices.h"
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
Cc: Thomas Huth <thuth@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412165404.tUWTMF4oc_i-RGBabeXOu-XYe52qySYsCUPhPuXaxqE@z>

Hi,

As his first comment describes itself, the "hw/devices.h" contains
declarations for "Devices that have nowhere better to go."
This series remove it, creating new headers for devices covered there.
MAINTAINERS is updated.
I also included 2 cleanups while working on this, in "qemu/typedefs.h"
and "hw/net/ne2000-isa.h" header guard.

v3:
- rebased
- added 2 patches suggested by Markus
- addressed Markus review comments
- added Markus's R-b

v2: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg00925.html
- added R-b, T-b tags
- addressed many review comments from Thomas

v1: https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00611.html

Phil.

$ git backport-diff -u remove_hw_devices-v2
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/12:[----] [-C] 'hw/arm/aspeed: Use TYPE_TMP105/TYPE_PCA9552 instead o=
f hardcoded string'
002/12:[down] 'hw/arm/nseries: Use TYPE_TMP105 instead of hardcoded strin=
g'
003/12:[down] 'hw/display/tc6393xb: Remove unused functions'
004/12:[0006] [FC] 'hw/devices: Move TC6393XB declarations into a new hea=
der'
005/12:[----] [-C] 'hw/devices: Move Blizzard declarations into a new hea=
der'
006/12:[----] [-C] 'hw/devices: Move CBus declarations into a new header'
007/12:[0002] [FC] 'hw/devices: Move Gamepad declarations into a new head=
er'
008/12:[0002] [FC] 'hw/devices: Move TI touchscreen declarations into a n=
ew header'
009/12:[----] [--] 'hw/devices: Move LAN9118 declarations into a new head=
er'
010/12:[----] [--] 'hw/net/ne2000-isa: Add guards to the header'
011/12:[----] [--] 'hw/net/lan9118: Export TYPE_LAN9118 and use it instea=
d of hardcoded string'
012/12:[----] [--] 'hw/devices: Move SMSC 91C111 declaration into a new h=
eader'

Philippe Mathieu-Daud=C3=A9 (12):
  hw/arm/aspeed: Use TYPE_TMP105/TYPE_PCA9552 instead of hardcoded
    string
  hw/arm/nseries: Use TYPE_TMP105 instead of hardcoded string
  hw/display/tc6393xb: Remove unused functions
  hw/devices: Move TC6393XB declarations into a new header
  hw/devices: Move Blizzard declarations into a new header
  hw/devices: Move CBus declarations into a new header
  hw/devices: Move Gamepad declarations into a new header
  hw/devices: Move TI touchscreen declarations into a new header
  hw/devices: Move LAN9118 declarations into a new header
  hw/net/ne2000-isa: Add guards to the header
  hw/net/lan9118: Export TYPE_LAN9118 and use it instead of hardcoded
    string
  hw/devices: Move SMSC 91C111 declaration into a new header

 MAINTAINERS                   |  7 ++++
 hw/arm/aspeed.c               | 13 +++++---
 hw/arm/exynos4_boards.c       |  3 +-
 hw/arm/gumstix.c              |  2 +-
 hw/arm/integratorcp.c         |  2 +-
 hw/arm/kzm.c                  |  2 +-
 hw/arm/mainstone.c            |  2 +-
 hw/arm/mps2-tz.c              |  3 +-
 hw/arm/mps2.c                 |  2 +-
 hw/arm/nseries.c              |  7 ++--
 hw/arm/palm.c                 |  2 +-
 hw/arm/realview.c             |  3 +-
 hw/arm/stellaris.c            |  2 +-
 hw/arm/tosa.c                 |  2 +-
 hw/arm/versatilepb.c          |  2 +-
 hw/arm/vexpress.c             |  2 +-
 hw/display/blizzard.c         |  2 +-
 hw/display/tc6393xb.c         | 18 +---------
 hw/input/stellaris_input.c    |  2 +-
 hw/input/tsc2005.c            |  2 +-
 hw/input/tsc210x.c            |  4 +--
 hw/misc/cbus.c                |  2 +-
 hw/net/lan9118.c              |  3 +-
 hw/net/smc91c111.c            |  2 +-
 include/hw/arm/omap.h         |  6 +---
 include/hw/devices.h          | 62 -----------------------------------
 include/hw/display/blizzard.h | 22 +++++++++++++
 include/hw/display/tc6393xb.h | 24 ++++++++++++++
 include/hw/input/gamepad.h    | 19 +++++++++++
 include/hw/input/tsc2xxx.h    | 36 ++++++++++++++++++++
 include/hw/misc/cbus.h        | 32 ++++++++++++++++++
 include/hw/net/lan9118.h      | 21 ++++++++++++
 include/hw/net/ne2000-isa.h   |  6 ++++
 include/hw/net/smc91c111.h    | 19 +++++++++++
 include/qemu/typedefs.h       |  1 -
 35 files changed, 226 insertions(+), 113 deletions(-)
 delete mode 100644 include/hw/devices.h
 create mode 100644 include/hw/display/blizzard.h
 create mode 100644 include/hw/display/tc6393xb.h
 create mode 100644 include/hw/input/gamepad.h
 create mode 100644 include/hw/input/tsc2xxx.h
 create mode 100644 include/hw/misc/cbus.h
 create mode 100644 include/hw/net/lan9118.h
 create mode 100644 include/hw/net/smc91c111.h

--=20
2.20.1



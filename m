Received: from eggs.gnu.org ([209.51.188.92]:54416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJB7X-0004hr-SH
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:11:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJB7V-0000mX-Rh
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:11:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:42766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJB7V-0000lK-LB
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:11:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJB7U-0006yi-Ps
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:11:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C14AE2E80CF
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:11:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 06:01:34 -0000
From: Thomas Huth <1803872@bugs.launchpad.net>
Reply-To: Bug 1803872 <1803872@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154254872666.7803.12367996737502527787.malonedeb@wampee.canonical.com>
Message-Id: <155608569531.13864.14754380970849607768.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1803872] Re: gcc 8.2 reports stringop-truncation
 when building qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1803872

Title:
  gcc 8.2 reports stringop-truncation when building qemu

Status in QEMU:
  Fix Released

Bug description:
  QEMU 3.0

  block/sheepdog.c: In function 'find_vdi_name':
  block/sheepdog.c:1239:5: error: 'strncpy' specified bound 256 equals dest=
ination size [-Werror=3Dstringop-truncation]
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_V=
DI_TAG_LEN);
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~

  If this is the intended behavior, please suppress the warning. For
  example:

  #pragma GCC diagnostic push
  #pragma GCC diagnostic ignored "-Wstringop-truncation"
  =C2=A0=C2=A0=C2=A0=C2=A0strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG=
_LEN);
  #pragma GCC diagnostic pop

  This also happens on other sources, for example hw/acpi/core.c, so
  another option is to suppress it globally on CFLAGS (-Wno-stringop-
  truncation)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1803872/+subscriptions

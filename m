Return-Path: <SRS0=GiFh=S6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1ABC43218
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 06:49:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B6BA2075D
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 06:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6BA2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40613 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKdch-000100-3w
	for qemu-devel@archiver.kernel.org; Sun, 28 Apr 2019 02:49:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKdbG-0008PP-Nq
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:47:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKdbE-0005Yz-W6
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:47:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hKdbE-0005Yk-R8
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:47:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 70094307D85E;
	Sun, 28 Apr 2019 06:47:43 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-62.brq.redhat.com [10.40.204.62])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B3D31171EE;
	Sun, 28 Apr 2019 06:47:35 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Sun, 28 Apr 2019 08:47:25 +0200
Message-Id: <20190428064731.29913-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Sun, 28 Apr 2019 06:47:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 0/6] hw/acpi: Improve build modularity
 (targeting MIPS/PPC)
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
Cc: Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190428064725.71Vzzx0f1ez_o0uDGth6Mcr_Z1cky0hII9G6hbSgFJg@z>

Hi,

This series is not related to the previous one I just send:
hw/i386/acpi: Improve build modularity (isapc/q35/...)
https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg04678.html

While the first only concern X86 (changes within the architecture),
this one allow the core ACPI feature to be used by the MIPS and
PPC archs (specific series will follow).

v2:
- Fixed IPMI build error (patchew)
- Added possibility to build without ACPI (X86)

v1: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg04696.html

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (6):
  hw/acpi: Move the IPMI stub to the stubs/ directory
  hw/acpi: Move the ACPI stub to the stubs/ directory
  hw/acpi: Simplify the Makefile logic
  hw/acpi: Always build the 'core' ACPI functions
  stubs: Add missing ACPI symbols
  vl: Do not set acpi_enabled when ACPI is disabled at build time

 MAINTAINERS                         |  2 ++
 hw/acpi/Makefile.objs               | 22 +++++++---------------
 hw/acpi/core.c                      |  1 +
 stubs/Makefile.objs                 |  2 ++
 hw/acpi/acpi-stub.c =3D> stubs/acpi.c |  6 ++++++
 hw/acpi/ipmi-stub.c =3D> stubs/ipmi.c |  0
 vl.c                                |  1 -
 7 files changed, 18 insertions(+), 16 deletions(-)
 rename hw/acpi/acpi-stub.c =3D> stubs/acpi.c (93%)
 rename hw/acpi/ipmi-stub.c =3D> stubs/ipmi.c (100%)

--=20
2.20.1



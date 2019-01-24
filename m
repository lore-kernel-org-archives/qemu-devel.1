Received: from eggs.gnu.org ([209.51.188.92]:38348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gmfde-0006RH-6O
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:05:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gmfdd-0000Zc-Gg
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:05:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gmfdd-0000Ym-6I
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:05:49 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0OE59qX118845
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 09:05:47 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q7egk18fq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 09:05:45 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Thu, 24 Jan 2019 14:05:31 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 24 Jan 2019 15:05:15 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190124140519.13838-1-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/4] aspeed/smc: add fast read support under
 User command mode.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

When in the User command mode, the Aspeed SMC controller driver
performs the dummy cycles of a fast read command using byte transfers,
that is ony byte for eight cycles. But, the QEMU m25p80 models one
dummy cycle with one byte transfer.

To restore the correct number of cycles, this series adds a function
snooping the SPI transfers to catch commands requiring dummy cycles
and replaces them with byte transfers compatible with the m25p80 model.

Thanks,

C.

C=C3=A9dric Le Goater (4):
  aspeed/smc: fix default read value
  aspeed/smc: define registers for all possible CS
  aspeed/smc: Add dummy data register
  aspeed/smc: snoop transfers to fake dummy cycles

 include/hw/ssi/aspeed_smc.h |   3 +
 hw/ssi/aspeed_smc.c         | 128 +++++++++++++++++++++++++++++++++---
 2 files changed, 123 insertions(+), 8 deletions(-)

--=20
2.20.1

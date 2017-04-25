Received: from eggs.gnu.org ([2001:4830:134:3::10]:44349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1d2uKR-0003uN-5d
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 02:52:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1d2uKO-0006DF-3b
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 02:52:03 -0400
Received: from 5.mo7.mail-out.ovh.net ([178.32.120.239]:38894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1d2uKN-0006Cf-Tn
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 02:52:00 -0400
Received: from player788.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 026204DB7A
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 08:51:57 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 25 Apr 2017 08:51:39 +0200
Message-Id: <1493103101-25165-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] ipmi: fix open() NULL argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <cminyard@mvista.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

Here is a small series fixing an NULL argument issue in the IPMI BMC
simulator and activating the IPMI tests under PPC64.

Thanks,

C.

C=C3=A9dric Le Goater (2):
  tests: add IPMI tests for ppc64
  ipmi: don't try to open a NULL filename

 hw/ipmi/ipmi_bmc_sim.c | 5 +++++
 tests/Makefile.include | 2 ++
 2 files changed, 7 insertions(+)

--=20
2.7.4

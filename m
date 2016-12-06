Received: from eggs.gnu.org ([2001:4830:134:3::10]:38611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cE5Yi-00046Y-AO
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 21:32:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cE5Yd-0006a8-Jw
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 21:32:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cE5Yd-0006Za-EB
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 21:32:39 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Tue,  6 Dec 2016 10:32:29 +0800
Message-Id: <1480991552-14360-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL V2 0/3] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@redhat.com, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

The following changes since commit bd8ef5060dd2124a54578241da9a572faf7658dd:

  Merge remote-tracking branch 'dgibson/tags/ppc-for-2.8-20161201' into staging (2016-12-01 13:39:29 +0000)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 9f5832d34b0c155e9538a745c80e441aed257670:

  fsl_etsec: Fix various small problems in hexdump code (2016-12-06 10:23:50 +0800)

----------------------------------------------------------------

Changes from V1:
- fix coding style

----------------------------------------------------------------
Andrey Smirnov (2):
      fsl_etsec: Pad short payloads with zeros
      fsl_etsec: Fix various small problems in hexdump code

Prasad J Pandit (1):
      net: mcf: check receive buffer size register value

 hw/net/fsl_etsec/etsec.c | 4 ++--
 hw/net/fsl_etsec/rings.c | 8 ++++++++
 hw/net/mcf_fec.c         | 2 +-
 3 files changed, 11 insertions(+), 3 deletions(-)

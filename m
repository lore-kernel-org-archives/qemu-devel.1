Received: from eggs.gnu.org ([2001:4830:134:3::10]:41996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cktYL-0004JO-Gi
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:24:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cktYK-0007WX-PB
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:23:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cktYK-0007WI-J7
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:23:56 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  6 Mar 2017 15:23:48 +0100
Message-Id: <1488810230-31945-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] sm501: drop obsolete code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>

  Hi,

This little series drops a bunch of code which is not needed any more.
Nowdays qemu console only uses 32bpp surfaces.

BALATON, this should simplify your job of getting the pixel conversions
right.  Feel free to add this to your series.

Gerd Hoffmann (2):
  sm501: drop support for anything but 32bpp
  sm501: drop sm501_template.h

 hw/display/sm501.c          | 167 +++++++++++++++++++++++---------------------
 hw/display/sm501_template.h | 145 --------------------------------------
 2 files changed, 86 insertions(+), 226 deletions(-)
 delete mode 100644 hw/display/sm501_template.h

-- 
1.8.3.1

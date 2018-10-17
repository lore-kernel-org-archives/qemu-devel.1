Received: from eggs.gnu.org ([2001:4830:134:3::10]:53407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gCmvn-0001P5-QW
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gCmvk-0007uN-Cr
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:36:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lhrazky@redhat.com>) id 1gCmvk-0007te-5g
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:36:12 -0400
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Hr=C3=A1zk=C3=BD?= <lhrazky@redhat.com>
Date: Wed, 17 Oct 2018 16:36:02 +0200
Message-Id: <20181017143604.5194-1-lhrazky@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH spice/qemu v2 0/2] QXL interface to set
 monitor ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org
Cc: kraxel@redhat.com

Hello,

sending version 2 of the RFC on the new QXL interface to identify the
graphics device monitors in the guest.

Still keeping it as RFC, I'd like to get this agreed upon but not merge
until the whole mechanism is implemented.

Gerd, I didn't split the QEMU patch, as I feel it kind of goes together,
one without the other is not really functional. I'll still do it if you
insist...

Changes since v1:
* Renamed both functions according to suggestions.
* Changed the spice_qxl_monitor_set_device_display_id() so that it
  actually takes the monitor_id as an argument from QEMU. Please see the
  documentation of the function for some explanation.
* Updated the docs.

Cheers,
Lukas

--=20
2.19.1

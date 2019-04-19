Received: from eggs.gnu.org ([209.51.188.92]:49764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nick.hudson@gmx.co.uk>) id 1hHacY-00020F-FO
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:00:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nick.hudson@gmx.co.uk>) id 1hHacX-0002fY-MJ
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:00:30 -0400
Received: from mout.gmx.net ([212.227.15.18]:59883)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nick.hudson@gmx.co.uk>)
	id 1hHacX-0002eu-Ce
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:00:29 -0400
From: Nick Hudson <nick.hudson@gmx.co.uk>
Message-ID: <b148c658-09ed-15a5-02e6-42e1c544e847@gmx.co.uk>
Date: Fri, 19 Apr 2019 22:00:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1 0/2] HPPA fixes for NetBSD/hppa emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

Hi,

Here are the required changes to allow qemu to emulate NetBSD/hppa.

Nick Hudson (2):
   Implement the pcxl and pcxl2 Fast TLB Insert instructions as used by
     NetBSD (and OpenBSD)
   Always return EXCP_DMAR for protection id trap as EXCP_DMP is
     considered legacy.

  target/hppa/insns.decode |  3 +++
  target/hppa/mem_helper.c |  3 +--
  target/hppa/translate.c  | 54 ++++++++++++++++++++++++++++++++++++++++
  3 files changed, 58 insertions(+), 2 deletions(-)

=2D-
2.17.1

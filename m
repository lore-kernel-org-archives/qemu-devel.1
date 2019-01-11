Received: from eggs.gnu.org ([209.51.188.92]:51138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghxm7-00055z-My
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:27:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghxm7-0008Nn-01
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:27:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ghxm6-0008NL-Qu
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:27:06 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C15DC87621
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 14:27:05 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 11 Jan 2019 15:27:01 +0100
Message-Id: <20190111142702.25884-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/1] Input 20190111 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit a311f891abf3833c1e4c5a62a6e5b0f1b81f22=
c3:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.0-p=
ull-request' into staging (2019-01-10 17:49:54 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/input-20190111-pull-request

for you to fetch changes up to 7a1b46e09504419a3aa867dba3bcf23db5d6d956:

  input: avoid malloc for mouse events (2019-01-11 11:57:17 +0100)

----------------------------------------------------------------
input: avoid malloc for mouse events

----------------------------------------------------------------

Gerd Hoffmann (1):
  input: avoid malloc for mouse events

 include/ui/input.h |  3 ---
 ui/input.c         | 68 +++++++++++++++++++++++++-----------------------=
------
 2 files changed, 31 insertions(+), 40 deletions(-)

--=20
2.9.3

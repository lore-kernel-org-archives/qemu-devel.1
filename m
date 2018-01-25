Received: from eggs.gnu.org ([2001:4830:134:3::10]:48482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1eekdW-0006xs-5B
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:44:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1eekdS-00016N-Qi
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:44:26 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47787)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1eekdS-00014H-Cq
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:44:22 -0500
MIME-version: 1.0
Content-type: text/plain; charset="UTF-8"
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Thu, 25 Jan 2018 19:43:39 +0300
Message-id: <1516898620-9486-1-git-send-email-a.perevalov@samsung.com>
References: <CGME20180125164414eucas1p1bd675e187875c435e996131622e82656@eucas1p1.samsung.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1] Fix build on ppc platform in
 migration/postcopy-ram.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com
Cc: Alexey Perevalov <a.perevalov@samsung.com>, lvivier@redhat.com, peterx@redhat.com, quintela@redhat.com, f4bug@amsat.org, ash.billore@samsung.com

It was a problem with 64 atomics on ppc in migration/postcopy-ram.c repor=
ted by
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>.


I didn't check on ppc due to debina installation inside docker is failed,
but I have my own debian on qemu-system-ppc, but build is still going.
It also was tested on Ubuntu16.04 on i386.

This commit is based on commit ee264eb32c14f076c964fc34ee66f6f95cce2080
"Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.12-20180121=
' into staging"

Alexey Perevalov (1):
  migration: change blocktime type to uint32_t

 hmp.c                    |  4 ++--
 migration/postcopy-ram.c | 47 ++++++++++++++++++++++++++++++------------=
-----
 migration/trace-events   |  4 ++--
 qapi/migration.json      |  4 ++--
 4 files changed, 36 insertions(+), 23 deletions(-)

--=20
2.7.4

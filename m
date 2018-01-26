Received: from eggs.gnu.org ([2001:4830:134:3::10]:42170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1ef754-0001aZ-Pw
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:42:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1ef750-0005fG-M5
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:42:22 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38045)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1ef750-0005dn-G4
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:42:18 -0500
MIME-version: 1.0
Content-type: text/plain; charset="UTF-8"
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Fri, 26 Jan 2018 19:05:19 +0300
Message-id: <1516982720-26501-1-git-send-email-a.perevalov@samsung.com>
References: <CGME20180126160530eucas1p2cd5b7dddee39500ab119fb83894cabd4@eucas1p2.samsung.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] Fix build on ppc platform in
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

This is a second version:
    - comment from David about casting
David was right, I tried to find it in standard, but it was implicitly
described for me, so part of standard:

   1. When a value with integer type is converted to another integer
type other than _Bool, if the value can be represented by the new
type, it is unchanged.
   2. Otherwise, if the new type is unsigned, the value is converted
by repeatedly adding or subtracting one more than the maximum value
that can be represented in the new type until the value is in the
range of the new type.



Initial message:

It was a problem with 64 atomics on ppc in migration/postcopy-ram.c repor=
ted by
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>.

Tested in Debian on qemu-system-ppc and in Ubuntu16.04 on i386.

This commit is based on commit ee264eb32c14f076c964fc34ee66f6f95cce2080
"Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.12-20180121=
' into staging"

Alexey Perevalov (1):
  migration: change blocktime type to uint32_t

 hmp.c                    |  4 ++--
 migration/postcopy-ram.c | 37 ++++++++++++++++++++-----------------
 migration/trace-events   |  4 ++--
 qapi/migration.json      |  4 ++--
 4 files changed, 26 insertions(+), 23 deletions(-)

--=20
2.7.4

Received: from eggs.gnu.org ([209.51.188.92]:35010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1gqmeh-0006oj-Bu
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 17:23:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1gqmec-0001g9-Nq
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 17:23:51 -0500
Received: from mail-eopbgr750044.outbound.protection.outlook.com
	([40.107.75.44]:33504
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1gqmec-0001ZM-7I
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 17:23:50 -0500
From: "Singh, Brijesh" <brijesh.singh@amd.com>
Date: Mon, 4 Feb 2019 22:23:39 +0000
Message-ID: <20190204222322.26766-1-brijesh.singh@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v2 0/2] Fix SEV VM device assignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Singh,
	Brijesh" <brijesh.singh@amd.com>

Fix: https://bugzilla.redhat.com/show_bug.cgi?id=3D1667249

Since v1:
 * check the error code from memory_region_from_host() before
   accessing the mr.

Brijesh Singh (2):
  memory: Fix the memory region type assignment order
  target/i386: sev: Do not pin the ram device memory region

 memory.c          |  9 ++++++++-
 target/i386/sev.c | 11 +++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

--=20
2.17.1

Received: from eggs.gnu.org ([209.51.188.92]:45080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1gkFbE-0001Ro-1E
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 16:53:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1gkFbD-0000Yc-9G
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 16:53:19 -0500
Received: from mail-eopbgr740047.outbound.protection.outlook.com
	([40.107.74.47]:8750
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1gkFbD-0000WF-0A
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 16:53:19 -0500
From: "Singh, Brijesh" <brijesh.singh@amd.com>
Date: Thu, 17 Jan 2019 21:53:15 +0000
Message-ID: <20190117215300.29694-1-brijesh.singh@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH 0/2] Fix SEV VM device assignment
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

Brijesh Singh (2):
  memory: Fix the memory region type assignment order
  target/i386: sev: Do not pin the ram device memory region

 memory.c          |  9 ++++++++-
 target/i386/sev.c | 11 +++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

--=20
2.17.1

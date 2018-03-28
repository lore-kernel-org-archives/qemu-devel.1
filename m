Received: from eggs.gnu.org ([2001:4830:134:3::10]:35145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1f1Blj-0003L6-Cx
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 10:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1f1Blh-0005Ba-LG
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 10:09:38 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 28 Mar 2018 10:09:25 -0400
Message-Id: <cover.1522245129.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/1] blockjob: leak fix,
 remove from txn when failing early
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, marcandre.lureau@redhat.com, mreitz@redhat.com, kwolf@redhat.com

This is Marc-Andr=C3=A9's patch with the updated content provided by John=
.

To make sure I've added John's bits to it in a way that both John and
Marc-Andr=C3=A9 agree is correct, I've dropped all S-o-B's until they pro=
vide
them.

Jeff Cody (1):
  blockjob: leak fix, remove from txn when failing early

 blockjob.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--=20
2.13.6

Received: from eggs.gnu.org ([2001:4830:134:3::10]:38637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dgCRG-0006uG-Ke
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 12:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dgCRC-0007eG-IM
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 12:05:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dgCRC-0007di-C5
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 12:05:26 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 11 Aug 2017 18:05:20 +0200
Message-Id: <1502467522-32237-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/2] vl: Partial support for non-scalar
 properties with -object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: el13635@mail.ntua.gr, kwolf@redhat.com, berrange@redhat.com, eblake@redhat.com, pbonzini@redhat.com, f4bug@amsat.org

v2:
* PATCH 1: Whitespace change dropped [Eric]
* PATCH 2: Deallocation done differently [Paolo], R-by dropped
           Commit message typo [Eric]

Markus Armbruster (2):
  vl: Factor object_create() out of main()
  vl: Partial support for non-scalar properties with -object

 qapi-schema.json | 14 ++++++++---
 vl.c             | 71 ++++++++++++++++++++++++++++++++++++++++++++++++--=
------
 2 files changed, 72 insertions(+), 13 deletions(-)

--=20
2.7.5

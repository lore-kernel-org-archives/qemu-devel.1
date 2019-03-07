Received: from eggs.gnu.org ([209.51.188.92]:54770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1pT4-0005W2-Ex
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:37:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1pT3-0004y3-Oj
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:37:34 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  7 Mar 2019 10:37:19 +0100
Message-Id: <20190307093723.655-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v6 0/4] hw/block: better reporting on
 pflash backing file mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, lersek@redhat.com, philmd@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

This is Alex's "[PATCH v5] hw/block: better reporting on pflash
backing file mismatch" with the padding split off into its own patch,
and both resulting patches applied to pflash_cfi02.c.  I downgraded it
to RFC for two reasons:

1. I think the padding patches should not be applied.  I'll reply to
PATCH 2 to explain why.

2. I left the update of pflash_cfi02.c as separate fixup patches, so
we can easily ignore them while we discuss 1.

v6:
* Split padding into its own patch.
* Delete "It should be padded to a multiple of the flash block size."
  comment.  Happy to put it back if you can enlighten me about its
  purpose.
* Improve both commit messages.
* New fixup patches to pflash_cfi02.c.

Alex Benn=C3=A9e (2):
  hw/block: better reporting on pflash backing file mismatch
  hw/block: Pad undersized read-only images with 0xFF

Markus Armbruster (2):
  fixup! hw/block: better reporting on pflash backing file mismatch
  fixup! hw/block: Pad undersized read-only images with 0xFF

 hw/block/pflash_cfi01.c | 41 ++++++++++++++++++++++++++++++++++-------
 hw/block/pflash_cfi02.c | 40 ++++++++++++++++++++++++++++++++++------
 2 files changed, 68 insertions(+), 13 deletions(-)

--=20
2.17.2

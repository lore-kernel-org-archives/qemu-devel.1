Received: from eggs.gnu.org ([209.51.188.92]:58960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hIhFd-0003Pl-D1
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 18:17:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hIhFc-0006zW-DU
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 18:17:25 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 22 Apr 2019 18:17:12 -0400
Message-Id: <20190422221714.7630-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/2] docs/interop/bitmaps: rewrite and
 modernize doc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: aliang@redhat.com, kchamart@redhat.com, eblake@redhat.com, Fam Zheng <fam@euphon.net>, nsoffer@redhat.com, qemu-stable@nongnu.org, armbru@redhat.com, vsementsov@virtuozzo.com, John Snow <jsnow@redhat.com>

The documentation as written in the 4.0 release is not quite correct as
of the 4.0 release; though thanks to backwards compatibility it's not
quite wrong either. It is suitable for inclusion in 4.0.1, or any
downstream that packages 4.0.

This patch is an attempt at a nearly full rewrite that revitalizes this
document to address frequent questions I encounter when discussing the
API.

V2:
  - Split off makefile change into its own little patch.

  - Addressed (almost) all comments from Vladimir.
    - Example styling was not reworked.
  - Renamed all filenames to be consistent throughout the document,
    fixing a few more file extensions in the process
  - Reflowed almost all paragraphs to 78 columns for consistency.
  - Changed a few bulleted lists to paragraphs instead
  - Changed the big ascii text diagram to a more compact version
    and clarified its language
  - While in general I prefer to use en_US spellings, I have
    replaced "canceled" with "cancelled" so it does not look
    out of place juxtaposed with BLOCK_JOB_CANCELLED...

Future work that remains to be done:

- Paying heed to blockdev-backup workflows
- Adding a small migration section explaining the options there
- Possibly reworking some of the sections that all make their own
  repeated attempts to clarify time interval discretization and adding
  a proper treatment of the idea start to finish; this may be neccessary
  to explain the two below items properly:
- Differential Backups
- Pull Backups and NBD

John Snow (2):
  Makefile: add nit-picky mode to sphinx-build
  docs/interop/bitmaps: rewrite and modernize doc

 docs/interop/bitmaps.rst | 1600 ++++++++++++++++++++++++++++++--------
 Makefile                 |    2 +-
 2 files changed, 1266 insertions(+), 336 deletions(-)

--=20
2.20.1

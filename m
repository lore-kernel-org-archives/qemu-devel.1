Received: from eggs.gnu.org ([208.118.235.92]:51854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1geeOY-0001Hm-UT
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 06:09:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1geeOV-00087f-R7
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 06:09:06 -0500
From: Leonid Bloch <lbloch@janustech.com>
Date: Wed, 2 Jan 2019 11:08:56 +0000
Message-ID: <20190102110804.18155-1-lbloch@janustech.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH 0/1] include: Auto-generate the sizes lookup
 table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, Leonid Bloch <lbloch@janustech.com>, Alberto Garcia <berto@igalia.com>, Markus Armbruster <armbru@redhat.com>

Following the conversations here:
https://patchwork.kernel.org/patch/10665157
and here:
https://patchwork.kernel.org/patch/10666975

Making the lookup table for power-of-two sizes auto-generated, instead
of being hard-coded into the units.h file.

I'm not sure if the changes I've made to Makefile here are "standard".
Please correct me if that's not the case.

Sorry it took so much time - I was busy with something completely
different.


Regards,
Leonid.

Leonid Bloch (1):
  include: Auto-generate the sizes lookup table

 .gitignore           |  1 +
 Makefile             |  5 +++
 block/qcow2.h        |  2 +-
 block/vdi.c          |  1 +
 include/qemu/units.h | 73 --------------------------------------------
 scripts/gen-sizes.sh | 66 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 74 insertions(+), 74 deletions(-)
 create mode 100755 scripts/gen-sizes.sh

--=20
2.20.1

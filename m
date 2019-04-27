Received: from eggs.gnu.org ([209.51.188.92]:33835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hKQKj-0001C0-UL
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 12:37:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hKQDZ-0004zN-8B
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 12:30:27 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:47158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hKQDT-0004TM-F3
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 12:30:22 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sat, 27 Apr 2019 18:30:04 +0200
Message-Id: <20190427163007.5113-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCHv3 0/2] ui/curses: BSD portability fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, kraxel@redhat.com, kamil@netbsd.org

BSD needs a few fixes for wide character manipulations.

Difference with v1:
- Fix unitialized value in error message

Difference with v2:
- Add cchar_t manipulation fix

Samuel Thibault (2):
  ui/curses: do not assume wchar_t contains unicode
  ui/curses: manipulate cchar_t with standard curses functions

 ui/curses.c | 188 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 120 insertions(+), 68 deletions(-)

--=20
2.20.1

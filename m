Received: from eggs.gnu.org ([209.51.188.92]:53153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hKS8c-0000Gu-UD
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 14:33:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hKS8c-00059a-49
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 14:33:26 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:40776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hKS8b-00057p-UH
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 14:33:26 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sat, 27 Apr 2019 20:33:05 +0200
Message-Id: <20190427183307.12796-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCHv4 0/2] ui/curses: BSD portability fixes
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

Difference with v3:
- use mbrtowc/wcrtomb instead of mbtowc/wctomb
- use MB_LEN_MAX instead of MB_CUR_MAX to avoid using a VLA.

Samuel Thibault (2):
  ui/curses: do not assume wchar_t contains unicode
  ui/curses: manipulate cchar_t with standard curses functions

 ui/curses.c | 194 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 126 insertions(+), 68 deletions(-)

--=20
2.20.1

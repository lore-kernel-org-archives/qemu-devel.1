Received: from eggs.gnu.org ([2001:4830:134:3::10]:58880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dEjXV-0005RV-Fd
	for qemu-devel@nongnu.org; Sat, 27 May 2017 17:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dEjXS-0003Fm-Dv
	for qemu-devel@nongnu.org; Sat, 27 May 2017 17:46:25 -0400
Received: from hera.aquilenet.fr ([141.255.128.1]:43416)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dEjXS-0003Ad-6p
	for qemu-devel@nongnu.org; Sat, 27 May 2017 17:46:22 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sat, 27 May 2017 23:46:15 +0200
Message-Id: <20170527214618.32626-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] slirp updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com, jan.kiszka@siemens.com

The following changes since commit 9964e96dc9999cf7f7c936ee854a795415d19b=
60:

  Merge remote-tracking branch 'jasowang/tags/net-pull-request' into stag=
ing (2017-05-23 15:01:31 +0100)

are available in the git repository at:

  http://people.debian.org/~sthibault/qemu.git tags/samuel-thibault

for you to fetch changes up to 2e30230aa95a2d6cfaadac015bd96c3db19c45e4:

  Fix total IP header length in forwarded TCP packets (2017-05-27 23:35:0=
0 +0200)

----------------------------------------------------------------
slirp updates

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (1):
      slirp: fix leak

Sjors Gielen (1):
      Fix total IP header length in forwarded TCP packets

Tao Wu (1):
      slirp: Fix wrong mss bug.

 slirp/socket.c    | 3 +++
 slirp/tcp_input.c | 4 ++--
 slirp/tcp_subr.c  | 4 ++--
 3 files changed, 7 insertions(+), 4 deletions(-)

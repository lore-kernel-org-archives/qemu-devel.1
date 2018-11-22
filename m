Received: from eggs.gnu.org ([2001:4830:134:3::10]:50661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPmj5-0005WE-54
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 06:00:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPmj3-0003Ut-Fc
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 06:00:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54967)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gPmj3-0003TR-9m
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 06:00:49 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Nov 2018 15:00:35 +0400
Message-Id: <20181122110039.15972-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 0/4] build-sys: require Vista API by
 default globally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Weil <sw@weilnetz.de>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, samuel.thibault@ens-lyon.org, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

Here is a small series improving a bit Windows headers inclusion, and
setting the default required API version globally to Vista. It also
allows easier tweaking of available API version via CFLAGS.

Building QGA for older versions (XP) seems possible so far: the
dependency on libqemuutil.a implies building qemu-thread-win32.c,
which requires Vista API since commit 12f8def0 (v2.9). But qemu-thread
isn't being used in QGA, the resulting binary may still work on XP.
XP is no longer supported for the past 4.5y, it's time to drop support
for it.

Marc-Andr=C3=A9 Lureau (4):
  build-sys: don't include windows.h, osdep.h does it
  build-sys: move windows defines in osdep.h header
  build-sys: build with Vista API by default
  RFC: qga: drop < Vista compatibility

 include/qemu/osdep.h      | 17 ++++++++++
 accel/tcg/translate-all.c |  4 ---
 qga/commands-win32.c      | 70 +--------------------------------------
 util/qemu-thread-win32.c  |  4 ---
 configure                 |  3 --
 roms/seabios              |  2 +-
 6 files changed, 19 insertions(+), 81 deletions(-)

--=20
2.20.0.rc1

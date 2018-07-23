Received: from eggs.gnu.org ([2001:4830:134:3::10]:58149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fhglw-0000zB-70
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 15:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fhglt-00085p-2C
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 15:45:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fhgls-00085i-S2
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 15:45:28 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 23 Jul 2018 16:45:20 -0300
Message-Id: <20180723194521.26831-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/1] Build fix for -rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>

The following changes since commit 9ba7dd14355bb7957680d5ef764471ab102df0=
99:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2018-07-23'=
 into staging (2018-07-23 15:15:46 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-next-pull-request

for you to fetch changes up to 5f00335aecafc9ad56592d943619d3252f8941f1:

  i386: Rename enum CacheType members (2018-07-23 12:56:19 -0300)

----------------------------------------------------------------
Fix for -rc2

* Fix build failure on mips host

----------------------------------------------------------------

Eduardo Habkost (1):
  i386: Rename enum CacheType members

 target/i386/cpu.h |   4 +-
 target/i386/cpu.c | 128 +++++++++++++++++++++++-----------------------
 2 files changed, 66 insertions(+), 66 deletions(-)

--=20
2.18.0.rc1.1.g3f1ff2140

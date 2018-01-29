Received: from eggs.gnu.org ([2001:4830:134:3::10]:42102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1egByf-00084v-KT
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:08:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1egByc-0006p9-C3
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:08:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1egByc-0006oc-6I
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:08:10 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 29 Jan 2018 16:07:37 +0000
Message-Id: <20180129160740.1195-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 0/3] Tracing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The following changes since commit 6233b4a8c2a32ef6955a921246fa08705bbb3676:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-01-26' into staging (2018-01-26 17:29:14 +0000)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to 24f4d3d3aeabf83445839099d6d66cbb3089c37a:

  tracetool: report error on foo() instead of foo(void) (2018-01-29 10:34:55 +0000)

----------------------------------------------------------------

----------------------------------------------------------------

Stefan Hajnoczi (3):
  tracetool: prefix parse errors with line numbers
  tracetool: clarify that "formats" means "format strings"
  tracetool: report error on foo() instead of foo(void)

 scripts/tracetool/__init__.py | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

-- 
2.14.3

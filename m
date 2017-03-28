Received: from eggs.gnu.org ([2001:4830:134:3::10]:48082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1css2U-0002VH-Qo
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 10:24:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1css2Q-0006lz-FB
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 10:24:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33675)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1css2Q-0006lV-9O
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 10:23:58 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 28 Mar 2017 15:23:45 +0100
Message-Id: <20170328142346.3899-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 0/1] Tracing patches
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

The following changes since commit eb06c9e2d3c8f026a206e8402b0ffa201060ec8e:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-03-27 17:34:50 +0100)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to 7609ffb9191e3fc473203f4bd58b934161eab358:

  trace: fix tcg tracing build breakage (2017-03-28 11:07:46 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Stefan Hajnoczi (1):
  trace: fix tcg tracing build breakage

 docs/tracing.txt                         |  3 +++
 trace/Makefile.objs                      | 16 ++++++++--------
 scripts/tracetool/format/tcg_h.py        |  1 +
 scripts/tracetool/format/tcg_helper_c.py |  1 +
 4 files changed, 13 insertions(+), 8 deletions(-)

-- 
2.9.3

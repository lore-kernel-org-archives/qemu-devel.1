Received: from eggs.gnu.org ([2001:4830:134:3::10]:39401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1enoAo-0004Z7-PF
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:20:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1enoAn-00036k-Qg
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:20:14 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49996 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1enoAn-00034U-29
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:20:13 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 19 Feb 2018 16:19:52 +0000
Message-Id: <20180219161955.29572-1-stefanha@redhat.com>
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

The following changes since commit e5ecc287a7bd24a1364e23e263cb60cfc8d21eb5:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20180216' into staging (2018-02-16 18:39:05 +0000)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to 7f1d87ab0fd94cef5086e2879716958303281054:

  trace: avoid SystemTap "char const" warnings (2018-02-19 13:09:44 +0000)

----------------------------------------------------------------

----------------------------------------------------------------

Jon Emil Jahren (2):
  tracetool: Update argument format regex to non-greedy star
  tracetool: For ust trace bool type as ctf_integer

Stefan Hajnoczi (1):
  trace: avoid SystemTap "char const" warnings

 hw/block/trace-events                    |  4 ++--
 scripts/tracetool/__init__.py            |  5 +++--
 scripts/tracetool/format/ust_events_h.py |  3 ++-
 trace-events                             | 12 ++++++------
 4 files changed, 13 insertions(+), 11 deletions(-)

-- 
2.14.3

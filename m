Received: from eggs.gnu.org ([2001:4830:134:3::10]:60073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhkr3-0002PZ-3q
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 20:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhkr2-00059l-7f
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 20:07:05 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:45112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1fhkr2-00059c-17
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 20:07:04 -0400
Received: by mail-oi0-x244.google.com with SMTP id q11-v6so4367631oic.12
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 17:07:03 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 19:01:24 -0500
Message-Id: <20180724000126.21787-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL for-3.0 0/2] qemu-ga patch queue for hard-freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

The following changes since commit 4eecc2e212bae7308d8582d99f665dfc253c9dda:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180723' into staging (2018-07-23 19:24:05 +0100)

are available in the Git repository at:

  git://github.com/mdroth/qemu.git tags/qga-pull-2018-07-23-tag

for you to fetch changes up to ae7da1e5f658ea21d96e565514de20ff2cf24fa1:

  qga: process_event() simplification and leak fix (2018-07-23 18:54:26 -0500)

----------------------------------------------------------------
qemu-ga patch queue for hard-freeze

* fix leak in qga main loop error path
* better error reporting when Windows version doesn't support fstrim

----------------------------------------------------------------
Marc-André Lureau (1):
      qga: process_event() simplification and leak fix

Sameeh Jubran (1):
      qga-win: Handle fstrim for OSes lower than Win8

 qga/commands-win32.c | 13 +++++++++++++
 qga/main.c           | 54 ++++++++++++++++++++++++++--------------------------
 2 files changed, 40 insertions(+), 27 deletions(-)

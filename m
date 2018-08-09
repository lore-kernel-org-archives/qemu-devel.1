Received: from eggs.gnu.org ([2001:4830:134:3::10]:49728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fnpAG-0008Lp-Rh
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 13:56:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fnpAC-0004hE-Qy
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 13:56:00 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:35897)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fnpAC-0004gL-Cq
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 13:55:56 -0400
Received: by mail-wr1-x42f.google.com with SMTP id h9-v6so5910957wro.3
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 10:55:56 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  9 Aug 2018 18:55:50 +0100
Message-Id: <20180809175553.18479-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH  0/3] Tweaks to linux-user -dfilter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

While debugging a dynamically linked program I got frustrated having
to manually calculate the .text segment to avoid the logs getting
filled up with library stuff I wasn't really interested in. This
allows us to:

  - have multiple -dfilter lines for flexibility
  - specify -dfilter progtext as a shortcut

We could potentially extend this to handle -dfilter lib at a later
date.

Thoughts?

Alex Bennée (3):
  util/log: allow -dfilter to stack
  util/log: add qemu_dfilter_append_range()
  linux-user: add -dfilter progtext shortcut

 include/qemu/log.h   |  2 ++
 linux-user/main.c    | 16 +++++++++++++++-
 tests/test-logging.c | 14 ++++++++++++++
 util/log.c           | 29 +++++++++++++++++++++++------
 4 files changed, 54 insertions(+), 7 deletions(-)

-- 
2.17.1

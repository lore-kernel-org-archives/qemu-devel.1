Received: from eggs.gnu.org ([209.51.188.92]:47787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2G0Z-0004PX-CN
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:57:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2G0W-0002jC-FK
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:57:54 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:54778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2G0W-0002Oe-7r
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:57:52 -0500
Received: by mail-wm1-x32e.google.com with SMTP id f3so12734631wmj.4
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 05:57:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Mar 2019 13:57:41 +0000
Message-Id: <20190308135744.6480-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/3] Fix various issues with Sphinx build
 machinery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

This patchset fixes some bugs with the Sphinx build machinery.
Most importantly, it fixes in-tree builds, which were broken
if you had sphinx-build available. The other two patches fix
some more minor problems that I noticed in the course of
fixing the first one.

thanks
-- PMM

Peter Maydell (3):
  Makefile: Fix Sphinx documentation builds for in-tree builds
  Makefile: Fix 'make distclean'
  Makefile: Don't install non-sphinx files in sphinx docs install

 Makefile | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

-- 
2.20.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:33521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYBnY-0003sx-Td
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYBnV-00088r-Re
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:47:24 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:37603)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYBnV-00088C-Ke
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:47:21 -0400
Received: by mail-wr0-x22a.google.com with SMTP id 33so14512627wrz.4
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 06:47:19 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 20 Jul 2017 14:47:13 +0100
Message-Id: <20170720134716.13049-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for 2.10 0/3] some docker fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

I noticed some problems while running my local builds and while trying
to reproduce Travis failures. They apply on top of the currently in
flight pull-req pull-ci-updates-for-softfreeze-180717-2

Alex Bennée (3):
  docker: ensure NOUSER for travis images
  docker: fix dirty/stash detection  on some systems
  docker: ignore submodules when checking diff

 tests/docker/Makefile.include | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.13.0

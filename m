Received: from eggs.gnu.org ([2001:4830:134:3::10]:36657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJbTK-0004aa-Ba
	for qemu-devel@nongnu.org; Fri, 18 May 2018 05:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJbTH-0001ep-5C
	for qemu-devel@nongnu.org; Fri, 18 May 2018 05:14:46 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:40331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fJbTG-0001du-UF
	for qemu-devel@nongnu.org; Fri, 18 May 2018 05:14:43 -0400
Received: by mail-wr0-x242.google.com with SMTP id v60-v6so8416372wrc.7
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 02:14:42 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 18 May 2018 10:14:38 +0100
Message-Id: <20180518091440.1559-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 0/2] Travis Stability Patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

The Sisyphean task of keeping our CI stable continues. The first patch
is simple as it reduces the build to prevent us timing out. The second
patch isn't meant for merging but as far as I can tell covers all the
regular tests that fail on Travis. I would be grateful if the test
authors could attempt to reproduce the failures and make the tests
more stable. I suspect they are load related but I haven't looked that
deeply.

Alex Bennée (2):
  .travis.yml: disable linux-user build for gcov
  tests/Makefile: comment out flakey tests

 .travis.yml            | 2 +-
 tests/Makefile.include | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.17.0

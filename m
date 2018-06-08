Received: from eggs.gnu.org ([2001:4830:134:3::10]:51385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fRJsV-0008FM-3O
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fRJsR-0002su-SB
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:04:39 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fRJsR-0002s4-Lz
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:04:35 -0400
Received: by mail-wm0-x241.google.com with SMTP id r125-v6so4679547wmg.2
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 09:04:35 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  8 Jun 2018 17:04:29 +0100
Message-Id: <20180608160432.8734-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 0/3] Better docker dependency checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

These patches apply on top of my tcg/testing patch series and attempt
to make the dependancy checking a bit smarter within the confines of
what Make can achieve. The basic idea is although the debian-sid-image
will always rebuild by making it a conditional dependancy we can only
trigger this when we need to rebuild the target image. Together with
the top-level initial build this mean you can now run make check-tcg
with high -j's without issue.

The first patch in the series fixes the checksum code as it was broken
anyway. Currently we don't properly handle extra_files and executables
but this should be fairly easy to add. I've not done it at the moment
because we don't use these exotic builds in any of the default
targets.

Alex Bennée (3):
  docker: docker.py don't conflate checksums for extra_files
  dcoker: docker.py add check sub-command
  docker: remove SUBMAKE_NOCACHE_HACK for debian-sid based images

 tests/docker/Makefile.include | 25 ++++++++++++++-----------
 tests/docker/docker.py        | 30 +++++++++++++++++++++++++++---
 tests/tcg/Makefile.include    |  1 -
 3 files changed, 41 insertions(+), 15 deletions(-)

-- 
2.17.1

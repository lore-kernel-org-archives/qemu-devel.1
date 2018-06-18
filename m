Received: from eggs.gnu.org ([2001:4830:134:3::10]:52435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fUtsL-0005y8-DU
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 09:07:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fUtsF-0002cX-MT
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 09:07:17 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:41627)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fUtsF-0002cE-Fd
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 09:07:11 -0400
Received: by mail-wr0-x22f.google.com with SMTP id h10-v6so16762348wrq.8
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 06:07:11 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 18 Jun 2018 14:07:01 +0100
Message-Id: <20180618130709.19730-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 0/8] Docker tweaks for TCG testing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com, cota@braap.org, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi Fam,

These are the docker specific changes from my current TCG testing
branch:

  https://github.com/stsquad/qemu/tree/testing/tcg-tests-revival-v8

Once the CI tests have worked their way through I'm hoping to submit
the pull-req to get this merged. However I've been hacking about in
docker.py and rather than sending the whole 50+ series I've split them
out for easy review. The ones that currently need review are:

: patch 0005/docker docker.py use ps to probe usage.patch
: patch 0006/docker docker.py don t conflate checksums for ext.patch
: patch 0007/docker docker.py add check sub command.patch
: patch 0008/docker docker.py adding age check command.patch

If you get a chance could you have a quick look through?

Alex Bennée (8):
  docker: Add "cc" subcommand
  docker: extend "cc" command to accept compiler
  docker: allow "cc" command to run in user context
  docker: Makefile.include introduce DOCKER_SCRIPT
  docker: docker.py use "ps" to probe usage
  docker: docker.py don't conflate checksums for extra_files
  docker: docker.py add check sub-command
  docker: docker.py adding age check command

 tests/docker/Makefile.include |  10 ++--
 tests/docker/docker.py        | 105 ++++++++++++++++++++++++++++++++--
 2 files changed, 106 insertions(+), 9 deletions(-)

-- 
2.17.1

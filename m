Received: from eggs.gnu.org ([2001:4830:134:3::10]:60688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVwzI-0001Hw-HA
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVwzF-0005HE-EW
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:34:16 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:33563)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVwzF-0005Gy-8i
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:34:13 -0400
Received: by mail-wr0-x229.google.com with SMTP id u110so206646wrb.0
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 02:34:13 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 14 Jul 2017 11:34:05 +0200
Message-Id: <20170714093407.11526-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] docker: allow running "docker-travis" with
 arbitrary parallelism
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com

docker-travis is limited to the -j3 flag specified for running on the
SaaS Travis CI infrastructure.

When running the test matrix locally with docker, however, we can run
much more jobs at the same time on a suitably beefy server.  Let people
do that with the usual J=nn option already supported by the other
docker-based tests.

Paolo

Paolo Bonzini (2):
  docker: allow customizing Travis global_env variables
  travis: move make -j flag out of script

 .travis.yml            | 3 ++-
 tests/docker/travis.py | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.13.0

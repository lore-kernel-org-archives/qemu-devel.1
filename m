Received: from eggs.gnu.org ([2001:4830:134:3::10]:49487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eJfXg-00011Y-LC
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 08:03:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eJfXX-0003Xy-5H
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 08:03:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eJfXW-0003Xg-Vo
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 08:03:07 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue, 28 Nov 2017 07:02:46 -0600
Message-Id: <20171128130248.901-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] nbd patches for -rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, secalert@redhat.com, ppandit@redhat.com

The following changes since commit c7e1f823aed63f49e559e7463da76d5b320be35b:

  Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2017-11-28 10:03:26 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2017-11-28

for you to fetch changes up to 51ae4f8455c9e32c54770c4ebc25bf86a8128183:

  nbd/server: CVE-2017-15118 Stack smash on large export name (2017-11-28 06:58:01 -0600)

Patches were reviewed off-list during the CVE embargo.

----------------------------------------------------------------
nbd patches for 2017-11-28

Eric Blake - 0/2 fix two NBD server CVEs

----------------------------------------------------------------
Eric Blake (2):
      nbd/server: CVE-2017-15119 Reject options larger than 32M
      nbd/server: CVE-2017-15118 Stack smash on large export name

 nbd/server.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.14.3

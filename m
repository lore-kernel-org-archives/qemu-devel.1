Received: from eggs.gnu.org ([2001:4830:134:3::10]:47818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tobleminer@gmail.com>) id 1dMVap-0005dc-3Y
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 04:29:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tobleminer@gmail.com>) id 1dMVao-00057g-ES
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 04:29:59 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:38042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tobleminer@gmail.com>)
	id 1dMVao-00056h-8C
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 04:29:58 -0400
Received: by mail-wm0-x22e.google.com with SMTP id u195so39525497wmd.1
	for <qemu-devel@nongnu.org>; Sun, 18 Jun 2017 01:29:57 -0700 (PDT)
From: Tobias Schramm <tobleminer@gmail.com>
Date: Sun, 18 Jun 2017 10:28:12 +0200
Message-Id: <20170618082813.8091-1-tobleminer@gmail.com>
Subject: [Qemu-devel] [PATCH 0/1] Add fmask/dmask option for 9p mapped mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Tobias Schramm <tobleminer@gmail.com>

I've noticed that there is no way to control file and folder umask on the host when
using 9p in mapped mode. This can be a major headache when actually sharing data
between different users using groups and ACLs. Thus I added the options fmask and dmask to
fsdev and virtfs to control the actual permissions of newly created files and folders on
the host. This is my first patch for QEMU. Please let me know if there are any issues with
it.

Tobias Schramm

Tobias Schramm (1):
  Add support for custom fmasks/dmasks in 9ps mapped mode

 fsdev/file-op-9p.h      |  4 ++++
 fsdev/qemu-fsdev-opts.c | 12 ++++++++++++
 hw/9pfs/9p-local.c      | 33 +++++++++++++++++++++++++++++----
 hw/9pfs/9p.c            |  3 +++
 4 files changed, 48 insertions(+), 4 deletions(-)

-- 
2.13.1

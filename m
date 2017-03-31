Received: from eggs.gnu.org ([2001:4830:134:3::10]:49663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctvIF-0006mN-ON
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 08:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctvIE-0005Sj-Uv
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 08:04:39 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 31 Mar 2017 14:04:29 +0200
Message-Id: <20170331120431.1767-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 0/2] curl: Extend and fix blockdev-add
 schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

Yes, it's yet another episode in our popular
get-blockdev-add-ready-for-2.9 drama!

Right now, the schema for the curl block driver is seriously lacking.
This series improves things at least a bit.

To improve things seriously, we might want to structure the URL instead
of it being just a plain string, and we might want to split the cookie
string into a list of dicts or something similar. However, strictly
speaking our curl block driver is *not* an (ht|f)tps? block driver but
just a curl driver. All it does is pass some options to libcurl and then
send and receive data from it. (We really should have just named it
"curl" from the start.)

Therefore, it probably is for the best to leave these options rather
opaque and let libcurl do the interpretation.


Max Reitz (2):
  qapi/curl: Extend and fix blockdev-add schema
  block/curl: Check protocol prefix

 qapi/block-core.json | 103 ++++++++++++++++++++++++++++++++++++++++++++++-----
 block/curl.c         |  10 +++++
 2 files changed, 104 insertions(+), 9 deletions(-)

-- 
2.12.1

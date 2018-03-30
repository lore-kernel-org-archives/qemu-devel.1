Received: from eggs.gnu.org ([2001:4830:134:3::10]:41028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1vlt-0005Uo-M8
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 11:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1vlq-0006OF-Ac
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 11:16:53 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 30 Mar 2018 18:16:33 +0300
Message-Id: <1522422996-14235-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/3] iotests: blacklist bochs and cloop for 205
 and 208
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, eblake@redhat.com, stefanha@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Blacklist these formats, as they don't support image creation, as they
say:
    > ./qemu-img create -f bochs x 1m
    qemu-img: x: Format driver 'bochs' does not support image creation

    > ./qemu-img create -f cloop x 1m
    qemu-img: x: Format driver 'cloop' does not support image creation

Vladimir Sementsov-Ogievskiy (3):
  iotests.py: improve verify_image_format helper
  iotests.py: support unsupported_fmts in main()
  iotests: blacklist bochs and cloop for 205 and 208

 tests/qemu-iotests/205        |  2 +-
 tests/qemu-iotests/208        |  2 ++
 tests/qemu-iotests/iotests.py | 11 ++++++-----
 3 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.7.4

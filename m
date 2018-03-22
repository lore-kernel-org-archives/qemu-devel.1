Received: from eggs.gnu.org ([2001:4830:134:3::10]:36878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eyyBp-0000N0-C9
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:15:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eyyBj-00063q-Pq
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:15:25 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:33475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1eyyBj-00060W-Dc
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:15:19 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 22 Mar 2018 13:14:51 +0200
Message-Id: <cover.1521717086.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-2.12 v3 0/2] Update output of some iotests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>

Hi,

I sent a patch a few days ago correction the output of iotests 051 and
186. I wanted to resend it again but I noticed that 186 needs now more
changes due to commit ac64273c66ab136c44043259162, so I'm including
those changes too.

Regards,

Berto

Alberto Garcia (2):
  iotests: Update 051 and 186 after commit 1454509726719e0933c
  iotests: Update 186 after commit ac64273c66ab136c44043259162

 tests/qemu-iotests/051.pc.out | 20 --------------------
 tests/qemu-iotests/186        |  4 ----
 tests/qemu-iotests/186.out    | 32 ++------------------------------
 3 files changed, 2 insertions(+), 54 deletions(-)

-- 
2.11.0

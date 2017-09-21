Received: from eggs.gnu.org ([2001:4830:134:3::10]:40965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1duqAZ-0008Ai-Mn
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 21:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1duqAY-000738-Lb
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 21:20:47 -0400
From: John Snow <jsnow@redhat.com>
Date: Wed, 20 Sep 2017 21:20:35 -0400
Message-Id: <20170921012037.553-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] IDE: combine portio r/w functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

Mark, here's a quick sketch for you. There are two things I don't like,
but didn't care enough to fix:

(1) Restricting nbytes to 2 or 4 means some extra boilerplate
    to quiet compilers who don't know it will only ever be 2 or 4
(2) the address value is all-but-ignored, it carries over from the
    portio signature and is useful primarily for tracing, but it's
    a little ugly/deceiving to take a parameter and not use it.

Suggested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

John Snow (2):
  ide: generic ide_data_read
  ide: generic ide_data_write

 hw/ide/core.c             | 185 +++++++++++++++++++++-------------------------
 hw/ide/trace-events       |   7 +-
 include/hw/ide/internal.h |   4 +-
 3 files changed, 89 insertions(+), 107 deletions(-)

-- 
2.9.5

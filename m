Received: from eggs.gnu.org ([2001:4830:134:3::10]:32931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJLUS-0001yl-L0
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:06:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJLUN-0000gT-1Y
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:06:20 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  9 Jun 2017 12:05:58 -0300
Message-Id: <20170609150600.4654-1-f4bug@amsat.org>
In-Reply-To: <80969f61-38d4-20ac-d850-5e90c8852b40@redhat.com>
References: <80969f61-38d4-20ac-d850-5e90c8852b40@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 0/2] ide/ahci: add missing includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-block@nongnu.org

Hi Eric, John.

The patch 07/11 "hw/arm: use defined type name instead of hard-coded string."
triggered this problem.

I split the previous series to only include the 2 commits involved to reproduce.

As you will see, calxeda_init() from highbank.c uses the sysbus type name
"sysbus-ahci" which is already defined in "hw/ide/ahci.h" as TYPE_SYSBUS_AHCI.
As mentioned in HACKING highbank.c first include is "qemu/osdep.h". However
compiling highbank.c fails (as reported in patch "04/11" commit comments).

I don't think appropriate to include "hw/ide/internal.h" and "sysemu/dma.h" in
highbank.c. Eventually another source including "hw/ide/ahci.h" will hit the
same error.

Do you see another place where those includes should go?

I think I did a mistake sending these both patchs in a series thinking they were
unrelated, I should have send them altogether, my bad :/

Regards,

Phil.

Philippe Mathieu-Daudé (2):
  arm/highbank: use defined type name instead of hard-coded string
  ide/ahci: add missing includes

 hw/arm/highbank.c     | 3 ++-
 include/hw/ide/ahci.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.11.0

Received: from eggs.gnu.org ([2001:4830:134:3::10]:60604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQZuQ-0006wp-Fz
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:59:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQZuL-00078a-Hg
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:59:34 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  6 Jun 2018 11:59:18 -0300
Message-Id: <20180606145921.30606-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/3] mac_newworld: add MAINTAINERS entries,
 fix qemu_log trailing '\n'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-ppc@nongnu.org

Nothing very exciting here.
I sometimes miss to notice some trace events, running with -d unimp,trace...
then using 'grep ^...'. This is only due to a missing '\n' :)

Philippe Mathieu-Daudé (3):
  MAINTAINERS: Add an entry for the MacIO device headers
  MAINTAINERS: Add entries for the MOS6522 VIA device
  hw/misc/mos6522: Add trailing '\n' to qemu_log() calls

 hw/misc/mos6522.c | 4 ++--
 MAINTAINERS       | 5 ++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.17.1

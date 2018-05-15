Received: from eggs.gnu.org ([2001:4830:134:3::10]:32910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIbpB-0002C0-7r
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIbp8-0005nF-4N
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:25:13 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 15 May 2018 12:24:58 -0300
Message-Id: <20180515152500.19460-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/2] mux: fix ctrl-a b again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-stable@nongnu.org

Hi, this series contains the rebased patches for the ctrl-a+b fix.

Please consider to include in qemu-stable.

Regards,

Phil.

v2:
- rebase on Peter serial cleanup:
  "Drop compile time limit on number of serial ports"
  http://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg03376.html
- added ctrl-ab test (Marc-André)

v1 was http://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg03168.html

Marc-André Lureau (1):
  mux: fix ctrl-a b again

Philippe Mathieu-Daudé (1):
  superio: Fix inconsistent use of Chardev->be

 chardev/char-mux.c   | 1 +
 hw/isa/isa-superio.c | 4 ++--
 tests/test-char.c    | 8 ++++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.17.0

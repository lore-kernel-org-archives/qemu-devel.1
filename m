Received: from eggs.gnu.org ([2001:4830:134:3::10]:58863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRKtT-0005ip-SP
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:37:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRKtP-0002jy-BK
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:37:27 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 19 Dec 2017 13:37:11 -0300
Message-Id: <20171219163713.31383-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/2] qemu-iotests: add missing make rule for
 socket_scm_helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Wenchao Xia <xiawenc@linux.vnet.ibm.com>, Stratos Psomadakis <psomas@grnet.gr>, Eric Blake <eblake@redhat.com>

Hi,

Apparently block-tests are only run on patchew CI, not Travis, so this went
unnoticed.

Now ./check does check for this helper, and errors are easier to figure out.

Regards,

Phil.

Philippe Mathieu-Daudé (2):
  qemu-iotests: add missing rule to build socket_scm_helper
  qemu-iotests: check socket_scm_helper is available

 tests/Makefile.include   | 2 +-
 tests/qemu-iotests/check | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.15.1

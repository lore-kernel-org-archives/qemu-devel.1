Received: from eggs.gnu.org ([209.51.188.92]:42592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1guNUH-0008FW-NV
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:20:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1guNUF-00054J-9k
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:20:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1guNUF-0004tp-08
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:19:59 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu, 14 Feb 2019 21:19:30 +0100
Message-Id: <20190214201939.494-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/9] ccid-card-passthru: check buffer size
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Prasad J Pandit <pjp@fedoraproject.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Hi,

This is the v2 of Prasad J Pandit first version [*], with Paolo's
review comment addressed.
This is a quick fix for CVE-2018-18438: "Integer overflow in
ccid_card_vscard_read() allows memory corruption".

Please review,

Phil.

[*] https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02200.html

Philippe Mathieu-Daud=C3=A9 (9):
  ccid-card-passthru: Move assertion in read() to can_read()
  ccid-card-passthru: Replace never trigger if statement by an assertion
  ccid-card-passthru: Assert on a stricter expression
  ccid-card-passthru: Let the chardev::read() be more generic
  ccid-card-passthru: Replace assert() by QEMU_BUILD_BUG_ON()
  ccid-card-passthru: Simplify the if() condition
  ccid-card-passthru: Use QERR_MISSING_PARAMETER
  ccid-card-passthru: Use size_t to hold size argument
  ccid-card-passthru: Use size_t for index

 hw/usb/ccid-card-passthru.c | 73 +++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 39 deletions(-)

--=20
2.20.1

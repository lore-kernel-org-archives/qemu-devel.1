Received: from eggs.gnu.org ([2001:4830:134:3::10]:58170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7qiJ-0007Al-J5
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7qiG-000320-Gb
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:05:39 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:44297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7qiG-00031q-BE
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:05:36 -0400
Received: by mail-qt0-x242.google.com with SMTP id j26so13491530qtl.11
	for <qemu-devel@nongnu.org>; Sun, 15 Apr 2018 16:05:36 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 15 Apr 2018 20:05:18 -0300
Message-Id: <20180415230522.24404-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/4] build: fix failure when host provides too
 old libfdt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Fam Zheng <famz@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, YunQiang Su <syq@debian.org>

Hi, I already hit this problem on Shippable and tried to resolve it for 2.10;
and shamefully hit it again yesterday on a Debian 8 host with distrib libfdt
installed. I wondered how to fix this without root access and realized my
previous Shippable kludge wasn't the best fix :)

Here we go adding the QEMU_LDFLAGS to enforce local libfdt in library path
before the system one.
This time it looks like the correct fix, also scalable for other libraries.

It would be great to have QEMU 2.12 buildable in Debian<9, but nobody
complained since 2.10 so this can wait 2.13 (this is not a regression neither).

Regards,

Phil.

Jan Kiszka (1):
  build: Silence dtc directory creation

Philippe Mathieu-Daudé (3):
  configure: Really use local libfdt if the system one is too old
  configure: Display if libfdt is from system or git
  shippable: Remove Debian 8 libfdt kludge

 configure      | 15 +++++++++------
 Makefile       |  2 +-
 rules.mak      |  2 +-
 .shippable.yml |  8 --------
 4 files changed, 11 insertions(+), 16 deletions(-)

-- 
2.17.0

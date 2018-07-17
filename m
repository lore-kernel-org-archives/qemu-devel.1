Received: from eggs.gnu.org ([2001:4830:134:3::10]:49153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffG2Z-00004t-OX
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:48:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffG2V-0008Qq-RN
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:48:39 -0400
Received: from mail-vk0-x243.google.com ([2607:f8b0:400c:c05::243]:37726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffG2V-0008Qf-M4
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:48:35 -0400
Received: by mail-vk0-x243.google.com with SMTP id h22-v6so22778686vke.4
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 19:48:35 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 16 Jul 2018 23:48:22 -0300
Message-Id: <20180717024827.27897-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/5] tests/vm: Improvements when KVM is not
 available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Hi Fam,

Few patches I added while testing the VM tests without KVM access.
I doubt many people want to suffer using TCG for VM testing, but
it was handy to debug/support aarch64 VM tests.

Also this could be a useful TCG stress test...?

Regards,

Phil.

Philippe Mathieu-Daudé (5):
  tests/vm: Extract the kvm_available() handy function
  tests/vm: Use 'host' cpu when KVM is available, else default to 'max'
  tests/vm: Do not abuse parallelism when KVM is not available
  tests/vm: Display remaining seconds to wait for a VM to start
  tests/vm: When using TCG, wait longer for a VM to start

 tests/vm/basevm.py | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

-- 
2.18.0

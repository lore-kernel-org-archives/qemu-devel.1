Received: from eggs.gnu.org ([2001:4830:134:3::10]:56793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1f4OLv-00064q-Ms
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 06:12:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1f4OLr-0007Dr-KN
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 06:12:15 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:51425)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1f4OLr-0007AU-Aj
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 06:12:11 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <a16f0636-9a13-f4fd-1b4c-34f7bf6b1b36@msgid.tls.msk.ru>
Date: Fri, 6 Apr 2018 13:12:02 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: ru-RU
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] roms/skiboot: .version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>

Hello!

In the qemu source tarball, roms/skiboot/ can't be built due to a trivial
error: the directory lacks expected-to-be-there .version file, which can
be built using roms/skiboot/make_version.sh script (which actually just
runs git --describe). However it is impossible to create from the
tarball since there's no .git/ directory in there.

Please include roms/skiboot/.version file in the distribution tarball.

Thanks,

/mjt

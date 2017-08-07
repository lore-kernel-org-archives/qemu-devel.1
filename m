Received: from eggs.gnu.org ([2001:4830:134:3::10]:44087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dej9c-0001x1-GT
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:37:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dej9X-0005FS-Iv
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:37:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dej9X-0005Dx-Cb
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:37:07 -0400
Date: Mon, 7 Aug 2017 16:31:21 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170807163121.797e7ad6@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] AVMF & OVMF blobs in QEMU tree???
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>

As I recall there were issues with FAT driver licensing in edk2,
but I've heard there were some changes in that regard.

Is there any other reasons why we are not putting subj.
in QEMU tree like we do with SeaBIOS and other roms?

PS:
Mostly I'm interested in having AVMF ROM in QEMU,
to make testing of ACPI tables (tests/bios-tables-test)
for virt-arm work (it has 0 coverage right now).
It would be useful to have OVMF blob as well so we could
notice if some OVMF related stuff is broken or changed
unexpectedly.

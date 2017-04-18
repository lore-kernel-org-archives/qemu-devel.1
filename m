Received: from eggs.gnu.org ([2001:4830:134:3::10]:56655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mithro@mithis.com>) id 1d0MRr-00044v-TD
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 02:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mithro@mithis.com>) id 1d0MRo-0004i6-QO
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 02:17:11 -0400
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:33152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mithro@mithis.com>) id 1d0MRo-0004hs-Gb
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 02:17:08 -0400
Received: by mail-pf0-x236.google.com with SMTP id s16so75995593pfs.0
	for <qemu-devel@nongnu.org>; Mon, 17 Apr 2017 23:17:08 -0700 (PDT)
From: Tim 'mithro' Ansell <mithro@mithis.com>
Date: Tue, 18 Apr 2017 16:15:49 +1000
Message-Id: <20170418061551.196582-1-mithro@mithis.com>
Subject: [Qemu-devel] [PATCH 0/2] targets/openrisc: Improve exception
 vectoring.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Tim 'mithro' Ansell <mithro@mithis.com>, shorne@gmail.com

Hi,

This patch series improves the exception vectoring on the OpenRISC platform by
adding support for both the EVBAR register and EPH bit.

This is my first patch to upstream QEMU, so please do point of if I have done
anything silly.

Tim 'mithro' Ansell (2):
  target/openrisc: Implement EVBAR register
  target/openrisc: Implement EPH bit

 target/openrisc/cpu.c        | 2 ++
 target/openrisc/cpu.h        | 7 +++++++
 target/openrisc/interrupt.c  | 9 ++++++++-
 target/openrisc/sys_helper.c | 7 +++++++
 4 files changed, 24 insertions(+), 1 deletion(-)

-- 
2.12.1

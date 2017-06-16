Received: from eggs.gnu.org ([2001:4830:134:3::10]:48263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dLpKP-0004Yp-Rg
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 07:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dLpKM-0003Vz-Kb
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 07:22:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dLpKM-0003VQ-EK
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 07:22:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 64FC2B167
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 11:22:08 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
Date: Fri, 16 Jun 2017 13:21:59 +0200
Message-Id: <20170616112201.24512-1-lersek@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] tests/q35-test: add TSEG size checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Paolo suggested that I add test cases for verifying TSEG sizes in qtest
(tests/q35-test.c); in particular that I check memory writeability
around the low boundary of TSEG.

As noted on patch #2, the "/q35/tseg-size/ext/16mb" test depends on the
following patch:

  [PATCH] q35/mch: implement extended TSEG sizes
  http://mid.mail-archive.com/20170608161013.17920-1-lersek@redhat.com

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>

Thanks!
Laszlo

Laszlo Ersek (2):
  tests/q35-test: push down qtest_start / qtest_end to test case(s)
  tests/q35-test: add TSEG size checks

 tests/q35-test.c | 125 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 118 insertions(+), 7 deletions(-)

-- 
2.9.3

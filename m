Received: from eggs.gnu.org ([2001:4830:134:3::10]:43633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e2eab-0000Ec-BQ
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 10:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e2eaV-0002FM-SN
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 10:35:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11419)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e2eaV-0002F6-LT
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 10:35:51 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 12 Oct 2017 16:35:46 +0200
Message-Id: <20171012143548.18581-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] target/i386: trap on instructions longer
 than >15 bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org

This is an improved (and more invasive) fix for the bug fixed in
commit 30663fd ("tcg/i386: Check the size of instruction being
translated", 2017-03-24).

Paolo Bonzini (2):
  target/i386: introduce x86_ld*_code
  target/i386: trap on instructions longer than >15 bytes

 target/i386/translate.c | 257 +++++++++++++++++++++++++++---------------------
 1 file changed, 147 insertions(+), 110 deletions(-)

-- 
2.14.2

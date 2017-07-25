Received: from eggs.gnu.org ([2001:4830:134:3::10]:48769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1da0CY-0005pW-A3
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:48:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1da0CV-0001Mg-74
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:48:42 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:38193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1da0CV-0001MV-0f
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:48:39 -0400
Received: by mail-wr0-x244.google.com with SMTP id g32so2646933wrd.5
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 06:48:38 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 25 Jul 2017 15:48:30 +0200
Message-Id: <1500990514-30326-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] mc146818rtc: implement UIP latching as
 intended
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peng.hao2@zte.com.cn, liu.yi24@zte.com.cn

Based on discussions with Peng Hao.  It is not clear to me what
causes UIP to get stuck in his case, but these changes test one
such scenario.

Paolo

Paolo Bonzini (4):
  rtc-test: cleanup register_b_set_flag test
  rtc-test: introduce more update tests
  mc146818rtc: simplify check_update_timer
  mc146818rtc: implement UIP latching as intended

 hw/timer/mc146818rtc.c |  37 ++++++------
 tests/rtc-test.c       | 156 +++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 145 insertions(+), 48 deletions(-)

-- 
1.8.3.1

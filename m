Received: from eggs.gnu.org ([2001:4830:134:3::10]:39317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dyw8Q-0001bu-Bw
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 04:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dyw8K-0001sY-Ti
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 04:31:30 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dyw8K-0001rI-Nk
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 04:31:24 -0400
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Mon, 02 Oct 2017 11:30:57 +0300
Message-id: <1506933058-28313-1-git-send-email-a.perevalov@samsung.com>
In-reply-to: <20170929143812.GG11930@redhat.com>
References: <20170929143812.GG11930@redhat.com>
	<CGME20171002083119eucas1p191b8bdf0c990b86a7290c28b65312b86@eucas1p1.samsung.com>
Subject: [Qemu-devel] [PATCH] fix tests/migration/stress build in case of
 absend static libc++
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, i.maximets@samsung.com, berrange@redhat.com, heetae82.ahn@samsung.com, quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com
List-ID: <qemu-devel.nongnu.org>

Hello Daniel,
I decided just to use CC instead of swapping CXX and CC in LINKPROG,
and keep PTHREAD_LIB untouched, once your decided previous patch is ok.



Alexey Perevalov (1):
  Makefile: don't use LINKPROG for tests/migration/stress

 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.7.4

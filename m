Received: from eggs.gnu.org ([2001:4830:134:3::10]:51740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cg9q7-0001Y4-Jb
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:46:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cg9q4-0003Ag-FJ
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:46:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cg9q4-0003AL-8n
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:46:40 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Feb 2017 13:46:35 +0100
Message-Id: <20170221124638.19573-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] cpu-exec: icount and exit request cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pavel.dovgaluk@ispras.ru, peter.maydell@linaro.org

These are the patches I left out of my previous pull request, in
hope of getting more reviews (especially for the first).  They
haven't come yet, so I'm asking more explicitly...

Paolo

Paolo Bonzini (2):
  cpu-exec: unify icount_decr and tcg_exit_req
  cpu-exec: remove unnecessary check of cpu->exit_request

Pavel Dovgalyuk (1):
  replay: check icount in cpu exec loop

 cpu-exec.c                | 79 ++++++++++++++++++++---------------------------
 include/exec/gen-icount.h | 53 +++++++++++++++----------------
 include/qom/cpu.h         | 15 +++++----
 qom/cpu.c                 |  2 +-
 tcg/tcg.h                 |  1 -
 translate-all.c           |  2 +-
 translate-common.c        | 13 +++-----
 7 files changed, 72 insertions(+), 93 deletions(-)

-- 
2.9.3

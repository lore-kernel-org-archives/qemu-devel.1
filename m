Received: from eggs.gnu.org ([2001:4830:134:3::10]:44083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d5qpF-00043q-RN
	for qemu-devel@nongnu.org; Wed, 03 May 2017 05:44:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d5qp9-0006k8-3g
	for qemu-devel@nongnu.org; Wed, 03 May 2017 05:44:01 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1d5qp8-0006ii-T8
	for qemu-devel@nongnu.org; Wed, 03 May 2017 05:43:55 -0400
Received: by mail-wm0-x243.google.com with SMTP id y10so11381356wmh.0
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 02:43:54 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  3 May 2017 11:43:46 +0200
Message-Id: <20170503094351.5040-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] MAINTAINERS/get_maintainers: add support
 for reviewers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, thuth@redhat.com, pavel.dovgaluk@ispras.ru

I would like to use "R" so that people can delegate maintenance of some
code while keeping some degree of oversight.  In my case, this can be
appropriate for record/replay and cpus.c.

Other people are free to use "R" as in Linux, where it is used to
designate non-maintainers for reviewing patches in a given area.

Paolo

Brian Norris (2):
  get_maintainer: it's '--pattern-depth', not '-pattern-depth'
  get_maintainer: --r (list reviewer) is on by default

Joe Perches (2):
  get_maintainer: Teach get_maintainer.pl about the new "R:" tag
  get_maintainer: add subsystem to reviewer output

Paul E. McKenney (1):
  MAINTAINERS: Add "R:" tag for self-appointed reviewers

 MAINTAINERS               |  2 ++
 scripts/get_maintainer.pl | 53 +++++++++++++++++++++++++++++++++--------------
 2 files changed, 39 insertions(+), 16 deletions(-)

-- 
2.12.2

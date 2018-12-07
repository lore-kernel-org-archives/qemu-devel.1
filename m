Received: from eggs.gnu.org ([2001:4830:134:3::10]:54357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gVMvy-00006l-RR
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 15:41:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gVMvu-0005Ye-TD
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 15:41:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gVMvu-0005YI-N6
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 15:41:10 -0500
Date: Fri, 7 Dec 2018 18:41:07 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181207204107.GH7395@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] Help needed: test-qht-par hangs on Travis
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>

I've noticed QEMU Travis builds are failing recently, and they
seem to happen only on the --enable-gprof jobs.  I have enabled
V=1 and noticed that the jobs are hanging inside test-qht-par.

Example here (look for "/qht/parallel/2threads-0%updates-1s"):

https://travis-ci.org/ehabkost/qemu-hacks/jobs/465081311

Does anybody have any idea why?

-- 
Eduardo

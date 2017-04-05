Received: from eggs.gnu.org ([2001:4830:134:3::10]:49369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cvqAR-0003OX-7D
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:00:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cvqAO-0001FW-73
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:00:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cvqAO-0001F8-0j
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:00:28 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed,  5 Apr 2017 20:00:21 +0100
Message-Id: <20170405190024.27581-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3 for 2.10] migration/i386 cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, quintela@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  This removes some qemu_get_ and qemu_put_ use from i386/machine.c
and cleans out some very old code.
  It breaks migration compatibility from prior to 0.12
for i386 and prior to ~0.14 for non-softfloat - it doesn't alter the
machine type, it just removes some old stream features.

(Has anyone got a good test of FP migration to make sure
I've not broken the FP/mmx/etc cases?)

Dave


Dr. David Alan Gilbert (3):
  migration/i386: Remove old non-softfloat 64bit FP support
  vmstatification: i386 FPReg
  migration/i386: Remove support for pre-0.12 formats

 target/i386/machine.c | 266 +++++++++++++-------------------------------------
 1 file changed, 66 insertions(+), 200 deletions(-)

-- 
2.9.3

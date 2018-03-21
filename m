Received: from eggs.gnu.org ([2001:4830:134:3::10]:55118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1eykkJ-0007k4-3q
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:54:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1eykkF-0004fQ-Vf
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:54:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jack.schwartz@oracle.com>)
	id 1eykkF-0004e3-Mi
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:54:03 -0400
From: Jack Schwartz <jack.schwartz@oracle.com>
Date: Wed, 21 Mar 2018 13:53:46 -0700
Message-Id: <1521665627-5451-1-git-send-email-jack.schwartz@oracle.com>
Subject: [Qemu-devel] [PATCH 0/1] multiboot.c: Document as fixed against
 CVE-2018-7550
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, pjp@fedoraproject.org, kraxel@redhat.com
Cc: karl.heubaum@oracle.com, konrad.wilk@oracle.com, mark.kanda@oracle.com, jack.schwartz@oracle.com

Some changes were delivered a few weeks ago that fixed CVE-2018-7550
before that CVE was created.  Changeset:
    2a8fcd119eb7 ("multiboot: bss_end_addr can be zero")

Shortly after that delivery, a different changeset claimed in its commit
message to fix that CVE, but it really fixed a different one.  Changeset:
    7cdc61becd09 ("vga: fix region calculation")
PJP says the proper CVE is CVE-2018-7858
https://bugzilla.redhat.com/show_bug.cgi?id=1553402

Not sure what the proper protocol is for getting this all straightened
out, but I would like to help since I delivered the multiboot changes.

This patch set contains an empty patch with a commit message to document
the multiboot changes.  Please add it to the repo as you see fit, or let
me know if you need something else from me to resolve this differently.

Note that unless the vga CVE is explained/corrected, people may get
confused when they see different fixes associated with the same CVE.

	Thanks,
	Jack

Jack Schwartz (1):
  multiboot.c: Document as fixed against CVE-2018-7550

-- 
1.8.3.1

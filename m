Received: from eggs.gnu.org ([2001:4830:134:3::10]:58716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dLWhn-0005eN-DD
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 11:29:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dLWhk-0001Pe-3m
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 11:29:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dLWhj-0001Ot-U4
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 11:29:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 50A3261BAE
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 15:29:00 +0000 (UTC)
Date: Thu, 15 Jun 2017 16:28:52 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170615152852.GB2399@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] ahci-test failures with 'Failed to get "write" lock'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jsnow@redhat.com, kwolf@redhat.com
Cc: stefanha@redhat.com, mreitz@redhat.com

Hi,
  Peter noticed that there were some hangs in the ahci-test;
I can reproduce them on my laptop as long as the laptop has
some other load on it (a few md5sum /dev/zero's help).

/x86_64/ahci/flush/migrate: qemu-system-x86_64: Failed to get "write" lock
Is another process using the image?
OK
/x86_64/ahci/migrate/sanity: qemu-system-x86_64: Failed to get "write" lock
Is another process using the image?

and that hangs in sanity.

That seems to be the common case, I've also had one:

/x86_64/ahci/migrate/ncq/halted: qemu-system-x86_64: Failed to get "write" lock
Is another process using the image?
qemu-system-x86_64: /home/dgilbert/git/qemu/block/io.c:1352: bdrv_aligned_pwritev: Assertion `child->perm & BLK_PERM_WRITE' failed.


Neither of these always fail.

Dave
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

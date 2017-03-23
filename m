Received: from eggs.gnu.org ([2001:4830:134:3::10]:36087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cqwEm-0003w4-VP
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 02:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cqwEi-0002CQ-3f
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 02:28:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cqwEh-0002C3-UU
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 02:28:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1DAEA7F3EB
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 06:28:39 +0000 (UTC)
Date: Thu, 23 Mar 2017 14:28:31 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170323062831.GD4224@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Qemu-devel] Wiki page for VT-d
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Devel Mailing List <qemu-devel@nongnu.org>
Cc: Peter Xu <peterx@redhat.com>

Hello everyone,

Since we still don't have a document-like thing for vIOMMUs on x86 yet
(for the basic command line interface, usage scenarios, etc.), I just
opened a VT-d wiki page to note down everything that might be related
to VT-d emulation in QEMU. It's here:

  http://wiki.qemu-project.org/Features/VT-d

We can have AMD IOMMUs as well in the future, but since currently
these two devices are not synced-up (most of the work are based on
Intel vIOMMUs), so I'll first create the VT-d page. We can extend the
documentation when needed.

Currently it only contains the most basic usages of the emulated VT-d
device, and some explanations on the recent VT-d vfio enablement
series (what it does, where it can be used, etc.). Please feel free to
add more things to it. :-)

Thanks,

-- peterx

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1detrI-0000PZ-Kd
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 22:03:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1detrD-0005Gp-Rd
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 22:03:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1detrD-0005GJ-Kp
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 22:02:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 46E83461C1
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 02:02:54 +0000 (UTC)
Received: from localhost (ovpn-12-100.pek2.redhat.com [10.72.12.100])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5C2587012E
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 02:02:50 +0000 (UTC)
Date: Tue, 8 Aug 2017 10:02:49 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170808020249.GQ14780@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] Howto: instructing patchew about patch dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi, QEMU patch submitters,

I've patched patchew so that if you add a line:

Based-on: $MESSAGE_ID

in your cover letter body, or in a reply to it (or reply to reply), patchew will
try to apply your series on top of the one $MESSAGE_ID refers to, assuming the
base series _was_ successfully applied by patchew earlier.

In the single patch case, you can put the line under the "---" mark in the
commit message (no need to let it enter git history).

For human readability, around the "Based-on:" line it may be better if the
subject is noted. E.g.:

Based-on: 20170804140942.19342-1-famz@redhat.com
([PATCH for-2.10] vmdk: Fix error handling/reporting of vmdk_check)

Please don't join them in one line because it will confuse the parser, after all
following the message id text, there aren't many spaces left.

Fam

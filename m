Received: from eggs.gnu.org ([2001:4830:134:3::10]:45888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgv3I-0001mD-7z
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:11:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgv3E-0004gy-55
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:11:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cgv3D-0004gY-Vo
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:11:24 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F3CF67FB89
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 15:11:23 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170223144034.b2bhgsvwfyyymxwk@eukaryote>
Date: Thu, 23 Feb 2017 16:11:21 +0100
In-Reply-To: <20170223144034.b2bhgsvwfyyymxwk@eukaryote> (Kashyap Chamarthy's
	message of "Thu, 23 Feb 2017 15:40:34 +0100")
Message-ID: <87ino1gcx2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Adding an overlay with 'blockdev-add' fails with:
 "Parameter 'driver' is missing"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org

Kashyap Chamarthy <kchamart@redhat.com> writes:

> TL;DR: Using `blockdev-add` to create an overlay file succeeds with QEMU
>        2.7.0, however the *same* test fails with QEMU from Git (plus a
>        couple of patch series from mailing list).  Details below.

commit 0153d2f50bc2ad3f41810d838fcf66acbf10f07a
Author: Kevin Wolf <kwolf@redhat.com>
Date:   Fri Oct 7 17:05:04 2016 +0200

    block: Remove "options" indirection from blockdev-add
    
    Now that QAPI supports boxed types, we can have unions at the top level
    of a command, so let's put our real options directly there for
    blockdev-add instead of having a single "options" dict that contains the
    real arguments.
    
    blockdev-add is still experimental and we already made substantial
    changes to the API recently, so we're free to make changes like this
    one, too.
    
    Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Sorry for the confusion!  Early adopters always have the most fun ;)

[...]

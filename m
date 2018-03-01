Received: from eggs.gnu.org ([2001:4830:134:3::10]:51763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1erOjn-0003Nu-Ov
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:59:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1erOjn-00045S-3K
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:59:11 -0500
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Thu,  1 Mar 2018 13:58:54 +0000
Message-Id: <20180301135856.22698-1-rjones@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] block: curl: Proof of concept for
 connecting to oVirt.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jcody@redhat.com
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

This is a proof of concept patch which needs a bunch more testing.
I'm just posting it to get feedback.

It's almost possible to connect qemu to an oVirt / RHV server and
upload or download or otherwise modify disk images.  However the
curl driver is missing a couple of features to satisfy oVirt's
authentication requirements, and these features could be generally
useful for others too.

The patches: Allow arbitrary headers to be sent, so you can add the
oVirt authentication ticket as a special header.  And allow you to
specify a CA bundle, which is required for servers which do client
authentication.

The particular tricky areas are:

 - I have no idea if I'm doing lists right (first patch), although
   it appears to work.

 - I did not test the QAPI stuff, and I'm not even sure how to go
   about that.

 - There's no documentation, but there's no documentation for many
   other curl driver features either.

 - There are no tests, but similarly no tests for other curl features.

Rich.

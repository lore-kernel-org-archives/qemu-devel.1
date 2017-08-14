Received: from eggs.gnu.org ([2001:4830:134:3::10]:48514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1dhMEo-000741-VI
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 16:45:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1dhMEj-0000xp-W7
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 16:45:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52598
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.vnet.ibm.com>)
	id 1dhMEj-0000wC-Og
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 16:45:21 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7EKhd3s114721
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 16:45:21 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cbfr2sfba-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 16:45:21 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.vnet.ibm.com>;
	Mon, 14 Aug 2017 21:45:17 +0100
From: Eric Farman <farman@linux.vnet.ibm.com>
Date: Mon, 14 Aug 2017 22:44:49 +0200
Message-Id: <20170814204450.24118-1-farman@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH for-2.10 0/1] Fix "make clean" for s390 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cohuck@redhat.com, thuth@redhat.com
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Eric Farman <farman@linux.vnet.ibm.com>

How often does one really do a "make clean" ?  Rather infrequently,
as I only stumbled on this today.

Perhaps I have missed the RM variable somewhere, as I see similar syntax
in some of the tests/tcg/ Makefiles, but I don't see it being set here.
My configure statement isn't terribly interesting, just enabling debug
for an s390x target, and as such there's no RM variable in its output.
I'll trust that Thomas will chime in with where it should have been.
In the meantime, this does the trick for me.

I didn't rebuild the image file after this change, because it didn't seem
necessary.  Let me know if that was a bad assumption, and I can submit one.

Eric Farman (1):
  pc-bios/s390-ccw: Use rm command during make clean

 pc-bios/s390-ccw/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.11.2

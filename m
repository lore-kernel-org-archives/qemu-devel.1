Received: from eggs.gnu.org ([2001:4830:134:3::10]:43222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ceKuz-0000PY-SU
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:12:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ceKuw-0002cK-M3
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:12:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49441
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1ceKuw-0002YJ-F5
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:12:10 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1GC3axR094568
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 07:12:08 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28na7xv8x4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 07:12:08 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 16 Feb 2017 12:12:06 -0000
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 16 Feb 2017 13:11:35 +0100
Message-Id: <20170216121140.9061-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/5] vmstate: handle arrays with null ptrs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Amit Shah <amit.shah@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

This is basically the next iteration of the patch set "[RFC PATCH v2 0/8]
VMS_ARRAY_OF_POINTER with null pointers". Mostly a rebase on top of
current master. I have kept the r-b's for patches which remained
conceptually the same.  If someone disagrees please complain.

RFC v2 -> v1:
* rebase
* changed marker as suggested by Dave (incl. simplifications)
* fixed issues pointed out by Dave
* reworded some commit messages
* added a test for array of ptr to primitive

Halil Pasic (5):
  migration/vmstate: renames in (load|save)_state
  migration/vmstate: split up vmstate_base_addr
  migration/vmstate: fix array of ptr with nullptrs
  tests/test-vmstate.c: test array of ptr with null
  tests/test-vmstate.c: test array of ptr to primitive

 include/migration/vmstate.h |   4 ++
 migration/vmstate.c         |  90 ++++++++++++++++++++++-------------
 tests/test-vmstate.c        | 113 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 174 insertions(+), 33 deletions(-)

-- 
2.8.4

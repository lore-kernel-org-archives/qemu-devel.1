Received: from eggs.gnu.org ([2001:4830:134:3::10]:34845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cgZME-0005KS-Im
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:01:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cgZMA-0002s2-Ha
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:01:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38189)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cgZMA-0002rg-8o
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:01:30 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1MFwgBL111467
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 11:01:28 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28sb1ns2sx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 11:01:28 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 22 Feb 2017 16:01:25 -0000
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 22 Feb 2017 17:01:14 +0100
Message-Id: <20170222160119.52771-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/5] vmstate: handle arrays with null ptrs
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

The objective is supporting migration of arrays of pointers 
holdig a mix of null and not null pointers.

v1 -> v2:
* do not ignore return value (Dave)
* change some asserts to report_error+rc (Dave)
* factor out and reuse wire_sample in patches 4 and 5 (Dave)
* minor reword of patch 2
* add r-b's


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
 migration/vmstate.c         |  97 +++++++++++++++++++++++------------
 tests/test-vmstate.c        | 122 ++++++++++++++++++++++++++++++++++++++------
 3 files changed, 173 insertions(+), 50 deletions(-)

-- 
2.8.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:43329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ds6Br-0000Rx-C5
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:50:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ds6Bm-0005SX-EC
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:50:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1ds6Bl-0005Rr-PB
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:50:42 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8DBn3c1144389
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:50:40 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cy1pn7dr7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:50:40 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 13 Sep 2017 12:50:38 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 13 Sep 2017 13:50:25 +0200
Message-Id: <20170913115029.47626-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/4] add CCW indirect data access support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

Abstract
--------

The objective of this series is introducing CCW IDA (indirect data
access) support to our virtual channel subsystem implementation. Briefly
CCW IDA can be thought of as a kind of a scatter gather support for a
single CCW. If certain flags are set, the cda is to be interpreted as an
address to a list which in turn holds further addresses designating the
actual data.  Thus the scheme which we are currently using for accessing
CCW payload does not work in general case. Currently there is no
immediate need for proper IDA handling (no use case), but since it IDA is
a non-optional part of the architecture, the only way towards AR
compliance is actually implementing IDA.

Testing
-------

On request the things meant for testing from v1 were factored out
into a separate series (requested by Connie). Please look for
the series  'tests for CCW IDA' (comming soon) or use the stuff
form v1.

Changelog
---------

v1 --> v2
* factored out the stuff added only for testing
* use g_assert instead of assert
* fixed a lot's of typos
* removed some TODOs addressed by another series of mine
* refactored ccw_dstream_rw_ida (structured programming)
* done some rewording of commit message #3

Halil Pasic (4):
  s390x/css: introduce css data stream
  s390x/css: use ccw data stream
  virtio-ccw: use ccw data stream
  s390x/css: support ccw IDA

 hw/s390x/css.c         | 171 +++++++++++++++++++++++++++++++++++++++++++++++--
 hw/s390x/virtio-ccw.c  | 156 +++++++++++++-------------------------------
 include/hw/s390x/css.h |  67 +++++++++++++++++++
 3 files changed, 280 insertions(+), 114 deletions(-)

--
2.13.5

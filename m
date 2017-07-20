Received: from eggs.gnu.org ([2001:4830:134:3::10]:43322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dYAhv-0006WS-8n
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:37:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dYAhr-0004PD-7h
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:37:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dYAhr-0004Oa-1p
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:37:27 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 20 Jul 2017 14:37:16 +0200
Message-Id: <20170720123721.12366-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/5] target/s390x: cpu model cleanups +
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, thuth@redhat.com, cohuck@redhat.com, jjherne@linux.vnet.ibm.com, david@redhat.com, borntraeger@de.ibm.com

We want to reuse e.g. s390_get_feat_block() in tcg. Turns out, that
set_bit_inv() doesn't work as expected on other architectures (if we
want to expose the uint8_t[] based data to the VM later), so let's
fix that.

Some other minor cleanups, including better baselining support if one
of the MSA subfunctions part of a base model is missing.

v1 -> v2:
- try to make the compiler not spit out warnings

David Hildenbrand (5):
  target/s390x: drop BE_BIT()
  target/s390x: indicate query subfunction in s390_fill_feat_block
  target/s390x: introduce (test|set)_be_bit
  s390x/kvm: better comment regarding zPCI feature availability
  target/s390x: improve baselining if certain base features are missing

 target/s390x/cpu_features.c | 33 +++++++++++++++++++++++++++------
 target/s390x/cpu_features.h |  9 ++++++++-
 target/s390x/cpu_models.c   | 33 +++++++++++++++++++++++++++++++++
 target/s390x/kvm.c          | 29 +++--------------------------
 4 files changed, 71 insertions(+), 33 deletions(-)

-- 
2.9.4

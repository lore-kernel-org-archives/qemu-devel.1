Received: from eggs.gnu.org ([209.51.188.92]:57276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJ6Ac-0003Pg-4S
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJ64U-0008UA-FJ
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:47:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:22526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hJ64U-0008SK-6q
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:47:34 -0400
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Wed, 24 Apr 2019 08:46:56 +0800
Message-Id: <20190424004700.12766-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/4] cleanup savevm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, dgilbert@redhat.com, Wei Yang <richardw.yang@linux.intel.com>

There are several trivial cleanup for savevm.

  * remove duplicate check
  * more restrict check
  * reorder load sequence
  * wrap several steps into qemu_loadvm_state_header

Wei Yang (4):
  migration/savevm: remove duplicate check of migration_is_blocked
  migration/savevm: use migration_is_blocked to validate
  migration/savevm: load_header before load_setup
  migration/savevm: wrap into qemu_loadvm_state_header()

 migration/savevm.c | 75 +++++++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 34 deletions(-)

-- 
2.19.1

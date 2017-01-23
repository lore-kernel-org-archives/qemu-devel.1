Received: from eggs.gnu.org ([2001:4830:134:3::10]:41636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cVj0t-000828-A9
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 13:06:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cVj0p-00031J-DX
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 13:06:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cVj0p-00031A-7o
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 13:06:39 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 23 Jan 2017 16:06:30 -0200
Message-Id: <20170123180632.28942-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] qemu-options: Rewrite -numa documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

The first patch is a trivial fix to an issue reported by Peter
Maydell. The second patch rewrites all the rest.

Eduardo Habkost (2):
  qemu-options: Rename variables on the -numa "cpus" option
  qemu-options: Rewrite -numa documentation

 qemu-options.hx | 46 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 14 deletions(-)

-- 
2.11.0.259.g40922b1

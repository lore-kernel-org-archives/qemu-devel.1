Received: from eggs.gnu.org ([2001:4830:134:3::10]:42952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzZvE-0005Vs-Ni
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 23:00:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzZvB-00076F-Nq
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 23:00:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dzZvB-00075T-Ha
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 23:00:29 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed,  4 Oct 2017 00:00:23 -0300
Message-Id: <20171004030025.7866-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/2] Deprecate -nodefconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair23@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>

Changes v2 -> v3:
* Move documentation to the right section of qemu-doc.texi

Changes v1 -> v2:
* Document at "Deprecated features" section in qemu-doc.texi
  (Daniel)
* Remove documentation for the option from qemu-options.hx
  (Markus)

Since 2012 (commit ba6212d8 "Eliminate cpus-x86_64.conf file") we
have no default config files that would be disabled using
-nodefconfig.  This series cleans up the code, updates
documentation, and document -nodefconfig as deprecated.

Eduardo Habkost (2):
  vl: Eliminate defconfig variable
  qemu-options: Deprecate -nodefconfig

 vl.c            |  5 +----
 qemu-doc.texi   |  4 ++++
 qemu-options.hx | 17 ++++-------------
 3 files changed, 9 insertions(+), 17 deletions(-)

-- 
2.13.5

Received: from eggs.gnu.org ([2001:4830:134:3::10]:42356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dKRQ9-0002Bd-U2
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 11:38:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dKRQ5-0007Jt-SJ
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 11:38:25 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:36183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dKRQ5-0007H6-L5
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 11:38:21 -0400
Received: by mail-wr0-x242.google.com with SMTP id e23so22871622wre.3
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 08:38:21 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Jun 2017 17:38:14 +0200
Message-Id: <20170612153816.15266-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] docs: create docs/interop/,
 include version number in qemu-doc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, thuth@redhat.com

Submitted together because of Makefile conflicts.

Paolo Bonzini (2):
  docs: create interop/ subdirectory
  qemu-doc: include version number

 .gitignore                                         | 16 ++---
 Makefile                                           | 72 ++++++++++++----------
 configure                                          |  2 +-
 docs/{specs => interop}/parallels.txt              |  0
 docs/{specs => interop}/qcow2.txt                  |  0
 docs/{specs => interop}/qed_spec.txt               |  0
 docs/{ => interop}/qemu-ga-ref.texi                |  0
 docs/{ => interop}/qemu-qmp-ref.texi               |  0
 docs/{ => interop}/qmp-intro.txt                   |  0
 docs/{ => interop}/qmp-spec.txt                    |  0
 docs/{specs => interop}/vhost-user.txt             |  0
 .../{ => interop}/vnc-ledstate-Pseudo-encoding.txt |  0
 qemu-doc.texi                                      |  5 +-
 rules.mak                                          |  2 +-
 14 files changed, 51 insertions(+), 46 deletions(-)
 rename docs/{specs => interop}/parallels.txt (100%)
 rename docs/{specs => interop}/qcow2.txt (100%)
 rename docs/{specs => interop}/qed_spec.txt (100%)
 rename docs/{ => interop}/qemu-ga-ref.texi (100%)
 rename docs/{ => interop}/qemu-qmp-ref.texi (100%)
 rename docs/{ => interop}/qmp-intro.txt (100%)
 rename docs/{ => interop}/qmp-spec.txt (100%)
 rename docs/{specs => interop}/vhost-user.txt (100%)
 rename docs/{ => interop}/vnc-ledstate-Pseudo-encoding.txt (100%)

-- 
2.13.0

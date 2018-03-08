Received: from eggs.gnu.org ([2001:4830:134:3::10]:60256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etxtF-0001Jp-DS
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:55:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etxtE-0004T8-ND
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:55:33 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36828 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1etxtE-0004Sj-IY
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:55:32 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0C08FA28C5
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 15:55:32 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu,  8 Mar 2018 15:55:22 +0000
Message-Id: <20180308155524.5082-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/2] Avoid QEMU specific types in trace
 probes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

Changed in v2:

 - Split into 2 patches
 - Added ptrdiff_t type to whitelist

Daniel P. Berrang=C3=A9 (2):
  trace: remove use of QEMU specific types from trace probes
  trace: only permit standard C types and fixed size integer types

 scripts/tracetool/__init__.py | 46 +++++++++++++++++++++++++++++++++++++=
++++++
 trace-events                  |  6 +++---
 2 files changed, 49 insertions(+), 3 deletions(-)

--=20
2.14.3

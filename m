Received: from eggs.gnu.org ([2001:4830:134:3::10]:56945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fHCmf-0001Nw-Hq
	for qemu-devel@nongnu.org; Fri, 11 May 2018 14:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fHCmc-0004Gy-VK
	for qemu-devel@nongnu.org; Fri, 11 May 2018 14:28:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35590 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fHCmc-0004Gl-Qx
	for qemu-devel@nongnu.org; Fri, 11 May 2018 14:28:46 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 11 May 2018 19:28:41 +0100
Message-Id: <20180511182841.8920-2-stefanha@redhat.com>
In-Reply-To: <20180511182841.8920-1-stefanha@redhat.com>
References: <20180511182841.8920-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/1] MAINTAINERS: Add trace-events and
 qemu-option-trace.texi to tracing section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The "trace-events" and "qemu-option-trace.texi" files in the top director=
y
are currently "unmaintained" according to scripts/get_maintainer.pl. They
obviously belong to the Tracing section, so add an entry for them there.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 1525840700-30635-1-git-send-email-thuth@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 459e3594e1..e187b1f18f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1656,6 +1656,8 @@ Tracing
 M: Stefan Hajnoczi <stefanha@redhat.com>
 S: Maintained
 F: trace/
+F: trace-events
+F: qemu-option-trace.texi
 F: scripts/tracetool.py
 F: scripts/tracetool/
 F: docs/devel/tracing.txt
--=20
2.17.0

Received: from eggs.gnu.org ([2001:4830:134:3::10]:34083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f4RSF-0006IY-0J
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f4RSB-00036F-1u
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:30:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35740 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f4RSA-00035p-Tw
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:30:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29BFF77067
	for <qemu-devel@nongnu.org>; Fri,  6 Apr 2018 13:30:54 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri,  6 Apr 2018 14:30:45 +0100
Message-Id: <20180406133046.5682-3-berrange@redhat.com>
In-Reply-To: <20180406133046.5682-1-berrange@redhat.com>
References: <20180406133046.5682-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/3] docs: Document -object tls-creds-x509
 priority=xxx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Christophe Fergeau <cfergeau@redhat.com>

From: Christophe Fergeau <cfergeau@redhat.com>

This was added in 13f1243, but is missing from qemu-options.hx

Signed-off-by: Christophe Fergeau <cfergeau@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 qemu-options.hx | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 3ece30d216..ca4e412f2f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4112,7 +4112,7 @@ expensive operation that consumes random pool entro=
py, so it is
 recommended that a persistent set of parameters be generated
 upfront and saved.
=20
-@item -object tls-creds-x509,id=3D@var{id},endpoint=3D@var{endpoint},dir=
=3D@var{/path/to/cred/dir},verify-peer=3D@var{on|off},passwordid=3D@var{i=
d}
+@item -object tls-creds-x509,id=3D@var{id},endpoint=3D@var{endpoint},dir=
=3D@var{/path/to/cred/dir},priority=3D@var{priority},verify-peer=3D@var{o=
n|off},passwordid=3D@var{id}
=20
 Creates a TLS anonymous credentials object, which can be used to provide
 TLS support on network backends. The @option{id} parameter is a unique
@@ -4145,6 +4145,15 @@ version by providing the @var{passwordid} paramete=
r. This provides
 the ID of a previously created @code{secret} object containing the
 password for decryption.
=20
+The @var{priority} parameter allows to override the global default
+priority used by gnutls. This can be useful if the system administrator
+needs to use a weaker set of crypto priorities for QEMU without
+potentially forcing the weakness onto all applications. Or conversely
+if one wants wants a stronger default for QEMU than for all other
+applications, they can do this through this parameter. Its format is
+a gnutls priority string as described at
+@url{https://gnutls.org/manual/html_node/Priority-Strings.html}.
+
 @item -object filter-buffer,id=3D@var{id},netdev=3D@var{netdevid},interv=
al=3D@var{t}[,queue=3D@var{all|rx|tx}][,status=3D@var{on|off}]
=20
 Interval @var{t} can't be 0, this filter batches the packet delivery: al=
l
--=20
2.14.3

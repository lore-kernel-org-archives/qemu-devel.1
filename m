Received: from eggs.gnu.org ([2001:4830:134:3::10]:47269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cDwOG-0007VO-M0
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:45:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cDwOF-0006x0-He
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:45:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cDwOF-0006wR-9O
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:45:19 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6978E7F415
	for <qemu-devel@nongnu.org>; Mon,  5 Dec 2016 16:45:18 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  5 Dec 2016 17:45:10 +0100
Message-Id: <1480956313-31322-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1480956313-31322-1-git-send-email-armbru@redhat.com>
References: <1480956313-31322-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/9] qapi: fix missing symbol @prefix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20161117155504.21843-6-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi-schema.json     |  4 ++--
 qapi/block-core.json |  4 ++--
 qapi/crypto.json     | 36 ++++++++++++++++++------------------
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index af488a8..824d205 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4652,7 +4652,7 @@
 { 'include': 'qapi/rocker.json' }
=20
 ##
-# ReplayMode:
+# @ReplayMode:
 #
 # Mode of the replay subsystem.
 #
@@ -4720,7 +4720,7 @@
 { 'command': 'query-gic-capabilities', 'returns': ['GICCapability'] }
=20
 ##
-# CpuInstanceProperties
+# @CpuInstanceProperties
 #
 # List of properties to be used for hotplugging a CPU instance,
 # it should be passed by management with device_add command when
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 39cdaba..d98fe73 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1144,7 +1144,7 @@
   'data': 'DriveMirror' }
=20
 ##
-# DriveMirror
+# @DriveMirror
 #
 # A set of parameters describing drive mirror setup.
 #
@@ -1368,7 +1368,7 @@
   'data': 'BlockIOThrottle' }
=20
 ##
-# BlockIOThrottle
+# @BlockIOThrottle
 #
 # A set of parameters describing block throttling.
 #
diff --git a/qapi/crypto.json b/qapi/crypto.json
index 5c9d7d4..15d296e 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -3,7 +3,7 @@
 # QAPI crypto definitions
=20
 ##
-# QCryptoTLSCredsEndpoint:
+# @QCryptoTLSCredsEndpoint:
 #
 # The type of network endpoint that will be using the credentials.
 # Most types of credential require different setup / structures
@@ -22,7 +22,7 @@
=20
=20
 ##
-# QCryptoSecretFormat:
+# @QCryptoSecretFormat:
 #
 # The data format that the secret is provided in
 #
@@ -36,7 +36,7 @@
=20
=20
 ##
-# QCryptoHashAlgorithm:
+# @QCryptoHashAlgorithm:
 #
 # The supported algorithms for computing content digests
 #
@@ -55,7 +55,7 @@
=20
=20
 ##
-# QCryptoCipherAlgorithm:
+# @QCryptoCipherAlgorithm:
 #
 # The supported algorithms for content encryption ciphers
 #
@@ -82,7 +82,7 @@
=20
=20
 ##
-# QCryptoCipherMode:
+# @QCryptoCipherMode:
 #
 # The supported modes for content encryption ciphers
 #
@@ -98,7 +98,7 @@
=20
=20
 ##
-# QCryptoIVGenAlgorithm:
+# @QCryptoIVGenAlgorithm:
 #
 # The supported algorithms for generating initialization
 # vectors for full disk encryption. The 'plain' generator
@@ -116,7 +116,7 @@
   'data': ['plain', 'plain64', 'essiv']}
=20
 ##
-# QCryptoBlockFormat:
+# @QCryptoBlockFormat:
 #
 # The supported full disk encryption formats
 #
@@ -131,7 +131,7 @@
   'data': ['qcow', 'luks']}
=20
 ##
-# QCryptoBlockOptionsBase:
+# @QCryptoBlockOptionsBase:
 #
 # The common options that apply to all full disk
 # encryption formats
@@ -144,7 +144,7 @@
   'data': { 'format': 'QCryptoBlockFormat' }}
=20
 ##
-# QCryptoBlockOptionsQCow:
+# @QCryptoBlockOptionsQCow:
 #
 # The options that apply to QCow/QCow2 AES-CBC encryption format
 #
@@ -158,7 +158,7 @@
   'data': { '*key-secret': 'str' }}
=20
 ##
-# QCryptoBlockOptionsLUKS:
+# @QCryptoBlockOptionsLUKS:
 #
 # The options that apply to LUKS encryption format
 #
@@ -172,7 +172,7 @@
=20
=20
 ##
-# QCryptoBlockCreateOptionsLUKS:
+# @QCryptoBlockCreateOptionsLUKS:
 #
 # The options that apply to LUKS encryption format initialization
 #
@@ -202,7 +202,7 @@
=20
=20
 ##
-# QCryptoBlockOpenOptions:
+# @QCryptoBlockOpenOptions:
 #
 # The options that are available for all encryption formats
 # when opening an existing volume
@@ -217,7 +217,7 @@
=20
=20
 ##
-# QCryptoBlockCreateOptions:
+# @QCryptoBlockCreateOptions:
 #
 # The options that are available for all encryption formats
 # when initializing a new volume
@@ -232,7 +232,7 @@
=20
=20
 ##
-# QCryptoBlockInfoBase:
+# @QCryptoBlockInfoBase:
 #
 # The common information that applies to all full disk
 # encryption formats
@@ -246,7 +246,7 @@
=20
=20
 ##
-# QCryptoBlockInfoLUKSSlot:
+# @QCryptoBlockInfoLUKSSlot:
 #
 # Information about the LUKS block encryption key
 # slot options
@@ -266,7 +266,7 @@
=20
=20
 ##
-# QCryptoBlockInfoLUKS:
+# @QCryptoBlockInfoLUKS:
 #
 # Information about the LUKS block encryption options
 #
@@ -294,7 +294,7 @@
            'slots': [ 'QCryptoBlockInfoLUKSSlot' ] }}
=20
 ##
-# QCryptoBlockInfoQCow:
+# @QCryptoBlockInfoQCow:
 #
 # Information about the QCow block encryption options
 #
@@ -305,7 +305,7 @@
=20
=20
 ##
-# QCryptoBlockInfo:
+# @QCryptoBlockInfo:
 #
 # Information about the block encryption options
 #
--=20
2.5.5

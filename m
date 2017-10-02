Received: from eggs.gnu.org ([2001:4830:134:3::10]:40415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1JZ-0005jA-Hu
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:03:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1JP-0004jl-Og
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:03:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz1JP-0004j8-Jb
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:03:11 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 16:03:05 +0200
Message-Id: <20171002140307.5292-7-armbru@redhat.com>
In-Reply-To: <20171002140307.5292-1-armbru@redhat.com>
References: <20171002140307.5292-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 6/8] qemu-options: Polish section "TPM device
 options"
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
List-ID: <qemu-devel.nongnu.org>

Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qemu-options.hx | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 8568ee388c..615cb230ab 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2915,19 +2915,18 @@ The general form of a TPM device option is:
 
 @item -tpmdev @var{backend} ,id=@var{id} [,@var{options}]
 @findex -tpmdev
-Backend type must be:
-@option{passthrough}.
 
 The specific backend type will determine the applicable options.
 The @code{-tpmdev} option creates the TPM backend and requires a
 @code{-device} option that specifies the TPM frontend interface model.
 
-Options to each backend are described below.
+Use @code{-tpmdev help} to print all available TPM backend types.
 
-Use 'help' to print all available TPM backend types.
-@example
-qemu -tpmdev help
-@end example
+@end table
+
+The available backends are:
+
+@table @option
 
 @item -tpmdev passthrough, id=@var{id}, path=@var{path}, cancel-path=@var{cancel-path}
 
@@ -2966,10 +2965,11 @@ To create a passthrough TPM use the following two options:
 Note that the @code{-tpmdev} id is @code{tpm0} and is referenced by
 @code{tpmdev=tpm0} in the device option.
 
+ETEXI
+
+STEXI
 @end table
-
 ETEXI
-
 DEFHEADING()
 
 #endif
-- 
2.13.6

Received: from eggs.gnu.org ([209.51.188.92]:46002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3RQU-0004JH-MT
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3RQT-0006eg-UO
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:21:34 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:39556 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h3RQQ-0006PM-Gj
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:21:32 -0400
Date: Mon, 11 Mar 2019 20:21:30 +0000
From: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
Message-ID: <20190311202130.GF9@59ca1d9b7985>
References: <20190311201532.GA6@59ca1d9b7985>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311201532.GA6@59ca1d9b7985>
Subject: [Qemu-devel] [PATCH v5 6/9] qemu-binfmt-conf.sh: honour QEMU_PATH
 and/or QEMU_SUFFIX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, eblake@redhat.com

Allow to set 'path' or 'suffix' through environment variables,
consistently with 'persistent' and 'credential'.

Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 scripts/qemu-binfmt-conf.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 124866246f..5616ac60ce 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -177,7 +177,7 @@ Options and associated environment variables:
 Argument             Env-variable     Description
 -h|--help                             display this usage
 -Q|--path PATH       QEMU_PATH        set path to qemu interpreter(s)
--F|--suffix SUFFIX                    add a suffix to the default interpreter name
+-F|--suffix SUFFIX   QEMU_SUFFIX      add a suffix to the default interpreter name
 -p|--persistent      QEMU_PERSISTENT  (yes) load the interpreter and keep it in memory; all future
                                       uses are cloned from the open file.
 -c|--credential      QEMU_CREDENTIAL  (yes) credential and security tokens are calculated according
@@ -191,6 +191,7 @@ Argument             Env-variable     Description

 Defaults:
 QEMU_PATH=$QEMU_PATH
+QEMU_SUFFIX=$QEMU_SUFFIX
 QEMU_PERSISTENT=$QEMU_PERSISTENT
 QEMU_CREDENTIAL=$QEMU_CREDENTIAL

@@ -323,13 +324,11 @@ BINFMT_SET=qemu_register_interpreter
 SYSTEMDDIR="/etc/binfmt.d"
 DEBIANDIR="/usr/share/binfmts"

-QEMU_PATH=/usr/local/bin
-
+QEMU_PATH="${QEMU_PATH:-/usr/local/bin}"
+QEMU_SUFFIX="${QEMU_SUFFIX:-}"
 QEMU_PERSISTENT="${QEMU_PERSISTENT:-no}"
 QEMU_CREDENTIAL="${QEMU_CREDENTIAL:-no}"

-QEMU_SUFFIX=""
-
 options=$(getopt -o ds:Q:S:e:hcp -l debian,systemd:,path:,suffix:,exportdir:,help,credential,persistent -- "$@")
 eval set -- "$options"

--
2.21.0

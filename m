Received: from eggs.gnu.org ([209.51.188.92]:36508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3IBo-0007t1-9e
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:29:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3IBj-00012v-Ic
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:29:48 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:42193 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h3IBj-00012N-3m
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:29:43 -0400
Date: Mon, 11 Mar 2019 10:29:42 +0000
From: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
Message-ID: <20190311102942.GE16@765644dd90e5>
References: <20190311101428.GA11@765644dd90e5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311101428.GA11@765644dd90e5>
Subject: [Qemu-devel] [PATCH v4 6/10] qemu-binfmt-conf.sh: honour QEMU_PATH
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
---
 scripts/qemu-binfmt-conf.sh | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 0918f7fba6..13e619794c 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -177,7 +177,7 @@ Options and associated environment variables:
 Argument             Env-variable     Description
 -h|--help                             display this usage
 -Q|--path PATH:      QEMU_PATH        set path to qemu interpreter(s)
--F|--suffix SUFFIX:                   add a suffix to the default interpreter name
+-F|--suffix SUFFIX:  QEMU_SUFFIX      add a suffix to the default interpreter name
 -d|--debian:                          don't write into /proc, generate update-binfmts templates
 -s|--systemd CPU:                     don't write into /proc, generate file for
                                       systemd-binfmt.service for the given CPU; if CPU is "ALL",
@@ -318,13 +318,11 @@ BINFMT_SET=qemu_register_interpreter
 SYSTEMDDIR="/etc/binfmt.d"
 DEBIANDIR="/usr/share/binfmts"

-QEMU_PATH=/usr/local/bin
-
+QEMU_PATH="${QEMU_PATH:-/usr/local/bin}"
+QEMU_SUFFIX="${QEMU_SUFFIX:-}"
 QEMU_CREDENTIAL="${QEMU_CREDENTIAL:-no}"
 QEMU_PERSISTENT="${QEMU_PERSISTENT:-no}"

-QEMU_SUFFIX=""
-
 options=$(getopt -o ds:Q:S:e:hcp -l debian,systemd:,path:,suffix:,exportdir:,help,credential,persistent -- "$@")
 eval set -- "$options"

--
2.21.0

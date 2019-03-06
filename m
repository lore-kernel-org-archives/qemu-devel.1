Received: from eggs.gnu.org ([209.51.188.92]:36753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h1OV3-0000Fc-6x
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 23:49:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h1OV2-0003ya-IY
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 23:49:49 -0500
Received: from smtp.lg.ehu.es ([158.227.0.66]:58426 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h1OV2-0003y7-63
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 23:49:48 -0500
Date: Wed, 6 Mar 2019 04:49:47 +0000
From: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
Message-ID: <20190306044947.GE75@03612eec87fc>
References: <20190306031221.GA53@03612eec87fc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306031221.GA53@03612eec87fc>
Subject: [Qemu-devel] [PATCH v3 5/10] qemu-binfmt-conf.sh: honour QEMU_PATH
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
 scripts/qemu-binfmt-conf.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 68aa4c3f78..c113ff131e 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -176,6 +176,7 @@ Usage: qemu-binfmt-conf.sh [--path PATH][--debian][--systemd CPU]
        --help:        display this usage
        --path:        set path to qemu interpreter ($QEMU_PATH)
        --suffix:      add a suffix to the default interpreter name
+                      ($QEMU_SUFFIX)
        --debian:      don't write into /proc,
                       instead generate update-binfmts templates
        --systemd:     don't write into /proc,
@@ -321,13 +322,11 @@ BINFMT_SET=qemu_register_interpreter
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
2.20.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:47694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK80-0006xF-Tw
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK7w-00035v-So
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cFK7w-00035T-Ka
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:12 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  9 Dec 2016 13:17:32 +0100
Message-Id: <1481285870-3396-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1481285870-3396-1-git-send-email-thuth@redhat.com>
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 02/20] tilegx: Move CPU files to target/ folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Jia Liu <proljc@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Eduardo Habkost <ehabkost@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, James Hogan <james.hogan@imgtec.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 {target-tilegx => target/tilegx}/Makefile.objs   | 0
 {target-tilegx => target/tilegx}/cpu.c           | 0
 {target-tilegx => target/tilegx}/cpu.h           | 0
 {target-tilegx => target/tilegx}/helper.c        | 0
 {target-tilegx => target/tilegx}/helper.h        | 0
 {target-tilegx => target/tilegx}/opcode_tilegx.h | 0
 {target-tilegx => target/tilegx}/simd_helper.c   | 0
 {target-tilegx => target/tilegx}/spr_def_64.h    | 0
 {target-tilegx => target/tilegx}/translate.c     | 0
 9 files changed, 0 insertions(+), 0 deletions(-)
 rename {target-tilegx => target/tilegx}/Makefile.objs (100%)
 rename {target-tilegx => target/tilegx}/cpu.c (100%)
 rename {target-tilegx => target/tilegx}/cpu.h (100%)
 rename {target-tilegx => target/tilegx}/helper.c (100%)
 rename {target-tilegx => target/tilegx}/helper.h (100%)
 rename {target-tilegx => target/tilegx}/opcode_tilegx.h (100%)
 rename {target-tilegx => target/tilegx}/simd_helper.c (100%)
 rename {target-tilegx => target/tilegx}/spr_def_64.h (100%)
 rename {target-tilegx => target/tilegx}/translate.c (100%)

diff --git a/target-tilegx/Makefile.objs b/target/tilegx/Makefile.objs
similarity index 100%
rename from target-tilegx/Makefile.objs
rename to target/tilegx/Makefile.objs
diff --git a/target-tilegx/cpu.c b/target/tilegx/cpu.c
similarity index 100%
rename from target-tilegx/cpu.c
rename to target/tilegx/cpu.c
diff --git a/target-tilegx/cpu.h b/target/tilegx/cpu.h
similarity index 100%
rename from target-tilegx/cpu.h
rename to target/tilegx/cpu.h
diff --git a/target-tilegx/helper.c b/target/tilegx/helper.c
similarity index 100%
rename from target-tilegx/helper.c
rename to target/tilegx/helper.c
diff --git a/target-tilegx/helper.h b/target/tilegx/helper.h
similarity index 100%
rename from target-tilegx/helper.h
rename to target/tilegx/helper.h
diff --git a/target-tilegx/opcode_tilegx.h b/target/tilegx/opcode_tilegx.h
similarity index 100%
rename from target-tilegx/opcode_tilegx.h
rename to target/tilegx/opcode_tilegx.h
diff --git a/target-tilegx/simd_helper.c b/target/tilegx/simd_helper.c
similarity index 100%
rename from target-tilegx/simd_helper.c
rename to target/tilegx/simd_helper.c
diff --git a/target-tilegx/spr_def_64.h b/target/tilegx/spr_def_64.h
similarity index 100%
rename from target-tilegx/spr_def_64.h
rename to target/tilegx/spr_def_64.h
diff --git a/target-tilegx/translate.c b/target/tilegx/translate.c
similarity index 100%
rename from target-tilegx/translate.c
rename to target/tilegx/translate.c
-- 
1.8.3.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:40739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1cqGEw-0002qK-PR
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 05:38:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1cqGEt-0005Ym-Eb
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 05:38:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:44627)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <schwab@suse.de>) id 1cqGEt-0005Y4-86
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 05:38:03 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 3005FAC3B
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 09:38:02 +0000 (UTC)
From: Andreas Schwab <schwab@suse.de>
Date: Tue, 21 Mar 2017 10:38:01 +0100
Message-ID: <mvminn3t1fq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] qemu-binfmt-conf.sh: Fix m68k_mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The m68k mask should not remove the low bit of the ELF version field and
should ignore the OS/ABI field.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 scripts/qemu-binfmt-conf.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 0f1aa63872..484bcf166e 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -47,7 +47,7 @@ ppc64le_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\x
 ppc64le_family=ppcle
 
 m68k_magic='\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x04'
-m68k_mask='\xff\xff\xff\xff\xff\xff\xfe\xfe\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
+m68k_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
 m68k_family=m68k
 
 # FIXME: We could use the other endianness on a MIPS host.
-- 
2.12.0


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

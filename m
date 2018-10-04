Received: from eggs.gnu.org ([2001:4830:134:3::10]:46400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g86LU-0005kK-A9
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:19:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g86LK-0002Yq-OG
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:19:19 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Thu,  4 Oct 2018 12:18:49 -0400
Message-Id: <20181004161852.11673-8-crosa@redhat.com>
In-Reply-To: <20181004161852.11673-1-crosa@redhat.com>
References: <20181004161852.11673-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 07/10] scripts/decodetree.py: remove unused
 imports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Cleber Rosa <crosa@redhat.com>, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 scripts/decodetree.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 277f9a9bba..457cffea90 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -149,12 +149,10 @@
 #   trans_addl_i(ctx, &arg_opi, insn)
 #
 
-import io
 import os
 import re
 import sys
 import getopt
-import pdb
 
 insnwidth = 32
 insnmask = 0xffffffff
-- 
2.17.1

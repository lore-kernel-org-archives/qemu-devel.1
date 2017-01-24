Received: from eggs.gnu.org ([2001:4830:134:3::10]:37500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cW2AX-0004ZA-Cp
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:34:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cW2AW-0005Lm-NK
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:33:57 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:36263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cW2AW-0005La-HB
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:33:56 -0500
Received: by mail-wm0-x22b.google.com with SMTP id c85so184601294wmi.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 06:33:56 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Jan 2017 14:33:46 +0000
Message-Id: <20170124143346.22240-8-alex.bennee@linaro.org>
In-Reply-To: <20170124143346.22240-1-alex.bennee@linaro.org>
References: <20170124143346.22240-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 7/7] qemu-options: remove stray space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 80df52651a..55c68cecbb 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1705,7 +1705,7 @@ DEF("net", HAS_ARG, QEMU_OPTION_net,
     "                old way to initialize a host network interface\n"
     "                (use the -netdev option if possible instead)\n", QEMU_ARCH_ALL)
 STEXI
-@item -net nic[,vlan=@var{n}][,macaddr=@var{mac}][,model=@var{type}] [,name=@var{name}][,addr=@var{addr}][,vectors=@var{v}]
+@item -net nic[,vlan=@var{n}][,macaddr=@var{mac}][,model=@var{type}][,name=@var{name}][,addr=@var{addr}][,vectors=@var{v}]
 @findex -net
 Create a new Network Interface Card and connect it to VLAN @var{n} (@var{n}
 = 0 is the default). The NIC is an e1000 by default on the PC
-- 
2.11.0

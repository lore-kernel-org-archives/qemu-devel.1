Received: from eggs.gnu.org ([2001:4830:134:3::10]:43071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jonemilj@gmail.com>) id 1eg0t3-00070Y-Jd
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 23:17:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jonemilj@gmail.com>) id 1eg0t2-0005Gm-PI
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 23:17:41 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:35996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jonemilj@gmail.com>) id 1eg0t2-0005G9-He
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 23:17:40 -0500
Received: by mail-lf0-x244.google.com with SMTP id t79so7932923lfe.3
	for <qemu-devel@nongnu.org>; Sun, 28 Jan 2018 20:17:40 -0800 (PST)
From: Jon Emil Jahren <jonemilj@gmail.com>
Date: Mon, 29 Jan 2018 05:16:48 +0100
Message-Id: <20180129041648.30884-3-jonemilj@gmail.com>
In-Reply-To: <20180129041648.30884-1-jonemilj@gmail.com>
References: <20180129041648.30884-1-jonemilj@gmail.com>
Subject: [Qemu-devel] [PATCH 2/2] tracetool: For ust trace bool type as
 ctf_integer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Jon Emil Jahren <jonemilj@gmail.com>

Previously functions having arguments of type bool was not traced
properly. The bool arguments were missing from the trace.

Signed-off-by: Jon Emil Jahren <jonemilj@gmail.com>
---
 scripts/tracetool/format/ust_events_h.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/tracetool/format/ust_events_h.py b/scripts/tracetool/format/ust_events_h.py
index 514294c2cc..4e95e9b3f9 100644
--- a/scripts/tracetool/format/ust_events_h.py
+++ b/scripts/tracetool/format/ust_events_h.py
@@ -79,7 +79,8 @@ def generate(events, backend, group):
                     out('       ctf_integer_hex('+ t + ', ' + n + ', ' + n + ')')
                 elif ("ptr" in t) or ("*" in t):
                     out('       ctf_integer_hex('+ t + ', ' + n + ', ' + n + ')')
-                elif ('int' in t) or ('long' in t) or ('unsigned' in t) or ('size_t' in t):
+                elif ('int' in t) or ('long' in t) or ('unsigned' in t) \
+                        or ('size_t' in t) or ('bool' in t):
                     out('       ctf_integer(' + t + ', ' + n + ', ' + n + ')')
                 elif ('double' in t) or ('float' in t):
                     out('       ctf_float(' + t + ', ' + n + ', ' + n + ')')
-- 
2.14.3

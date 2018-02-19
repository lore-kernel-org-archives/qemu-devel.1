Received: from eggs.gnu.org ([2001:4830:134:3::10]:39364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1enoAm-0004W0-35
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:20:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1enoAi-0002uX-PY
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:20:12 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46458 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1enoAi-0002tf-ME
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:20:08 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 19 Feb 2018 16:19:54 +0000
Message-Id: <20180219161955.29572-3-stefanha@redhat.com>
In-Reply-To: <20180219161955.29572-1-stefanha@redhat.com>
References: <20180219161955.29572-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] tracetool: For ust trace bool type as
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jon Emil Jahren <jonemilj@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Jon Emil Jahren <jonemilj@gmail.com>

Previously functions having arguments of type bool was not traced
properly. The bool arguments were missing from the trace.

Signed-off-by: Jon Emil Jahren <jonemilj@gmail.com>
Message-id: 20180129041648.30884-3-jonemilj@gmail.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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

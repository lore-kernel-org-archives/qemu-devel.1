Received: from eggs.gnu.org ([2001:4830:134:3::10]:37432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1diP9R-000430-VM
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:04:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1diP9N-0005Gt-I2
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:04:13 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:33099)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1diP9N-0005F9-Aq
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:04:09 -0400
Received: by mail-wr0-x22f.google.com with SMTP id b65so50611301wrd.0
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 11:04:07 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 17 Aug 2017 19:03:56 +0100
Message-Id: <20170817180404.29334-2-alex.bennee@linaro.org>
In-Reply-To: <20170817180404.29334-1-alex.bennee@linaro.org>
References: <20170817180404.29334-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 1/9] tcg/README: listify the TCG types.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rth@twiddle.net, cota@braap.org, batuzovk@ispras.ru
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Although the other types are aliases lets make it clear what TCG types
are available.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tcg/README | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tcg/README b/tcg/README
index 03bfb6acd4..f116b7b694 100644
--- a/tcg/README
+++ b/tcg/README
@@ -53,9 +53,12 @@ an "undefined result".
 
 TCG instructions operate on variables which are temporaries, local
 temporaries or globals. TCG instructions and variables are strongly
-typed. Two types are supported: 32 bit integers and 64 bit
-integers. Pointers are defined as an alias to 32 bit or 64 bit
-integers depending on the TCG target word size.
+typed. A number of types are supported:
+
+  TCGv_i32 - 32 bit integer
+  TCGv_i64 - 64 bit integer
+  TCGv     - target pointer (aliased to 32 or 64 bit integer)
+  TCGv_ptr - host pointer (used for direct access to host structures)
 
 Each instruction has a fixed number of output variable operands, input
 variable operands and always constant operands.
-- 
2.13.0

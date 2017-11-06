Received: from eggs.gnu.org ([2001:4830:134:3::10]:60741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1eBViz-0003KQ-QC
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 19:57:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1eBViw-0000m7-Or
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 19:57:13 -0500
Received: from speedy.comstyle.com ([206.51.28.2]:29235 helo=mail.comstyle.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brad@comstyle.com>) id 1eBViw-0000lz-KI
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 19:57:10 -0500
Received: from mail.comstyle.com (localhost [127.0.0.1])
	by mail.comstyle.com (Postfix) with ESMTP id 4A38E9843A
	for <qemu-devel@nongnu.org>; Sun,  5 Nov 2017 19:57:10 -0500 (EST)
Received: from humpty.home.comstyle.com (unknown
	[IPv6:2607:fea8:12c0:f00:3c40:9470:82cf:3fa8])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested) (Authenticated sender: brad)
	by mail.comstyle.com (Postfix) with ESMTPSA id 1D70C98439
	for <qemu-devel@nongnu.org>; Sun,  5 Nov 2017 19:57:10 -0500 (EST)
Date: Sun, 5 Nov 2017 19:56:58 -0500
From: Brad Smith <brad@comstyle.com>
Message-ID: <20171106005656.GC84093@humpty.home.comstyle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] osdep: Deal with TIME_MAX and OpenBSD 64-bit
 time_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Define TIME_MAX to LLONG_MAX for OpenBSD since OpenBSD uses 64-bit time_t.

Signed-off-by: Brad Smith <brad@comstyle.com>


diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 6855b94bbf..824714049b 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -132,8 +132,12 @@ extern int daemon(int, int);
 #define ESHUTDOWN 4099
 #endif
 #ifndef TIME_MAX
+#ifdef __OpenBSD__
+#define TIME_MAX LLONG_MAX
+#else
 #define TIME_MAX LONG_MAX
 #endif
+#endif
 
 /* HOST_LONG_BITS is the size of a native pointer in bits. */
 #if UINTPTR_MAX == UINT32_MAX

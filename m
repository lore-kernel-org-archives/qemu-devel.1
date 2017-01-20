Received: from eggs.gnu.org ([2001:4830:134:3::10]:39508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cUPYW-0000Qu-8z
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 22:08:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cUPYV-0002oN-6y
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 22:08:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cUPYV-0002o6-0p
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 22:07:59 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Jan 2017 11:07:45 +0800
Message-Id: <1484881670-24237-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1484881670-24237-1-git-send-email-jasowang@redhat.com>
References: <1484881670-24237-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 1/6] docs: Fix description of the sentence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Eric Blake <eblake@redhat.com>, Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>

From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

Say it in another way to make it easier to understand.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 docs/colo-proxy.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/docs/colo-proxy.txt b/docs/colo-proxy.txt
index 76767cb..c4941de 100644
--- a/docs/colo-proxy.txt
+++ b/docs/colo-proxy.txt
@@ -158,7 +158,9 @@ secondary.
 
 == Usage ==
 
-Here, we use demo ip and port discribe more clearly.
+Here is an example using demonstration IP and port addresses to more
+clearly describe the usage.
+
 Primary(ip:3.3.3.3):
 -netdev tap,id=hn0,vhost=off,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown
 -device e1000,id=e0,netdev=hn0,mac=52:a4:00:12:78:66
-- 
2.7.4

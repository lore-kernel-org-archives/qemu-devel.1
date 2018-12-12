Received: from eggs.gnu.org ([2001:4830:134:3::10]:52525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6Mh-0000zT-5K
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6Mc-0000MK-4t
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:58 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:53232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6Mb-0000KF-Q0
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:53 -0500
Received: by mail-wm1-x32c.google.com with SMTP id m1so5558572wml.2
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:53 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	u10sm15878859wrr.33.2018.12.12.07.23.51 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 12 Dec 2018 07:23:51 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:53 +0100
Message-Id: <1544628195-37728-33-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 32/54] checkpatch: warn about qemu/queue.h head
 structs that are not typedef-ed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

These are just like any other struct or union, so they should have
CamelCase typedefs.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a8d6e44..b4b3495 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2263,6 +2263,11 @@ sub process {
 			}
 		}
 
+		if ($line =~ /^.\s*(Q(?:S?LIST|SIMPLEQ|TAILQ)_HEAD)\s*\(\s*[^,]/ &&
+		    $line !~ /^.typedef/) {
+		    ERROR("named $1 should be typedefed separately\n" . $herecurr);
+		}
+
 # Need a space before open parenthesis after if, while etc
 		if ($line=~/\b(if|while|for|switch)\(/) {
 			ERROR("space required before the open parenthesis '('\n" . $herecurr);
-- 
1.8.3.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:38015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dzlqY-0004Et-V8
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:44:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dzlqT-0006DC-W6
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:44:30 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:13477 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dzlqT-0006B3-Jj
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:44:25 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed,  4 Oct 2017 18:44:20 +0300
Message-Id: <20171004154420.34596-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] checkpatch: fix incompatibility with old perl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, stefanha@redhat.com, alex.williamson@redhat.com, berrange@redhat.com

Do not use '/r' modifier which was introduced in perl 5.14.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3c0a28e644..0c41f1212f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1432,7 +1432,8 @@ sub process {
 					qr/%[-+ *.0-9]*([hljztL]|ll|hh)?(x|X|"\s*PRI[xX][^"]*"?)/;
 
 				# don't consider groups splitted by [.:/ ], like 2A.20:12ab
-				my $tmpline = $rawline =~ s/($hex[.:\/ ])+$hex//gr;
+				my $tmpline = $rawline;
+				$tmpline =~ s/($hex[.:\/ ])+$hex//g;
 
 				if ($tmpline =~ /(?<!0x)$hex/) {
 					ERROR("Hex numbers must be prefixed with '0x'\n" .
-- 
2.11.1

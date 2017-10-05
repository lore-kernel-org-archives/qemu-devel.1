Received: from eggs.gnu.org ([2001:4830:134:3::10]:37208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e076B-0003ed-1p
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:26:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e076A-0005Ho-5y
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:26:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1e076A-0005Ft-0L
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:26:02 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu,  5 Oct 2017 10:25:47 -0400
Message-Id: <20171005142547.1363-2-stefanha@redhat.com>
In-Reply-To: <20171005142547.1363-1-stefanha@redhat.com>
References: <20171005142547.1363-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] checkpatch: fix incompatibility with old
 perl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Do not use '/r' modifier which was introduced in perl 5.14.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Fixes: 3e5875afc0f ("checkpatch: check trace-events code style")
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Message-id: 20171004154420.34596-1-vsementsov@virtuozzo.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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
2.13.6

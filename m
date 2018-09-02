Received: from eggs.gnu.org ([2001:4830:134:3::10]:32770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1fwSoN-0006iC-3a
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 09:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1fwSU4-0005GL-Fv
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 09:32:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43206 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ybettan@redhat.com>) id 1fwSU3-0005EL-8h
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 09:32:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 93EA74021702
	for <qemu-devel@nongnu.org>; Sun,  2 Sep 2018 12:36:20 +0000 (UTC)
From: Yoni Bettan <ybettan@redhat.com>
Date: Sun,  2 Sep 2018 15:36:04 +0300
Message-Id: <20180902123608.124586-1-ybettan@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] Reformatted INFO files to fit the Markdown
 (.md) format.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, Yoni Bettan <ybettan@redhat.com>

This patch make INFO files (e.g. README, CODING_STYLE etc) much more
readable when watched from GitHub GUI.

./VERSION and ./MAINTAINERS were leave untouched otherwise
./scripts/get_maintainer.pl breaks.

./COPYING and ./COPYING.LIB were leave untouched because it look likes
they come from GNU and not QEMU. 

Visualization of the change can be found at
https://github.com/ybettan/qemu/tree/md.
NOTE:
This last part of the message should be removed from the commit message
since I will remove the 'md' brance from my fork if the patch is
accepted.

Yoni Bettan (4):
  README.md : Reformatted to fit the Markdown (.md) format.
  CODING_STYLE.md : Reformatted to fit the Markdown (.md) format.
  HACKING.md : Reformatted to fit the Markdown (.md) format.
  LICENSE.md : Reformatted to fit the Markdown (.md) format.

 CODING_STYLE => CODING_STYLE.md | 151 ++++++++++++++------------
 HACKING => HACKING.md           | 186 +++++++++++++++++---------------
 LICENSE => LICENSE.md           |   4 +-
 README => README.md             |  87 +++++++--------
 4 files changed, 224 insertions(+), 204 deletions(-)
 rename CODING_STYLE => CODING_STYLE.md (50%)
 rename HACKING => HACKING.md (53%)
 rename LICENSE => LICENSE.md (90%)
 rename README => README.md (68%)

-- 
2.17.1

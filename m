Received: from eggs.gnu.org ([2001:4830:134:3::10]:41173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1fwWZs-0005ph-RZ
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 13:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1fwWZm-0002gL-2d
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 13:54:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34414 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ybettan@redhat.com>) id 1fwWZj-0002cT-4P
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 13:54:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F0D88011309
	for <qemu-devel@nongnu.org>; Sun,  2 Sep 2018 17:54:12 +0000 (UTC)
From: Yoni Bettan <ybettan@redhat.com>
Date: Sun,  2 Sep 2018 20:53:58 +0300
Message-Id: <20180902175401.8195-1-ybettan@redhat.com>
Subject: [Qemu-devel] [PATCH V2 0/3] Formatted INFO files to fit Markdown
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
Cc: ehabkost@redhat.com, stefanha@redhat.com, Yoni Bettan <ybettan@redhat.com>

This patch make INFO files (e.g. README, CODING_STYLE and HACKING) much more
readable when watched from GitHub GUI.

./VERSION, ./MAINTAINERS were leave untouched otherwise
./scripts/get_maintainer.pl breaks.

./COPYING, ./LICENSE ./COPYING.LIB were leave untouched because it look likes
they come from GNU and not QEMU. 

Visualization of the change can be found at
https://github.com/ybettan/qemu/tree/md.
NOTE:
This last part of the message should be removed from the commit message
since I will remove the 'md' branch from my fork if the patch is
accepted.

Yoni Bettan (3):
  README.md : Formatted to fit Markdown (.md) format.
  CODING_STYLE.md : Formatted to fit Markdown (.md) format.
  HACKING.md : Formatted to fit Markdown (.md) format.

 CODING_STYLE => CODING_STYLE.md | 151 ++++++++++++++------------
 HACKING => HACKING.md           | 186 +++++++++++++++++---------------
 README => README.md             |  89 +++++++--------
 scripts/checkpatch.pl           |   2 +-
 4 files changed, 223 insertions(+), 205 deletions(-)
 rename CODING_STYLE => CODING_STYLE.md (50%)
 rename HACKING => HACKING.md (53%)
 rename README => README.md (67%)

V2:
- Undone the changes on ./LICENSE
- Updated scripts/get_maintainer.pl to reference to README.md instead of README
- Repaired broken link to ./LICENSE in ./README.md

-- 
2.17.1

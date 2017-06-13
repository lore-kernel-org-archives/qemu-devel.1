Received: from eggs.gnu.org ([2001:4830:134:3::10]:40657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1dKlM9-0005E6-PM
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 08:55:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1dKlM6-0002uN-4O
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 08:55:37 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vadim.galitsyn@profitbricks.com>)
	id 1dKlM5-0002sM-SG
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 08:55:34 -0400
Received: by mail-wr0-x22c.google.com with SMTP id g76so135461458wrd.1
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 05:55:31 -0700 (PDT)
From: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Date: Tue, 13 Jun 2017 14:55:14 +0200
Message-Id: <20170613125515.30416-1-vadim.galitsyn@profitbricks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] hmp,
 qmp: introduce "info memory" and "query-memory" commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org


Hello,
 
Some time ago we came up with the idea to provide the following patch. The story started in https://lists.gnu.org/archive/html/qemu-devel/2012-07/msg01472.html.
 
For our production environment, we need QEMU to report the amount of guest memory, taking into account hot-plugged memory.
 
Currently QEMU does not have a command to report this information.
 
Included patch introduces "info memory" (HMP) and “query-memory” (QMP) commands, which return, as separate values, the amount of statically allocated, hot-plugged, and "actual" (ballooned) memory.
 
Could you please consider if this functionality can be included into mainline QEMU?
 
Thank you,
Vadim

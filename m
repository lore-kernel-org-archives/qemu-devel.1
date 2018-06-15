Received: from eggs.gnu.org ([2001:4830:134:3::10]:49746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tamiko@kyomu.43-1.org>) id 1fTwo2-0001LX-0j
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 18:02:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tamiko@kyomu.43-1.org>) id 1fTwo1-00088H-9Q
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 18:02:54 -0400
Received: from tsukuyomi.43-1.org ([2a01:4f8:173:743::1:50]:56236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tamiko@kyomu.43-1.org>)
	id 1fTwo1-00086a-3A
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 18:02:53 -0400
From: Matthias Maier <tamiko@43-1.org>
Date: Fri, 15 Jun 2018 17:02:03 -0500
Message-Id: <20180615220205.6929-1-tamiko@43-1.org>
Subject: [Qemu-devel] [PATCH v3 0/2] Fix compilation with python-3 if
 en_US.UTF-8 is unavailable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Arfrever Frehtes Taifersar Arahesis <arfrever.fta@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Hi,

this is hopefully the final iteration of the patches.

v3:
 - reverse order of patches
 - rename second patch to "Revert commit ..."
 - drop "UTF-8" argument in decode()/encode(); bot functions default to
   utf-8 already.

v2:
 - ensure compatibility with python2 by only calling encode()/decode() if
   script is run with a python3 interpreter

Best,
Matthias

Received: from eggs.gnu.org ([209.51.188.92]:35674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bipin.tomar@yahoo.com>) id 1gugzr-0008Vo-Hx
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:09:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bipin.tomar@yahoo.com>) id 1gugzq-0001Po-G0
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:09:55 -0500
Received: from sonic315-20.consmr.mail.ne1.yahoo.com ([66.163.190.146]:43941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bipin.tomar@yahoo.com>)
	id 1gugzq-0001IY-AA
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:09:54 -0500
Date: Fri, 15 Feb 2019 17:09:31 +0000 (UTC)
From: "bipin.tomar@yahoo.com" <bipin.tomar@yahoo.com>
Message-ID: <729515484.1572396.1550250571940@mail.yahoo.com>
MIME-Version: 1.0
References: <729515484.1572396.1550250571940.ref@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Why only devdax guarantees guest data persistence ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Text from "docs/nvdimm.txt" says:
Guest Data Persistence
----------------------

Though QEMU supports multiple types of vNVDIMM backends on Linux,
currently the only one that can guarantee the guest write persistence
is the device DAX on the real NVDIMM device (e.g., /dev/dax0.0), to
which all guest access do not involve any host-side kernel cache.

I think here "host-side kernel cache" imply "page cache". Why does fsdax NOT have the same persistence guarantees as devdax for vNVDIMM?
Both the modes avoid using page cache then why is devdax explicitly called out?
-BT

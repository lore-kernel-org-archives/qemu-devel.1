Received: from eggs.gnu.org ([2001:4830:134:3::10]:43119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chao.p.peng@linux.intel.com>) id 1dSeGE-0007di-0x
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 02:58:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chao.p.peng@linux.intel.com>) id 1dSeGA-0000vu-VJ
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 02:58:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:33248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chao.p.peng@linux.intel.com>)
	id 1dSeGA-0000vE-Mb
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 02:58:02 -0400
Message-ID: <1499237876.3041.4.camel@linux.intel.com>
From: Chao Peng <chao.p.peng@linux.intel.com>
Date: Wed, 05 Jul 2017 14:57:56 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] change x86 default machine type to Q35?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Tian, Kevin" <kevin.tian@intel.com>

Hi,
 
Q35 has been in QEMU for quite a while. Compared to the current default
i440FX, Q35 is probably not that mature and not widely used, however in
some case, Q35 has advantages, for example, in supporting new features.
For instance, we have some features require PCI-e support which is only
available on Q35 and some others need it for EFI support. It is of
course not necessary to change it as the default but if more and more
features have dependencies on Q35 because of requiring much more modern
features then I think it may be worth to do so. In such case we can have
more people to use it and find problems we may know or not know. There
are certainly some drawbacks:
-        Compatibility: current code or script may need adjustment
-        Quality: we may suffer more bugs on Q35
 
Any thoughts?
 
Chao

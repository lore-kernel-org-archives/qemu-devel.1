Received: from eggs.gnu.org ([2001:4830:134:3::10]:52122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhen.you@intel.com>) id 1fQ3I3-0005CM-PN
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 00:09:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhen.you@intel.com>) id 1fQ3I0-0000Gw-J6
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 00:09:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:38390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lizhen.you@intel.com>)
	id 1fQ3I0-0000DI-A0
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 00:09:44 -0400
From: "You, Lizhen" <lizhen.you@intel.com>
Date: Tue, 5 Jun 2018 04:09:38 +0000
Message-ID: <AD4B58344A9BCE45A17661C5F05E0D893925DE13@shsmsx102.ccr.corp.intel.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] The side effect of changing Processor Brand string?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "You, Lizhen" <lizhen.you@intel.com>

Hi All,

I'd like to change the Processor Brand String(CPUID[0x80000002|0x80000003|0=
x80000004]) of my guest OSS cpu model  to a string that won't be standard I=
ntel or AMD related processor brand string.  Would this change have any sid=
e effect on the applications that run on this guest?  Seems some applicatio=
n would check the Processor Brand String for choosing different code path, =
for eg Oracle database?

Thanks,
Lizhen

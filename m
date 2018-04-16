Received: from eggs.gnu.org ([2001:4830:134:3::10]:46815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arindam.roy@intel.com>) id 1f8Dop-0001g0-Uc
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 19:45:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arindam.roy@intel.com>) id 1f8Dom-00056r-Ph
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 19:45:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:55266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arindam.roy@intel.com>)
	id 1f8Dom-0004uy-EP
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 19:45:52 -0400
From: "Roy, Arindam" <arindam.roy@intel.com>
Date: Mon, 16 Apr 2018 23:45:46 +0000
Message-ID: <1A666A0023410949B8E9FD19D950912233E365F4@ORSMSX106.amr.corp.intel.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Consult] nfs-vsocks support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi Jing,
Busybox is a standalone statically linked bash env.
You can download the source from here:
https://busybox.net/downloads/

Or you can just download and copy it to your /usr/sbin :
https://busybox.net/downloads/binaries/

The script is creating a runtime filesystem for your guest.
Its linking all the standard shell commands to busybox, so in the guest run=
time those are executed by busybox.

Arindam

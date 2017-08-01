Received: from eggs.gnu.org ([2001:4830:134:3::10]:51683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@intel.com>) id 1dcROd-0001Po-4o
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 03:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@intel.com>) id 1dcROZ-0002xx-5M
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 03:15:15 -0400
From: "Hu, Robert" <robert.hu@intel.com>
Date: Tue, 1 Aug 2017 07:15:01 +0000
Message-ID: <9E79D1C9A97CFD4097BCE431828FDD311571D704@SHSMSX103.ccr.corp.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] Does qemu guest agent support 'guest-exec'?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>

Hi,

qemu/scripts/qmp/qemu-ga-client seems only support "cat, fsfreeze, fstrim, =
halt, ifconfig, info, ping, powerdown, reboot, shutdown, suspend".

But from qemu/qga/commands.c seems at least Linux guest should already supp=
ort this. Despite qemu-ga-client, how can I talk to guest-agent in guest to=
 execute some program? any other utils?

Best Regards,
Robert Hoo

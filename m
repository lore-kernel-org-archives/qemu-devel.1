Received: from eggs.gnu.org ([2001:4830:134:3::10]:43380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Alin.Rauta@enea.com>) id 1e87FR-0000Rd-D9
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:12:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Alin.Rauta@enea.com>) id 1e87FM-00045p-GK
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:12:41 -0400
Received: from mail-ve1eur01on0107.outbound.protection.outlook.com
	([104.47.1.107]:14884
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Alin.Rauta@enea.com>) id 1e87FL-0003QC-Sj
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:12:36 -0400
From: Alin Rauta <Alin.Rauta@enea.com>
Date: Fri, 27 Oct 2017 16:12:22 +0000
Message-ID: <DB5PR07MB13827040DB6EAD8EAD49BEE8ED5A0@DB5PR07MB1382.eurprd07.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel]  virtio multiqueue RX frame classification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi,
I have a question regarding receive pkts classification in QEMU.
The virtIO spec states that the receive flow classification is implicit whe=
n enabling multiqueue support, but are there any ways to control the actual=
 RX classification from inside the guest system or know how it is done?  As=
 example, let's say the guest system wants to get the pkts with a specific =
ethernet type or UDP port on a virtIO queue or set of queues.
Thanks,
Alin

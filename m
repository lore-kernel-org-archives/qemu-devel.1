Received: from eggs.gnu.org ([2001:4830:134:3::10]:45644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yvugenfi@redhat.com>) id 1e8kYk-0005UW-VB
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 06:11:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yvugenfi@redhat.com>) id 1e8kYh-0006dO-Qc
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 06:11:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yvugenfi@redhat.com>) id 1e8kYh-0006cl-KK
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 06:11:11 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Yan Vugenfirer <yvugenfi@redhat.com>
In-Reply-To: <DB5PR07MB13827040DB6EAD8EAD49BEE8ED5A0@DB5PR07MB1382.eurprd07.prod.outlook.com>
Date: Sun, 29 Oct 2017 12:11:00 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <18D8AA4C-A9CD-4C1F-814B-7EFA70244437@redhat.com>
References: <DB5PR07MB13827040DB6EAD8EAD49BEE8ED5A0@DB5PR07MB1382.eurprd07.prod.outlook.com>
Subject: Re: [Qemu-devel] virtio multiqueue RX frame classification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alin Rauta <Alin.Rauta@enea.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi Alin,

Unfortunately it is not possible today. It would be very helpful for =
optimising RSS on Windows guest as well.

Best regards,
Yan.


> On 27 Oct 2017, at 19:12, Alin Rauta <Alin.Rauta@enea.com> wrote:
>=20
> Hi,
> I have a question regarding receive pkts classification in QEMU.
> The virtIO spec states that the receive flow classification is =
implicit when enabling multiqueue support, but are there any ways to =
control the actual RX classification from inside the guest system or =
know how it is done?  As example, let's say the guest system wants to =
get the pkts with a specific ethernet type or UDP port on a virtIO queue =
or set of queues.
> Thanks,
> Alin

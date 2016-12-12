Received: from eggs.gnu.org ([2001:4830:134:3::10]:56829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cGH79-0001GW-Jm
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:17:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cGH76-0005Uy-Ft
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:17:19 -0500
Received: from [45.249.212.188] (port=2431 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cGH75-0005Tk-Q8
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:17:16 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Mon, 12 Dec 2016 03:16:46 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA159EBE@DGGEMA505-MBX.china.huawei.com>
References: <1480908432-82844-1-git-send-email-arei.gonglei@huawei.com>
	<20161211053749-mutt-send-email-mst@kernel.org>
In-Reply-To: <20161211053749-mutt-send-email-mst@kernel.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH for-2.9 0/3] cryptodev: prepare works for
 hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Wubin (H)" <wu.wubin@huawei.com>, longpeng <longpeng2@huawei.com>

>
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Sunday, December 11, 2016 11:38 AM
> To: Gonglei (Arei)
> Cc: qemu-devel@nongnu.org; Wubin (H); longpeng
> Subject: Re: [PATCH for-2.9 0/3] cryptodev: prepare works for hotplug
>=20
> On Mon, Dec 05, 2016 at 11:27:09AM +0800, Gonglei wrote:
> > The patch set make the cryptodev object can be hot plugging
> > in safety, and which are preparing works for virtio-crypto
> > device hotpulgging.
>=20
>=20
> Thanks, pls remember to ping after 2.8 is out.
>=20
OK, the v2 will be posted with virtio-crypto device hotplugging function.


Regards,
-Gonglei

> > Gonglei (3):
> >   cryptodev: introduce a new is_used property
> >   cryptodev: wrap the ready flag
> >   virtio-crypto: avoid one cryptodev device is used by multiple virtio
> >     crypto devices
> >
> >  backends/cryptodev-builtin.c |  4 ++++
> >  backends/cryptodev.c         | 34
> ++++++++++++++++++++++++++++++----
> >  hw/virtio/virtio-crypto.c    | 22 +++++++++++++++++++---
> >  include/sysemu/cryptodev.h   | 42
> ++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 95 insertions(+), 7 deletions(-)
> >
> > --
> > 1.8.3.1
> >

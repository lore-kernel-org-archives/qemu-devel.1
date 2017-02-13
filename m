Received: from eggs.gnu.org ([2001:4830:134:3::10]:44653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cdGg4-00071p-Ab
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 08:28:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cdGg1-0006oH-2L
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 08:28:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cdGg0-0006oB-Sg
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 08:28:20 -0500
Message-ID: <1486992492.19677.18.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 13 Feb 2017 14:28:12 +0100
In-Reply-To: <20170213075558.786-1-ppandit@redhat.com>
References: <20170213075558.786-1-ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] usb: xhci: break loop after ctrl transfer
 complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Li Qiang <liqiang6-s@360.cn>, Prasad J Pandit <pjp@fedoraproject.org>

On Mo, 2017-02-13 at 13:25 +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>=20
> xHCI controller emulator loops through the transfer ring to
> transfer control/data between host memory and device endpoints.
> It continues to do so after processing 'Status Stage' TD which
> is the last descriptor in control transfer.

That is perfectly fine.  The guest is allowed to queue up multiple
requests.

> Add break to avoid
> infinite loop.

It's not that simple.

https://patchwork.ozlabs.org/patch/724484/

cheers,
  Gerd

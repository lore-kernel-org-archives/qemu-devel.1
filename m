Received: from eggs.gnu.org ([2001:4830:134:3::10]:42597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZZzx-0005p1-O1
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:17:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZZzt-0003c8-Op
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:17:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cZZzt-0003bL-J4
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:17:37 -0500
Message-ID: <1486113454.16444.13.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 03 Feb 2017 10:17:34 +0100
In-Reply-To: <20170202192228.10847-1-ppandit@redhat.com>
References: <20170202192228.10847-1-ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] usb: ccid: check ccid apdu length
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

On Fr, 2017-02-03 at 00:52 +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>=20
> CCID device emulator uses Application Protocol Data Units(APDU)
> to exchange command and responses to and from the host.
> The length in these units couldn't be greater than 65536. Add
> check to ensure the same. It'd also avoid potential integer
> overflow in emulated_apdu_from_guest.
>=20
> Reported-by: Li Qiang <liqiang6-s@360.cn>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

Added to usb queue.

thanks,
  Gerd

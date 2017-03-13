Received: from eggs.gnu.org ([2001:4830:134:3::10]:43441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cnRr2-0004GN-0S
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 11:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cnRqx-0001Qp-Ft
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 11:25:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cnRqx-0001QD-9l
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 11:25:43 -0400
Message-ID: <1489418740.13264.44.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 13 Mar 2017 16:25:40 +0100
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA1E2D1B@DGGEMA505-MBS.china.huawei.com>
References: <20170313131029.14044-1-hangaohuai@huawei.com>
	<1489413307.13264.21.camel@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA1E2D1B@DGGEMA505-MBS.china.huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] fix :cirrus_vga fix OOB read case qemu
 Segmentation fault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Hangaohuai <hangaohuai@huawei.com>, fangying <fangying1@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

  Hi,

> commit d16136d22af0fcf0d651de04c9e3cbc7137cc6f9
> Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Mon Jul 7 10:32:34 2014 +1000
>=20
> cirrus: Fix host CPU blits

> So does v2 is needed?

Yes, otherwise we will end up with a regression
similar to the one fixed by ben.

cheers,
  Gerd

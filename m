Received: from eggs.gnu.org ([2001:4830:134:3::10]:54126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dL1hv-0005VS-Lp
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:23:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dL1hs-0006wm-HL
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:23:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dL1hs-0006w7-BR
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:23:08 -0400
Message-ID: <1497421386.11748.1.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 14 Jun 2017 08:23:06 +0200
In-Reply-To: <CAKXe6SLoc3XPMaSme-qWjQJOyrJLKZyMyX-zCiuHtiL4c2ZmVA@mail.gmail.com>
References: <1497411544-80213-1-git-send-email-liqiang6-s@360.cn>
	<149741206273.576.11299001383096762722@4a9a010726c0>
	<CAKXe6SLoc3XPMaSme-qWjQJOyrJLKZyMyX-zCiuHtiL4c2ZmVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] usb: xhci: fix info leak when writing
 event to the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: famz@redhat.com, Li Qiang <liqiang6-s@360.cn>, P J P <ppandit@redhat.com>

  Hi,

>=C2=A0> CC=C2=A0 =C2=A0 =C2=A0 hw/timer/a9gtimer.o
> > In file included from /tmp/qemu-test/src/hw/net/vmxnet3.c:30:
> > /tmp/qemu-test/src/include/migration/register.h:18: error:
> > redefinition of typedef =E2=80=98LoadStateHandler=E2=80=99
> > /tmp/qemu-test/src/include/migration/vmstate.h:32: note: previous
> > declaration of =E2=80=98LoadStateHandler=E2=80=99 was here
>=20
>=20
> Seems not related with my patch.

Indeed, master branch seems to be broken, I got a few more of these
already ...

cheers,
  Gerd

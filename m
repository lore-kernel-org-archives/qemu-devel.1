Received: from eggs.gnu.org ([209.51.188.92]:34029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1goPKB-0007eV-3t
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 04:04:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1goPKA-0002tU-8L
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 04:04:55 -0500
Received: from 4.mo69.mail-out.ovh.net ([46.105.42.102]:45218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1goPKA-0002gv-2f
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 04:04:54 -0500
Received: from player756.ha.ovh.net (unknown [10.109.160.93])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id E8A923CE12
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 10:04:33 +0100 (CET)
Date: Tue, 29 Jan 2019 10:04:26 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190129100426.7d61bf55@bahia.lan>
In-Reply-To: <8b87466e-3e9a-14ae-c827-ac5e61717a87@redhat.com>
References: <alpine.BSF.2.21.9999.1901290213290.42676@zero.eik.bme.hu>
	<8b87466e-3e9a-14ae-c827-ac5e61717a87@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] macOS build error after ddac19f534 (virtio: split
 virtio 9p bits from virtio-pci)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Tue, 29 Jan 2019 08:32:08 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Hi Zoltan,
>=20
> On 1/29/19 2:20 AM, BALATON Zoltan wrote:
> > Hello,
> >=20
> > I'm getting error building on macOS after commit ddac19f534:
> >=20
> > =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aarch64-softmmu/hw/virtio/virti=
o-blk-pci.o
> > In file included from qemu/hw/virtio/virtio-9p-pci.c:19:
> > In file included from qemu/hw/9pfs/virtio-9p.h:6:
> > In file included from qemu/hw/9pfs/9p.h:7:
> > qemu/fsdev/file-op-9p.h:19:10: fatal error: 'sys/vfs.h' file not found
> > #include <sys/vfs.h>
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~
> >=20
> > Am I missing something? (Apart from the include file which is not
> > present on OS X... Maybe this needs the #ifdefs it had before the split=
?) =20
>=20

No, the problem is that virtio-9p-pci should only be compiled on a linux
host.

> It seems commits are not correctly ordered for bisectability :(
>=20
> If you cherry-pick ecd3b89b054, does it build?

I agree this is likely the problem. A workaround is to pass --disable-virtfs
to configure when bisecting on OS X.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:59718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dmzxz-0007lZ-6T
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:11:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dmzxu-0006lA-8H
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:11:23 -0400
Received: from 13.mo6.mail-out.ovh.net ([188.165.56.124]:58620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dmzxu-0006kW-1z
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:11:18 -0400
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 49D531084E3
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 12:11:15 +0200 (CEST)
Date: Wed, 30 Aug 2017 12:11:09 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170830121109.7fab5559@bahia>
In-Reply-To: <2061420835.208824.1504085337258@mail.yahoo.com>
References: <1915302638.2814146.1504030043465.ref@mail.yahoo.com>
	<1915302638.2814146.1504030043465@mail.yahoo.com>
	<14033890-2a35-666c-2fa7-5a8727090801@tuxfamily.org>
	<1075529669.195794.1504079702032@mail.yahoo.com>
	<bc7bacd9-fec7-c193-6de0-99d1f7fd0f6f@tuxfamily.org>
	<2061420835.208824.1504085337258@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/E44NL0T_W6EsyAs7O2ejDot";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-discuss] Accessing a shared folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mahmood <nt_mahmood@yahoo.com>
Cc: Thomas Huth <huth@tuxfamily.org>, "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>

--Sig_/E44NL0T_W6EsyAs7O2ejDot
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Aug 2017 09:28:57 +0000 (UTC)
Mahmood <nt_mahmood@yahoo.com> wrote:

> >Could you please try to replace the -virtfs option with these two option=
s:
> >
>  >-fsdev local,id=3Dshared,path=3D/home/mahmood/Downloads \
>  >-device virtio-9p-pci,fsdev=3Dshared,mount_tag=3DDownloads =20
>=20
>=20
>=20
>=20
> Still get the same error!
>=20
> mahmood@cluster:qemu-vm$ qemu-system-x86_64 -m 4000 -cpu Opteron_G5 -smp =
2 -hda centos7server.img -boot c=C2=A0 -usbdevice tablet -enable-kvm -devic=
e e1000,netdev=3Dhost_files -netdev user,net=3D10.0.2.0/24,id=3Dhost_files =
-fsdev local,id=3Dshared,path=3D/home/mahmood/Downloads -device virtio-9p-p=
ci,fsdev=3Dshared,mount_tag=3DDownloads
> qemu-system-x86_64: -device virtio-9p-pci,fsdev=3Dshared,mount_tag=3DDown=
loads: Parameter 'driver' expects device type
> mahmood@cluster:qemu-vm$
>=20

Hi,

Both -virtfs and -fsdev/-device syntaxes work for me with the current QEMU
master branch :) Where's your qemu-system-x86_64 binary coming from ?

Cheers,

--
Greg

PS: I'm on vacation. I'll be fully available next week.


>=20
>=20
>=20
> Regards,
> Mahmood
>=20


--Sig_/E44NL0T_W6EsyAs7O2ejDot
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWaaPPQAKCRAC/DrrAQHb
whfMAJsFfC8oNnrL3LTHAwqa00I9qajgOwCdHGvhpe2zWgbblDrGFoPtKe8Rtho=
=+Row
-----END PGP SIGNATURE-----

--Sig_/E44NL0T_W6EsyAs7O2ejDot--

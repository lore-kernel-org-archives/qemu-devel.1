Received: from eggs.gnu.org ([2001:4830:134:3::10]:50713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWyL2-00005X-CO
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 01:49:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWyKy-0005U3-Gs
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 01:49:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:26338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gWyKy-0005Ts-Am
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 01:49:40 -0500
Date: Wed, 12 Dec 2018 07:49:36 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181212064936.ubnv3yif34e7ga5j@sirius.home.kraxel.org>
References: <20181127135030.1671-1-i.maximets@samsung.com>
	<CGME20181127135045eucas1p1e259cacbab5e715f7845b9beee22f882@eucas1p1.samsung.com>
	<20181127135030.1671-2-i.maximets@samsung.com>
	<20181211105329.GE921@redhat.com>
	<52c43506-ef39-6d08-7db4-ad3c0f96dd1f@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <52c43506-ef39-6d08-7db4-ad3c0f96dd1f@samsung.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] hostmem-memfd: disable for systems
 wihtout sealing support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ilya Maximets <i.maximets@samsung.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Dec 11, 2018 at 02:09:11PM +0300, Ilya Maximets wrote:
> On 11.12.2018 13:53, Daniel P. Berrang=E9 wrote:
> >>
> >> Let's restrict memfd backend to systems with sealing support.
> >=20
> > I don't think we need todo that - sealing is optional in the QEMU cod=
e,
> > we simply have it set to the wrong default when sealing is not availa=
ble.
>=20
> That was literally what I've fixed in v1:
>     https://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg05483.h=
tml
>=20
> but 2 people suggested me to disable memfd entirely for this case.
> Do you think I need to get patch from v1 back ?
>=20
> Gerd, Marc-Andr=E9, what do you think?

I still think it makes sense to require sealing support.  Sealing is
very useful, and there are only a few kernel versions with memfd but
without sealing.  So finding such kernels in the wild will become more
rare over time.  I wouldn't worry too much about them.

cheers,
  Gerd

Received: from eggs.gnu.org ([2001:4830:134:3::10]:47943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dokus-0005Kc-SH
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 02:31:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dokuo-0000IE-8X
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 02:31:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dokuo-0000FW-2w
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 02:31:22 -0400
Message-ID: <1504506678.18331.1.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 04 Sep 2017 08:31:18 +0200
In-Reply-To: <CAKmqyKMUVEb13Ffv5YsovOTRAaQ8g=Q2C=U4FzWWZuygAdMwdA@mail.gmail.com>
References: <20170901105023.11108-1-kraxel@redhat.com>
	<CAKmqyKMUVEb13Ffv5YsovOTRAaQ8g=Q2C=U4FzWWZuygAdMwdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] pixman: drop submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

  Hi,

> > diff --git a/configure b/configure
> > index dd73cce62f..73760430b0 100755
> > --- a/configure
> > +++ b/configure
> > @@ -930,8 +930,6 @@ for opt do
> > =C2=A0=C2=A0=C2=A0;;
> > =C2=A0=C2=A0=C2=A0--with-system-pixman) pixman=3D"system"
>=20
> Is there any use case for '--with-system-pixman now?

There is "--without-pixman" (so you can turn off pixman if you don't
want build the system emulation).  So IMHO it makes sense to leave the
opposite switch in.  The name is a bit strange now, but changing it
might break build scripts, so I left it as-is.  Maybe configure should
accept both "--with-pixman" and "--with-system-pixman"?

cheers,
  Gerd

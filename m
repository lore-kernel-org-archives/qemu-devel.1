Received: from eggs.gnu.org ([2001:4830:134:3::10]:60397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRPkK-00069r-ME
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:43:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRPkH-0001pb-FX
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:43:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cRPkH-0001ox-Ak
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:43:45 -0500
Message-ID: <1484167421.26755.10.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 11 Jan 2017 21:43:41 +0100
In-Reply-To: <20170111145934.nogaszs5gvmn5bad@perseus.local>
References: <1476776717-24807-1-git-send-email-ppandit@redhat.com>
	<CAJ+F1CKnyE1d8nT_dj2D5St=2e9+W5Zx0zvXGxPDsOsg1NW66w@mail.gmail.com>
	<alpine.LFD.2.20.1611281003090.19776@wniryva>
	<20170111145934.nogaszs5gvmn5bad@perseus.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] display: cirrus: check vga bits per
 pixel(bpp) value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: P J P <ppandit@redhat.com>, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, Qemu Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Huawei PSIRT <psirt@huawei.com>

On Mi, 2017-01-11 at 16:59 +0200, Alberto Garcia wrote:
> On Mon, Nov 28, 2016 at 11:52:08AM +0530, P J P wrote:
> > | > --- a/hw/display/cirrus_vga.c
> > | > +++ b/hw/display/cirrus_vga.c
> > | > @@ -272,6 +272,9 @@ static void cirrus_update_memory_access(CirrusV=
GAState
> > | > *s);
> > | >  static bool blit_region_is_unsafe(struct CirrusVGAState *s,
> > | >                                    int32_t pitch, int32_t addr)
> > | >  {
> > | > +    if (!pitch) {
> > | > +        return true;
> > | > +    }
> > | >
> > |=20
> > | That doesn't look directly related to 'cirrus_get_bpp', care to expla=
in?
> >=20
> >   'blit_region_is_unsafe' is called from 'blit_is_unsafe' to check if b=
lit=20
> > parameters (cirrus_blt_srcpitch/cirrus_blt_dstpitch)  are safe for=20
> > 'cirrus_do_copy'. These too could lead to div by zero in cirrus_do_copy
>=20
> This change is causing display artifacts in QEMU 2.8.
>=20
> What seems to happen is that blit_is_unsafe() is also called for
> CIRRUS_BLTMODE_PATTERNCOPY, but in this case cirrus_blt_srcpitch is
> not used. However, because of this new check if its value is 0 then
> cirrus_bitblt_common_patterncopy() returns early and becomes a no-op.

inflight vga queue pull request has a fix for that.

cheers,
  Gerd

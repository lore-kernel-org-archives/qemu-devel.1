Received: from eggs.gnu.org ([2001:4830:134:3::10]:58265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fNuPZ-0001dz-LU
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:16:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fNuPW-0000le-Gi
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:16:41 -0400
Date: Wed, 30 May 2018 08:16:33 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180530061633.iltyrqvyctpipxmt@sirius.home.kraxel.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-16-f4bug@amsat.org>
	<4f76d9d2-5c4b-a6ef-e050-9d9a1f31be85@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f76d9d2-5c4b-a6ef-e050-9d9a1f31be85@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.10 15/35] usb: correctly handle Zero
 Length Packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Tue, May 29, 2018 at 11:22:46AM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On 07/24/2017 03:27 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > USB Specification Revision 2.0, =C2=A75.5.3:
> >   The Data stage of a control transfer from an endpoint to the host i=
s complete when the endpoint does one of the following:
> >   =E2=80=A2 Has transferred exactly the amount of data specified duri=
ng the Setup stage
> >   =E2=80=A2 Transfers a packet with a payload size less than wMaxPack=
etSize or transfers a zero-length packet"
> >=20
> > hw/usb/redirect.c:802:9: warning: Declared variable-length array (VLA=
) has zero size
> >         uint8_t buf[size];
> >         ^~~~~~~~~~~ ~~~~
> >=20
> > Reported-by: Clang Static Analyzer
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >  hw/usb/redirect.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
> > index 5e42730449..5b7073d2cd 100644
> > --- a/hw/usb/redirect.c
> > +++ b/hw/usb/redirect.c
> > @@ -795,7 +795,7 @@ static void usbredir_handle_bulk_data(USBRedirDev=
ice *dev, USBPacket *p,
> >             usbredirparser_peer_has_cap(dev->parser,
> >                                         usb_redir_cap_32bits_bulk_len=
gth));
> > =20
> > -    if (ep & USB_DIR_IN) {
> > +    if (ep & USB_DIR_IN || size =3D=3D 0) {
> >          usbredirparser_send_bulk_packet(dev->parser, p->id,
> >                                          &bulk_packet, NULL, 0);
> >      } else {
> >=20
>=20
> Ping?

Whoops, pretty old one.  Don't have this in my qemu-devel archive any
more.  Can you rebase + resend?

thanks,
  Gerd

Received: from eggs.gnu.org ([2001:4830:134:3::10]:55144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWL6e-0007FA-Pl
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 07:56:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWL6d-0007Ib-SG
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 07:56:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gWL6d-0007IN-Lw
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 07:56:15 -0500
Date: Mon, 10 Dec 2018 13:56:13 +0100
From: "kraxel@redhat.com" <kraxel@redhat.com>
Message-ID: <20181210125613.x6mrmfgvtcoo3sv3@sirius.home.kraxel.org>
References: <RO1P152MB14839E480D046B4052F0ADC797A40@RO1P152MB1483.LAMP152.PROD.OUTLOOK.COM>
	<20181210063657.2lqj7vkqwdaobp7e@sirius.home.kraxel.org>
	<RO1P152MB1483300ECF25FEE36927B1AF97A50@RO1P152MB1483.LAMP152.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <RO1P152MB1483300ECF25FEE36927B1AF97A50@RO1P152MB1483.LAMP152.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Guests are crashing on startup,
 seem related to usb-audio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonardo Soares =?utf-8?Q?M=C3=BCller?= <leozinho29_eu@hotmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Mon, Dec 10, 2018 at 12:11:09PM +0000, Leonardo Soares M=FCller wrote:
> Hi, I did not save that Mageia 7 data as I was unaware I could do this.
> The data below is from another crash with openSUSE Leap, this time I
> saved this backtrace with generate-core-file.

> On #4 it shows:
> $2 =3D {pid =3D 225, id =3D 2027203168, ep =3D 0x555557e46520, stream =3D=
 0, iov =3D
> {iov =3D 0x7fffc418d190, niov =3D 0, nalloc =3D 1, size =3D 0}, paramet=
er =3D 0,
                                               ^^^^^^^^
> short_not_ok =3D false, int_req =3D false, status =3D 0, actual_length =
=3D 0,
>   state =3D USB_PACKET_SETUP, combined =3D 0x0, queue =3D {tqe_next =3D=
 0x0,
> tqe_prev =3D 0x0}, combined_entry =3D {tqe_next =3D 0x0, tqe_prev =3D 0=
x0}}

Hmm, zero-length usb package.  Should be 192 bytes ...

Does anything change with
  https://git.kraxel.org/cgit/qemu/log/?h=3Dsirius/usb-audio-crash ?

thanks,
  Gerd

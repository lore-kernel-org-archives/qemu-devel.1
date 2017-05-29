Received: from eggs.gnu.org ([2001:4830:134:3::10]:44802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dFJc4-0003Rm-50
	for qemu-devel@nongnu.org; Mon, 29 May 2017 08:17:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dFJc1-000383-0x
	for qemu-devel@nongnu.org; Mon, 29 May 2017 08:17:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dFJc0-00037z-Ra
	for qemu-devel@nongnu.org; Mon, 29 May 2017 08:17:28 -0400
Message-ID: <1496060245.5201.1.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 May 2017 14:17:25 +0200
In-Reply-To: <CAJ+F1C+Tr_yK6FzpG4Xiwe=8gtUSc02T1oREc7Ba939y14pDFg@mail.gmail.com>
References: <20170510202006.31737-1-jjongsma@redhat.com>
	<CAJ+F1C+Tr_yK6FzpG4Xiwe=8gtUSc02T1oREc7Ba939y14pDFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] spice: Use proper enum type for kbd led
 state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, Jonathon Jongsma <jjongsma@redhat.com>, qemu-devel@nongnu.org

On Thu, 2017-05-25 at 12:50 +0000, Marc-Andr=C3=A9 Lureau wrote:
>=20
>=20
> On Thu, May 11, 2017 at 6:16 AM Jonathon Jongsma <jjongsma@redhat.com
> > wrote:
> > Although the Qemu and spice flags currently have the same value, it
> > seems more correct to pass the spice flag values to
> > spice_server_kbd_leds(), especially considering that this function
> > already makes an effort to convert between the QEMU_*_LED and
> > SPICE_KEYBOARD_MODIFIER_* values.
> >=20
> > Signed-off-by: Jonathon Jongsma <jjongsma@redhat.com>
>=20
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> =C2=A0

Added to ui queue.

thanks,
  Gerd

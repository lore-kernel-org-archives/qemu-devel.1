Received: from eggs.gnu.org ([2001:4830:134:3::10]:49302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1frlD5-0004p3-HJ
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:31:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1frlCz-0005io-Tk
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:31:11 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:34274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1frlCz-0005hY-OD
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:31:05 -0400
Received: by mail-io0-x242.google.com with SMTP id c22-v6so6597013iob.1
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 07:31:05 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20180820052456.tt6joujlmhehr7aa@sirius.home.kraxel.org>
Date: Mon, 20 Aug 2018 10:31:02 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <4C3545DA-01CB-4D7B-8C4D-AA38ED2803A0@gmail.com>
References: <20180819043509.12888-1-programmingkidx@gmail.com>
	<20180820052456.tt6joujlmhehr7aa@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH] hw/input/ps2.c: fix erratic mouse behavior
 for Windows 3.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, qemu-devel@nongnu.org


> On Aug 20, 2018, at 1:24 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
> On Sun, Aug 19, 2018 at 12:35:09AM -0400, John Arbuckle wrote:
>> When the user moves the mouse and moves the scroll wheel at the same
>> time, the mouse cursor's movement becomes erratic in Windows 3.1. =
With
>> this patch if the mouse is in ps/2 mode and the scroll wheel is used,
>> the command queue is reset. This does not fix the erratic mouse
>> problem in Windows NT 4.0.
>=20
> I don't think we need to reset the queue.  Just ignoring the z axis
> value for type 0 should do.  Can you try this?
>=20
> --- a/hw/input/ps2.c
> +++ b/hw/input/ps2.c
> @@ -661,6 +661,8 @@ static int ps2_mouse_send_packet(PS2MouseState *s)
>     /* extra byte for IMPS/2 or IMEX */
>     switch(s->mouse_type) {
>     default:
> +        s->mouse_dz =3D 0;
> +        dz1 =3D 0;
>         break;
>     case 3:
>         if (dz1 > 127)
>=20
> cheers,
>  Gerd
>=20

Sorry it did not fix the problem.

https://winworldpc.com/product/windows-3/31
In case you or anyone else wishes to reproduce this problem, the link to =
the Windows 3.1 installer is above.

Thank you.=

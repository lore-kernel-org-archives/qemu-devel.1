Received: from eggs.gnu.org ([2001:4830:134:3::10]:44229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ecWsx-0007Zz-Sa
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:39:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ecWrB-0003Cf-Iz
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:39:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ecWrB-0003C1-75
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:37:21 -0500
Date: Fri, 19 Jan 2018 13:37:08 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180119133708.GM16798@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <cover.1515960078.git.pisa@cmp.felk.cvut.cz>
	<425e38f28bba536cfb1ae389ffa963984990f306.1515960078.git.pisa@cmp.felk.cvut.cz>
	<65ff7759-2e09-fba6-e60e-41e8d89d0e7c@amsat.org>
	<201801152229.53520.pisa@cmp.felk.cvut.cz>
	<04fbdf17-6431-5d67-6681-3cc0f375b32a@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <04fbdf17-6431-5d67-6681-3cc0f375b32a@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V4 2/7] CAN bus support to connect bust to
 Linux host SocketCAN interface.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Stefan Hajnoczi <stefanha@gmail.com>, Deniz Eren <deniz.eren@icloud.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Konrad Frederic <frederic.konrad@adacore.com>, Jan Kiszka <jan.kiszka@siemens.com>

On Mon, Jan 15, 2018 at 09:12:09PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On 01/15/2018 06:29 PM, Pavel Pisa wrote:
> >>> +    /* open socket */
> >>> +    s =3D socket(PF_CAN, SOCK_RAW, CAN_RAW);
> >>
> >> I never used it, but I think QEMU uses his socket API: "qemu/sockets=
.h"
> >=20
> > The SocketCAN host connection code is Linux specific,
> > but I can switch to qemu_socket() if it is preferred.
> > But address family has to be from Linux header file anyway.
>=20
> qemu_socket() sockets are heavily tested and already solve many things,
> like async I/O and error handling.

NB that's just the low level system call wrapper. All it really does is
ensure O_CLOSEXEC is set for all sockets. It should defintely be used
just for that reason alone though.=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

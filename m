Received: from eggs.gnu.org ([2001:4830:134:3::10]:56201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dZz2c-00010G-8F
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 08:34:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dZz2X-0006Et-CA
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 08:34:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dZz2X-0006EJ-5y
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 08:34:17 -0400
Message-ID: <1500986052.29790.5.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 25 Jul 2017 14:34:12 +0200
In-Reply-To: <20170724182751.18261-17-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-17-f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.10 16/35] usb/dev-mtp: fix use of
 uninitialized values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case CMD_GET_OBJECT_INFO:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0o =3D usb_mtp_object_l=
ookup(s, c->argv[0]);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (c->argc > 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
o =3D usb_mtp_object_lookup(s, c->argv[0]);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}

How about zero-initializing c->argv instead?

cheers,
  Gerd

Received: from eggs.gnu.org ([2001:4830:134:3::10]:54661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dKKdo-000159-OU
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 04:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dKKdk-0006V3-Qi
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 04:24:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dKKdk-0006Uh-Ls
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 04:24:00 -0400
Message-ID: <1497255838.6334.6.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 12 Jun 2017 10:23:58 +0200
In-Reply-To: <CAJ+F1CLAq16p4SkcsyAeLZJ3BCtQQVfiXzvgnzxfN-iVFT0RCA@mail.gmail.com>
References: <20170606110459.9771-1-kraxel@redhat.com>
	<20170606110459.9771-4-kraxel@redhat.com>
	<CAJ+F1CLAq16p4SkcsyAeLZJ3BCtQQVfiXzvgnzxfN-iVFT0RCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 3/4] sdl2: use framebuffer helper functions.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, qemu-devel@nongnu.org

  Hi,

> It's a bit weird to have win_fb used without being really
> initialized.
>=20
> Furthermore, there doesn't seem to be guarantee that
> glGenFramebuffers(1, &fb->framebuffer) will make only non-0 values.

0 is reserved for the default framebuffer of the current context, i.e.
the sdl window in this case.

cheers,
  Gerd

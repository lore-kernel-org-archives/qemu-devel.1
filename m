Received: from eggs.gnu.org ([2001:4830:134:3::10]:35324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cJJ21-0004eV-9b
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 06:56:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cJJ1y-0005nG-7c
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 06:56:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1cJJ1y-0005n1-1F
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 06:56:30 -0500
Date: Tue, 20 Dec 2016 17:26:16 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <CAJ+F1CJq2tp+-sDjX6EqZ7mFx63uUkc3=i8yaQyVmmG1c1RTNw@mail.gmail.com>
Message-ID: <alpine.LFD.2.20.1612201723570.28755@wniryva>
References: <20161214070156.23368-1-ppandit@redhat.com>
	<CAJ+F1CJq2tp+-sDjX6EqZ7mFx63uUkc3=i8yaQyVmmG1c1RTNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] display: virtio-gpu-3d: check virgl
 capabilities max_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Zhenhao Hong <zhenhaohong@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

  Hello Marc,

+-- On Tue, 20 Dec 2016, Marc-Andr=C3=A9 Lureau wrote --+
| > +    if (!max_size) {
|=20
| Shouldn't it check for >=3D sizeof(union virgl_caps) ? (since that's wh=
at
| virglrenderer vrend_renderer_fill_caps() expects)

  No, 'max_size' isn't set by a user, it's set by the library function=20
'vrend_renderer_get_cap_set'.

  -> https://cgit.freedesktop.org/~airlied/virglrenderer/tree/src/vrend_r=
enderer.c#n6280

And if not zero, it'll be set to sizeof(union virgl_caps).

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F

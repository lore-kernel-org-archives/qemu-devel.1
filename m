Received: from eggs.gnu.org ([2001:4830:134:3::10]:60252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cJKq1-00073i-Jb
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 08:52:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cJKq0-0007j9-QF
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 08:52:17 -0500
Received: from mail-yw0-x22a.google.com ([2607:f8b0:4002:c05::22a]:34746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cJKq0-0007it-Lh
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 08:52:16 -0500
Received: by mail-yw0-x22a.google.com with SMTP id t125so82135277ywc.1
	for <qemu-devel@nongnu.org>; Tue, 20 Dec 2016 05:52:16 -0800 (PST)
MIME-Version: 1.0
References: <20161214070156.23368-1-ppandit@redhat.com>
	<CAJ+F1CJq2tp+-sDjX6EqZ7mFx63uUkc3=i8yaQyVmmG1c1RTNw@mail.gmail.com>
	<alpine.LFD.2.20.1612201723570.28755@wniryva>
In-Reply-To: <alpine.LFD.2.20.1612201723570.28755@wniryva>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 20 Dec 2016 13:52:04 +0000
Message-ID: <CAJ+F1C+KHospc2E+ajjBBa7PjicOEhabUZ3yXm22UCGhM1ceHQ@mail.gmail.com>
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
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Zhenhao Hong <zhenhaohong@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

Hi

On Tue, Dec 20, 2016 at 12:56 PM P J P <ppandit@redhat.com> wrote:

>   Hello Marc,
>
> +-- On Tue, 20 Dec 2016, Marc-Andr=C3=A9 Lureau wrote --+
> | > +    if (!max_size) {
> |
> | Shouldn't it check for >=3D sizeof(union virgl_caps) ? (since that's wh=
at
> | virglrenderer vrend_renderer_fill_caps() expects)
>
>   No, 'max_size' isn't set by a user, it's set by the library function
> 'vrend_renderer_get_cap_set'.
>
>   ->
> https://cgit.freedesktop.org/~airlied/virglrenderer/tree/src/vrend_render=
er.c#n6280
>
> And if not zero, it'll be set to sizeof(union virgl_caps).
>

ok

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



>
> Thank you.
> --
> Prasad J Pandit / Red Hat Product Security Team
> 47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F

--=20
Marc-Andr=C3=A9 Lureau

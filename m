Received: from eggs.gnu.org ([2001:4830:134:3::10]:50372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cT67j-0004VN-Dv
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:10:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cT67i-00076M-Fa
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:10:55 -0500
Received: from mail-yw0-x243.google.com ([2607:f8b0:4002:c05::243]:36084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cT67i-000763-AR
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:10:54 -0500
Received: by mail-yw0-x243.google.com with SMTP id l75so8542982ywb.3
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 04:10:54 -0800 (PST)
MIME-Version: 1.0
References: <20170115203014.GA12068@var.home>
In-Reply-To: <20170115203014.GA12068@var.home>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 16 Jan 2017 12:10:42 +0000
Message-ID: <CAJ+F1CKnAdL6g=oKJ=s2_Go0UXrV1FeHuJbO+0zQ_sRb_yCbmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Drop duplicate display option documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org

Hi

On Mon, Jan 16, 2017 at 12:30 AM Samuel Thibault <samuel.thibault@gnu.org>
wrote:

> The curses and none possibilities are already documented on a separate
> line,
> so documenting it on the sdl line was both unneeded and confusing.
>
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
>

Introduced in commit f04ec5afbb7d60a56863add800fd90ceee66f362


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>




> diff --git a/qemu-options.hx b/qemu-options.hx
> index c534a2f7f9..9c81d3752d 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -927,7 +927,7 @@ ETEXI
>
>  DEF("display", HAS_ARG, QEMU_OPTION_display,
>      "-display sdl[,frame=3Don|off][,alt_grab=3Don|off][,ctrl_grab=3Don|o=
ff]\n"
> -    "            [,window_close=3Don|off][,gl=3Don|off]|curses|none|\n"
> +    "            [,window_close=3Don|off][,gl=3Don|off]\n"
>      "-display gtk[,grab_on_hover=3Don|off][,gl=3Don|off]|\n"
>      "-display vnc=3D<display>[,<optargs>]\n"
>      "-display curses\n"
>
> --
Marc-Andr=C3=A9 Lureau

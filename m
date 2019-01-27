Received: from eggs.gnu.org ([209.51.188.92]:49377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gniz4-0003JF-1o
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 06:52:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gnipy-0001wl-TP
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 06:42:55 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gnipy-0001wR-HX
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 06:42:54 -0500
Received: by mail-wr1-x444.google.com with SMTP id l9so14767742wrt.13
	for <qemu-devel@nongnu.org>; Sun, 27 Jan 2019 03:42:54 -0800 (PST)
MIME-Version: 1.0
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
	<20190117114359.5164-6-marcandre.lureau@redhat.com>
	<20190127000148.b6pbeenaks3fq3hl@function>
In-Reply-To: <20190127000148.b6pbeenaks3fq3hl@function>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sun, 27 Jan 2019 15:42:41 +0400
Message-ID: <CAJ+F1CLiHg1ceiq-bJgHqJ16OEWFv6tEad++O4om6AEoR47fzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/27] slirp: add callbacks for timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, QEMU <qemu-devel@nongnu.org>, Zhang Chen <zhangckid@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi

On Sun, Jan 27, 2019 at 4:17 AM Samuel Thibault <samuel.thibault@gnu.org> w=
rote:
>
> Applied too, but
>
> Marc-Andr=C3=A9 Lureau, le jeu. 17 janv. 2019 15:43:37 +0400, a ecrit:
> > +    /* Create a new timer with the given callback and opaque data */
> > +    void *(*timer_new)(SlirpTimerCb cb, void *opaque);
> > +    /* Remove and free a timer */
> > +    void (*timer_free)(void *timer);
> > +    /* Modify a timer to expire at @expire_time */
> > +    void (*timer_mod)(void *timer, int64_t expire_time);
>
> I'd say we will want to make the API use an opaque type for timers, for
> typechecking.

You mean declaring a typedef struct SlirpTimer in libslirp.h?

I am not sure it's a good idea, since the type is defined by the API
client, it's an opaque type for the library.

thanks

>
> Samuel
>


--=20
Marc-Andr=C3=A9 Lureau

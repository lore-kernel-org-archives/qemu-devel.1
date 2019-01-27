Received: from eggs.gnu.org ([209.51.188.92]:49128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gniyk-0002sg-0W
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 06:51:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnivg-0002k7-BV
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 06:48:49 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:42976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gnivc-0002Cc-3E
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 06:48:45 -0500
Date: Sun, 27 Jan 2019 12:48:40 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190127114840.e3anzsnm6pzxbjb4@function>
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
	<20190117114359.5164-6-marcandre.lureau@redhat.com>
	<20190127000148.b6pbeenaks3fq3hl@function>
	<CAJ+F1CLiHg1ceiq-bJgHqJ16OEWFv6tEad++O4om6AEoR47fzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CLiHg1ceiq-bJgHqJ16OEWFv6tEad++O4om6AEoR47fzg@mail.gmail.com>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, QEMU <qemu-devel@nongnu.org>, Zhang Chen <zhangckid@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

Marc-Andr=C3=A9 Lureau, le dim. 27 janv. 2019 15:42:41 +0400, a ecrit:
> On Sun, Jan 27, 2019 at 4:17 AM Samuel Thibault <samuel.thibault@gnu.or=
g> wrote:
> > Marc-Andr=C3=A9 Lureau, le jeu. 17 janv. 2019 15:43:37 +0400, a ecrit=
:
> > > +    /* Create a new timer with the given callback and opaque data =
*/
> > > +    void *(*timer_new)(SlirpTimerCb cb, void *opaque);
> > > +    /* Remove and free a timer */
> > > +    void (*timer_free)(void *timer);
> > > +    /* Modify a timer to expire at @expire_time */
> > > +    void (*timer_mod)(void *timer, int64_t expire_time);
> >
> > I'd say we will want to make the API use an opaque type for timers, f=
or
> > typechecking.
>=20
> You mean declaring a typedef struct SlirpTimer in libslirp.h?
>=20
> I am not sure it's a good idea, since the type is defined by the API
> client, it's an opaque type for the library.

Ah, right, C doesn't permit to declare a type without defining it.
Too bad, then.

Samuel

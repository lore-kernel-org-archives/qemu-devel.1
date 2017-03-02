Received: from eggs.gnu.org ([2001:4830:134:3::10]:50814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjNv7-000144-6w
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:25:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjNv5-0004vI-Rm
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:25:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cjNv5-0004v2-Lc
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:25:11 -0500
References: <1487665107-88004-1-git-send-email-liqiang6-s@360.cn>
	<910332417.8403823.1487665924940.JavaMail.zimbra@redhat.com>
	<CAKXe6S+Gw5q1Ohw8F3SQzYp7g_2sBUW7gEYd94yYt8m_3Naw2g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0c88b0e9-2e27-a3cc-c746-02c67c07253f@redhat.com>
Date: Thu, 2 Mar 2017 11:25:08 +0100
MIME-Version: 1.0
In-Reply-To: <CAKXe6S+Gw5q1Ohw8F3SQzYp7g_2sBUW7gEYd94yYt8m_3Naw2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] spice-char: fix segfault in
 char_spice_finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: marcandre lureau <marcandre.lureau@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Li Qiang <liqiang6-s@360.cn>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <mlureau@redhat.com>



On 02/03/2017 11:20, Li Qiang wrote:
> Hello Paolo,
>=20
> Have you queued this patch?

No, I thought Gerd would.  Queued now.

Paolo

> 2017-02-21 16:32 GMT+08:00 Marc-Andr=C3=A9 Lureau <mlureau@redhat.com
> <mailto:mlureau@redhat.com>>:
>=20
>     Hi
>=20
>     ----- Original Message -----
>     > In 'qemu_chr_open_spice_vmc' if the 'psubtype' is NULL, it will
>     > call 'char_spice_finalize'. But as the SpiceChardev is not insert=
ed
>     > in the 'spice_chars' list, the 'QLIST_REMOVE' will cause a segfau=
lt.
>     > Add a detect to avoid it.
>     >
>     > Signed-off-by: Li Qiang <liqiang6-s@360.cn <mailto:liqiang6-s@360=
.cn>>
>=20
>     Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com
>     <mailto:marcandre.lureau@redhat.com>>
>=20
>     > ---
>     >  spice-qemu-char.c | 5 ++++-
>     >  1 file changed, 4 insertions(+), 1 deletion(-)
>     >
>     > diff --git a/spice-qemu-char.c b/spice-qemu-char.c
>     > index 6f46f46..4d1c76e 100644
>     > --- a/spice-qemu-char.c
>     > +++ b/spice-qemu-char.c
>     > @@ -215,7 +215,10 @@ static void char_spice_finalize(Object *obj)
>     >      SpiceChardev *s =3D SPICE_CHARDEV(obj);
>     >
>     >      vmc_unregister_interface(s);
>     > -    QLIST_REMOVE(s, next);
>     > +
>     > +    if (s->next.le_prev) {
>     > +        QLIST_REMOVE(s, next);
>     > +    }
>     >
>     >      g_free((char *)s->sin.subtype);
>     >  #if SPICE_SERVER_VERSION >=3D 0x000c02
>     > --
>     > 1.8.3.1
>     >
>     >
>=20
>=20

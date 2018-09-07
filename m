Received: from eggs.gnu.org ([2001:4830:134:3::10]:37513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fyC93-0004KP-RV
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 04:29:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fyC93-0001Sc-3m
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 04:29:37 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43133)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fyC92-0001S1-Sp
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 04:29:37 -0400
Received: by mail-wr1-x443.google.com with SMTP id k5-v6so14037763wre.10
	for <qemu-devel@nongnu.org>; Fri, 07 Sep 2018 01:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180907075948.26917-1-marcandre.lureau@redhat.com>
	<20180907075948.26917-3-marcandre.lureau@redhat.com>
	<fbd32e27-eaa3-5ef0-c6ec-926577a14d56@redhat.com>
In-Reply-To: <fbd32e27-eaa3-5ef0-c6ec-926577a14d56@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 7 Sep 2018 12:29:23 +0400
Message-ID: <CAJ+F1CJz=_Hfaw0wh+kCGzdF4LKD9SC2Fes70OEzzJBJvBDnhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/12] cutils: add qemu_pstrcmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>

Hi

On Fri, Sep 7, 2018 at 12:26 PM Thomas Huth <thuth@redhat.com> wrote:
>
> On 2018-09-07 09:59, Marc-Andr=C3=A9 Lureau wrote:
> > A char** variant of strcmp().
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  include/qemu/cutils.h | 12 ++++++++++++
> >  util/cutils.c         |  5 +++++
> >  2 files changed, 17 insertions(+)
> >
> > diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> > index 47aaa3b0b9..0941639f36 100644
> > --- a/include/qemu/cutils.h
> > +++ b/include/qemu/cutils.h
> > @@ -169,4 +169,16 @@ bool test_buffer_is_zero_next_accel(void);
> >  int uleb128_encode_small(uint8_t *out, uint32_t n);
> >  int uleb128_decode_small(const uint8_t *in, uint32_t *n);
> >
> > +/**
> > + * qemu_pstrcmp:
> > + * @str1: a pointer to a C string
> > + * @str2: a pointer to a C string
> > + *
> > + * Compares *str1 and *str2 with g_strcmp0().
> > + *
> > + * Returns: an integer less than, equal to, or greater than zero, if
> > + * *str1 is <, =3D=3D or > than *str2 .
> > + */
>
> Maybe add a comment that str1 or str2 can also be NULL?

*str1 or *str2 (not str1 or str2). ok

>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>


--=20
Marc-Andr=C3=A9 Lureau

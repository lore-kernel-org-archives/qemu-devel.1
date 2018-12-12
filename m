Received: from eggs.gnu.org ([2001:4830:134:3::10]:56053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gX90Y-0002jH-JL
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 13:13:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gX90W-00085x-Ns
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 13:13:18 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gX90V-000847-WF
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 13:13:16 -0500
Received: by mail-wm1-x343.google.com with SMTP id n190so6776688wmd.0
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 10:13:14 -0800 (PST)
MIME-Version: 1.0
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
	<87va3yfytv.fsf@dusky.pond.sub.org>
In-Reply-To: <87va3yfytv.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 12 Dec 2018 22:13:01 +0400
Message-ID: <CAJ+F1CJ-=Nk5_PDT5u+Jv3+8Yecu7GFrBCih-tnMvNnqvWxQnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v7 00/27] Hi,
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Wed, Dec 12, 2018 at 9:18 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > This is the second part of the "add #if pre-processor conditions to
> > generated code" series, adding schema member conditions (roughly
> > 16-38/49).
> >
> > Members can be exploded as dictionnary with 'type'/'if' keys:
> >
> > { 'struct': 'TestIfStruct', 'data':
> >   { 'foo': 'int',
> >     'bar': { 'type': 'int', 'if': 'defined(TEST_IF_STRUCT_BAR)'} } }
> >
> > Enum values can be exploded as dictionnary with 'type'/'if' keys:
> >
> > { 'enum': 'TestIfEnum', 'data':
> >   [ 'foo',
> >     { 'name' : 'bar', 'if': 'defined(TEST_IF_ENUM_BAR)' } ] }
>
> PATCH 03,18,20,25 are only losely related to this second part.  They are
> also ready.  Queued on branch qapi-next in my public repository, with
> PATCH 18 and 20 squashed together.
>
> I took the liberty to implement the the idea on normalization I
> mentioned in review of PATCH 08.  I also squashed a few patches that are
> essentially fixups into the patches they fix.  I did not address any
> other review comments.  Result is on branch qapi-if-2.  Please have a
> look.
>

Looks good to me.  Is there something left to rework from this branch
or it is good to go?
thanks

--=20
Marc-Andr=C3=A9 Lureau

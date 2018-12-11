Received: from eggs.gnu.org ([2001:4830:134:3::10]:52810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gWgpq-000694-Gt
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 07:08:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gWgpp-0007H6-P3
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 07:08:22 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gWgpp-0007GW-HB
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 07:08:21 -0500
Received: by mail-wr1-x441.google.com with SMTP id t27so13808961wra.6
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 04:08:21 -0800 (PST)
MIME-Version: 1.0
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
	<20181208111606.8505-18-marcandre.lureau@redhat.com>
	<87o99ss1y5.fsf@dusky.pond.sub.org>
In-Reply-To: <87o99ss1y5.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 11 Dec 2018 16:08:08 +0400
Message-ID: <CAJ+F1CL_y7S3Kq1VXNPBxFq3GqWYiKn7ALR3SesGm+NMd37JOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v7 17/27] qapi: simplify
 make_enum_members()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi

On Tue, Dec 11, 2018 at 4:06 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > The function only receives the dictionary form of enum expressions
> > now, so we can make it shorter.
> >
> > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  scripts/qapi/common.py | 11 +----------
> >  1 file changed, 1 insertion(+), 10 deletions(-)
> >
> > diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> > index fd622313cb..44020779dd 100644
> > --- a/scripts/qapi/common.py
> > +++ b/scripts/qapi/common.py
> > @@ -1714,16 +1714,7 @@ class QAPISchema(object):
> >                                              qtype_values, 'QTYPE'))
> >
> >      def _make_enum_members(self, values):
> > -        enum =3D []
> > -        for v in values:
> > -            if isinstance(v, dict):
> > -                name =3D v['name']
> > -                ifcond =3D v.get('if')
> > -            else:
> > -                name =3D v
> > -                ifcond =3D None
> > -            enum.append(QAPISchemaMember(name, ifcond))
> > -        return enum
> > +        return [QAPISchemaMember(v['name'], v.get('if')) for v in valu=
es]
> >
> >      def _make_implicit_enum_type(self, name, info, ifcond, values):
> >          # See also QAPISchemaObjectTypeMember._pretty_owner()
>
> We may want to squash this one into PATCH 08 as mentioned in that
> patch's review.
>
> In case we don't:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>

Feel free to squash on commit, thanks

--=20
Marc-Andr=C3=A9 Lureau

Received: from eggs.gnu.org ([2001:4830:134:3::10]:60639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gVaeZ-0008VJ-0R
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:20:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gVaeY-0005F6-3v
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:20:10 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33487)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gVaeX-0005Eq-Vi
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:20:10 -0500
Received: by mail-qt1-f193.google.com with SMTP id l11so7459981qtp.0
	for <qemu-devel@nongnu.org>; Sat, 08 Dec 2018 03:20:09 -0800 (PST)
MIME-Version: 1.0
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
	<20180706105753.26700-23-marcandre.lureau@redhat.com>
	<877egm8quh.fsf@dusky.pond.sub.org>
In-Reply-To: <877egm8quh.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 8 Dec 2018 15:19:57 +0400
Message-ID: <CAMxuvay4kax62=H=oFdaSi_jJhbogME4W_rUV3XNAY3jssW+TQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 22/27] docs: document schema
 configuration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Armbruster, Markus" <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Thu, Dec 6, 2018 at 10:14 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  docs/devel/qapi-code-gen.txt | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.tx=
t
> > index c2e11465f0..799aef7728 100644
> > --- a/docs/devel/qapi-code-gen.txt
> > +++ b/docs/devel/qapi-code-gen.txt
> > @@ -752,6 +752,25 @@ gets its generated code guarded like this:
> >   #endif /* defined(HAVE_BAR) */
> >   #endif /* defined(CONFIG_FOO) */
> >
> > +Where a member can be defined with a single string value for its type,
> > +it is also possible to supply a dictionary instead with both 'type'
> > +and 'if' keys.
> > +
> > +Example: a conditional 'bar' member
> > +
> > +{ 'struct': 'IfStruct', 'data':
> > +  { 'foo': 'int',
> > +    'bar': { 'type': 'int', 'if': 'defined(IFCOND)'} } }
> > +
> > +An enum value can be replaced by a dictionary with a 'name' and a 'if'
> > +key.
> > +
> > +Example: a conditional 'bar' enum member.
> > +
> > +{ 'enum': 'IfEnum', 'data':
> > +  [ 'foo',
> > +    { 'name' : 'bar', 'if': 'defined(IFCOND)' } ] }
> > +
> >  Please note that you are responsible to ensure that the C code will
> >  compile with an arbitrary combination of conditions, since the
> >  generators are unable to check it at this point.
>
> I'd prefer to update qapi-code-gen.txt right when we extend the schema
> language, like you did in part 1 (commit 967c885108f qapi: add 'if' to
> top-level expressions).  I understand it's a bit more churn, since you
> need four steps (enum, struct, union, alternate members).  I think the
> following would be the least work for you that still satisfies me:
>
> * Add the part about enum values in PATCH 13.
>
> * Add the rest in PATCH 17 (the first patch that implements a part of
>   it), with a TODO implement <list of things that get done in later
>   patches>.  Then just update the TODO as you go.
>
> Okay?

Easy enough, done.

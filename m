Received: from eggs.gnu.org ([2001:4830:134:3::10]:45830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gUChC-0005h1-Fd
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:33:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gUCh7-0000KB-A9
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:33:10 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gUCh7-0000Jh-2g
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:33:05 -0500
Received: by mail-qk1-f194.google.com with SMTP id n12so9824919qkh.11
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 07:33:05 -0800 (PST)
MIME-Version: 1.0
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
	<20180706105753.26700-6-marcandre.lureau@redhat.com>
	<877egpwc1z.fsf@dusky.pond.sub.org>
In-Reply-To: <877egpwc1z.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 4 Dec 2018 19:32:52 +0400
Message-ID: <CAMxuvaxCAXHDXvDSH9rsWxU12CLGmVpCJD+M_bWFuMUMJx8ZQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 05/27] qapi: include osdep.h in type
 headers
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

Hi

On Tue, Dec 4, 2018 at 7:23 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Now that the schema can be configured, it is crucial that all types
> > are configured the same. Make sure config-host.h is included, so
> > build-sys tracks the dependency and rebuilds the types, by including
> > osdep.h first.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  scripts/qapi/types.py | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
> > index fd7808103c..91f87d0b8f 100644
> > --- a/scripts/qapi/types.py
> > +++ b/scripts/qapi/types.py
> > @@ -201,6 +201,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVi=
sitor):
> >  ''',
> >                                        types=3Dtypes, visit=3Dvisit))
> >          self._genh.preamble_add(mcgen('''
> > +#include "qemu/osdep.h"
> >  #include "qapi/qapi-builtin-types.h"
> >  '''))
>
> No.  Every .c must include qemu/osdep.h first.  No .h may include it.
> We clean this up periodically.  scripts/clean-includes can help with
> that.  We currently have a few offenders in the tree.

Ok, I don't know the reason an internal header couldn't include osdep,
could you explain?

I think we can replace osdep.h by config-host.h for the same result,
I'd have to check.

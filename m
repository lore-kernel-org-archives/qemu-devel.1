Received: from eggs.gnu.org ([209.51.188.92]:52381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ghxr0-0000rC-OA
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:32:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ghxqz-0002Wv-Tl
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:32:10 -0500
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:52306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ghxqz-0002VN-Nf
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:32:09 -0500
Received: from player779.ha.ovh.net (unknown [10.109.160.232])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 1084CD7719
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 15:32:05 +0100 (CET)
Date: Fri, 11 Jan 2019 15:31:55 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190111153155.71e094ad@bahia.lan>
In-Reply-To: <694664dc-1bb7-0bb8-f44b-23b3175fea09@kaod.org>
References: <1547196148-12250-1-git-send-email-thuth@redhat.com>
	<b1db55de-6741-76c7-33b1-74fc2692b82c@redhat.com>
	<694664dc-1bb7-0bb8-f44b-23b3175fea09@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] HACKING: Clarify the paragraph about
 typedefs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan
	Gilbert" <dgilbert@redhat.com>

On Fri, 11 Jan 2019 13:12:23 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 1/11/19 11:38 AM, Paolo Bonzini wrote:
> > On 11/01/19 09:42, Thomas Huth wrote: =20
> >>  2.3. Typedefs
> >> -Typedefs are used to eliminate the redundant 'struct' keyword.
> >> +Typedefs can be used to eliminate the redundant 'struct' keyword. Thi=
s is
> >> +especially helpful for common types that are used all over the place.=
 Since
> >> +certain C compilers choke on duplicated typedefs, you should avoid th=
em and
> >> +declare a typedef only in one header file. For common types, you can =
use
> >> +"include/qemu/typedefs.h" for example. Note that it is also perfectly=
 fine to
> >> +use forward struct definitions without typedefs for references in hea=
ders
> >> +to avoid the problem with duplicated typedefs.
> >>   =20
> >=20
> > I agree 100% with the wording after "Since".  However, I think the first
> > part should be made stronger, not weaker.
> >=20
> > Typedefs are use to eliminate the redundant 'struct' keyword, since type
> > names have a different style than other identifiers ("CamelCase" versus
> > "snake_case").  Each struct should have a CamelCase name and a
> > corresponding typedef.
> >=20
> > Since certain C compilers choke on duplicated typedefs, you should avoid
> > them and declare a typedef only in one header file.  For common types,
> > you can use "include/qemu/typedefs.h" for example.  However, as a metter
> > of convenience it is also perfectly fine to use forward struct
> > definitions instead of typedefs in headers and function prototypes; this
> > avoids problems with duplicated typedefs and reduces the need to include
> > headers from other headers. =20
>=20
> I suppose this is difficult to check with checkpatch ? It's easy to
> cross the border as I have proven many times.=20

With Thomas's series merged, a simple build with clang will catch the
duplicated typedefs. Not sure it is worth the pain to teach checkpatch.

> =20
> > And, I would move it to CODING_STYLE since we are at it. :) =20
>=20
> yes.
>=20
> C.
>=20

Received: from eggs.gnu.org ([2001:4830:134:3::10]:50360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cQXTd-0003qb-CW
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 05:46:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cQXTX-0000A8-U4
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 05:46:57 -0500
Received: from mx4-phx2.redhat.com ([209.132.183.25]:56781)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cQXTX-000097-Lj
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 05:46:51 -0500
Date: Mon, 9 Jan 2017 05:46:49 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <831913828.4083117.1483958809541.JavaMail.zimbra@redhat.com>
In-Reply-To: <87fulfkmbw.fsf@dusky.pond.sub.org>
References: <20161206141343.28044-1-marcandre.lureau@redhat.com>
	<87fulfkmbw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 00/17] qapi doc generation (whole
 version, squashed)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

Hi

----- Original Message -----
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
> > Add a qapi2texi script to generate the documentation from the qapi
> > schemas.
> >
> > The SQUASHED patch in this series is a squashed version of the
> > documentation move from qmp-commands.txt to the schemas. The whole
> > version (not sent on the ML to avoid spamming) is in the following git
> > branch: https://github.com/elmarco/qemu/commits/qapi-doc
> >
> > PDF preview:
> > https://fedorapeople.org/~elmarco/qemu-qmp-ref.pdf
> >
> > v6:
> > - rebased on top of armbru/qapi-next branch
> > - add a few patches to improve Exception subclasses and usage in
> >   qapi.py as suggested during review
> > - parser and generator fixes and improvements after v5 review:
> >   - various union improvements, hopefully with a better syntax
> >   - improve error messages
> >   - improve docs/qapi-code-gen.txt documentation section
> >   - do not allow interleaved body documentation between sections
> >   - more tests for new cases
> >   - make expression documentation mandatory, fix the tests
> >   - replace bad usage of @var{} with @t{} in texi, fix texi2pod to
> >     handle it
> >   - renaming, reordering etc..
> > - add docs/qapi-syntax.texi to describe the API syntax used in the
> >   texi documentation
> > - fix interleaved body and section documentation
> > - improve documentation sections name
> > - many build-sys improvements after review
> > - fix and improve commit messages, update R-b tags
>=20
> There's quite some new material in v6.  How can we converge on something
> mergable quickly?  Let me review my review.
>=20
> PATCH 01-04,06,12-16 are ready with minor tweaks here and there.
>=20
> PATCH 17 "build-sys: add qapi doc generation targets" is almost ready:
> one a simple question left.
>=20
> PATCH 07 should be dropped.  The idea it implements is mine, but it's a
> bad one %-)
>=20
> PATCH 09 "texi2pod: learn quotation, deftp and deftypefn" still needs
> review, but is probably just fine, so let's not worry about it.
>=20
> PATCH 10 "json: reorder documentation body" looks problematic.  Can we
> postpone it?
>=20
> PATCH 11 "(SQUASHED) move doc to schema" could use double-checking, but
> only when we're ready to commit it.  Let's not worry about it.
>=20
> PATCH 05 "docs: add master qapi texi files" has major documentation
> improvements since v5, which are not ready.  Besides issues with the
> documentation, there are issues with what's being documented.  To
> converge on this one, we also need to converge on PATCH 08.
>=20
> PATCH 08 "qapi: add qapi2texi script" is the core of the matter.  I
> proposed a bunch of FIXME comments, minor tweaks and fixes.  A few more
> issues are still open, but we should be able to address them with only
> minor churn.
>=20

ok

> There's one feature that I feel takes us in the wrong direction: the
> invention of a formal language to describe QAPI definitions from the
> user's point of view.  I doubt this language is necessary.  Both the
> language and its documentation in PATCH 05 have numerous issues, and
> this is a major reason for PATCH 05 not being ready.
>=20
> I'm proposing to rip out this part for now, along with all of the new
> documentation (revert to PATCH 05 v5).  Not ideal, because the series
> then regresses QMP documentation (JSON type information lost), and
> leaves the new, doc comment requirements and features undocumented.  So
> add suitable FIXMEs, and make updating the documentation a priority.
> Once that's done, we can discuss how to add back type information, and
> what to do about the proposed formal language.
>=20
> Does this sound like a sensible plan?

I'd rather have type information. The syntax I use in the doc (introduced s=
ince first RFC btw) should be natural to a programmer. But more importantly=
, I would rather move on with the series, so I am ready to take compromises=
 and postpone it.

Regarding ordering of sections: imho it would be best if body/args/notes co=
uld be read or written in any order. Programmers don't read API doc like bo=
oks, they often jump directly to various args/sections. API doc writer shou=
ld be aware about such reading, or the tooling/IDE that may show it in diff=
erent ways. This is common to various API doc format and tools. Nevertheles=
s, PATCH 10 shows some of our doc has been written to be read in a certain =
order, and would need to be improved to be read out of order without confus=
ion. Since that would delay again this series, I'll follow your suggestion =
for now, drop patch 10, and keep original ordering (not completely though: =
parser/generator in v7 will have body then args then additional sections, b=
ut the end results should be the same, additional sections after args will =
be untitled/anonymous. support interleaving args with other sections would =
not be a great idea imho)

I am working on v7, stay tuned :)

thanks

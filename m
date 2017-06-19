Received: from eggs.gnu.org ([2001:4830:134:3::10]:43973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dMuLm-0007jn-Me
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:56:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dMuLi-0002UY-5t
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:56:06 -0400
Date: Mon, 19 Jun 2017 12:55:47 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170619105547.bkjv3hrc7epvqqow@eukaryote>
References: <1497624690-1156-2-git-send-email-kchamart@redhat.com>
	<1497627680.3289.1.camel@that.guru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1497627680.3289.1.camel@that.guru>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] live-block-ops.txt: Rename, rewrite,
 and improve it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephen Finucane <stephen@that.guru>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org

On Fri, Jun 16, 2017 at 04:41:20PM +0100, Stephen Finucane wrote:
> On Fri, 2017-06-16 at 16:51 +0200, Kashyap Chamarthy wrote:

[...]

> As requested, a couple of rST pointers below that will help you if/when=
 you
> switch to Sphinx. I've only focused on the design aspect, not the conte=
nt.

Thanks for the Sphinx / rST review.  Eric Blake is reviewing the
content, and probably others will chime in, too.

[...]

> > +Copyright (C) 2017 Red Hat Inc.
> > +
> > +This work is licensed under the terms of the GNU GPL, version 2 or
> > +later.=A0=A0See the COPYING file in the top-level directory.
> > +
> > +---
> > +
>=20
> This information doesn't need to be output in the web version, IMO. If =
write it
> like a comment, it will only be visible in the source. See what we do i=
n OVS
> docs [1] for an example.
>=20
> [1] https://raw.githubusercontent.com/openvswitch/ovs/master/Documentat=
ion/index.rst

Yep, that's useful.  Fixed in v3.

[...]

> > +NB: The file ``qapi/block-core.json`` in the QEMU source tree has th=
e
> > +canonical QEMU API (QAPI) schema documentation for the QMP primitive=
s
> > +discussed here.
> > +
>=20
> You might consider using admonitions here and elsewhere. This would mak=
e sense
> as a 'note' or 'important' directive:
>=20
>   .. note::
>=20
>       The file ``qapi/block-core.json`` ...

Yes, done.

> > +
> > +.. contents::
>=20
> This can probably go if/when Sphinx is integrated - Sphinx includes a T=
oC in
> the sidebar by default. Perhaps include a TODO to remove this?
>=20
>   .. TODO(kashyap): Remove this when Sphinx is integrated

Useful, done.

[...]

> > +(1) Directional: 'base' and 'top'.=A0=A0Given the simple disk image =
chain
> > +=A0=A0=A0=A0above, image [A] can be referred to as 'base', and image=
 [B] as
> > +=A0=A0=A0=A0'top'.=A0=A0(This terminology can be seen in in QAPI sch=
ema file,
> > +=A0=A0=A0=A0block-core.json.)
>=20
> This looks really like a definition list, which is rST are written like=
 so:
>=20
>   term
>=20
>     Detailed description of the term here...
>=20
> So this would become:
>=20
>   Directional
>=20
>     'base' and 'top'. Given...

Yeah, I tried it, but it's just creating needless blank lines for me in
the HTML rendering.  So I stuck with using numbers.

[...]

> > +NB: The base disk image can be raw format; however, all the overlay
> > +files must be of QCOW2 format.
>=20
> .. important::

Yes, noted.

[...]

> > +Brief overview of live block QMP primitives
> > +-------------------------------------------

[...]

> Definition list?

Not quite.  It's more a quick overview.
=20
> > +
> > +
> > +.. _`Interacting with a QEMU instance`:
>=20
> If you're not linking to this, you don't need to include this. The 'con=
tents'
> directive will automatically insert an anchor for each heading.

Yeah, I actually did link to to further below, hence I retained it.

[...]

> > +The ``-blockdev`` command-line option, used above, is available from
> > +QEMU 2.9 onwards.=A0=A0In the above invocation, notice the 'node-nam=
e'
>=20
> ``node-name``?

Yes.

>=20
> > +parameter that is used to refer to the disk image a.qcow2 ('node-A')=
 --
>=20
> ``a.qcow2``?

Perhaps.

[...]

> > +NB: In the event we have to repeat a certain QMP command, we will: f=
or
> > +the first occurrence of it, show the the ``qmp-shell`` invocation,
> > +*and* the corresponding raw JSON QMP syntax; but for subsequent
> > +invocations, present just the ``qmp-shell`` syntax, and omit the
> > +equivalent JSON output.
>=20
> .. important::

Yeah, it's more of a ".. note::", will fix.

[...]

> > +Here, "node-A" is the name QEMU internally uses to refer to the base
> > +image [A] -- it is the backing file, based on which the overlay imag=
e,
> > +[B], is created.
>=20
> I guess you should probably use ``[A]`` here to preserve formatting

Hmm, noted.

[...]

> > +
> > +A note on points-in-time vs file names
> > +--------------------------------------
> > +
> > +In our disk disk image chain:
> > +
> > +::
>=20
> repeated word and no need for ':\n\n::' - you can just use '::'.
>=20
>   In our disk image chain::
>=20
> ditto for the rest of the file

Ah, indeed.  I recall using it in the past, but forgot.  Avoids needless
blank lines.  Will fix throughout.

[...]

> > +
> > +
> > +Live block streaming --- ``block-stream``
> > +-----------------------------------------
> > +
> > +The ``block-stream`` command allows you to do live copy data from ba=
cking
> > +files into overlay images.
> > +
> > +Given our original example disk image chain from earlier:
> > +
> > +::
> > +
> > +=A0=A0=A0=A0[A] <-- [B] <-- [C] <-- [D]
> > +
> > +The disk image chain can be shortened in one of the following differ=
ent
> > +ways (not an exhaustive list).
> > +
>=20
> Maybe you should include an anchor here, so you can link to it below.

Yes, makes sense.  I know by "link to it below", you mean link to it in
the next where I refer to these.

[...]

> > +[The invocation for rest of the cases, discussed in the previous
> > +section, is omitted for brevity.]
>=20
> This looks like a:
>=20
>   .. note::

Yes; will fix.

[...]

--=20
/kashyap

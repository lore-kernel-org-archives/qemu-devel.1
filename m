Received: from eggs.gnu.org ([2001:4830:134:3::10]:39636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eb4MW-0005RN-Vo
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:59:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eb4MT-0000T6-44
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:59:41 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:40548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eb4MS-0000Si-Te
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:59:37 -0500
Received: by mail-wm0-x22a.google.com with SMTP id v123so1790600wmd.5
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 04:59:36 -0800 (PST)
Date: Mon, 15 Jan 2018 12:59:33 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180115125933.GA11737@stefanha-x1.localdomain>
References: <CAJSP0QUMA7v=-qX-CNCi30aoH-HzXC9i75EpLWP_TmFuDzpTQQ@mail.gmail.com>
	<CAKmqyKPk69_d-iYGekoS9WBM1fnzav1iFAQEXQq_jLOW9_Dt3w@mail.gmail.com>
	<CAJSP0QVd70uAiG3vyOjO-qOdt1YbEccYydJvz4igg7_bBiW+5A@mail.gmail.com>
	<CAKmqyKP2cQGXSmPvaGt3AwDz6zewJ6HH=vVTSnk6GVAQAhW5uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <CAKmqyKP2cQGXSmPvaGt3AwDz6zewJ6HH=vVTSnk6GVAQAhW5uA@mail.gmail.com>
Subject: Re: [Qemu-devel] Call for GSoC & Outreachy 2018 mentors & project
 ideas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, Jailhouse <jailhouse-dev@googlegroups.com>


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2018 at 03:25:56PM -0800, Alistair Francis wrote:
> On Wed, Jan 10, 2018 at 4:52 AM, Stefan Hajnoczi <stefanha@gmail.com> wro=
te:
> > On Tue, Jan 9, 2018 at 9:45 PM, Alistair Francis <alistair23@gmail.com>=
 wrote:
> >> Can anyone who has done this before chime in.
> >>
> >> What do you think about getting someone to cleanup and improve the GDB
> >> support in QEMU? Would that be the right difficulty of task for a GSoC
> >> project?
> >
> > There is not enough information to give feedback on whether this
> > project idea is suitable.  What are the specific tasks you'd like the
> > student to work on?
> >
> > In general, I'm sure there are well-defined 12-week project ideas
> > around the GDB stub.  New features are easy to propose and are usually
> > well-defined (e.g. implement these commands that are documented in the
> > GDB protocol documentation).  Cleaning up code is less clear and it
> > would depend on exactly what needs to be done.  Interns will not have
> > a background in the QEMU codebase and may not be able to make
> > judgements about how to structure things, so I would be more careful
> > about refactoring/cleanup projects.
> >
> > Please see my talk about QEMU GSoC for guidelines on project ideas:
> > https://www.youtube.com/watch?v=3DxNVCX7YMUL8&t=3D19m11s
> > http://vmsplice.net/~stefan/stefanha-kvm-forum-2016.pdf
>=20
> That helps a lot, thanks for that.
>=20
> So for a more concrete solution, how would adding support for multi
> CPU support to the GDB server sound?
>=20
> This would allow GDB debugging for the A53 and the R5 on the Xilinx
> ZynqMP for example. This is something we have in the Xilinx tree, but
> it is in no state to go upstream and really needs to be re-write to be
> upstreamable and more generic.

Excellent.  Then they'll already have an idea of "how" it can be
achieved but have the freedom to write code that is most suitable for
upstream.  That is a good starting point for a project.

Here is the project idea template:

=3D=3D=3D TITLE =3D=3D=3D

 '''Summary:''' Short description of the project

 Detailed description of the project.

 '''Links:'''
 * Wiki links to relevant material
 * External links to mailing lists or web sites

 '''Details:'''
 * Skill level: beginner or intermediate or advanced
 * Language: C
 * Mentor: Email address and IRC nick
 * Suggested by: Person who suggested the idea

Once you have written down the project idea, please post it under
Internships/ProjectIdeas/MultiCPUGDBStub and then add it to the
Google_Summer_of_Code_2018 wiki page using the
"{{:Internships/ProjectIdeas/MultiCPUGDBStub}}" inlining syntax.

Or if you prefer, just reply with the project idea to this email and
I'll post it on the wiki for you.

Can you think of a co-mentor who would be willing to participate?  It
makes internships easier when there are multiple mentors - less stress
for mentors, faster communication for students.

Stefan

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaXKW1AAoJEJykq7OBq3PI+10H/1UJxf59fZxm4WaP+4z9s+Bj
yiC+jfo651OjDVjWYWu4z5WaLwugBK/yhAaB035KvRaglYL6Xx7UnnyfIUFREIDB
l1OZE/0gQus3ccAV7U5/wu1iXnI5S2S7SwzOOejqFN9lsz6zXymKEIcwVKt709jQ
YcVFxApJS5rL8th0WB+9CK1MVAZs0DWq3GampVcxXupGYkx4Ob7ixDVI/yUz9mkP
9O1bCgjT4Qz6Oi3PdvDkXbjuOgNGwWoak+uSBTThLZtEN49uPaS3GqyKxV0uoscu
aMXZOXDGq6zqZN8mJYm5pSHFH7dpJ/bG2wjsDfP8M6K6+/Vqw2yJ/sVI9Mf+cDs=
=88XH
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--

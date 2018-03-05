Received: from eggs.gnu.org ([2001:4830:134:3::10]:43255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1esm9q-0003Y6-Mf
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 04:11:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1esm9l-0008CX-Ls
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 04:11:46 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:53856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1esm9l-0008C6-5I
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 04:11:41 -0500
Received: by mail-wm0-x232.google.com with SMTP id t74so14328860wme.3
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 01:11:40 -0800 (PST)
Date: Mon, 5 Mar 2018 09:11:37 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180305091137.GA7910@stefanha-x1.localdomain>
References: <CAJSP0QUMA7v=-qX-CNCi30aoH-HzXC9i75EpLWP_TmFuDzpTQQ@mail.gmail.com>
	<CAKmqyKPk69_d-iYGekoS9WBM1fnzav1iFAQEXQq_jLOW9_Dt3w@mail.gmail.com>
	<CAJSP0QVd70uAiG3vyOjO-qOdt1YbEccYydJvz4igg7_bBiW+5A@mail.gmail.com>
	<CAKmqyKP2cQGXSmPvaGt3AwDz6zewJ6HH=vVTSnk6GVAQAhW5uA@mail.gmail.com>
	<20180115125933.GA11737@stefanha-x1.localdomain>
	<CAKmqyKMoqyyr2oBWyEarZhxxBS+F_=zCJARdVvpFkyPv+L3xJQ@mail.gmail.com>
	<768cc6c1-bc98-413e-0362-080b4c22fa00@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <768cc6c1-bc98-413e-0362-080b4c22fa00@amsat.org>
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
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair23@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, Jailhouse <jailhouse-dev@googlegroups.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philippe@mathieu-daude.net>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2018 at 08:54:11PM -0300, Philippe Mathieu-Daud=E9 wrote:
> On 02/14/2018 04:00 PM, Alistair Francis wrote:
> > On Mon, Jan 15, 2018 at 4:59 AM, Stefan Hajnoczi <stefanha@gmail.com> w=
rote:
> >> On Thu, Jan 11, 2018 at 03:25:56PM -0800, Alistair Francis wrote:
> >>> On Wed, Jan 10, 2018 at 4:52 AM, Stefan Hajnoczi <stefanha@gmail.com>=
 wrote:
> >>>> On Tue, Jan 9, 2018 at 9:45 PM, Alistair Francis <alistair23@gmail.c=
om> wrote:
> >>>>> Can anyone who has done this before chime in.
> >>>>>
> >>>>> What do you think about getting someone to cleanup and improve the =
GDB
> >>>>> support in QEMU? Would that be the right difficulty of task for a G=
SoC
> >>>>> project?
> >>>>
> >>>> There is not enough information to give feedback on whether this
> >>>> project idea is suitable.  What are the specific tasks you'd like the
> >>>> student to work on?
> >>>>
> >>>> In general, I'm sure there are well-defined 12-week project ideas
> >>>> around the GDB stub.  New features are easy to propose and are usual=
ly
> >>>> well-defined (e.g. implement these commands that are documented in t=
he
> >>>> GDB protocol documentation).  Cleaning up code is less clear and it
> >>>> would depend on exactly what needs to be done.  Interns will not have
> >>>> a background in the QEMU codebase and may not be able to make
> >>>> judgements about how to structure things, so I would be more careful
> >>>> about refactoring/cleanup projects.
> >>>>
> >>>> Please see my talk about QEMU GSoC for guidelines on project ideas:
> >>>> https://www.youtube.com/watch?v=3DxNVCX7YMUL8&t=3D19m11s
> >>>> http://vmsplice.net/~stefan/stefanha-kvm-forum-2016.pdf
> >>>
> >>> That helps a lot, thanks for that.
> >>>
> >>> So for a more concrete solution, how would adding support for multi
> >>> CPU support to the GDB server sound?
> >>>
> >>> This would allow GDB debugging for the A53 and the R5 on the Xilinx
> >>> ZynqMP for example. This is something we have in the Xilinx tree, but
> >>> it is in no state to go upstream and really needs to be re-write to be
> >>> upstreamable and more generic.
> >>
> >> Excellent.  Then they'll already have an idea of "how" it can be
> >> achieved but have the freedom to write code that is most suitable for
> >> upstream.  That is a good starting point for a project.
> >>
> >> Here is the project idea template:
> >>
> >> =3D=3D=3D TITLE =3D=3D=3D
> >>
> >>  '''Summary:''' Short description of the project
> >>
> >>  Detailed description of the project.
> >>
> >>  '''Links:'''
> >>  * Wiki links to relevant material
> >>  * External links to mailing lists or web sites
> >>
> >>  '''Details:'''
> >>  * Skill level: beginner or intermediate or advanced
> >>  * Language: C
> >>  * Mentor: Email address and IRC nick
> >>  * Suggested by: Person who suggested the idea
> >>
> >> Once you have written down the project idea, please post it under
> >> Internships/ProjectIdeas/MultiCPUGDBStub and then add it to the
> >> Google_Summer_of_Code_2018 wiki page using the
> >> "{{:Internships/ProjectIdeas/MultiCPUGDBStub}}" inlining syntax.
> >>
> >> Or if you prefer, just reply with the project idea to this email and
> >> I'll post it on the wiki for you.
> >>
> >> Can you think of a co-mentor who would be willing to participate?  It
> >> makes internships easier when there are multiple mentors - less stress
> >> for mentors, faster communication for students.
> >=20
> > Yep, here is my proposal. I don't have wiki access, so I can't add it m=
yself.
> >=20
> > I think Philippe would be a good co-mentor, if he is happy to. I am
> > also welcome to mentor other ideas, it doesn't have to be this one.
>=20
> I'm very happy to co-mentor with Alistair, I can manage at least 2h/w on =
it.

I've added you to the wiki page.

BTW, if you and Alistair don't have wiki accounts yet, let me know and
I'll set it up for you.

Stefan

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJanQnJAAoJEJykq7OBq3PIF9oH/iIBSd5XS0mRCsrlmDEVN+sR
DTeyF1O3eQU0Gj5eCc+PLYd9n62xdS+CGBK4N0EXOAquPb5w7Mkawa0CeXwZIZ8A
Fn/TXwAU/OZFbuRSZiOQ//+SZFtyKrfNtAyUxhSvHsWiA1cP6ruN4DUkKkksqVwU
JKL2BeF7EO8U0YcHIRbv3+3Jt6Y3xIXKpB+7dbs50FBsvuLHHa4OFFJEdqdxT00v
kmcVszpnOxB7WFH+0Q6Q59TPuHbU9zNnUxdRvNlS/GbgR5qU+7AXjYGwWbOlQ+AO
AZcPbTBgEclzb4vw9BNBl7inBZ41Yjo5hwyIux24hZmtNODGo0tcmJfcjFj6yS4=
=3Akl
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--

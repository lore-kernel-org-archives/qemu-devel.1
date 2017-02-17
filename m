Received: from eggs.gnu.org ([2001:4830:134:3::10]:38881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cemAE-0004B3-Vy
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 12:17:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cemAB-00025z-Qb
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 12:17:46 -0500
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
	<1933406e-2576-e687-3545-a72f3b999310@redhat.com>
	<bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
	<CABHMSTUsZy0u4b1b84YC5CgafKvD-Zms5dCQ=31+XnQphUQxLA@mail.gmail.com>
	<20170217064327.GB21716@lemon.lan>
	<CAFEAcA8_f8SVX+rirAFBJ76ZiXaKUwh9uO0AeBFoR7G_q8pGDg@mail.gmail.com>
	<6ab86cf8-4780-ca76-f648-ac0ce211e27b@redhat.com>
	<CABHMSTWN2KdAXDjEEbyWio6rNM2FuDk_NUj40mFW0HdyZFu68g@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fc3b6729-6739-5daf-5e78-85fbd7d3260d@redhat.com>
Date: Fri, 17 Feb 2017 11:17:40 -0600
MIME-Version: 1.0
In-Reply-To: <CABHMSTWN2KdAXDjEEbyWio6rNM2FuDk_NUj40mFW0HdyZFu68g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0U4VR2gX3DMpBJB9xTH9xfkxNNquM32bA"
Subject: Re: [Qemu-devel] Fix build break during configuration on musl-libc
 based Linux systems.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chad Joan <chadjoan@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0U4VR2gX3DMpBJB9xTH9xfkxNNquM32bA
From: Eric Blake <eblake@redhat.com>
To: Chad Joan <chadjoan@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <fc3b6729-6739-5daf-5e78-85fbd7d3260d@redhat.com>
Subject: Re: [Qemu-devel] Fix build break during configuration on musl-libc
 based Linux systems.
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
 <1933406e-2576-e687-3545-a72f3b999310@redhat.com>
 <bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
 <CABHMSTUsZy0u4b1b84YC5CgafKvD-Zms5dCQ=31+XnQphUQxLA@mail.gmail.com>
 <20170217064327.GB21716@lemon.lan>
 <CAFEAcA8_f8SVX+rirAFBJ76ZiXaKUwh9uO0AeBFoR7G_q8pGDg@mail.gmail.com>
 <6ab86cf8-4780-ca76-f648-ac0ce211e27b@redhat.com>
 <CABHMSTWN2KdAXDjEEbyWio6rNM2FuDk_NUj40mFW0HdyZFu68g@mail.gmail.com>
In-Reply-To: <CABHMSTWN2KdAXDjEEbyWio6rNM2FuDk_NUj40mFW0HdyZFu68g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/17/2017 10:54 AM, Chad Joan wrote:
> Wow, that is some quick turn-around.  Well done!
>=20
> My thoughts:
>=20
>    - I find this summary info very helpful!  On behalf of the N people
>    trying to heal paper cuts: thank you!
>    - I still recommend an example snippet for shell/bash interaction th=
at
>    demonstrates the workflow you expect from a first-time contributor. =
 It
>    should be populated with commonly used values (ex: mailing list
>    addresses).  I don't expect this to happen fast like the summary inf=
o; I
>    suspect someone is going to have to pretend they are submitting a pa=
tch,
>    write down what they do, and then think about how to present this.

For a quickie patch, I make my edits, then 'git commit -a -s' and 'git
send-email -1' - but that works because I've already set up git hooks to
auto-cc the list, and I already debugged my 'get send-email' setup years
ago.  So yeah, doing it from a completely virgin environment could
benefit from a complete command line that reproduces what I take for
granted in my normal environment.  And some email setups are a lot
friendlier than others (I personally do not use gmail, but will readily
admit that it is probably a lot easier to set up my work emails to use
Red Hat's SMTP servers than it is for a gmail contributor to get their
email setup working in a way that does not mangle patches).

>    - Regarding the signature: IIRC, setting up certificates on a machin=
e
>    using gpg can be quite time consuming and learning-intensive if you'=
ve
>    never needed to do it before.

But nothing requires you to set up a certificate to submit a patch.  I'm
not sure which piece of the documentation got you steered in that
direction, but gpg signing of patches is only required of maintainers,
not contributors (or maybe you're hinting at the extra effort required
to set up gmail as a valid 'git send-email' target, to which I have no
experience, but which starts to leave the realm of qemu-specific
instructions into something where it would be better to link to a good
git setup tutorial, if one exists).

>  Having that example will go a long way to
>    help with this.

<snip lots of useful ideas for improvement>

>    - I should also mention that I found the rest of the document to be =
very
>    well-written.  It's comprehensiveness became its weakness, but that'=
s still
>    important long-term, hence why I think an alternative path with a sh=
ort
>    example for trivial patches is plenty sufficient: from my perspectiv=
e,
>    there's no need to change the rest of the text; it is already good :=
).

Thanks for that feedback.  It's often hard for a core contributor to
remember what it was like to submit their first patch years ago, and
having a fresh take on the matter from a new contributor is well worth
the reminders.  It's also nice to hear this as a compliment, and not
just a complaint.

>=20
> Note that I'm bothering to stick around and provide feedback, despite o=
ther
> pressing life obligations.  Providing advice on submit-a-patch usabilit=
y
> for QEMU isn't on my schedule, but I don't have the heart to bail on th=
is,
> especially when you all are kindly listening, having high quality
> discussion, and sincerely trying to improve things.  If you read betwee=
n
> the lines, you see the truth: I am a yak shaver!

At the risk of pushing too hard, you could always turn your (good!)
suggestions into concrete wording, or even request a wiki account to
make the changes yourself. But even if that is beyond your planned level
of involvement, I do hope that various readers will be able to act on
the suggestions in this mail to improve things.

>=20
> Oh man, when I hit a topic like "use git send-email", the hair started
> flying: learning new git commands, two-factor auth on gmail, U2F keys,
> governance for the no-mans-land of a server, and so on, a real yak-shav=
ing
> party.  After an hour or two, my safety triggered, and I thought, "man,=
 I
> am spending way too much time perfecting this workflow that I might nev=
er
> do again" and I spent a few minutes writing a message in gmail.  I
> certainly don't expect QEMU devs to fix garbled patches either: that al=
so
> seems like a huge waste of valuable time (and for talented and passiona=
te
> individuals, too).  There has to be a better way!  So I hope the whitel=
ist
> idea helps, or maybe it's enough to just call awareness to this potenti=
al
> improvement.

Again, part of the problem may be that gmail is not really suited to the
ideal patch flow, and so that's going to be a pain point for any such
contributor.  Submitting patches as an attachment is harder than the
inline version you get with 'git send-email', but it is one of those
one-off manual fixups that a maintainer can overlook, as long as it
really is a one-off thing and not a repeated pattern.  And yes, we
should document that use of an attachment is the most likely to avoid
mangling the patch if you don't have 'git send-email' working, even if
it is harder for the maintainer to apply such a patch.


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--0U4VR2gX3DMpBJB9xTH9xfkxNNquM32bA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYpzA0AAoJEKeha0olJ0NqhDAH/RDSQejOVvc249OBXo74uckp
ncmQsgqnicHNuwx+AVFWQy5oigDrQTQo7BLFuO/Upn+YfyK2oQvxS3DEW8mVZ+G3
0lQebj/PbKHwi/NU+yq7aoeJlQINVwzzRJpLTX+AjSQyGyd1PRn7mTX4GlDGtMAo
IgVgSQxrJqMLHJtcg4wnuE7IsbDG6vDa4RI15X7a+wywiSHS3IlRdVlCNsklSSwG
gqiMe4ZlEt4RZzq9HmDixTyJ7SckgHInHLe2CEMWVssfNe8AKRpi6W+VJiANnAg6
8FWaFut/uFnbn+hyX4V6t4QOLFU5LNZ/Y0QiNMTaANd2EU3WkSSlsBFzQb0+9Bc=
=3myd
-----END PGP SIGNATURE-----

--0U4VR2gX3DMpBJB9xTH9xfkxNNquM32bA--

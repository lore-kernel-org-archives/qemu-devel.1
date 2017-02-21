Received: from eggs.gnu.org ([2001:4830:134:3::10]:45514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cg0ib-0003nX-7y
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 22:02:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cg0iX-00005F-T3
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 22:02:21 -0500
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
	<1933406e-2576-e687-3545-a72f3b999310@redhat.com>
	<bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
	<CABHMSTUsZy0u4b1b84YC5CgafKvD-Zms5dCQ=31+XnQphUQxLA@mail.gmail.com>
	<20170217064327.GB21716@lemon.lan>
	<CAFEAcA8_f8SVX+rirAFBJ76ZiXaKUwh9uO0AeBFoR7G_q8pGDg@mail.gmail.com>
	<6ab86cf8-4780-ca76-f648-ac0ce211e27b@redhat.com>
	<CABHMSTWN2KdAXDjEEbyWio6rNM2FuDk_NUj40mFW0HdyZFu68g@mail.gmail.com>
	<fc3b6729-6739-5daf-5e78-85fbd7d3260d@redhat.com>
	<CABHMSTUS4Oi5WZt0NcYaOnX9_u8zQeu=CupLVX2LjvD+mTYATg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ac569867-6629-7b56-0bf1-85f15b52f143@redhat.com>
Date: Mon, 20 Feb 2017 21:02:13 -0600
MIME-Version: 1.0
In-Reply-To: <CABHMSTUS4Oi5WZt0NcYaOnX9_u8zQeu=CupLVX2LjvD+mTYATg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bcjAhnL497dBadcqjc6MD1SlReIvekL3d"
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
--bcjAhnL497dBadcqjc6MD1SlReIvekL3d
From: Eric Blake <eblake@redhat.com>
To: Chad Joan <chadjoan@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <ac569867-6629-7b56-0bf1-85f15b52f143@redhat.com>
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
 <fc3b6729-6739-5daf-5e78-85fbd7d3260d@redhat.com>
 <CABHMSTUS4Oi5WZt0NcYaOnX9_u8zQeu=CupLVX2LjvD+mTYATg@mail.gmail.com>
In-Reply-To: <CABHMSTUS4Oi5WZt0NcYaOnX9_u8zQeu=CupLVX2LjvD+mTYATg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/19/2017 01:02 AM, Chad Joan wrote:
> development work.  There are no user accounts, just root.  I have tried=
 to
> avoid putting any personal information on it.  If I am on it, then I'm
> editing files in /etc or installing system-wide software.  I'm realizin=
g
> that I might have to change this a bit due to the WIP nature of the
> hardened-musl profile: ultimately I *am* doing development work on it, =
and
> that kind of snuck up on me.  If I give myself a user account, then
> authoring patches with git (and using send-email) becomes somewhat more=

> practical (putting smtp login information onto the machine still bugs m=
e).

You don't have to store your SMTP passwords; git is smart enough to ask
you interactively if you (intentionally) omit the passwords from
=2Egitconfig.  But I agree that even storing your SMTP address and
username in configs can be a bit hairier than you want on some boxes.

> Still, I can't imagine I'm the only person who runs into this kind of t=
hing
> and wants to write quick patches on an impersonal machine.

There's always the option to float the patches back to a personal
machine before posting to the list (yes, it requires more work on your
end, but if it serves as a nice manual wall between your internal and
external machines, it may well be worth the discipline).

>=20
>=20
>> [...]
>>
>> But nothing requires you to set up a certificate to submit a patch.  I=
'm
>> not sure which piece of the documentation got you steered in that
>> direction, but gpg signing of patches is only required of maintainers,=

>> not contributors (or maybe you're hinting at the extra effort required=

>> to set up gmail as a valid 'git send-email' target, to which I have no=

>> experience, but which starts to leave the realm of qemu-specific
>> instructions into something where it would be better to link to a good=

>> git setup tutorial, if one exists).
>>
>>
> I think this is just language ambiguity and confirmation bias doing the=
ir
> thing.  Usually when I read "you have to sign this" in an OSS context, =
I
> think of cryptographic signing.  I haven't encountered the requirement =
for
> non-cryptographic signing before.  Language is arbitrary and we all hav=
e
> different experiences and backgrounds.

Is it sufficient to just give the example of 'git commit -s' being the
trick to automatically adding the necessary Signed-off-by: line?  (Of
course, automating the process like that, without actually reading
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Docum=
entation/SubmittingPatches?id=3Df6f94e2ab1b33f0082ac22d71f66385a60d8157f#=
n297
to understand what it means and that you actually comply, is risky)

>=20
> This is one of the reasons why I suggest a simple example: it would be =
both
> very concise and unambiguous.  If there are no signing steps in the exa=
mple
> then you don't even need to spend words telling the reader that
> cryptographic signing is unnecessary.  It'll be implied.
>=20
> Thankfully, this is a separate concern from the 'git send-email' thing.=


'git send-email -s' can also add Signed-off-by: lines, if you didn't add
them earlier (but only if you use send-email, rather than attachments) :)=


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--bcjAhnL497dBadcqjc6MD1SlReIvekL3d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYq621AAoJEKeha0olJ0NqvvUH/ApRBE4yKX7LEblWguXIU25Y
F+n6JDxqSCSDqeioTFFQJ8+cvPhSo/JLup4j3Q4UKMXhvU4p1Zge7gQ3TXK9BF14
DwwYCIkcB7zwVD6sRJdjkOZKOUGPAdOBUcYe6taLMKBoM0IIRvSLeRCBKd7niKy/
HlzP+OMOQyl6+hXQwFY1yXiE6eIXD8xtRmt0jVaTUCwdYCxRYh8UfH+5ARl0XSSl
DfbylTyw4OOfnfwz0kIq/5mpxUIaq10pvd0FLpk5eSD2cO8V2Dyk5w4qVFHB1nX0
3XJY2BgXjzmZnGcvjzvxiQ3By0/1IY9e3pmEftZPnvAvjhiqgDvSMLcmOvYDdHk=
=ojxP
-----END PGP SIGNATURE-----

--bcjAhnL497dBadcqjc6MD1SlReIvekL3d--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:59064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1co73z-0001fU-Bp
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1co73w-0001FD-39
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:25:55 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:56031)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1co73v-0001DX-Nj
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:25:52 -0400
References: <87tw6y8bs8.fsf@secure.mitica>
	<CAFEAcA978SJemCfYJPa8jwtuhhi6JGh9pEDGYNJ1npJA3nvEQA@mail.gmail.com>
	<20170314081312.GB13140@stefanha-x1.localdomain>
	<CAFEAcA9F2BPexRieaEhu+UpJxoOdEfw8eggW8b2SjuoMMTNgog@mail.gmail.com>
	<87wpbstesf.fsf@secure.mitica>
	<CAFEAcA9nZszkmH7-P9jkxoGxLYHKspDiS-PFUyVZrrtDfgPNMA@mail.gmail.com>
	<20170315112917.7dddc8a4@bahia.lab.toulouse-stg.fr.ibm.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <d354a388-b7ae-09f6-356e-6555d136b5d8@vivier.eu>
Date: Wed, 15 Mar 2017 12:25:38 +0100
MIME-Version: 1.0
In-Reply-To: <20170315112917.7dddc8a4@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="E7THkVJDpplmQXMFg05frgsTMh30HFbpQ"
Subject: Re: [Qemu-devel] KVM call for 2017-03-14
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Juan Quintela <quintela@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developer <qemu-devel@nongnu.org>, KVM devel mailing list <kvm@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E7THkVJDpplmQXMFg05frgsTMh30HFbpQ
From: Laurent Vivier <laurent@vivier.eu>
To: Greg Kurz <groug@kaod.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Juan Quintela <quintela@redhat.com>, Stefan Hajnoczi
 <stefanha@gmail.com>, QEMU Developer <qemu-devel@nongnu.org>,
 KVM devel mailing list <kvm@vger.kernel.org>
Message-ID: <d354a388-b7ae-09f6-356e-6555d136b5d8@vivier.eu>
Subject: Re: [Qemu-devel] KVM call for 2017-03-14
References: <87tw6y8bs8.fsf@secure.mitica>
 <CAFEAcA978SJemCfYJPa8jwtuhhi6JGh9pEDGYNJ1npJA3nvEQA@mail.gmail.com>
 <20170314081312.GB13140@stefanha-x1.localdomain>
 <CAFEAcA9F2BPexRieaEhu+UpJxoOdEfw8eggW8b2SjuoMMTNgog@mail.gmail.com>
 <87wpbstesf.fsf@secure.mitica>
 <CAFEAcA9nZszkmH7-P9jkxoGxLYHKspDiS-PFUyVZrrtDfgPNMA@mail.gmail.com>
 <20170315112917.7dddc8a4@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20170315112917.7dddc8a4@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le 15/03/2017 =C3=A0 11:29, Greg Kurz a =C3=A9crit :
> On Tue, 14 Mar 2017 11:56:36 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
>=20
>> On 14 March 2017 at 09:59, Juan Quintela <quintela@redhat.com> wrote:
>>> Peter Maydell <peter.maydell@linaro.org> wrote: =20
>>>> On 14 March 2017 at 09:13, Stefan Hajnoczi <stefanha@gmail.com> wrot=
e: =20
>>>>> On Mon, Mar 13, 2017 at 11:02:01AM +0100, Peter Maydell wrote:
>>>>> The minimum requirements for the new language:
>>>>> 1. Does it support the host operating systems that QEMU runs on?
>>>>> 2. Does it support the host architectures that QEMU runs on? =20
>>>>
>>>> Speaking of this, I was thinking that we should introduce
>>>> a rule that for any host OS/arch we support we must have
>>>> a build machine so we can at least do a compile test.
>>>> For instance if you believe configure we support Solaris
>>>> and AIX, but I bet they're bit-rotting. The ia64 backend
>>>> has to be a strong candidate for being dumped too.
>>>> Demanding "system we can test on or we drop support"
>>>> would let us more clearly see what we're actually running
>>>> on and avoid unnecessarily ruling things out because they
>>>> don't support Itanium or AIX... =20
>>>
>>> YES, YES and YES.
>>>
>>> I demand an osX build machine NOW!!!!  Remote access is ok. =20
>>
>> OSX is actually in the set that's OK because I have a
>> machine I can test on. The ones that are problems are
>> all the BSDs, AIX, Solaris, Haiku, and architectures
>=20
> The most relevant links I could find about AIX hosts only mention=20
> QEMU 0.9.1:
>=20
> http://www.perzl.org/aix/index.php?n=3DMain.Qemu
> http://www.vivier.eu/Qemu/
>=20
> I'm not aware of any effort within IBM to support newer versions
> of QEMU on an AIX host (Cc'ing Laurent in case he would be aware
> of a non-IBM initiative).
>

At this time it was a personal initiative, made possible because I have
worked at Bull on the port of GNOME to AIX and had access to some Bull
AIX Servers.

Now this effort has been moved to the AIX Toolbox for Linux Applications:=


http://www-03.ibm.com/systems/power/software/aix/linux/

Perhaps you can try to contact someone inside IBM about this toolbox?

Laurent



--E7THkVJDpplmQXMFg05frgsTMh30HFbpQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYySSyAAoJEPMMOL0/L748ZZ8P+wd9B8V6s6LTw21RPIIhzNTa
HlR8gmOs7S5htQluCdsHW9b0VGohkjj/9zIcJgCsMFYeh62xWWj59zVBYi3t5xup
zEe2RdgN5pgQbOgqf9nZ2h9KkBonAnn9ow84EDSMdYPTijCLCkbVz8196JNzdXJI
J3PgoKeyURU/BzUNLyw8mOl8RRRzTci1BZNUqIupA07tlnomI2bJSgUirJ0IfQJ4
Lg8URXdpstzpODaWJv9ClpNi3ektb8qvAMJYwcLsybleAF/9pG4xbqFKTpdhqM2y
UBFwz4it627DlFsDcgqkdx7XdgfgjPJk+XY7vzdXGcDmQnfreUVG4jH+r6Zv2ZmD
9U/HVYPAJM+ZGJvUiM4uEQ3fMKE+xec+QHYltMTGQ8YF5oFAx/72UoLXva/3qlBs
IP1dg+TJSZs/gbPr2LrqA5F1oQis0xYR1UZtk9L6E6YWiuPeuPXFntBtlPQJpFG8
n7hEuVd0+S1dHojXMpaznmeBaU9EgtslAfksjc9Zvg0Ax7or4hZq8RwIRx8jiYCr
YA2Nl55ut1IpRU4s+/hB8og5AGmqmRO7eTgY9qZJlIRSMYyh0TFL5dIAH4dJtXJa
MPouoQ2W4hYA4xwFqj0zNNgSz8AIJVvjhuhV7NCINWxXfZi0HCPmBQXSa/ShyY9A
BktEa21nPpSH4UdgU3G0
=F+yo
-----END PGP SIGNATURE-----

--E7THkVJDpplmQXMFg05frgsTMh30HFbpQ--

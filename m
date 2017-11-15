Received: from eggs.gnu.org ([2001:4830:134:3::10]:58008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eF4HP-0007zs-Nc
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 15:27:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eF4HO-0006FW-O6
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 15:27:27 -0500
References: <CAJH6TXiMxUoU2sFEHAoZ8jhDMtg_saEnTHM9f0vJ6Nhqj7099w@mail.gmail.com>
	<c2ecae32-f999-9f1e-46a6-37cdab2a62e3@redhat.com>
	<CAJH6TXhBAaBE9gBSxksWZqNywWmencRaGyeY-oN3jbKdgUettQ@mail.gmail.com>
	<0e6cc220-814a-17fd-4fd7-7b0665d34e81@redhat.com>
	<CAJH6TXh2v-F=yqxQbUUawk_Ctq-sgFefGp1XvMsC=syX_5jEqA@mail.gmail.com>
	<30b54865-2255-d13d-a054-afcf5bbd06b2@redhat.com>
	<20171115202440.GJ19514@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7b11bb2b-b93d-e8ff-f396-703c93549d0d@redhat.com>
Date: Wed, 15 Nov 2017 21:27:14 +0100
MIME-Version: 1.0
In-Reply-To: <20171115202440.GJ19514@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4P1tliVKjoijAQQ3mSBLnU7SEQ3445lqF"
Subject: Re: [Qemu-devel] [Libguestfs]  [qemu-img] support for XVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, Qemu-block <qemu-block@nongnu.org>, qemu-devel@nongnu.org, libguestfs <libguestfs@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4P1tliVKjoijAQQ3mSBLnU7SEQ3445lqF
From: Max Reitz <mreitz@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>,
 Qemu-block <qemu-block@nongnu.org>, qemu-devel@nongnu.org,
 libguestfs <libguestfs@redhat.com>
Message-ID: <7b11bb2b-b93d-e8ff-f396-703c93549d0d@redhat.com>
Subject: Re: [Libguestfs] [Qemu-devel] [qemu-img] support for XVA
References: <CAJH6TXiMxUoU2sFEHAoZ8jhDMtg_saEnTHM9f0vJ6Nhqj7099w@mail.gmail.com>
 <c2ecae32-f999-9f1e-46a6-37cdab2a62e3@redhat.com>
 <CAJH6TXhBAaBE9gBSxksWZqNywWmencRaGyeY-oN3jbKdgUettQ@mail.gmail.com>
 <0e6cc220-814a-17fd-4fd7-7b0665d34e81@redhat.com>
 <CAJH6TXh2v-F=yqxQbUUawk_Ctq-sgFefGp1XvMsC=syX_5jEqA@mail.gmail.com>
 <30b54865-2255-d13d-a054-afcf5bbd06b2@redhat.com>
 <20171115202440.GJ19514@redhat.com>
In-Reply-To: <20171115202440.GJ19514@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-15 21:24, Richard W.M. Jones wrote:
> On Wed, Nov 15, 2017 at 09:07:12PM +0100, Max Reitz wrote:
>> On 2017-11-15 21:06, Gandalf Corvotempesta wrote:
>>> 2017-11-15 20:59 GMT+01:00 Max Reitz <mreitz@redhat.com>:
>>>> Well, you can't just add support to qemu-img alone either.  Every im=
age
>>>> format supported by qemu-img is one supported by qemu as a whole and=

>>>> thus needs a proper block driver that needs to support random access=
es
>>>> as well.
>>>
>>> I was talking about qemu-img convert, just to convert an XVA image to=

>>> something different, in a single pass, without having to extract the
>>> tar.
>>
>> I know, but that doesn't work.  qemu-img convert uses the normal
>> general-purpose block drivers for that.
>=20
> In any case there's no need as qemu/qemu-img can already access files
> inside an uncompressed tarball using the offset/size support added to
> the raw driver exactly for this purpose:
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg03945.html

If that works, yes.  To me it doesn't look like XVA is just a single raw
image inside of a tarball, but I may very well be wrong, of course.

Max


--4P1tliVKjoijAQQ3mSBLnU7SEQ3445lqF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloMoyISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AgPQH+wU9EK0TRsGB07dSJ9jSyteXc+jriAIS
tN1614P269qjeJ0nRyS1tidhTq7hrpNkE5s5sMwzsUzxdJABBlem8dvVg67KliR/
EdTnBtpVvXMRSgdMWQopN3pMDdywHMNF2KWUY/LRSHpIVryG/HAw/vpaTyUYVVdk
0nvkm+k/LCLdRxzXus0GK68LUQ4pRf+6Giu5Wa1SpVl3bTvOx6tVPVlj+Lg6dsfa
LL2SC6CSLNVLYogvrm81YP5ziTulX/xNby/AjZwgr5hZba3xaDByb+QandRe7Pud
pYwL4XfstJQ6ADLunEN9OvosaXCUjHwuOakAx+6MvghRdJXZmtb/pQQ=
=EkZk
-----END PGP SIGNATURE-----

--4P1tliVKjoijAQQ3mSBLnU7SEQ3445lqF--

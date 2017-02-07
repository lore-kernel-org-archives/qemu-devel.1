Received: from eggs.gnu.org ([2001:4830:134:3::10]:56949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbE2g-0002rw-Bm
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 17:15:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbE2e-0001ZY-VB
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 17:15:18 -0500
References: <20170126123530.GB23095@lemon.Home>
	<20170126132708.GB29127@redhat.com>
	<6a9aeec8-d4ee-a0aa-7e04-0ee4295fef80@redhat.com>
	<8a13c995-c094-2704-c770-214132b2d6cf@redhat.com>
	<20170201121658.GF3232@redhat.com>
	<c4d38998-b862-90e6-6c4b-4b96a8d17bb4@redhat.com>
	<20170201122854.GG3232@redhat.com>
	<37f445c0-c174-bca4-7073-7aa6c64046b0@redhat.com>
	<87bmul9hfc.fsf@dusky.pond.sub.org>
	<d03de140-db6b-26ed-6cc9-958591843483@redhat.com>
	<20170206103104.GD3029@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c7b5df9b-f235-ee36-4ab1-3023245b9cd1@redhat.com>
Date: Tue, 7 Feb 2017 23:15:06 +0100
MIME-Version: 1.0
In-Reply-To: <20170206103104.GD3029@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5UChJw3SpfIMBPBCBnDki8S0K8mkaVRQR"
Subject: Re: [Qemu-devel] [PATCH v1 3/6] qemu-img: add support for -n arg to
 dd command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5UChJw3SpfIMBPBCBnDki8S0K8mkaVRQR
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <c7b5df9b-f235-ee36-4ab1-3023245b9cd1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 3/6] qemu-img: add support for -n arg to
 dd command
References: <20170126123530.GB23095@lemon.Home>
 <20170126132708.GB29127@redhat.com>
 <6a9aeec8-d4ee-a0aa-7e04-0ee4295fef80@redhat.com>
 <8a13c995-c094-2704-c770-214132b2d6cf@redhat.com>
 <20170201121658.GF3232@redhat.com>
 <c4d38998-b862-90e6-6c4b-4b96a8d17bb4@redhat.com>
 <20170201122854.GG3232@redhat.com>
 <37f445c0-c174-bca4-7073-7aa6c64046b0@redhat.com>
 <87bmul9hfc.fsf@dusky.pond.sub.org>
 <d03de140-db6b-26ed-6cc9-958591843483@redhat.com>
 <20170206103104.GD3029@redhat.com>
In-Reply-To: <20170206103104.GD3029@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

First, because this is perhaps the most important thing: I think I
remembered what the original proposal to solve all this mess, or at
least move it to a later point:

We wanted to just disallow overwriting existing files without
conv=3Dnotrunc. I think.

The thing is that it's pretty much impossible with the qemu block layer
to determine whether a file exists or not. Maybe you cannot open it but
it would be possible to overwrite it. This is the reason the patches for
this did not make it into 2.8.


On 06.02.2017 11:31, Daniel P. Berrange wrote:
> On Fri, Feb 03, 2017 at 07:56:11PM +0100, Max Reitz wrote:
>>> In case you say that's inconvenient: pretty much everything about dd'=
s
>>> archaic user interface is inconvenient.  If you want convenient, roll=

>>> your own.  If you want familiar, stick to the original.
>>
>> I agree. But qemu-img dd already is not dd. It interprets disk image
>> files as virtual disks instead of as plain files. The question is
>> whether virtual disks are to be treated as block devices or as files.
>>
>> I don't have a strong opinion on the matter. Either way will surprise
>> some people. The original issue was whether to make nocreat/notrunc a
>> mandatory option, so if we didn't have any backwards compatibility
>> issues, it would be the following two surprises:
>>
>> (1) Don't make nocreat/notrunc mandatory (as it is now). Then people
>>     who expect qemu-img dd to treat image files as block devices will
>>     be surprised that all their data is gone. Bad.
>=20
> I don't think people really expect qemu-img to treat image file as if
> they were block devices when operating on the host.
>=20
> It is like saying people expect /usr/bin/dd to treat a plain file
> as a block device, because they might use it with losetup later.

That's not a good comparison. Disk images are meant to be used with qemu
(or some other VMM, or, yes, with losetup if it's a raw image). Plain
files can be anything. No, dd does not look into the file to determine
whether it may be a raw disk image or not, but it does execute fstat()
to find out whether it's a plain file or a block device.

Furthermore, you are omitting the sentence where I said that qemu-img dd
does not operate on just the host level. It interprets the disk image
contents, thus it is, in a sense, operating from the guest's
perspective. It's somewhere in between, which is why I argued that some
people may assume it's a guest-level tool. At least it's on the same
level as block jobs are, whatever that may mean.

(Well, it does mean that block jobs with mode=3Dexisting do not truncate
the output, but the default is mode=3Dabsolute-paths, so they would
overwrite it anyway. So there's that.)

I agree that I would probably not expect qemu-img dd to treat images
like block devices. At least I would test it first. But I stand by the
point that it is conceivable to think so, and thus we have to assume
there are such people.

They may be few, but I reasoned that reality would hit them much harder
than all the rest would be affected if we implemented the opposite behavi=
or.

It's a simple trade-off that we did not consider; or rather that we
considered too late.

I also agree with you that it's too late to change now.

Max


--5UChJw3SpfIMBPBCBnDki8S0K8mkaVRQR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliaRuoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A2LQH/jRoNN0vBsT2Cw7yqvxt6mvUsFmBr8Kt
WEWqJXRY4zvPK2K8z8sm2rt8rKt01kicEpHBXqAmMFcEO13oyurODHunJGDy9hG5
W5j+Lp/h1k+BV4Jj2UcvQvJqyimodcDd6DB3jzOOqqSanWo/UVOshFZsgGfhUOn5
EKBs/s1AUZcZH939oSY0+27iAFTNj0r7KoJdHEG4I+MUSmq1MvNXmO6XkBACebRg
fC2YmtY6yozzgSmCKvIqsUPzEGeeiVg1zrgd1z8TxFrD75jKXO5ZkfRLqMd5G6V8
AA8GZN3otYMs/yej079a4S+kSHHW6bccbQrO1bRrPgi1/IlvIQlQLY0=
=Wr/a
-----END PGP SIGNATURE-----

--5UChJw3SpfIMBPBCBnDki8S0K8mkaVRQR--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:45867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQZJm-0003ik-2z
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQZJh-0005fx-JY
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:21:42 -0400
References: <20180606123237.2235ae4a@kitsune.suse.cz>
	<bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
	<20180606131929.44d0fd6b@kitsune.suse.cz>
	<93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
	<20180606134327.05de9616@kitsune.suse.cz>
	<94cea1d9-d934-85d1-66d4-dbfc82b8dd53@redhat.com>
	<20180606141356.0b86d6b4@kitsune.suse.cz>
	<95f92a95-6592-27a2-a822-d3a047cf8339@redhat.com>
	<20180606154510.24be6ceb@kitsune.suse.cz>
	<20180606135010.GF3064@redhat.com>
	<20180606141432.GS7451@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9a7567dd-5813-8a5a-b079-ae198e5394a5@redhat.com>
Date: Wed, 6 Jun 2018 16:21:28 +0200
MIME-Version: 1.0
In-Reply-To: <20180606141432.GS7451@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="e9YQjKZ60Ooz8oyv0YxZuc93YYkFwoMBH"
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e9YQjKZ60Ooz8oyv0YxZuc93YYkFwoMBH
From: Max Reitz <mreitz@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, "Richard W.M. Jones"
 <rjones@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com
Message-ID: <9a7567dd-5813-8a5a-b079-ae198e5394a5@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
References: <20180606123237.2235ae4a@kitsune.suse.cz>
 <bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
 <20180606131929.44d0fd6b@kitsune.suse.cz>
 <93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
 <20180606134327.05de9616@kitsune.suse.cz>
 <94cea1d9-d934-85d1-66d4-dbfc82b8dd53@redhat.com>
 <20180606141356.0b86d6b4@kitsune.suse.cz>
 <95f92a95-6592-27a2-a822-d3a047cf8339@redhat.com>
 <20180606154510.24be6ceb@kitsune.suse.cz> <20180606135010.GF3064@redhat.com>
 <20180606141432.GS7451@localhost.localdomain>
In-Reply-To: <20180606141432.GS7451@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-06 16:14, Eduardo Habkost wrote:
> On Wed, Jun 06, 2018 at 02:50:10PM +0100, Daniel P. Berrang=C3=A9 wrote=
:
>> On Wed, Jun 06, 2018 at 03:45:10PM +0200, Michal Such=C3=A1nek wrote:
>>>
>>> I think that *if* we want an 'appliance' format that stores a whole V=
M
>>> in a single file to ease VM distribution then the logical place to lo=
ok
>>> in qemu is qcow. The reason have been explained at length.
>>
>> I rather disagree. This is a common problem beyond just QEMU and every=
one
>> just uses an existing archive format (TAR, ZIP) for bundling together
>> one or more disk images, metdata for config, and whatever other resour=
ces
>> are applicable for the vendor.  This works with any disk format (raw,
>> qcow2, vmdk, vpc, etc) so is preferrable to inventing someting that is=

>> specific to qcow2 IMHO.
>=20
> Now we have N+1 appliance file formats.  :)
>=20
> (We like it or not, qcow2 is already used as an appliance format
> for single-disk VMs in practice.)
>=20
> But I agree this must not be specific to qcow2.  The same VM
> description format we agree upon should work with other disk
> formats or with multi-disk appliances.
>=20
> If we specify a reasonable VM description format for appliances
> and make it work inside (e.g.) tar files, we will still have the
> option of allowing the description be placed inside qcow2 if we
> really want to.  I don't think we need to finish this qcow2
> bikeshedding exercise right now.

That actually sounds reasonable to me.

I better not think about it for too long so I don't come up with
something I very much dislike about it.

(Well, now I have.  The thing I still dislike is that we haven't talked
about what we actually want in the end.  Do we want just the very basic
configuration options that are portable?  But what really is the use
case for such basic information?  Won't people demand ever more
configuration options, then?  I certainly would.

And having to handle a full-blown config is probably a pain...)

Max


--e9YQjKZ60Ooz8oyv0YxZuc93YYkFwoMBH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsX7egACgkQ9AfbAGHV
z0D0Mgf/QLYs7GLheg1zG/v9bR5nvLkVh2sur5NZR6uW+BanWlAZUrBYnNqTxhL9
chZdKdD2VbHanzxICc9RUrEDfPH6WbnQl2V3pMdVm5TYK9CEPQ9BStuby+pRAHup
SY/4f1wvPVaO1hJmffCyTK2Gkd42DxzMSdL6x0K55Z0tZhA4h4V0S1AQrBPTzONc
vC5lX2hXmL0lBmcLTPhKQRbMRA5P/TysW9dhDJRmnKs0pr/IUytmn5uxk8+Jh/cf
MSJ8d0RLoOVXfM7pSAuCJxM5r7C2JNJ9hQQ0Cm5AI/bzpdT+FLr/LN9RtHC7cXjn
73lNKRskNLhC2cPHCXPWv4Nv/WyLfQ==
=2mxf
-----END PGP SIGNATURE-----

--e9YQjKZ60Ooz8oyv0YxZuc93YYkFwoMBH--

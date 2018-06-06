Received: from eggs.gnu.org ([2001:4830:134:3::10]:54922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQcsf-0007xa-7Y
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:09:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQcse-000852-5g
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:09:57 -0400
References: <20180606123237.2235ae4a@kitsune.suse.cz>
	<bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
	<20180606131929.44d0fd6b@kitsune.suse.cz>
	<93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
	<20180606134327.05de9616@kitsune.suse.cz>
	<94cea1d9-d934-85d1-66d4-dbfc82b8dd53@redhat.com>
	<20180606141356.0b86d6b4@kitsune.suse.cz>
	<95f92a95-6592-27a2-a822-d3a047cf8339@redhat.com>
	<20180606154510.24be6ceb@kitsune.suse.cz>
	<d2b5d074-4052-a5fb-4048-cc30ad092f0f@redhat.com>
	<20180606161031.GT7451@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <61c88dc0-5585-f8f0-8777-eabac594c925@redhat.com>
Date: Wed, 6 Jun 2018 20:09:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180606161031.GT7451@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NGrYIp5xrEJRCzFMVVlVIdxwDdwJB6Z4B"
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NGrYIp5xrEJRCzFMVVlVIdxwDdwJB6Z4B
From: Max Reitz <mreitz@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, "Richard W.M. Jones"
 <rjones@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com
Message-ID: <61c88dc0-5585-f8f0-8777-eabac594c925@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
References: <20180606123237.2235ae4a@kitsune.suse.cz>
 <bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
 <20180606131929.44d0fd6b@kitsune.suse.cz>
 <93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
 <20180606134327.05de9616@kitsune.suse.cz>
 <94cea1d9-d934-85d1-66d4-dbfc82b8dd53@redhat.com>
 <20180606141356.0b86d6b4@kitsune.suse.cz>
 <95f92a95-6592-27a2-a822-d3a047cf8339@redhat.com>
 <20180606154510.24be6ceb@kitsune.suse.cz>
 <d2b5d074-4052-a5fb-4048-cc30ad092f0f@redhat.com>
 <20180606161031.GT7451@localhost.localdomain>
In-Reply-To: <20180606161031.GT7451@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-06 18:10, Eduardo Habkost wrote:
> On Wed, Jun 06, 2018 at 04:17:14PM +0200, Max Reitz wrote:
>> On 2018-06-06 15:45, Michal Such=C3=A1nek wrote:

[...]

>>> I understand that for some use cases simplifying the distribution of
>>> VMs as much as possible is quite important.
>>
>> I don't because still nobody has explained it to me.
>>
>> The only explanation I got so far was "People are lazy and we have
>> defaults for everything, so we don't throw an error if people forget t=
o
>> pass a configuration file."
>=20
> People don't pass a configuration file today because there's no
> standard for such a configuration file.  qcow2 is already used
> today as an appliance file format because there's no better
> option.  People download disk images from appliance and OS
> providers, import them into a cloud system, and it works out of
> the box because (luckily) "pc" is enough for most of them.

OK.

> We can specify a true appliance file format, and ask people to
> use it.  But then providers of single-disk appliances and OSes
> will need to publish two appliance images: qcow2 disk image for
> old systems that don't support the new format, and one in the new
> appliance format, for systems that support it.

True.  This is a valid argument for making a compatible change to qcow2.
 But: If these options are actually important, the qcow2 file is not
really compatible either.  You might end up with a blank screen again.

Depending on how we'd design a new format, it might contain a config
file and a qcow2 file which may be easily extractable.  If so, users of
legacy software could easily extract the qcow2 file and might even be
tempted to look at the config file when it doesn't work, and maybe that
could even help them.

Also, I think that it is not too unreasonable to ask providers to
provide two formats.

But that does not make me disregard your argument.  It is still valid,
especially with your convenience note below.

(Providers could choose whether it is best for them to include the
description in the qcow2 file, or whether to offer an archive that
contains e.g. a raw file.)

>> Which to me still just makes it an inconvenience.
>=20
> Well, there are small inconveniences and there are big
> inconveniences that together make a system unnecessarily hard to
> use.  I'd say this one falls somewhere in the middle.

Hm, OK.

> [...]
>> I'm noticing a pattern here, and that is that everybody has a differen=
t
>> opinion on what we actually want in the end, and it's just by chance
>> that we find ourselves in two camps ("put it in qcow2" vs. "put it
>> somewhere else").
>>
>> Maybe we should first discuss what we actually want before we can
>> discuss where to put it.
>=20
> I'm inclined to agree.  Once we figure out a good VM description
> format, we can justify a proposal to allow embedding the VM
> description in qcow2 for convenience.

OK.

Max


--NGrYIp5xrEJRCzFMVVlVIdxwDdwJB6Z4B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsYI2YACgkQ9AfbAGHV
z0BrZQf/V1nQyPXUlUzS0FbsbYBrGmdDSWnArUHi+jlt4TZBooBYnsDANn6FQ3n2
FusbXeKhxgBH2d4tKnqptK/RtpwrSuVN3uN+y3FbjAUanjrrWhzS4yxGVJj9vAVV
+NNV/UwMCWX9gISYRgJ0Sy+xwf4UfBuBRzVuAqanM+AgMIWGNMTCi2OVgAdh3bC/
dYT3pA1BQv2wmHhR6Xx55RARPIkTcno6gD94saxzwRwd6kY2T5vH7QQOS+ecLT3m
h7M3IUWXsBP67MZE3TuulMY9KQpeFSsvYxL/PsfNqEScNYvRcO80sPc44ir50o12
B3vMvwoWiSvhqnBtrnu1rZHg7Bu+JA==
=HgMR
-----END PGP SIGNATURE-----

--NGrYIp5xrEJRCzFMVVlVIdxwDdwJB6Z4B--

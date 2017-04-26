Received: from eggs.gnu.org ([2001:4830:134:3::10]:39644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3MgL-0005XU-P3
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:08:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3MgH-0003Ea-4b
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:08:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d3MgG-0003Dc-SG
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:08:29 -0400
References: <1493161481-29595-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<1493161481-29595-9-git-send-email-mdroth@linux.vnet.ibm.com>
	<20170426110202.GF18933@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8760694f-6e70-4f0f-9482-9eb7075eb6c7@redhat.com>
Date: Wed, 26 Apr 2017 08:08:25 -0500
MIME-Version: 1.0
In-Reply-To: <20170426110202.GF18933@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Cp4n1McBTvTMxJJg3d4El8RUpKPsQ5C6O"
Subject: Re: [Qemu-devel] [PULL 8/8] qga: Add `guest-get-timezone` command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, Vinzenz Feenstra <vfeenstr@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Cp4n1McBTvTMxJJg3d4El8RUpKPsQ5C6O
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 Vinzenz Feenstra <vfeenstr@redhat.com>
Message-ID: <8760694f-6e70-4f0f-9482-9eb7075eb6c7@redhat.com>
Subject: Re: [Qemu-devel] [PULL 8/8] qga: Add `guest-get-timezone` command
References: <1493161481-29595-1-git-send-email-mdroth@linux.vnet.ibm.com>
 <1493161481-29595-9-git-send-email-mdroth@linux.vnet.ibm.com>
 <20170426110202.GF18933@redhat.com>
In-Reply-To: <20170426110202.GF18933@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2017 06:02 AM, Daniel P. Berrange wrote:
> On Tue, Apr 25, 2017 at 06:04:41PM -0500, Michael Roth wrote:
>> From: Vinzenz Feenstra <vfeenstr@redhat.com>
>>
>> Adds a new command `guest-get-timezone` reporting the currently
>> configured timezone on the system. The information on what timezone is=

>> currently is configured is useful in case of Windows VMs where the
>> offset of the hardware clock is required to have the same offset. This=

>> can be used for management systems like `oVirt` to detect the timezone=

>> difference and warn administrators of the misconfiguration.
>=20
>> +GuestTimezone *qmp_guest_get_timezone(Error **errp)
>> +{
>=20
>> +    name =3D g_time_zone_get_abbreviation(tz, intv);
>=20
> [snip]
>=20
>> +##
>> +# @GuestTimezone:
>> +#
>> +# @zone:    Timezone name
>=20
> This isn't clearly documented in glib, but it looks like the time zone
> names are *different* when glib is run on POSIX vs Win32 platforms.
>=20
> Do we really want to expose something in QAPI that is going to have
> different semantics depending on the guest OS the agent runs in ?
>=20

Maybe it's just a matter of proper documentation.  The 'offset' field is
the important one, with unambiguous machine-parseable semantics; the
'zone' field is an optional, informative, human-readable format
according to the guest OS's whims, and should not be relied on for
scripting purposes.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Cp4n1McBTvTMxJJg3d4El8RUpKPsQ5C6O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZAJvJAAoJEKeha0olJ0Nqp44H/Rri8tS9fZc+ptG0I03/pArK
+ZKPhWrOl1lj7sdLVWD3+rN0uwmvqqQ+mQnWUJ6rmXm+xztMfLdup1NHQrqMbVzm
5GrRAuqSQ4gat9X6K/23Uq4RE5pWeK+35SbYHP3rllXPCvGnPEkABQdzh0n7YpbK
l+ylv8Y5sttXBCl8CxjZauY1WyQFdXB+IaVeaPX9QY9HwE+v7LuHSuPjsWVYW9W4
0HyP4ZyyGm8iq/QIwfCV62x1eGPMmeC49dHR2pshxsFkU+P/HH3M7I16Jr7CU+h2
lODt96mtrn/ASx7oxwbTKEZ+uqOEI5CcBJXyiX65mjwSxtpUJEEeN6HO0WPcLhI=
=FjxJ
-----END PGP SIGNATURE-----

--Cp4n1McBTvTMxJJg3d4El8RUpKPsQ5C6O--

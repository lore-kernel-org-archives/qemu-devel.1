Received: from eggs.gnu.org ([2001:4830:134:3::10]:39778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ceoMA-0007dt-KJ
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:38:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ceoM6-0001m9-N1
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:38:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ceoM6-0001lZ-Eh
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:38:10 -0500
References: <20170217172607.25575-1-danielhb@linux.vnet.ibm.com>
	<3c2ce558-db56-79b5-14ed-4431f6529c82@redhat.com>
	<6fe6a499-faa2-1e3d-a419-d33b2e538e7c@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1867aaa8-57ba-0223-3b28-bac569f6f9de@redhat.com>
Date: Fri, 17 Feb 2017 13:38:07 -0600
MIME-Version: 1.0
In-Reply-To: <6fe6a499-faa2-1e3d-a419-d33b2e538e7c@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0WMetfQdGBVDQIXuDnC3C8xPWTvVfwfjO"
Subject: Re: [Qemu-devel] [PATCH] Changing error message of QMP
 'migrate_set_downtime' to seconds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0WMetfQdGBVDQIXuDnC3C8xPWTvVfwfjO
From: Eric Blake <eblake@redhat.com>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com
Message-ID: <1867aaa8-57ba-0223-3b28-bac569f6f9de@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Changing error message of QMP
 'migrate_set_downtime' to seconds
References: <20170217172607.25575-1-danielhb@linux.vnet.ibm.com>
 <3c2ce558-db56-79b5-14ed-4431f6529c82@redhat.com>
 <6fe6a499-faa2-1e3d-a419-d33b2e538e7c@linux.vnet.ibm.com>
In-Reply-To: <6fe6a499-faa2-1e3d-a419-d33b2e538e7c@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/17/2017 01:01 PM, Daniel Henrique Barboza wrote:

>>> 2000000)) {
>>> +        (params->downtime_limit < 0 ||
>>> +         params->downtime_limit > MAX_MIGRATE_SET_DOWNTIME)) {
>>>           error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
>>>                      "downtime_limit",
>>> -                   "an integer in the range of 0 to 2000000
>>> milliseconds");
>>> +                   "an integer in the range of 0 to 2000 seconds");
>> Perhaps you could use %d and set  MAX_MIGRATE_SET_DOWNTIME to 2000?
>> Though perhaps the migration maintainers are okay with the patch as is=
=2E
>=20
> I did that at first but I got errors on "error_setg" about the extra
> parameter.

Ah, right, because QERR_INVALID_PARAMETER_VALUE is a macro that expands
to a fixed printf-style format string where you have to know how many
exact arguments it further expects.  The only way around that is to
open-code the error message you want, instead of forcing the use of the
awkward macro.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--0WMetfQdGBVDQIXuDnC3C8xPWTvVfwfjO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYp1EfAAoJEKeha0olJ0Nqm/AH/i302tu0iOJgw9azy+KcGucs
X+Bwr4Gww5+lgCEe+GL3LyUF0wuHwhUS2jijZ95FifcmsQfUvkS/JBgE+Qg0SmRy
ytleeed1wr6HKLSM0Fhao2xR1w4PL53ltickDHNWuBzMUMPeNze+2OUZa0QYn9qH
uFMG4oIRIrytrHU55ljlpTOH/FiH+I6n0pdrCYgSY3Bi4ljXxH52cMldeWTVFjfr
gTff2G3+9s7mCWrgq3r7vdTzadvz0m5xpvS2zI6owngK2si5yidUS3WKAyqniXhb
bU5d/1hEyL/bjKCK/eREWJ8bZEQE2w2chs3YV+2fmENEV65ch3lf44YlJSVld1E=
=WJdx
-----END PGP SIGNATURE-----

--0WMetfQdGBVDQIXuDnC3C8xPWTvVfwfjO--

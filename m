Received: from eggs.gnu.org ([2001:4830:134:3::10]:55134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw7NN-0000YY-FA
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw7NM-0006Ue-Dr
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:23:01 -0400
References: <20170405194741.18956-1-eblake@redhat.com>
	<20170405194741.18956-11-eblake@redhat.com>
	<20170406090045.GC4341@noname.redhat.com>
	<1313a278-947d-9b73-640f-3aa518019773@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b0c018d5-8178-fdc0-9412-b3b53babd941@redhat.com>
Date: Thu, 6 Apr 2017 08:22:51 -0500
MIME-Version: 1.0
In-Reply-To: <1313a278-947d-9b73-640f-3aa518019773@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dbfnh1wAxiIqvcFU5tJHIxD4kW4VsD7IX"
Subject: Re: [Qemu-devel] [PATCH v3 10/13] block: Simplify
 bdrv_append_temp_snapshot() logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, "open list:Block layer core" <qemu-block@nongnu.org>, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dbfnh1wAxiIqvcFU5tJHIxD4kW4VsD7IX
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org,
 "open list:Block layer core" <qemu-block@nongnu.org>, armbru@redhat.com
Message-ID: <b0c018d5-8178-fdc0-9412-b3b53babd941@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 10/13] block: Simplify
 bdrv_append_temp_snapshot() logic
References: <20170405194741.18956-1-eblake@redhat.com>
 <20170405194741.18956-11-eblake@redhat.com>
 <20170406090045.GC4341@noname.redhat.com>
 <1313a278-947d-9b73-640f-3aa518019773@redhat.com>
In-Reply-To: <1313a278-947d-9b73-640f-3aa518019773@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2017 07:52 AM, Eric Blake wrote:

>>> +out:
>>> +    QDECREF(snapshot_options);
>>>      g_free(tmp_filename);
>>>      return bs_snapshot;
>>
>> bs_snapshot is uninitialised or at least the wrong return value in err=
or
>> cases. (Hm... Shouldn't the compiler catch the uninitialised part?)
>=20
> Odd, and I agree that I recall the compiler generally able to catch tha=
t
> (maybe it's a matter of compiling with -g vs. -O2).  I'm surprised the
> autobuilder didn't flag it.

And now the autobuilder finally replies.  It is indeed a matter of
difference in CFLAGS on whether the compiler will catch it.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--dbfnh1wAxiIqvcFU5tJHIxD4kW4VsD7IX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5kErAAoJEKeha0olJ0NqaroH/iBrki+56O/wEQKIm1H9QWHb
aByPk8CMLOskLWVqlSn07eP3f+NAvi24VAgTG1nIX+kUpCJ8PTtlfgnDodr8do26
vxjH6aBGwJCNdk5dqpwlymmeRoDIk4m/FI8lqk3d32venrmkqRIfB37EED4NuM8g
QTm6VwF8Cbl8q2eed41CyZKkjcLedTYO4/fw6esAYRIcmZurufytx0qWBKq1r+5T
OHsl3ix8f0OmMqB3ML1+MTW1PTz5LHM0hHc/NWyr3sMORqPIqZS8sCpOj3sZI2Sl
6QKwJQAe5fjQoNIdTzIzNoueX7ol7U4Va9mJ4Dv6GK7g6Goq+jxNcO0Z30h/Tuc=
=7eT1
-----END PGP SIGNATURE-----

--dbfnh1wAxiIqvcFU5tJHIxD4kW4VsD7IX--

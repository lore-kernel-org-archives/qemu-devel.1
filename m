Received: from eggs.gnu.org ([2001:4830:134:3::10]:60949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2dzB-0002SO-El
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:57:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2dzA-0006to-IC
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:57:17 -0400
References: <20171002143919.207741-1-vsementsov@virtuozzo.com>
	<20171002143919.207741-5-vsementsov@virtuozzo.com>
	<a7594875-cd6f-8195-4b86-d7f67ad9f208@redhat.com>
	<2cb5ac95-e27c-2d13-b557-9dedc1f86473@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <28aa9488-8cf3-b71f-5c74-74c884fbe3be@redhat.com>
Date: Thu, 12 Oct 2017 08:56:46 -0500
MIME-Version: 1.0
In-Reply-To: <2cb5ac95-e27c-2d13-b557-9dedc1f86473@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="g1cXWD6SHw1jKVXjV6R2bDONkgUN63Tej"
Subject: Re: [Qemu-devel] [PATCH 4/5] backup: simplify non-dirty bits
 progress processing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g1cXWD6SHw1jKVXjV6R2bDONkgUN63Tej
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Message-ID: <28aa9488-8cf3-b71f-5c74-74c884fbe3be@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/5] backup: simplify non-dirty bits progress
 processing
References: <20171002143919.207741-1-vsementsov@virtuozzo.com>
 <20171002143919.207741-5-vsementsov@virtuozzo.com>
 <a7594875-cd6f-8195-4b86-d7f67ad9f208@redhat.com>
 <2cb5ac95-e27c-2d13-b557-9dedc1f86473@virtuozzo.com>
In-Reply-To: <2cb5ac95-e27c-2d13-b557-9dedc1f86473@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/12/2017 06:42 AM, Vladimir Sementsov-Ogievskiy wrote:

>> I'm not sure we actually need a new field... let's just say that the j=
ob
>> length is the number of bytes described by the incremental backup. Eve=
ry
>> time we copy some, move offset forward. This would give a more
>> appropriately linear/accurate sense of the progress.
>>
>> I think we are allowed to do this as I think we promise that these
>> progress numbers mean essentially nothing...
>=20
> I'm not sure, length is published field, it is available in libvirt.
> IMHO, If we change it semantics it should
> firstly break our iotests but what it will break for users is
> unpredictable..

Libvirt already documents that progress numbers do NOT have any specific
meaning other than a rough estimate of percentage complete, and that it
IS acceptable for the numbers to jump around or move non-linearly during
a job.  I see no problem with returning different numbers than
previously if it makes our estimation of progress look smoother; it is
not a semantics change by the definition we've given to the numbers, but
merely a quality-of-implementation improvement.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--g1cXWD6SHw1jKVXjV6R2bDONkgUN63Tej
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnfdJ4ACgkQp6FrSiUn
Q2rt7ggAocRL8DmLrq04dOXCcQ9voJlsH3I9g7VMxiJ3/FepTHBfvUI9qp4NuPfr
Xzu0WjmoARYmH9hV5C0yV564du2Caj8V6MxMnjuR3+5rrKWL0oTgMtUMewhYCFu3
bEz6k8KAJhwpIm2EB7ZBy+C8zo5R687ZwMWGI9gb5fuyMGMg/GXxG0TGSlsleOYT
HH93brBmZmVj95Z9hFUdmzhJTzPNpW+HsH8EulT9nAr8254mqkbMjBGBaeLLyIVL
3izui1qX0isC8tjE4K2GBrwbrvHA6WfaakW1/VSRwuGtGvL4opPaPcqMvugRZjeS
PD/JQYyDN9ntHEKbSP5w4YcSY9oujw==
=rITL
-----END PGP SIGNATURE-----

--g1cXWD6SHw1jKVXjV6R2bDONkgUN63Tej--

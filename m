Received: from eggs.gnu.org ([2001:4830:134:3::10]:38004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbSXf-0002lp-3k
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 08:44:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbSXc-0000XW-1e
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 08:44:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cbSXb-0000X1-Pc
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 08:44:11 -0500
References: <20170207155956.21573-1-pbonzini@redhat.com>
	<b7fc7007-1663-b41d-422a-9600e44d7b38@redhat.com>
	<87zihxukx2.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6b2917c1-c591-85dc-849f-558212d22adc@redhat.com>
Date: Wed, 8 Feb 2017 07:44:09 -0600
MIME-Version: 1.0
In-Reply-To: <87zihxukx2.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ixReQglkqTAM22CBSqO3Av8l46uKQjomw"
Subject: Re: [Qemu-devel] [PATCH] link to .xz files to save some bandwidth
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ixReQglkqTAM22CBSqO3Av8l46uKQjomw
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com
Message-ID: <6b2917c1-c591-85dc-849f-558212d22adc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] link to .xz files to save some bandwidth
References: <20170207155956.21573-1-pbonzini@redhat.com>
 <b7fc7007-1663-b41d-422a-9600e44d7b38@redhat.com>
 <87zihxukx2.fsf@dusky.pond.sub.org>
In-Reply-To: <87zihxukx2.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/08/2017 02:49 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 02/07/2017 09:59 AM, Paolo Bonzini wrote:
>>> I have converted all .gz and .bz2 files to .xz on download.qemu.org
>>> and this patch would change the links in the website.  This would sav=
e
>>> about 5 GB of bandwidth every day (about 20% savings).
>>>
>>> xz should be available for all platforms.  Besides providing better
>>> compression ratios, decompression of .xz files is about twice as fast=

>>> compared to bzip2.  Compression instead is about 5.5 times slower.
>>
>> I agree that bzip2 is pointless these days; .gz is a bit more importan=
t
>> when targetting older platforms but I think that does not describe
>> qemu's target audience.  Do we want to even enter the xz vs. lzma
>> controversy, or are we okay with being xz-only?
>=20
> Pointer to / summary of the controversy, so that folks can decide
> whether they care?

Here's a big thread on the coreutils list, where I proposed a patch to
add lzip distribution alongside xz, but where the patch was more-or-less
dropped due to the debate that ensued:

https://lists.gnu.org/archive/html/coreutils/2017-01/threads.html#00008

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--ixReQglkqTAM22CBSqO3Av8l46uKQjomw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYmyCpAAoJEKeha0olJ0NqCgIH/3tv2n4ONdYJ5I4Rvw2R58f0
7ZTYcJB7jNRR4Z8NfnjeOqtTdUivsWY8hK9sbjOcRgHNe6irEeXau8Rjlg72nxDO
NvEP6R/fvLW1Zps+HKk/fV8MqLoFbocV8OMkTd0RumUQ6zpStf4GvvgPIuijo1O/
f9ZrPxuRCTc708XNUCXSyzvsteGeYmIMr8k3dNoSIVWP4PrdspCPgFeBV7arV0nH
9KZ30a4fETf6ymPCgsOmTEkTSdb1onoKIech0mIfzciIGDQsEQwLaobqm+fiTXGo
0dHZHeMzPbLqlqioUrMjOB4XBEgewfrbb7QAZwjEfl3r9fn7wOdVyDDdiizIjG4=
=cmKu
-----END PGP SIGNATURE-----

--ixReQglkqTAM22CBSqO3Av8l46uKQjomw--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:46780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fXMmM-00024P-Gp
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 04:23:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fXMmL-0001zv-MW
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 04:23:18 -0400
References: <20180615142108.27814-1-kwolf@redhat.com>
	<20180615142108.27814-26-kwolf@redhat.com>
	<7a310b92-f8cb-b68b-d882-9b2959794347@de.ibm.com>
	<20180622125502.GF4366@localhost.localdomain>
	<20180625071610.GH16514@angien.pipo.sk>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f34a06e6-2487-e7dd-1393-cb8d82e0bfb5@redhat.com>
Date: Mon, 25 Jun 2018 10:23:03 +0200
MIME-Version: 1.0
In-Reply-To: <20180625071610.GH16514@angien.pipo.sk>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="aDZNqh8iQaSppcgJaqwqZnPS4lTOMKSUI"
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: libvir-list@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aDZNqh8iQaSppcgJaqwqZnPS4lTOMKSUI
From: Thomas Huth <thuth@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: libvir-list@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>
Message-ID: <f34a06e6-2487-e7dd-1393-cb8d82e0bfb5@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
References: <20180615142108.27814-1-kwolf@redhat.com>
 <20180615142108.27814-26-kwolf@redhat.com>
 <7a310b92-f8cb-b68b-d882-9b2959794347@de.ibm.com>
 <20180622125502.GF4366@localhost.localdomain>
 <20180625071610.GH16514@angien.pipo.sk>
In-Reply-To: <20180625071610.GH16514@angien.pipo.sk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25.06.2018 09:16, Peter Krempa wrote:
> On Fri, Jun 22, 2018 at 14:55:02 +0200, Kevin Wolf wrote:
>> Am 22.06.2018 um 13:38 hat Christian Borntraeger geschrieben:
>>>
>>> On 06/15/2018 04:21 PM, Kevin Wolf wrote:
>>>> The -drive option serial was deprecated in QEMU 2.10. It's time to
>>>> remove it.
>>>>
>>>> Tests need to be updated to set the serial number with -global inste=
ad
>>>> of using the -drive option.
[...]
>>> So it seems that this breaks s390x.
>>
>> Thanks for bringing this up. libvirt should fix this before QEMU 3.0 i=
s
>> released.
>=20
> So, I already extracted the code that formats the attributes which
> should be actually done for the frontend few months ago, but did not
> swithc to it since I did not want to check when everything was added.
>=20
> The fix will be rather simple if we are certain that the disk serial,
> geometry and error policies were supported in qemu 1.5. In that case we=

> can switch unconditionally to the new format.

The CHS device properties are available since QEMU v1.2:
- IDE: https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Dba801960
- SCSI: https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Dd252df48
- virtio-blk: https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3De63e7=
fde2

The "serial" property and the PCI "addr" property are also available
since 2012 at least, I didn't fully track their origins, but QEMU v1.2
already supported them.

So yes, all these properties should be available in QEMU 1.5 already.

 Thomas


--aDZNqh8iQaSppcgJaqwqZnPS4lTOMKSUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJbMKZsAAoJEC7Z13T+cC21qG4P/1wxMkVNmt1vkJOd3ssg2xyv
pUjuREyC0pGdwXIHXAkTBLxLlK5TKCw+8wmD1HDHqxwwoRsb24VCPpIyQR6YvLsV
jFYCqQ6ac2Ii/y48lrG2e5euwqUOC2Q6PKNYsFigLx/fhhWQReyI5jU2aa7v5qY9
GdgKmOM08/hmrt6Lx4kayLd+s40ikJ4C9pcl+aBX1OwlIG7HUwj25mRpXCXTER/0
pCOu/nF3fuBz7kueRRzfTHCE5wddzHxP/B8dtBvwWnaRS+GW3YvOzgQ6BiaxqgvS
jwexnydM0IsUuTVzv2B3v28TsurZ3kuJZOCL8qXn/bZZZis2cCmI4759s4Y1F6bb
v+Ei3PawIMv9CdIuLDpqa3PwzKoaTdRpLqMGg+ojTuIOBp/GQLWzLsnabmG+YAri
SsPSh9FrxknzP9/2HC8zVgNIFJ1c/j41i0V018nPxuqbPeN+NCkNV2R9WW+HGSc3
cL/vFL6pcHPHW+vn4/IXFMyejG2UmG6kZcsCx5WC38G2LRU4FSc7xdFkBEL6TfvU
h9bvyeMS0DtUtUvAOiruz18EwVYPEUZ09aaHhw7yz5FAnhINhMMq1+WeEcefZxUq
t/AQv8WvLOMRvBPOFCWTkbSeL+xnllJGkjgRL1bXONwOb7V1GdHuGcQe5uMTQeXP
Waq+HI0usDa30M0u2cDZ
=nWeh
-----END PGP SIGNATURE-----

--aDZNqh8iQaSppcgJaqwqZnPS4lTOMKSUI--

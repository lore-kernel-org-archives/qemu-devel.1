Received: from eggs.gnu.org ([2001:4830:134:3::10]:53113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn9M6-000382-7j
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:12:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn9M5-0002xe-3n
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:12:54 -0400
References: <cover.1504112061.git.jcody@redhat.com>
	<af4268153bce149a9599e4079a0f8908e32fdef8.1504112061.git.jcody@redhat.com>
	<94eb9a23-1cb7-a139-039e-4d0f138a6244@redhat.com>
	<20170830201107.GL4770@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aa69cb6b-3463-8811-966f-4218aba98e02@redhat.com>
Date: Wed, 30 Aug 2017 15:12:44 -0500
MIME-Version: 1.0
In-Reply-To: <20170830201107.GL4770@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="losKi7du4COasRFFtkUuEF06scKxaUd02"
Subject: Re: [Qemu-devel] [PATCH v2 1/7] block/ssh: don't call
 libssh2_init() in block_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, kwolf@redhat.com, rjones@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--losKi7du4COasRFFtkUuEF06scKxaUd02
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, mitake.hitoshi@lab.ntt.co.jp,
 namei.unix@gmail.com, kwolf@redhat.com, rjones@redhat.com,
 qemu-block@nongnu.org
Message-ID: <aa69cb6b-3463-8811-966f-4218aba98e02@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/7] block/ssh: don't call libssh2_init()
 in block_init()
References: <cover.1504112061.git.jcody@redhat.com>
 <af4268153bce149a9599e4079a0f8908e32fdef8.1504112061.git.jcody@redhat.com>
 <94eb9a23-1cb7-a139-039e-4d0f138a6244@redhat.com>
 <20170830201107.GL4770@localhost.localdomain>
In-Reply-To: <20170830201107.GL4770@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/30/2017 03:11 PM, Jeff Cody wrote:
> On Wed, Aug 30, 2017 at 02:40:16PM -0500, Eric Blake wrote:
>> On 08/30/2017 11:56 AM, Jeff Cody wrote:
>>> We don't need libssh2 failure to be fatal (we could just opt to not
>>> register the driver on failure). But, it is probably a good idea to
>>> avoid external library calls during the block_init(), and call the
>>> libssh2 global init function on the first usage, returning any errors=
=2E
>>>

>>
>> Is returning 'ret' from libssh2_init() wise?
>>
>> If 'ret' is not important, you could simplify this:
>>
>> if (ssh_state_init(s, errp)) {
>>     return -1;
>> }
>=20
> Good point, not sure if a non-zero ret from libssh2_init() provides mea=
ning
> beyond 'error' for us.  Maybe return -EIO instead of -1, though?

You used -EIO for 5/7, so that does sound a bit better.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--losKi7du4COasRFFtkUuEF06scKxaUd02
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmnHDwACgkQp6FrSiUn
Q2pE7Qf/fUJVwrkT+hldNW7ENlIGI8TZ16MaqEWKSrzbp9t/O4hr2W2kydGRkVLB
3+ldUnTNs3df8rPdGsQIC41f/AIqfeLIuqKdreSN/AfP7cZbHXVWSu4+8DsTIR6v
0kODhVckCL3MXnx2cqdr5FUgjERil0JKB2lonLIZXCMTcCWrEzSa6L5PpK5nI4cd
3szS3lpqAwThzpnikPaurYOSkfoUZU/tbH7AMI9Fd81tJG632PJ4NWpib82YohiC
a6KTvHFzatierj2OIamcUVVm+hgKgL4ll+MeBNtB2BodsRQwSQb48SZ+jZVW+eVS
nm5RRONH3sAQOi4KpFg/lP6d6q2hlA==
=e76T
-----END PGP SIGNATURE-----

--losKi7du4COasRFFtkUuEF06scKxaUd02--

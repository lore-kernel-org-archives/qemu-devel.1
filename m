Received: from eggs.gnu.org ([2001:4830:134:3::10]:49286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfp4c-0007UJ-5g
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 11:08:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfp4a-00046M-Nw
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 11:08:34 -0400
References: <20170809203808.31725-1-eblake@redhat.com>
	<20170810130240.GC3650@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <daa65e6b-77d5-7779-faf4-8e76a811ba86@redhat.com>
Date: Thu, 10 Aug 2017 10:08:23 -0500
MIME-Version: 1.0
In-Reply-To: <20170810130240.GC3650@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="udwPOXLG0Cf1UXcO47wecoQemcUREgo47"
Subject: Re: [Qemu-devel] [PATCH for-2.10 v2 0/5] More bdrv_getlength() fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jcody@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--udwPOXLG0Cf1UXcO47wecoQemcUREgo47
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jcody@redhat.com
Message-ID: <daa65e6b-77d5-7779-faf4-8e76a811ba86@redhat.com>
Subject: Re: [PATCH for-2.10 v2 0/5] More bdrv_getlength() fixes
References: <20170809203808.31725-1-eblake@redhat.com>
 <20170810130240.GC3650@localhost.localdomain>
In-Reply-To: <20170810130240.GC3650@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/10/2017 08:02 AM, Kevin Wolf wrote:
> Am 09.08.2017 um 22:38 hat Eric Blake geschrieben:
>> We already have a lot of bdrv_getlength() fixes in -rc2; so I think
>> this is still okay for -rc3.
>>
>> v1 was here (with a typo'd subject line):
>> https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg01226.html
>>
>> Since v1:
>> - patch 1: fix error message capitalization (Kevin, R-b kept)
>> - fix locking bug in original patch 2 (Kevin)
>> - split original patch 2 into two parts: signature update, and
>> added error checking (Kevin)
>> - check for unlikely integer overflow before bdrv_truncate (Jeff)
>>
>> 001/5:[0002] [FC] 'vpc: Check failure of bdrv_getlength()'
>> 002/5:[down] 'qcow: Change signature of get_cluster_offset()'
>> 003/5:[0048] [FC] 'qcow: Check failure of bdrv_getlength() and bdrv_tr=
uncate()'
>> 004/5:[----] [--] 'qcow2: Drop debugging dump_refcounts()'
>> 005/5:[----] [--] 'qcow2: Check failure of bdrv_getlength()'
>=20
> Looks good to me, but as the bug is far from being critical, I'd rather=

> apply the more complex qcow1 patches only to block-next. The vpc and
> qcow2 parts seems a lot less risky, so 2.10 should be okay for them.
>=20
> What do you think?

The argument for NOT doing the qcow changes (patches 2 and 3): the only
place where we are not checking for failures is part of
get_cluster_offset() - but in all likelihood, if we were unable to
determine or change the length of the backing file, we will have nearby
problems that will ultimately cause failure soon enough.  Furthermore,
it's not a regression (we've had several releases with the problem), and
qcow is not a good format (it's painfully slow, and we strongly
recommend qcow2 instead) - so no one will be hitting any actual bugs in
practice.

I'll trust your judgment as maintainer, so taking just 1, 4, and 5 in
2.10 is fine.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--udwPOXLG0Cf1UXcO47wecoQemcUREgo47
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmMducACgkQp6FrSiUn
Q2qWlQf9EVVmEz4Xd6tj/uBKfr5O4rQuzhae257TbHaMrNiZ+DzjKSJp/cyTj0zS
FfSbMMcYGb/OwFN21K9F88gNdy19L9YmyOjeRBPjXtDGdhwi1qWwi4rrEkio17D2
rArRch0JjAa2RBFEE+5SPvpqrd+VTsTkLFDJ0joauwz4zwiLPLgR5S/x4lgUdo0s
JaEiYtROxMwfsTKUY+uLzAVMtzHMQ0K1xwfL7+oAKUdSg4vahE5MZZ6zwYk4JETc
lBwjo40edzzD29/BG1nAMZxez/K4uAs+Bz2hGS+R88GkTNiPCivUEaACkfr5A/lP
CNWodtTMBLz/T/ObNaggQEs7+/cOZg==
=WgFp
-----END PGP SIGNATURE-----

--udwPOXLG0Cf1UXcO47wecoQemcUREgo47--

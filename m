Received: from eggs.gnu.org ([2001:4830:134:3::10]:33203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e4p4j-0000gs-IX
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e4p4g-0004b0-Tv
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:12:01 -0400
References: <cover.1508257445.git.jcody@redhat.com>
	<85b170e6abd3f92bee7449d0970f6ba24e589c72.1508257445.git.jcody@redhat.com>
	<20171018135957.GD17962@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <62cadfa1-326a-1027-8933-d2fb3aa4c627@redhat.com>
Date: Wed, 18 Oct 2017 09:11:41 -0500
MIME-Version: 1.0
In-Reply-To: <20171018135957.GD17962@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="15eBP7g6WgjHophk52CqbdbtGhs4aTUIV"
Subject: Re: [Qemu-devel] [PATCH v5 05/10] qemu-iotests: change qemu pid and
 fd tracking / cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--15eBP7g6WgjHophk52CqbdbtGhs4aTUIV
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com,
 kwolf@redhat.com
Message-ID: <62cadfa1-326a-1027-8933-d2fb3aa4c627@redhat.com>
Subject: Re: [PATCH v5 05/10] qemu-iotests: change qemu pid and fd tracking /
 cleanup
References: <cover.1508257445.git.jcody@redhat.com>
 <85b170e6abd3f92bee7449d0970f6ba24e589c72.1508257445.git.jcody@redhat.com>
 <20171018135957.GD17962@localhost.localdomain>
In-Reply-To: <20171018135957.GD17962@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/18/2017 08:59 AM, Jeff Cody wrote:
> On Tue, Oct 17, 2017 at 12:31:50PM -0400, Jeff Cody wrote:
>> So that later patches can cleanup running qemu processes called from
>> different subshells, track resources to cleanup in pid and fd list
>> files.
>>
>> In subsquent patches, ./check will kill all QEMU processes launched wi=
th

s/subsquent/subsequent/

>> the common.qemu framework, and the tests will not need to cleanup
>> manually (unless they want to do so as part of the test, e.g. wait for=

>> a process to end such as migration).
>>
>> Signed-off-by: Jeff Cody <jcody@redhat.com>
>> ---

>> +    # The FIFOs do not correspond to process entry in the pidlist, so=

>> +    # just clean them up afterwards
>> +    while read fifo_name
>> +    do
>> +        # make sure entries are inside the $TEST_DIR
>> +        fifo_path=3D$(dirname -z $(realpath "$fifo_name"))
>=20
> Pointing out another issue I noticed after testing on a different machi=
ne:
> in Bash > 4.4, this generates a warning, which breaks diff stats.  The =
fix
> is to drop the '-z':
>         fifo_path=3D$(dirname $(realpath "$fifo_name"))

That, and 'dirname -z' is GNU-specific.  It is handy for getting the
name of a directory that ends in newline (yes, you are evil if you do
'mkdir $"abc\n"', because $(dirname "$dir") will strip that trailing
newline and likely trip up a poorly-written script to operate on 'abc'
instead).  But as we already check for no whitespace in $TESTDIR, we
don't have to rely on -z to work around evil directories with a name
ending in newline.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--15eBP7g6WgjHophk52CqbdbtGhs4aTUIV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnnYR0ACgkQp6FrSiUn
Q2rKJggAmthMaMmNgLVK6pTzloUfQK3VcIcYsw/GfKO6OfMFMWOw51gX1QrqaCm5
ui38nL+n5cGmek0gU7nGX/aiwDOTOlmP8zRvWMkoAM/0AtyFYNlD3XbuIN2LGpl7
sGd5rh5M6p9lkdZcR/ilJ65IpYUiWCx8ebOaZNOIc+mVitjqNVSS7Kvw10jl95Vi
l3F07r4FWExln6g6Wcy8RKqNUi0CiBJ/5gIwwawbSQR1PtYjrtUu61+MKhBAFtEy
Q/hsxt0AACns3qlm3ECg96zZ6AD9n/qZeFbRWWVEXOmIoVaco6+UAnxYCK5eqpB8
V6/kHfgyytotBaAdCT2iCTlz2EgSiQ==
=Y4Cb
-----END PGP SIGNATURE-----

--15eBP7g6WgjHophk52CqbdbtGhs4aTUIV--

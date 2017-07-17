Received: from eggs.gnu.org ([2001:4830:134:3::10]:58466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXApx-0004UB-Hc
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:33:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXApw-00049l-HF
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:33:41 -0400
References: <20170717142310.17048-1-eblake@redhat.com>
	<f6c0aba5-7406-5bd6-fd48-a0d09ebb050b@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b6dd33f6-50ad-7308-396e-8bbb88de3d5a@redhat.com>
Date: Mon, 17 Jul 2017 13:33:28 -0500
MIME-Version: 1.0
In-Reply-To: <f6c0aba5-7406-5bd6-fd48-a0d09ebb050b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CeVE7Ttd5J9EMdtXDRgoaWOP21vG5K77J"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] nbd: Fix iotests failure due
 to changed client error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, mreitz@redhat.com, Ishani <chugh.ishani@research.iiit.ac.in>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CeVE7Ttd5J9EMdtXDRgoaWOP21vG5K77J
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, mreitz@redhat.com,
 Ishani <chugh.ishani@research.iiit.ac.in>
Message-ID: <b6dd33f6-50ad-7308-396e-8bbb88de3d5a@redhat.com>
Subject: Re: [Qemu-block] [PATCH] nbd: Fix iotests failure due to changed
 client error message
References: <20170717142310.17048-1-eblake@redhat.com>
 <f6c0aba5-7406-5bd6-fd48-a0d09ebb050b@redhat.com>
In-Reply-To: <f6c0aba5-7406-5bd6-fd48-a0d09ebb050b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/17/2017 01:12 PM, John Snow wrote:
>=20
>=20
> On 07/17/2017 10:23 AM, Eric Blake wrote:
>> Commit 8ecaeae8 changed the way the client requests an NBD export,
>> and in the process also changed the resulting error message when
>> the export is not present, breaking a couple of iotests.  The error
>> message is now directly given by the server (a failed NBD_OPT_GO)
>> instead of implied by the client (after exhausting NBD_OPT_LIST),
>> but looking at the testsuite changes, it proves worthwhile to
>> reword the error message to be slightly less verbose (as this is
>> one particular error message likely to be hit by a user).
>>
>> Note that the error message is now sensitive to which binary is
>> running the server as well as the client (since the expected
>> output is replaying a message received from the server); in

also depends on the server being new enough to understand NBD_OPT_GO.
I'll tweak the commit message before sending the pull request

>> general iotests are run on client and server from the same source
>> code base, but if it proves problematic in practice, we'll have
>> to tweak or sanitize the output somehow.
>>
>> Reported-by: Kevin Wolf <kwolf@redhat.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> Thanks, fixes it up for me.
>=20
> Tested-by: John Snow <jsnow@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>

Thanks; queued on my NBD branch:
git://repo.or.cz/qemu/ericb.git nbd

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CeVE7Ttd5J9EMdtXDRgoaWOP21vG5K77J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlltAvgACgkQp6FrSiUn
Q2rJ8Qf+JKZwBupm9alFeFYYbil0vFfURKyjuPkBWk5qUmBd9KLD0hQCzzXYqr1+
6Yl4zc6CHZaaffdaCV90f0KVMxHqaRQmU+k1d6zf/iIhLs3NNMnQa/KzNF3IJ84b
MirHiwyFo6ouPHJG72IJ/2SdaA8tVpIacd0Fp7n9LMig+5YB8ZqKOSwRgkI4zkrk
A6K3R43gaIZ7vypsPSr2FtmiMODI4x6ka4N3uYYEBWZCGaP7PuS+K6xFc+wdkrpS
DtkBsk4LjQWE0PhmI4RM+R6q9WVH2PV9n6+Pz4m2RYUo67jIQOy0T/7Sa/tXxUt5
pjLo3Bk7jiOdpUVgrt7C2C6cOW+aMw==
=3K/r
-----END PGP SIGNATURE-----

--CeVE7Ttd5J9EMdtXDRgoaWOP21vG5K77J--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:43868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e07OS-0000fd-N8
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:44:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e07ON-0002Qk-5F
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:44:56 -0400
References: <20171004014347.25099-1-eblake@redhat.com>
	<20171004014347.25099-6-eblake@redhat.com>
	<20171005144119.GG10969@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <36585356-7cb7-30c7-bfe4-db6a56796b1d@redhat.com>
Date: Thu, 5 Oct 2017 09:44:36 -0500
MIME-Version: 1.0
In-Reply-To: <20171005144119.GG10969@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MxHIMhgElSuMXfF21xIbHk2EE11bqMPAr"
Subject: Re: [Qemu-devel] [PATCH v2 5/5] iotests: Add test 197 for covering
 copy-on-read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MxHIMhgElSuMXfF21xIbHk2EE11bqMPAr
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com,
 jcody@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <36585356-7cb7-30c7-bfe4-db6a56796b1d@redhat.com>
Subject: Re: [PATCH v2 5/5] iotests: Add test 197 for covering copy-on-read
References: <20171004014347.25099-1-eblake@redhat.com>
 <20171004014347.25099-6-eblake@redhat.com>
 <20171005144119.GG10969@stefanha-x1.localdomain>
In-Reply-To: <20171005144119.GG10969@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/05/2017 09:41 AM, Stefan Hajnoczi wrote:
> On Tue, Oct 03, 2017 at 08:43:47PM -0500, Eric Blake wrote:
>> Add a test for qcow2 copy-on-read behavior, including exposure
>> for the just-fixed bugs.
>>
>> The copy-on-read behavior is always to a qcow2 image, but the
>> test is careful to allow running with most image protocol/format
>> combos as the backing file being copied from (luks being the
>> exception, as it is harder to pass the right secret to all the
>> right places).  In fact, for './check nbd', this appears to be
>> the first time we've had a qcow2 image wrapping NBD, requiring
>> an additional line in _filter_img_create to match the similar
>> line in _filter_img_info.
>>
>> Invoking blkdebug to prove we don't write too much took some
>> effort to get working; and it requires that $TEST_WRAP (based
>> on $TEST_DIR) not be subject to word splitting.  We may decide
>> later to have the entire iotests suite use relative rather than
>> absolute names, to avoid problems inherited by the absolute
>> name of $PWD or $TEST_DIR, at which point the sanity check in
>> this commit could be simplified.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>

>=20
> Aside from the 2GB request issue:

I'm wondering if it is easy enough to just capture the qemu-io output
into a temporary holding area, grep that for success or OOM, then skip
the test on OOM (for small machines) or log the success (for beefy
spots), so that at least the test will not hold up CI efforts on small
machines.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--MxHIMhgElSuMXfF21xIbHk2EE11bqMPAr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnWRVQACgkQp6FrSiUn
Q2pVsQf8DKuOPw1JGmtcpnH8C/JREGavqRv0WCJverPzLLkk88EXUekxmvn1eST/
HIfEI0yCaQ9Fh0C36P4T7TyROzO86fVjh451AhFKjyZyEscVN4/B1XPozzFjaF7c
SRHSbRevRHfgL6r7h5YA2+nzHTlu9tADdR1doWy17GL8lQg2EV9BntStGwvzdoPS
XU0RWBdotW8od1KHCxlVw4zFPA22X62JsVGJNrGHXxRQJg4+PDKwxjyOzr5kT/t+
EHJtFymdGBSqIY10u1vbBMvitYmJGGZAKeZ4QooTQVEky6G2gU41CrzhZr16pUNJ
kxK665ZdD3J9/IYrKIbdrJeVUXkqcQ==
=xtrn
-----END PGP SIGNATURE-----

--MxHIMhgElSuMXfF21xIbHk2EE11bqMPAr--

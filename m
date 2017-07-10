Received: from eggs.gnu.org ([2001:4830:134:3::10]:44673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUbSm-0002xe-MF
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:23:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUbSl-0006v9-Lh
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:23:08 -0400
References: <20170706163828.24082-1-pbonzini@redhat.com>
	<20170706163828.24082-2-pbonzini@redhat.com>
	<20170710132121.GF14195@stefanha-x1.localdomain>
	<906526d4-218b-6a19-09cd-9dbaa014261d@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bd25fda6-ff7f-41d4-12fe-bfc44dad3e96@redhat.com>
Date: Mon, 10 Jul 2017 11:22:55 -0500
MIME-Version: 1.0
In-Reply-To: <906526d4-218b-6a19-09cd-9dbaa014261d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lq6pOtmeaiXgIWqs7Kjtt7x3ErTfb2fOJ"
Subject: Re: [Qemu-devel] [PATCH 01/11] block: prepare write threshold code
 for thread safety
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: famz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lq6pOtmeaiXgIWqs7Kjtt7x3ErTfb2fOJ
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: famz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <bd25fda6-ff7f-41d4-12fe-bfc44dad3e96@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/11] block: prepare write threshold code
 for thread safety
References: <20170706163828.24082-1-pbonzini@redhat.com>
 <20170706163828.24082-2-pbonzini@redhat.com>
 <20170710132121.GF14195@stefanha-x1.localdomain>
 <906526d4-218b-6a19-09cd-9dbaa014261d@redhat.com>
In-Reply-To: <906526d4-218b-6a19-09cd-9dbaa014261d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/10/2017 11:16 AM, Paolo Bonzini wrote:
> On 10/07/2017 15:21, Stefan Hajnoczi wrote:
>> On Thu, Jul 06, 2017 at 06:38:18PM +0200, Paolo Bonzini wrote:
>>> Code refactoring only.
>>>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>  block/write-threshold.c | 28 ++++++++++++++++------------
>>>  1 file changed, 16 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/block/write-threshold.c b/block/write-threshold.c
>>> index 0bd1a01c86..c8ebc32b4d 100644
>>> --- a/block/write-threshold.c
>>> +++ b/block/write-threshold.c
>>> @@ -37,18 +37,22 @@ static void write_threshold_disable(BlockDriverSt=
ate *bs)
>>>      }
>>>  }
>>> =20
>>> +static uint64_t exceeded_amount(const BdrvTrackedRequest *req,
>>> +                                uint64_t thres)
>>
>> Not a reason to respin, but I would prefer a more specific name so the=

>> intent of the code is easier to understand: exceeded_threshold() inste=
ad
>> of exceeded_amount().
>>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> It's the amount by which the request exceeds threshold...  Not sure wha=
t
> name would be best.

threshold_overage ?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lq6pOtmeaiXgIWqs7Kjtt7x3ErTfb2fOJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZY6nfAAoJEKeha0olJ0NqqD0IAJzXc02yz594q5AMCLTqGeKp
FOaRfXTvmwSRQlzrvMRB8B+4LeIp5xfLcyQSGVIrrdhL9EDAxTwkcNM3CI+X38pw
tU+aRpn5cdzMtwfj903N4wt78ZYAow93XH9OJa/gEY//l49asPj574yxUi4gPecR
+jXSKKa0ihgle2UxYv2qFQKWzpLKtzhyy9nIU32+lftdFfEz2ImOuZy2HRpKbSbS
aBzMhGVN98aArB7H0D/7bOEL2oOtz+aPf85lzQWDoLqFjujKWaBdmlVnWrj26SxF
CZbGQzsHdDMPQ8N2eYTdPiF5sDadAmHJ3LzfPNgQylH/24CJjcmlQ7HLFZZkTzk=
=YqYS
-----END PGP SIGNATURE-----

--lq6pOtmeaiXgIWqs7Kjtt7x3ErTfb2fOJ--

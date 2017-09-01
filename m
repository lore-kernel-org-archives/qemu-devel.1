Received: from eggs.gnu.org ([2001:4830:134:3::10]:58890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnsGj-0000SX-Jd
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 16:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnsGi-0008Se-HQ
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 16:10:21 -0400
References: <20170901105434.3288-1-berrange@redhat.com>
	<5fff868d-4d35-ec3f-cdd8-9b7363c4e6d3@redhat.com>
	<20170901143348.GP31680@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <92c6a48b-892b-e7de-bbe9-44618f4a94e9@redhat.com>
Date: Fri, 1 Sep 2017 15:10:06 -0500
MIME-Version: 1.0
In-Reply-To: <20170901143348.GP31680@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ESB1whq0bgAC2elgcNQk8lIanh970ncvO"
Subject: Re: [Qemu-devel] [PATCH 0/2] Fix / skip recent iotests with LUKS
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ESB1whq0bgAC2elgcNQk8lIanh970ncvO
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>
Message-ID: <92c6a48b-892b-e7de-bbe9-44618f4a94e9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] Fix / skip recent iotests with LUKS
 driver
References: <20170901105434.3288-1-berrange@redhat.com>
 <5fff868d-4d35-ec3f-cdd8-9b7363c4e6d3@redhat.com>
 <20170901143348.GP31680@redhat.com>
In-Reply-To: <20170901143348.GP31680@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/01/2017 09:33 AM, Daniel P. Berrange wrote:
> On Fri, Sep 01, 2017 at 09:26:30AM -0500, Eric Blake wrote:
>> On 09/01/2017 05:54 AM, Daniel P. Berrange wrote:
>>> Two recently added iotests are currently breaking 'check -luks',
>>> fix the easy one and disable the hard one.
>>>
>>> Daniel P. Berrange (2):
>>>   iotests: rewrite 192 to use _launch_qemu to fix LUKS support
>>>   iotests: blacklist 194 with the luks driver
>>
>> Since both tests involve an NBD server, I can take this series through=

>> my NBD queue.  Or, since both involve LUKS, you can push it in your ne=
xt
>> crypto pull request.  Any preferences?
>=20
> Best if either you or a block maintainer queue it i think

Okay, on my NBD queue:
http://repo.or.cz/qemu/ericb.git/shortlog/refs/heads/nbd

I'll wait to see if other NBD patches land in the next few days, but
will send a pull request within a week.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ESB1whq0bgAC2elgcNQk8lIanh970ncvO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmpvp8ACgkQp6FrSiUn
Q2rbxQgArR4+axS4PNYgu/PhBNWN19TsjGJTPwJAtH1EaSJXiiLqfLRdptjHHdxM
AfFtAU0HA1rTBDI3ZAEsqwngAkgABvVd9UIapCyU9E9q92NyDyAVWxjyf1Cb54Nu
vujMiX112XyOsvUj+bqjo1yoPSYlufpw7xQMRRSvym9tbE4lIKpkiDE0pQ9wC3Sl
h7W1FlMrbWT6afKkO1hsYZRmustdtHI2WugZt6gI9ewh6/R7B2c44qF9NIA7Xd9P
BbsKv+8WEdg/QIPa8uvQgdSdWfiRRdkL3mhgOHYgDbFEX/u3j8UsRNtxQqpHmA+o
uJsh1rtR6329Th6w6174Csm32XRW/g==
=5ZDB
-----END PGP SIGNATURE-----

--ESB1whq0bgAC2elgcNQk8lIanh970ncvO--

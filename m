Received: from eggs.gnu.org ([2001:4830:134:3::10]:49366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkX6F-0003z8-6E
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:57:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkX6E-00047J-Av
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:57:43 -0400
References: <20170823134242.12080-1-famz@redhat.com>
	<20170823134242.12080-3-famz@redhat.com>
	<dcc61514-4535-43bf-2b67-16051ef2b9c6@redhat.com>
	<20170823144746.GA1866@lemon>
From: Eric Blake <eblake@redhat.com>
Message-ID: <105b8fd4-3587-7a77-e0d5-fbf01623efc1@redhat.com>
Date: Wed, 23 Aug 2017 09:57:28 -0500
MIME-Version: 1.0
In-Reply-To: <20170823144746.GA1866@lemon>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BJQEiuLMWd8O7JXHMauEautDInwOL7sfn"
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/4] block-backend: Allow more
 "can inactivate" cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BJQEiuLMWd8O7JXHMauEautDInwOL7sfn
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>
Message-ID: <105b8fd4-3587-7a77-e0d5-fbf01623efc1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/4] block-backend: Allow more "can
 inactivate" cases
References: <20170823134242.12080-1-famz@redhat.com>
 <20170823134242.12080-3-famz@redhat.com>
 <dcc61514-4535-43bf-2b67-16051ef2b9c6@redhat.com>
 <20170823144746.GA1866@lemon>
In-Reply-To: <20170823144746.GA1866@lemon>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/23/2017 09:47 AM, Fam Zheng wrote:
> On Wed, 08/23 09:36, Eric Blake wrote:
>> On 08/23/2017 08:42 AM, Fam Zheng wrote:
>>> These two conditions corresponds to mirror job's source and target,
>>
>> s/corresponds to/correspond to a/
>>
>> [can touch up on pull request]
>>
>>> which need to be allowed as they are part of the non-shared storage
>>> migration workflow: failing to inactivate either will result in a
>>> failure during migration completion.
>>>
>>> Signed-off-by: Fam Zheng <famz@redhat.com>
>>> ---
>>>  block/block-backend.c          | 21 ++++++++++++++++-----
>>>  include/sysemu/block-backend.h |  1 +
>>>  2 files changed, 17 insertions(+), 5 deletions(-)
>>>
>>> =20
>>> -    return false;
>>> +    /* Inactivating means no more write to the image can be done, ev=
en if it's
>>
>> s/write/writes/
>>
>>> +     * guest invisible change. For block job BBs that satisfy this, =
we can just
>>
>> reads awkwardly. Maybe 'even if it's changes invisible to the guest'?
>> But I can leave your wording if I don't get confirmation.
>=20
> Not sure I understand the grammar of "it's changes" but yours must be b=
etter.
> Feel free to update it. Thanks,

If it's confusing, we can still do better.  I settled on:

no more writes to the image can be done, even if those writes would be
changes invisible to the guest.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BJQEiuLMWd8O7JXHMauEautDInwOL7sfn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmdl9gACgkQp6FrSiUn
Q2p1HggAkzEmS4n6Y0aGRw6hHC6YAW4aJyhs5N6VNGHnxPng7urDPwQrssib7gcD
4uIYUKX5/jg6CkGKF2QU8d16rfwe8e7PnQgT5Ioct6gjLLF03B0VRAr1X1uugwjr
wKhL6CUSOs23H2NdvVIA0w1LN3QPnnBGjV1eRtKHiVHBrPfvQv15jVCWSd66BOIM
4dQGmb9SkPJTUEWg/iBF1qweXKlv7Pbqn3V75eoDe5uTnERNXDckaPob9R0KAkR3
aTh7iB8eA3o8EcF1hEaSABDyBCe/RdyhkKEQJY/7X/TeMyyXbiZNL2nDV/LFhlU7
pP08PwapWyK06lfuTfFMg0/o3dpkhA==
=UWxX
-----END PGP SIGNATURE-----

--BJQEiuLMWd8O7JXHMauEautDInwOL7sfn--

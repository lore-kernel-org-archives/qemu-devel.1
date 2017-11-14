Received: from eggs.gnu.org ([2001:4830:134:3::10]:50418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEh5o-0006ay-WE
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 14:41:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEh5o-00045Y-4u
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 14:41:57 -0500
References: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1510654613-47868-2-git-send-email-anton.nefedov@virtuozzo.com>
	<7ce0d647-14c7-6874-b9d8-606a58c66b6e@redhat.com>
	<5216d1a4-84b9-3ae2-0aab-187a12588b17@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e9a5a22b-7fef-04f9-642a-8cd5375773ec@redhat.com>
Date: Tue, 14 Nov 2017 13:41:40 -0600
MIME-Version: 1.0
In-Reply-To: <5216d1a4-84b9-3ae2-0aab-187a12588b17@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="H1tnrlHBbigqP0oQpngLr5snQ3a6uHSxF"
Subject: Re: [Qemu-devel] [PATCH 1/5 for-2.11?] qcow2: reject unaligned
 offsets in write compressed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, famz@redhat.com, den@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H1tnrlHBbigqP0oQpngLr5snQ3a6uHSxF
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, famz@redhat.com, den@virtuozzo.com
Message-ID: <e9a5a22b-7fef-04f9-642a-8cd5375773ec@redhat.com>
Subject: Re: [PATCH 1/5 for-2.11?] qcow2: reject unaligned offsets in write
 compressed
References: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1510654613-47868-2-git-send-email-anton.nefedov@virtuozzo.com>
 <7ce0d647-14c7-6874-b9d8-606a58c66b6e@redhat.com>
 <5216d1a4-84b9-3ae2-0aab-187a12588b17@virtuozzo.com>
In-Reply-To: <5216d1a4-84b9-3ae2-0aab-187a12588b17@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/14/2017 12:30 PM, Anton Nefedov wrote:
> On 14/11/2017 7:50 PM, Eric Blake wrote:
>> On 11/14/2017 04:16 AM, Anton Nefedov wrote:
>>> Misaligned compressed write is not supported.
>>>
>>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>>> ---
>>> =C2=A0 block/qcow2.c | 4 ++++
>>> =C2=A0 1 file changed, 4 insertions(+)
>>
>> Should this one be applied in 2.11?
>>
>=20
> For the record, this one is pretty hard to trigger; backup and qemu-img=

> convert currently use compressed write, both make sure they operate in
> clusters.
>=20
> qemu-io is almighty though

Okay, then we definitely have a bug, and this patch is definitely 2.11
material, especially if you update the commit message to show the
trigger case:

>=20
> qemu-io> write -c -P 7 512 64k
> wrote 65536/65536 bytes at offset 512
> 64 KiB, 1 ops; 0.0187 sec (3.329 MiB/sec and 53.2566 ops/sec)
> qemu-io> read -P 7 512 64k
> Pattern verification failed at offset 512, 65536 bytes
> read 65536/65536 bytes at offset 512
> 64 KiB, 1 ops; 0.0002 sec (248.016 MiB/sec and 3968.2540 ops/sec)
> qemu-io> read -P 7 0 64k
> read 65536/65536 bytes at offset 0
> 64 KiB, 1 ops; 0.0000 sec (1.606 GiB/sec and 26315.7895 ops/sec)
>=20
> /Anton
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--H1tnrlHBbigqP0oQpngLr5snQ3a6uHSxF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloLRvQACgkQp6FrSiUn
Q2qnPggAqgzVvat4eFYTW0eo0io+xFiII7Zcp8t7o7TR0WTxhqE6+LCs2mj6t550
3HK39C9n1VkJfbK0RNRJ+Bb6TQ6oeAwE09aw18W1vwTtvw6RpK2cWCFuvyT4N6Xp
vY7wRNQESo2DE35qcaiaJIFpe7D3xdOJ+LFugsTne6daeHjP1UQkmzZB9tMG65zD
3baDXJt4pBPtQ0c9gp/kETXGDbCpt9H93yJv2QCGHON2rRVw9tSoQHAE+i6twNu0
7k0hJ/YlYQJnVwqquMQW7ILq09UB7ASUgpvd/MH/qf1FZLNFtlOxgqPz9Yhps0hH
BdhoQT6JAEYiYoAvEi1bvfUZQnCFDQ==
=UNQO
-----END PGP SIGNATURE-----

--H1tnrlHBbigqP0oQpngLr5snQ3a6uHSxF--

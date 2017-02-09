Received: from eggs.gnu.org ([2001:4830:134:3::10]:34304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbpuL-0000ym-Kb
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 09:41:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbpuK-0000gp-LZ
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 09:41:13 -0500
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-5-vsementsov@virtuozzo.com>
	<7b79d03c-0fba-ddb8-4295-b155cb26a206@redhat.com>
	<829007b8-d8a4-652c-7a23-59fbb5476cd2@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <de548107-dbff-36ca-96ba-fead03589fde@redhat.com>
Date: Thu, 9 Feb 2017 08:41:03 -0600
MIME-Version: 1.0
In-Reply-To: <829007b8-d8a4-652c-7a23-59fbb5476cd2@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uPhXwJikslRs8xhnjv7hisK2lKkJxjX4D"
Subject: Re: [Qemu-devel] [PATCH 04/18] nbd/client: refactor
 nbd_receive_starttls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uPhXwJikslRs8xhnjv7hisK2lKkJxjX4D
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com,
 stefanha@redhat.com
Message-ID: <de548107-dbff-36ca-96ba-fead03589fde@redhat.com>
Subject: Re: [PATCH 04/18] nbd/client: refactor nbd_receive_starttls
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
 <20170203154757.36140-5-vsementsov@virtuozzo.com>
 <7b79d03c-0fba-ddb8-4295-b155cb26a206@redhat.com>
 <829007b8-d8a4-652c-7a23-59fbb5476cd2@virtuozzo.com>
In-Reply-To: <829007b8-d8a4-652c-7a23-59fbb5476cd2@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/09/2017 12:20 AM, Vladimir Sementsov-Ogievskiy wrote:
> 07.02.2017 19:32, Eric Blake wrote:
>> On 02/03/2017 09:47 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Split out nbd_receive_simple_option to be reused for structured reply=

>>> option.

>>> +    return "<unknown option>";
>> Can you please consider making this include the %d representation of t=
he
>> unknown option; perhaps by snprintf'ing into static storage?  While it=

>=20
> Hmm.. The caller should free it in this case.

Only if you print it into malloc'd space. I think that printing it into
static storage may be sufficient (although then we have a race if more
than one thread is trying to use that static storage at the same time -
but do we ever have more than one thread trying to handle an error at
the same time?).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--uPhXwJikslRs8xhnjv7hisK2lKkJxjX4D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYnH9/AAoJEKeha0olJ0NqaBoH/2i6zz8pWtMFHQkgyEeX+Ikz
wv6eqe9xdv1TTO1RIfHDOickpG5ETbjw+4xczvuFQq1ryul0vvXIrINSxmlBbR1H
p9dPST3+7CanM8brgGF8yJ+APA2CVrRH7HNxqO9KWyue6xfuV3XKv1vsauqTXG8/
6fnQDgV+FK4b3YU/hmvkRsmwzr4ccpLE+tcsnm8x4EBDLlAhKLKdqhop/n0C+0qY
FAhROxaed1BkS0dUTfpGdmRdOmWrO+e31gaEimkRyxpy+Bh3OHauTRUUCrLpiD6c
NWX1MlW1NDEF7w1np/1UvrjHjqkAP4C+zpl/RrANtg2G7ihaNsA6AO7QiTN3hIU=
=qznI
-----END PGP SIGNATURE-----

--uPhXwJikslRs8xhnjv7hisK2lKkJxjX4D--

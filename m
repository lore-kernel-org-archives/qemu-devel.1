Received: from eggs.gnu.org ([2001:4830:134:3::10]:51897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cfqc6-00087Z-MG
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:14:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cfqc5-0007wj-Om
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:14:58 -0500
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-5-vsementsov@virtuozzo.com>
	<7b79d03c-0fba-ddb8-4295-b155cb26a206@redhat.com>
	<829007b8-d8a4-652c-7a23-59fbb5476cd2@virtuozzo.com>
	<de548107-dbff-36ca-96ba-fead03589fde@redhat.com>
	<e0ec9530-a87d-0f10-262d-4b2af4516eed@virtuozzo.com>
	<14aa4b87-54d4-1faa-8453-5e5dea2e346a@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <15e87bd8-38e6-a502-a8f3-99d043997b8e@redhat.com>
Date: Mon, 20 Feb 2017 10:14:49 -0600
MIME-Version: 1.0
In-Reply-To: <14aa4b87-54d4-1faa-8453-5e5dea2e346a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CaVWW1PQXoQ5uAXWvaG0JU1nQpdkkJLIw"
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
Cc: kwolf@redhat.com, famz@redhat.com, den@virtuozzo.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CaVWW1PQXoQ5uAXWvaG0JU1nQpdkkJLIw
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, den@virtuozzo.com, armbru@redhat.com,
 mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, jsnow@redhat.com
Message-ID: <15e87bd8-38e6-a502-a8f3-99d043997b8e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/18] nbd/client: refactor
 nbd_receive_starttls
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
 <20170203154757.36140-5-vsementsov@virtuozzo.com>
 <7b79d03c-0fba-ddb8-4295-b155cb26a206@redhat.com>
 <829007b8-d8a4-652c-7a23-59fbb5476cd2@virtuozzo.com>
 <de548107-dbff-36ca-96ba-fead03589fde@redhat.com>
 <e0ec9530-a87d-0f10-262d-4b2af4516eed@virtuozzo.com>
 <14aa4b87-54d4-1faa-8453-5e5dea2e346a@redhat.com>
In-Reply-To: <14aa4b87-54d4-1faa-8453-5e5dea2e346a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/11/2017 01:30 PM, Eric Blake wrote:
>>>>> On 02/03/2017 09:47 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>>>> Split out nbd_receive_simple_option to be reused for structured re=
ply
>>>>>> option.
>>>>>> +    return "<unknown option>";
>>>>> Can you please consider making this include the %d representation o=
f
>>>>> the
>>>>> unknown option; perhaps by snprintf'ing into static storage?  While=
 it

> If you're still worried about the race (I'm not), to the point that you=

> don't want to use static storage just to avoid g_malloc(), then another=

> option is to make nbd_opt_name() take an input parameter for a buffer
> and max size, and let the caller provide stack-based storage for
> computing the resulting message (similar to how strerror_r does things)=
=2E

Or, as long as the caller prints the value as well as the reverse-mapped
name, that would work too.  I'm going to add such a reverse-mapping for
my NBD_INFO_* patches about to land later today, so I'll make my
counter-proposal for NBD_OPT_* along those lines as part of my series.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--CaVWW1PQXoQ5uAXWvaG0JU1nQpdkkJLIw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYqxX5AAoJEKeha0olJ0NqEEIH/Apt3+343AVROV5xLZspxL/l
8nYMRYD0v8dCuB4+tEDzw7agV6Dtd/1fJB7YGVWlsth0BjclcDBjo08C7iwDph1W
g9jZRNe62xG+1pg6ypT3gvKowCI1pFgVlcVWQjOdkfrWrOWnJC4S1t5VxA3UMVaa
5Ag/HVz8F8FJ8aHqNLNUrp7J7cY4EkgmkOYhXIz3/q0nBpsv+TjUNSAHKuwIPiRx
EogMVGBueiRi2nsOnQ58SPhKqKaZZFf/lqzRo//eXs/rMDa4bA60HMkiFYwv3zqd
wjjtLMXTD6WoBACdxJaBOok3mmgOIJlFfuZeLiPLjiL+70v/njfEhPzrvSpohr4=
=p8Ac
-----END PGP SIGNATURE-----

--CaVWW1PQXoQ5uAXWvaG0JU1nQpdkkJLIw--

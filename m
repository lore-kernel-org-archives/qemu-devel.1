Received: from eggs.gnu.org ([2001:4830:134:3::10]:34894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtyNQ-0004Mi-4e
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtyNP-0004uv-9X
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:54:28 -0400
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
	<20170918135935.255591-4-vsementsov@virtuozzo.com>
	<d554b537-54da-2a70-66c7-722f2c27f4da@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7df363e9-4f05-6b90-5ee9-dd848c52857d@redhat.com>
Date: Mon, 18 Sep 2017 10:54:19 -0500
MIME-Version: 1.0
In-Reply-To: <d554b537-54da-2a70-66c7-722f2c27f4da@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CFCtkQFhvADkNpIhaDlUgT9sxSkdacHVv"
Subject: Re: [Qemu-devel] [PATCH v2 3/7] block/nbd-client: refactor reading
 reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CFCtkQFhvADkNpIhaDlUgT9sxSkdacHVv
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <7df363e9-4f05-6b90-5ee9-dd848c52857d@redhat.com>
Subject: Re: [PATCH v2 3/7] block/nbd-client: refactor reading reply
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
 <20170918135935.255591-4-vsementsov@virtuozzo.com>
 <d554b537-54da-2a70-66c7-722f2c27f4da@redhat.com>
In-Reply-To: <d554b537-54da-2a70-66c7-722f2c27f4da@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/18/2017 10:43 AM, Paolo Bonzini wrote:
> On 18/09/2017 15:59, Vladimir Sementsov-Ogievskiy wrote:
>> Read the whole reply in one place - in nbd_read_reply_entry.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> ---
>>  block/nbd-client.h |  1 +
>>  block/nbd-client.c | 42 ++++++++++++++++++++++++------------------
>>  2 files changed, 25 insertions(+), 18 deletions(-)
>>

>=20
> I am not sure this is an improvement.  In principle you could have
> commands that read replies a bit at a time without using a QEMUIOVector=
=2E

Right now we don't, but the most likely point where this would be an
issue is the fact that we want to implement structured replies (the
server can send more than one response to a single request from the
client) in order to then implement block status queries (where the
server can send piecemeal information in response to a query, and the
client could very easily want to handle information as it comes in
rather than waiting for the entire server response, especially if the
amount of information returned by the server is not known a priori by
the client, the way the length is known in advance for NBD_CMD_READ, but
instead learned partway through the reply).  I guess the question
becomes a matter of whether we are over-constraining future additions by
making this refactoring, or whether we can still implement block status
queries using a single QEMUIOVector.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CFCtkQFhvADkNpIhaDlUgT9sxSkdacHVv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm/7CsACgkQp6FrSiUn
Q2o0AwgAqzTlWXM/kflvpUySktRwnVwcGTRrfI/WHDTATbWy/il4i3IuJRGmJW08
OjQ2KqBiwHd+xSmqPwHf0Gs3iGJBCg+8dGhO/ahqQEu+pf4q5vfW/7b3o99NmLRV
RMBxgD84Xom6jlBBluWs7GgQobOshnkjcEqw8njPLxUHhjMglxZHCKjVJPjzS/iX
oE5d+OjCK5ZKVjPdKsusKkmVdRBzll5CA27zngsca23RILaHEZLwdByPWsAsRj6u
kOST8Tdh3Vc506SWNlpNehJFJraAMxr+rAVpC3QPp9E0TQgFJe0KK9Hl2nNNSjDX
BSs11U/dxXd4eKsXtFs0O1DB7E0uRw==
=Z/i0
-----END PGP SIGNATURE-----

--CFCtkQFhvADkNpIhaDlUgT9sxSkdacHVv--

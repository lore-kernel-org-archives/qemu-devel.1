Received: from eggs.gnu.org ([2001:4830:134:3::10]:42595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3nTl-0002DQ-CU
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 14:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3nTk-0004gw-GB
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 14:49:53 -0400
References: <20180403110810.25624-1-kwolf@redhat.com>
	<d1633a50-2aad-af64-081c-bfac72b89e12@redhat.com>
	<20180404154141.GS38016@angien.pipo.sk>
	<20180404155420.GG4482@localhost.localdomain>
	<98cbcf10-6dd4-3373-5b08-f5c73691fa73@redhat.com>
	<20180404183755.GI4482@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <add8a5a5-0ba1-fae0-05b9-e909165ef0b7@redhat.com>
Date: Wed, 4 Apr 2018 13:49:37 -0500
MIME-Version: 1.0
In-Reply-To: <20180404183755.GI4482@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EKBRPGgm5MQN6NH2DwbZZ34Z2ljoBevO7"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.12] gluster: Fix
 blockdev-add with server.N.type=unix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, mreitz@redhat.com, prasanna.kalever@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EKBRPGgm5MQN6NH2DwbZZ34Z2ljoBevO7
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 qemu-devel@nongnu.org, mreitz@redhat.com, prasanna.kalever@redhat.com
Message-ID: <add8a5a5-0ba1-fae0-05b9-e909165ef0b7@redhat.com>
Subject: Re: [Qemu-block] [PATCH for-2.12] gluster: Fix blockdev-add with
 server.N.type=unix
References: <20180403110810.25624-1-kwolf@redhat.com>
 <d1633a50-2aad-af64-081c-bfac72b89e12@redhat.com>
 <20180404154141.GS38016@angien.pipo.sk>
 <20180404155420.GG4482@localhost.localdomain>
 <98cbcf10-6dd4-3373-5b08-f5c73691fa73@redhat.com>
 <20180404183755.GI4482@localhost.localdomain>
In-Reply-To: <20180404183755.GI4482@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/04/2018 01:37 PM, Kevin Wolf wrote:
> Am 04.04.2018 um 20:16 hat Eric Blake geschrieben:
>> On 04/04/2018 10:54 AM, Kevin Wolf wrote:
>>
>>>>> Should we also add a deprecation warning for 'socket' and update th=
e
>>>>> deprecation documentation, so we can start the clock ticking on get=
ting
>>>>> rid of maintaining the back-compat glue forever?
>>>>

> We only strictly need it in introspection at the time when we remove th=
e
> old option. But maybe it would be nicer to wait with the deprecation
> error_report() until libvirt has a chance to avoid the warning.

Makes sense - so no deprecation warning for 2.12, and the timeline for
performing a deprecation is shifted by a couple of releases after the
first time we introduce proper introspection support.  Which makes this
patch fine as-is.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--EKBRPGgm5MQN6NH2DwbZZ34Z2ljoBevO7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrFHkEACgkQp6FrSiUn
Q2pF2Qf9H7NibOm+XSK3VCSckjGFYYUsYl+Gkfc4hlHQXBbjFOS0sHDUuLPWQCYg
ijlORLecOvyvYoPWqIWJAWtE+ZwVa0rrjtF/NSGh25Wn80OSWclG8f29iJ7iIdsf
FzaYcIUREr24NA7puGVm5TwOBEVvokpzHiQNbjTDhR3pw6XxXHQExzN4nPbGYNO/
SPSFcACrCGRjzq+Z79dbKc91tU1KVGYSQgyiA4qqZc380oWEKhm/12H+zsKcY/K2
n+WKnup5xZjtLorpLm46m1aasVX8Xw0NG0c4DYkhz5FxNQgi6kbvzaZvY4z8waFN
ghUALxRUwe3lEzchE+9Shx/MwUMtOQ==
=QzGM
-----END PGP SIGNATURE-----

--EKBRPGgm5MQN6NH2DwbZZ34Z2ljoBevO7--

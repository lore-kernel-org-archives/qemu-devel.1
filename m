Received: from eggs.gnu.org ([2001:4830:134:3::10]:43640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duPiT-000246-Mq
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 17:06:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duPiP-0006oD-1v
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 17:06:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1duPiO-0006nk-PQ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 17:05:56 -0400
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
	<1505375436-28439-7-git-send-email-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0888aa23-a2a9-6080-d6c0-7522c86b5eb4@redhat.com>
Date: Tue, 19 Sep 2017 16:05:48 -0500
MIME-Version: 1.0
In-Reply-To: <1505375436-28439-7-git-send-email-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JT29wFHwrSO0T8mDcjdn8eSkF4St9ts7l"
Subject: Re: [Qemu-devel] [RFC 06/15] monitor: move the cur_mon hack deeper
 for QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JT29wFHwrSO0T8mDcjdn8eSkF4St9ts7l
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>,
 Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <0888aa23-a2a9-6080-d6c0-7522c86b5eb4@redhat.com>
Subject: Re: [RFC 06/15] monitor: move the cur_mon hack deeper for QMP
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
 <1505375436-28439-7-git-send-email-peterx@redhat.com>
In-Reply-To: <1505375436-28439-7-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/14/2017 02:50 AM, Peter Xu wrote:
> In monitor_qmp_read(), we have the hack to temporarily replace the
> cur_mon pointer.  Now we move this hack deeper inside the QMP dispatche=
r
> routine since the Monitor pointer can be passed in to that using the ne=
w
> JSON Parser opaque field now.
>=20
> This does not make much sense as a single patch.  However, this will be=

> a big step for the next patch, when the QMP dispatcher routine will be
> splitted from the QMP parser.

English is weird: 'split' is the word for present, past, and past
participle tenses; there is no word 'splitted'.

>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--JT29wFHwrSO0T8mDcjdn8eSkF4St9ts7l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnBhqwACgkQp6FrSiUn
Q2qZFwf9Hlww9GNtMMw7PL9ScuHiibfWcul3XYvPOh7/DjO8CKgeBYxOIJzHKS7G
73NpJmmuSoQKU/uuI3hsRvICyVzUPsFKM9Omq+wY2HoclbPc6wi5n/l58TsTTDdt
Jq3+0/90PiIoLEbRgx5CHXgwZ1dj2SvqPVyLcWuzzTGiaAepeLUsDNv4gK5P5WjF
IkxDGWxY+GZU6lREZHaO8UvbQmi64LUvrD8BV0lrHALgK0bfDdAA5lPIdw5QTNsJ
JGTDxNHTIe7bwSBgVZ8aX0sG6G9dnE1rOAtnehjE5lCxvUGgFKohXiwEstwEK32i
mkuPTPTzfNVsThwj7nS6ThAHXHTOfA==
=Jugu
-----END PGP SIGNATURE-----

--JT29wFHwrSO0T8mDcjdn8eSkF4St9ts7l--

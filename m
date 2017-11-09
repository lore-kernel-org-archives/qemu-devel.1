Received: from eggs.gnu.org ([2001:4830:134:3::10]:59908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCo9R-0002zJ-Gt
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:49:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCo9Q-0006pz-NP
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:49:53 -0500
References: <20171109102652.6360-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2f50050a-c7f9-43c7-5c2a-8643f4c33126@redhat.com>
Date: Thu, 9 Nov 2017 08:49:41 -0600
MIME-Version: 1.0
In-Reply-To: <20171109102652.6360-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Nb69iE5FfsEv4jfodLCpO1N8nkuAFoKBR"
Subject: Re: [Qemu-devel] [PATCH] coroutine: simplify co_aio_sleep_ns()
 prototype
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Nb69iE5FfsEv4jfodLCpO1N8nkuAFoKBR
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2f50050a-c7f9-43c7-5c2a-8643f4c33126@redhat.com>
Subject: Re: [PATCH] coroutine: simplify co_aio_sleep_ns() prototype
References: <20171109102652.6360-1-stefanha@redhat.com>
In-Reply-To: <20171109102652.6360-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/09/2017 04:26 AM, Stefan Hajnoczi wrote:
> The AioContext pointer argument to co_aio_sleep_ns() is only used for
> the sleep timer.  It does not affect where the caller coroutine is
> resumed.
>=20
> Due to changes to coroutine and AIO APIs it is now possible to drop the=

> AioContext pointer argument.  This is safe to do since no caller has
> specific requirements for which AioContext the timer must run in.
>=20
> This patch drops the AioContext pointer argument and renames the
> function to simplify the API.

And it fixes a stale comment ;)

>=20
> Reported-by: Paolo Bonzini <pbonzini@redhat.com>
> Reported-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/qemu/coroutine.h    | 6 +-----
>  block/null.c                | 3 +--
>  block/sheepdog.c            | 3 +--
>  blockjob.c                  | 2 +-
>  util/qemu-coroutine-sleep.c | 4 ++--
>  5 files changed, 6 insertions(+), 12 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Nb69iE5FfsEv4jfodLCpO1N8nkuAFoKBR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloEawUACgkQp6FrSiUn
Q2qpYQf/VlyrY2fBXgV1Qo8egQSjBxCPERJ08Eojct33TXgWAOtgnTLTcxcLcXdX
W+/sHYi4MZeV+by9EmqXBi8257yifF9hZjZT2JtY6lXaQFJBGOO8Nk4GUPXswrOn
3af1B5uppF+zfMAnGKI7eXejEaTl8RVjwASfeHl5zdrkA+1A56eEq+Y60i5COGJp
VJL0FYMglBpG3jjDvSYNqS3pC2v1a9ox2/scn4n/havHHUAiT48jeq/jo37bUGt+
ysseiQUdbEQidwz0vB4pK+jwfPUxugsh13YTsENTMzNWcbPv/qVy2tW3342TnfHy
qUKOWTxVzDlTWoP9PhU1n9h/f0IK1Q==
=vGo8
-----END PGP SIGNATURE-----

--Nb69iE5FfsEv4jfodLCpO1N8nkuAFoKBR--

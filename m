Received: from eggs.gnu.org ([2001:4830:134:3::10]:55928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dehP6-0001J4-HE
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:45:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dehP1-0007EW-HD
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:45:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dehP1-0007Dv-7W
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:44:59 -0400
References: <1502109458-31251-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1502109458-31251-6-git-send-email-pradeep.jagadeesh@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8d3843e5-3e6e-84fc-c568-521603abb4c2@redhat.com>
Date: Mon, 7 Aug 2017 07:44:55 -0500
MIME-Version: 1.0
In-Reply-To: <1502109458-31251-6-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lVTsfwm2MGftTqviU498Bxo9dW64Clw0L"
Subject: Re: [Qemu-devel] [PATCH V8 5/6] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Markus Armbruster <armbru@redhat.com>, alberto garcia <berto@igalia.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lVTsfwm2MGftTqviU498Bxo9dW64Clw0L
From: Eric Blake <eblake@redhat.com>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, alberto garcia <berto@igalia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org
Message-ID: <8d3843e5-3e6e-84fc-c568-521603abb4c2@redhat.com>
Subject: Re: [PATCH V8 5/6] fsdev: QMP interface for throttling
References: <1502109458-31251-1-git-send-email-pradeep.jagadeesh@huawei.com>
 <1502109458-31251-6-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1502109458-31251-6-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/07/2017 07:37 AM, Pradeep Jagadeesh wrote:
> This patch introduces qmp interfaces for the fsdev
> devices. This provides two interfaces one
> for querying info of all the fsdev devices. The second one
> to set the IO limits for the required fsdev device.
>=20
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> ---
>  Makefile                    |  4 +++
>  fsdev/qemu-fsdev-dummy.c    | 11 ++++++
>  fsdev/qemu-fsdev-throttle.c | 76 +++++++++++++++++++++++++++++++++++++=
+++
>  fsdev/qemu-fsdev-throttle.h |  8 +++--
>  fsdev/qemu-fsdev.c          | 38 ++++++++++++++++++++
>  monitor.c                   |  5 +++
>  qapi-schema.json            |  3 ++
>  qapi/fsdev.json             | 84 +++++++++++++++++++++++++++++++++++++=
++++++++
>  qmp.c                       | 14 ++++++++
>  9 files changed, 241 insertions(+), 2 deletions(-)
>  create mode 100644 qapi/fsdev.json
>=20

> +##
> +# @fsdev-set-io-throttle:
> +#
> +# Change I/O limits for a 9p/fsdev device.
> +#
> +# I/O limits can be enabled by setting throttle value to non-zero numb=
er.
> +#
> +# I/O limits can be disabled by setting all throttle values to 0.
> +#
> +# Returns: Nothing on success
> +#          If @device is not a valid fsdev device, GenericError
> +#
> +# Since: 2.10
> +#

2.11, now.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lVTsfwm2MGftTqviU498Bxo9dW64Clw0L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmIYMcACgkQp6FrSiUn
Q2rIBAgAmpE4nPp9VUC6WLvbvlq1VpQaBj7kCPzqf7UktrLkS5Cnwd8Ql3EDLURo
AXMJME1ZfYAPEyU2xWnGhR0BHbZT7ysqlsjZ+o4M6uogkqas/hko0KgwZHhksL/P
jnkeUOK3Etm5jBNWv1eK/Sp3h65vcnjT4E72RL6Plit4iieJJIetVb+9uZrvO1bc
GNG5KnAm1YUKlPzH+DrzRPQ3vWlDRlztgdmbDHdAokzNENkXIaBXmP2OgdiYGjLE
4svfzInGOWDt8jicm6CO7OixJtjZdjJuWZU+Osa4OIO/gq+cFwUhHrH8EWwWXQoP
AsGx7KgqdV8aG3hvchLv3+upZdtzHw==
=yS96
-----END PGP SIGNATURE-----

--lVTsfwm2MGftTqviU498Bxo9dW64Clw0L--

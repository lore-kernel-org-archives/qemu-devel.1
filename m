Received: from eggs.gnu.org ([2001:4830:134:3::10]:58691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUza9-00004t-11
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:08:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUza8-0003Dd-6X
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:08:21 -0400
References: <20170711124024.1396-1-pbutsykin@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4472392c-5754-5643-c8c4-d6957c897754@redhat.com>
Date: Tue, 11 Jul 2017 20:08:10 +0200
MIME-Version: 1.0
In-Reply-To: <20170711124024.1396-1-pbutsykin@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fIWi6ObGLhCNe6Ja7KIBDJM7qmqSs0F1b"
Subject: Re: [Qemu-devel] [PATCH v4 0/4] Add shrink image for qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fIWi6ObGLhCNe6Ja7KIBDJM7qmqSs0F1b
From: Max Reitz <mreitz@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org
Message-ID: <4472392c-5754-5643-c8c4-d6957c897754@redhat.com>
Subject: Re: [PATCH v4 0/4] Add shrink image for qcow2
References: <20170711124024.1396-1-pbutsykin@virtuozzo.com>
In-Reply-To: <20170711124024.1396-1-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-11 14:40, Pavel Butsykin wrote:
> This patch add shrinking of the image file for qcow2. As a result, this=
 allows
> us to reduce the virtual image size and free up space on the disk witho=
ut
> copying the image. Image can be fragmented and shrink is done by punchi=
ng holes
> in the image file.

Looks good, but will need a rebase on my preallocated truncation series.
 (Should be rather simple, however; just adjusting an enum value in
patch 1, some contextual changes, and adding a condition in patch 3 to
return an error if you try to shrink a qcow2 image with a prealloc value
other than PREALLOC_MODE_OFF.)

Max


--fIWi6ObGLhCNe6Ja7KIBDJM7qmqSs0F1b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZZRQKEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQOlC
CACBqi0F2FoVkjIhtlKk8FqIg7M0PcDTFvSQ6Ng/GUep4NBi6Ds55lcVqIQu7ptX
JkMSOesYT3niIarMqRY/5Sus0BpDAvMh6tNeszdpgyUIxQYRcGkPKFrHgor0Bieo
RL/MbeRj+X0fs3kA4AwNpzvGtl0jbB36hSt+CLSMrU5SerOb9hq3sIYGFrKewMZb
YGGca1cO3M4oH1XWzt/kHJLH6u0ly8cY+8W8womIcaIRW50g5AdfRbXFRhuuxv4J
lIvQSWWaoBFw9H30NXMbCFVwbWsX7sc+5XlwAEHfYowYaI6XZ9nJcIj+lpWYKiK1
wXsflT67EZDKrmVKVIWcnJVT
=KiiA
-----END PGP SIGNATURE-----

--fIWi6ObGLhCNe6Ja7KIBDJM7qmqSs0F1b--

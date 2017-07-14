Received: from eggs.gnu.org ([2001:4830:134:3::10]:50666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dW1V4-00031h-W2
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:23:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dW1V0-0006BI-82
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:23:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dW1Uz-0006B4-V9
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:23:18 -0400
References: <20170714133111.27359-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0594d8b4-3b3c-327e-e2ed-d24c736f7ff0@redhat.com>
Date: Fri, 14 Jul 2017 09:23:12 -0500
MIME-Version: 1.0
In-Reply-To: <20170714133111.27359-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9ik63RndeFsCKlIRFmJ6dlgR2HeL481eA"
Subject: Re: [Qemu-devel] [PATCH] trace: update old trace events in docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Wang Dong <dongdwdw@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9ik63RndeFsCKlIRFmJ6dlgR2HeL481eA
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Wang Dong <dongdwdw@linux.vnet.ibm.com>
Message-ID: <0594d8b4-3b3c-327e-e2ed-d24c736f7ff0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] trace: update old trace events in docs
References: <20170714133111.27359-1-stefanha@redhat.com>
In-Reply-To: <20170714133111.27359-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/14/2017 08:31 AM, Stefan Hajnoczi wrote:
> Commit c5f1ad429cdf26023cf331075a7d327708e3db6d ("block: Remove
> bdrv_aio_readv/writev/flush()") removed
> bdrv_aio_readv()/bdrv_aio_writev() so the example in the tracing
> documentation is no longer valid.
>=20
> Reported-by: Wang Dong <dongdwdw@linux.vnet.ibm.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  docs/devel/tracing.txt | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/docs/devel/tracing.txt b/docs/devel/tracing.txt
> index 8c0029b..5768a0b 100644
> --- a/docs/devel/tracing.txt
> +++ b/docs/devel/tracing.txt
> @@ -14,8 +14,7 @@ for debugging, profiling, and observing execution.
> =20
>  2. Create a file with the events you want to trace:
> =20
> -   echo bdrv_aio_readv   > /tmp/events
> -   echo bdrv_aio_writev >> /tmp/events
> +   echo memory_region_ops_read >/tmp/events
> =20
>  3. Run the virtual machine to produce a trace file:
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--9ik63RndeFsCKlIRFmJ6dlgR2HeL481eA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZaNPQAAoJEKeha0olJ0NqoQsH/i1eEY9VUh81BF4T/RpHPXZD
pbcrz3s8/bro0vOnGgd5qVtBjVJESjR3iwY9iyYnZzrET6DErvC3KRHhld/9ZzeR
NTX8xSU8WDsi9h1qFgiGVc/KNQbBAv69lukpKmmWtpdr2TiwnXNMj5okDo7lxiRU
YZrnyqn99poo/7v9HcSdxQHssljE6xcAKYFB7rJcwA8C5c+ht3IaSWVih7azSE9y
vudR8PNsXzk7W2hgi/OG751zMOVKgS1ZpTDhnSTVV7gSQLBjywYSDGfFglhfpeTW
W0xT0/L6JP/GI2X1wOq+KMzE3kFpA6un5E3+8+It4YuGoD/nZZwpQoaFXAL5Aj0=
=lsqU
-----END PGP SIGNATURE-----

--9ik63RndeFsCKlIRFmJ6dlgR2HeL481eA--

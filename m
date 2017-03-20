Received: from eggs.gnu.org ([2001:4830:134:3::10]:38979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpy1T-0002n1-I6
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:11:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpy1O-0000u6-D6
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:10:59 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:35977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cpy1O-0000tm-0f
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:10:54 -0400
Received: by mail-wm0-x229.google.com with SMTP id n11so64575602wma.1
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 07:10:53 -0700 (PDT)
Date: Mon, 20 Mar 2017 14:10:50 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170320141050.GX17887@stefanha-x1.localdomain>
References: <CAKkuVugZBgy4duTUep5y6rH4qEkt7QLTQDrUOEW=MX9J=aXBrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b/3kIrr+SWblMf9a"
Content-Disposition: inline
In-Reply-To: <CAKkuVugZBgy4duTUep5y6rH4qEkt7QLTQDrUOEW=MX9J=aXBrQ@mail.gmail.com>
Subject: Re: [Qemu-devel] Adding our own nic model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shirley Kotian <shirley.kotian@gmail.com>
Cc: qemu-devel@nongnu.org


--b/3kIrr+SWblMf9a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 16, 2017 at 05:46:03PM +0530, Shirley Kotian wrote:
> We are working on a project in QEMU wherein we want to add our own nic
> model userio. Can you please tell us how to go about it.

It's hard to answer the question without more details.

If you want to connect a software switch to QEMU then the vhost-user
virtio-net interface is a better choice than trying to add a new NIC
model.

Stefan

--b/3kIrr+SWblMf9a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz+LqAAoJEJykq7OBq3PIHlkIAKSzNJmTruA92vsTd3hJ8ecR
ygnjZC7jeDJenZyC8fAQxlh0K0Z+KdQLSjQTefhViiTrUN/+3YqIbL9HkLxJaGFl
gwR9dy9Nvx74dNqW0iM2LruCZ0I0hda0erf68oOPhwT9kg+IO6zSWvAtlQW1OZEC
w2qst4bwD8Zy5p6EdEueCiQNYt2CAYY172dYddnhRZtmntWWp1ge83/jJfZ4F30x
5QJTIhIMA2ZPOd91FTbgNemwqIBUzH7ZY+kQg/fzvcjv3SWSVwnqwiux6v21R6GN
VP9/iFLlfa8zS1S1j7ES4F6NESHDR/1krBGpArE/c4h4ldY/9ScRxj2xOIRSOTI=
=mA6c
-----END PGP SIGNATURE-----

--b/3kIrr+SWblMf9a--

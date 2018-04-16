Received: from eggs.gnu.org ([2001:4830:134:3::10]:39228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f7yr5-0004q6-DT
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 03:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f7yr1-00087c-EZ
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 03:47:15 -0400
Received: from mail-pl0-x22e.google.com ([2607:f8b0:400e:c01::22e]:33576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1f7yr1-00087C-6v
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 03:47:11 -0400
Received: by mail-pl0-x22e.google.com with SMTP id w12-v6so8644353plp.0
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 00:47:11 -0700 (PDT)
Date: Mon, 16 Apr 2018 15:47:06 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180416074706.GB28904@stefanha-x1.localdomain>
References: <20180411072027.5656-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
In-Reply-To: <20180411072027.5656-1-tiwei.bie@intel.com>
Subject: Re: [Qemu-devel] [RFC] vhost-user: introduce F_NEED_ALL_IOTLB
 protocol feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 11, 2018 at 03:20:27PM +0800, Tiwei Bie wrote:
> This patch introduces VHOST_USER_PROTOCOL_F_NEED_ALL_IOTLB

Naming suggestion: "PREFILL_IOTLB" instead of "NEED_ALL_IOTLB".

I wasn't able to guess what "NEED_ALL_IOTLB" does.  "PREFILL_IOTLB"
communicates that memory translation will be set up in advance.

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa1FT6AAoJEJykq7OBq3PIaFQH/3byJA+zXtTb5oMuaN52T9xG
wVKXYMyHoxGRbsD7U1MDpUSytoypy3YMZXLc82J63Uw+2wTTzHh7vAF6BYJmZ9im
Bl4mmDbP9G+lIR44N8cmjYnQhX3W5nEqNlHiYLaC7dcEpNkj6GlpA17rVRP1Nz3g
jiAXDKStyidS3QZ3IYyc2KJrWtgqV5TOTb2xstrtJLgZtSDLFSSovDunmYxKkpzI
5mNQRRkKXpx0vFmks5rDyHguRaUgxqtU+gMnpMg0nuikJGc9I1igyd9Vhsmr5T8b
/+mPoRR1h11imQS+E8BSbHjz1bissKokpefZ5Pd2yMaGsnDgB4Sl1sLZkHOFVgo=
=214T
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--

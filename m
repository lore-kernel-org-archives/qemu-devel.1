Received: from eggs.gnu.org ([2001:4830:134:3::10]:43541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9RSP-0002Ws-9o
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:31:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9RSO-0002Np-EZ
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:31:49 -0400
Date: Fri, 20 Apr 2018 16:31:38 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180420083138.GK15181@stefanha-x1.localdomain>
References: <20180416165849.28864-1-mreitz@redhat.com>
	<20180416165849.28864-2-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qo8f1a4rgWw9S/zY"
Content-Disposition: inline
In-Reply-To: <20180416165849.28864-2-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/9] block: Add COR filter
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--Qo8f1a4rgWw9S/zY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 16, 2018 at 06:58:41PM +0200, Max Reitz wrote:
>  { 'enum': 'BlockdevDriver',
> -  'data': [ 'blkdebug', 'blkverify', 'bochs', 'cloop',
> +  'data': [ 'blkdebug', 'blkverify', 'bochs', 'cloop', 'cor',

"copy-on-read" would be clearer than "cor" for the QMP API and the
block/cor.c source file.  Is there a need to make the name very short?

--Qo8f1a4rgWw9S/zY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa2aVqAAoJEJykq7OBq3PIKWMH/jMUjbGoP8DLF1E/M6bIvCCn
/JM4/89pTE8/hBwmftV2uTaaXd8xBKXRN5oZkII/28bBkds/gJ11oZr8AaJbLMAs
9d7MUhkPVZ4T0iY2VolZxmXVVlDbl292pU3A/5Mz4g4oHGdUXCMLKYwFT9TAI7pX
GtdzMYHPnV2yw4ORuAyiYghQnEqnVdMDXuxmFfVZ8S9DoKwrX2xhluNFKuuGsUDB
OmiqZBsqV4TWGsK3VOZEf9e+hg4wcL3BYx/hiLSbkqnnEbfi9ZC4xoizKUqUCxqW
RbGZXEoaNINrXJErZXt8QDRaTEM5ucf5/39aD6ZpJYF2h3IVrMK1RypFYnhtK1Y=
=2iwv
-----END PGP SIGNATURE-----

--Qo8f1a4rgWw9S/zY--

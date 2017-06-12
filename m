Received: from eggs.gnu.org ([2001:4830:134:3::10]:42540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dKPsf-0000N3-FA
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dKPsa-0002r9-LD
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:59:45 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:33266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dKPsa-0002qu-E1
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:59:40 -0400
Received: by mail-wr0-x232.google.com with SMTP id v104so97335617wrb.0
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 06:59:40 -0700 (PDT)
Date: Mon, 12 Jun 2017 14:59:24 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170612135924.GC17075@stefanha-x1.localdomain>
References: <20170608182113.nmxnvus26vplg5du@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Content-Disposition: inline
In-Reply-To: <20170608182113.nmxnvus26vplg5du@postretch>
Subject: Re: [Qemu-devel] [Proposal] I/O throttling through new -object
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 08, 2017 at 09:21:13PM +0300, Manos Pitsidianakis wrote:
> The old interface will be retained as much as possible.

I think "retained" means "reused" here but in case it doesn't:

The old interface must remain 100% functional.  Existing software like
libvirt must continue to work without any changes.  QEMU releases are
backwards compatible except for a long-term deprecation schedule.

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZPp48AAoJEJykq7OBq3PIozMH/RHtOpFU3mUCjGLeNfqT/MNz
ZNFlFKe1bdPu5deY3zMHZzpxFAUZBnNFCswdUVyh/OR5GcDmB2yMLgRGtDFpmnYW
47rDvnZkP6rLMk99i3BKV3g6hTBaDhXxPMDK4iDKGWtxJNPmgaSlGefCqSUefqsB
Ii1uQyG78xUKv4ItQ8s8iBDpxAbirlj+7yehfSJ5lbx5jDKMgij5bpVKHrAJc6/b
67S95JmtCGQmcspnKsRXs7sbxcxLOWMiJiBpzRUOjWU7ig86cfae6F5B/RkYwJj6
6yNfi4R6iUs8N4MWiRSNDhInw57ZUhG83/qnL4xrc3hfb7xDELa87lmg3Vblnnw=
=lBtD
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--

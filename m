Received: from eggs.gnu.org ([2001:4830:134:3::10]:56141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3i2d-0006Dh-Il
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3i2X-0000qE-VQ
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:01:31 -0400
Date: Wed, 4 Apr 2018 14:01:16 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180404130116.GP4467@stefanha-x1.localdomain>
References: <20180329110914.20888-1-famz@redhat.com>
	<20180329110914.20888-2-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jXoUnAu9pZeaHebo"
Content-Disposition: inline
In-Reply-To: <20180329110914.20888-2-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH 1/8] block: Introduce
 bdrv_co_map_range API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com


--jXoUnAu9pZeaHebo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 29, 2018 at 07:09:07PM +0800, Fam Zheng wrote:
> +int coroutine_fn bdrv_co_map_range(BdrvChild *child, int64_t offset,
> +                                   int64_t bytes, int64_t *pnum, int64_t *map,

I just noticed that .bdrv_co_block_status() also calls the argument
"map".  In that case, let's keep it "map" unless you want to rename
"map" to "file_offset" in .bdrv_co_block_status() too.

Stefan

--jXoUnAu9pZeaHebo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaxMycAAoJEJykq7OBq3PIcIgH/2K8gdsmpNZmNOgfflC5Epih
9uVMdXgQs9D0VUBZkHCvwPNQNhg8shIwc38y7xsWf5tk0upxUEqJU1PiyQst0EbG
3zTHww4gdQTXr6WkbwTrHK8qpAHCBTv/HvAOJCnUam280JPfn5+5ISqx3IXxyZgl
BoWi8nYB24CQYWR3uPLzg50fxx9XK/wkPb8lCLmeeFOJ4bQg/QJZ2Ix8SK61wJOK
eYEGEZ61+7alkl0+7XVNVL9Cd9jLuj8WJNODKGFiGoUSWOJfCWPb/C/wppHQQ+b0
46jdHmwadpau8GAbmdRv6J8a3BClTT9MUwGQdnrh2+bszMYiHcMRpMqWej9N5DI=
=ya8I
-----END PGP SIGNATURE-----

--jXoUnAu9pZeaHebo--

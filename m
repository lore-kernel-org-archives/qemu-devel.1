Received: from eggs.gnu.org ([2001:4830:134:3::10]:39358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9QZc-0004Rd-IQ
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9QZb-0000Xr-RD
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:35:12 -0400
Date: Fri, 20 Apr 2018 15:35:03 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180420073503.GH15181@stefanha-x1.localdomain>
References: <20180411163940.2523-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8/pVXlBMPtxfSuJG"
Content-Disposition: inline
In-Reply-To: <20180411163940.2523-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/19] Drain fixes and cleanups, part 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com


--8/pVXlBMPtxfSuJG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 11, 2018 at 06:39:21PM +0200, Kevin Wolf wrote:
> This is the third and hopefully for now last part of my work to fix
> drain. The main goal of this series is to make drain robust against
> graph changes that happen in any callbacks of in-flight requests while
> we drain a block node.

I have reviewed the first half of this series and will review the rest
when v2 is posted since I want to see how the changes suggested by Paolo
play out first.

Stefan

--8/pVXlBMPtxfSuJG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa2ZgnAAoJEJykq7OBq3PI4UAH/30rtTJ7PIp5tcMnSrJRBFeQ
XJBQMTRnpr6JXoHBxvs5Vu6gDqpeLf3/32oaNMgshUYqMHvDrH7HIKalwPp14pQN
Ql3Tl3I9w0iW4a1NAau0ZMynmWhujmXwZgdYLVXoFzJxD4H7s8U4PhTF1wgehONt
TmnoD5JlBf+mUt4sRtIzBiPN8xbnMVsbZbsYxdvBkvr7LXUcAPBiHqdVgl2uIUU0
2u975svYvsYR2xx5mReDnGpo/QC1tMxc0pmQF4ikXpDppQYVTFBAcAbbe49ZdSFs
7EXXZHI6SZv1F3w8lormc/shr4jbimbfnHBc9krbmffN/qUwFunnG6qbyBd8kx8=
=BuLD
-----END PGP SIGNATURE-----

--8/pVXlBMPtxfSuJG--

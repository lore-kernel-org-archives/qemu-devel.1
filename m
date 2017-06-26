Received: from eggs.gnu.org ([2001:4830:134:3::10]:53742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dPTzu-0002ot-4d
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 09:24:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dPTzn-0003A5-My
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 09:24:10 -0400
Date: Mon, 26 Jun 2017 14:23:59 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170626132359.GA29664@stefanha-x1.localdomain>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-2-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <20170623124700.1389-2-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC v3 1/8] block: move
 ThrottleGroup membership to ThrottleGroupMember
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 23, 2017 at 03:46:53PM +0300, Manos Pitsidianakis wrote:
> This commit gathers ThrottleGroup membership details from
> BlockBackendPublic into ThrottleGroupMember and refactors existing code
> to use the structure.

This summarizes the code change but doesn't explain why it's necessary.

I suggest something like this:

  This patch eliminates the 1:1 relationship between BlockBackend and
  throttle group state.  Users will be able to create multiple throttle
  nodes, each with its own throttle group state, in the future.  The
  throttle group state cannot be per-BlockBackend anymore, it must be
  per-throttle node.

> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block/block-backend.c           |  66 +++++----
>  block/qapi.c                    |   8 +-
>  block/throttle-groups.c         | 304 ++++++++++++++++++++--------------------
>  blockdev.c                      |   4 +-
>  include/block/throttle-groups.h |  15 +-
>  include/qemu/throttle.h         |  26 ++++
>  include/sysemu/block-backend.h  |  20 +--
>  tests/test-throttle.c           |  53 +++----
>  8 files changed, 260 insertions(+), 236 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZUQrvAAoJEJykq7OBq3PI6cIIAIRQ5wn7/NQUwfngpejN6mII
KRH1gRZjaDzCOcdX6NXaWls0Azm9oBMpcZwGun7x349/6TN7a8FI/BfNR5ju8ePX
P/LYVsT8WsI2Cu52Vh4RxVZOZFsAiAUZqzsDy1ytiwaHvEB1cRtM2Y+hgE6h6i57
NTVg2bapVy+0a5R2NXf6RbUD5cd1UazqqLQEr4g01ZnfOGIs1ioLeYJM/MkPz1VE
G+7aDbwI2J8aLRRTLjYd5EG5sYMlR2sWXdlPQpX32G0u1PTvSFuPHePHhRncG7lu
bW+u9X0KTDZmEdYbdF5mqUDsXltcbKlnXAdpq3J5Q1gYZL1DHUs6npOYx6pRCyg=
=Sg0x
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--

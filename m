Received: from eggs.gnu.org ([2001:4830:134:3::10]:50218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eEGzk-0007tb-RL
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 10:49:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eEGzj-0002yO-W7
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 10:49:56 -0500
Date: Mon, 13 Nov 2017 15:49:48 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171113154948.GE27765@stefanha-x1.localdomain>
References: <cover.1510339534.git.berto@igalia.com>
	<071eb397118ed207c5a7f01d58766e415ee18d6a.1510339534.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qFgkTsE6LiHkLPZw"
Content-Disposition: inline
In-Reply-To: <071eb397118ed207c5a7f01d58766e415ee18d6a.1510339534.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] qemu-iotests: Test I/O limits with
 removable media
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, sochin jiang <sochin.jiang@huawei.com>


--qFgkTsE6LiHkLPZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 10, 2017 at 08:54:48PM +0200, Alberto Garcia wrote:
> +        result = self.vm.qmp("blockdev-add", driver = "null-aio",
> +                             node_name = "cd0")

PEP8 says:

"Don't use spaces around the = sign when used to indicate a keyword
argument or a default parameter value."

https://www.python.org/dev/peps/pep-0008/#whitespace-in-expressions-and-statements

I fixed this while merging the patch.

--qFgkTsE6LiHkLPZw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaCb8cAAoJEJykq7OBq3PItksH/3kJdm6Xgnrs6P8uWzF+2sQF
9qf+ExVlvsivst9/YDVZyWpFOY4xcz5RfKE0VJc4My4cLNS9Ou7kT8gxkQb5pWAh
Tame6URHp5p+wuDrI7z0VdgM2ZcyIlWSg3bMR6G3jX+4RPyX8aJXvDEZ0+TbNlxB
MTd8V+K3whTGSQcAPZJ83K9kBroYEWwCGtEIoVdWveZrDItXyjr6s5jTLDaXGGZA
XuKFw4a7A7yPfyfKXAF4m9R35wfImP+9OzptoMejeQN745pMKZnWIyL3tKtfASW4
aqXbyNTBAeVmrSobwIKZHcn6kqf5uA+h1ZKQebeuTzPKshOaP13vOpjUnkJGX54=
=eat8
-----END PGP SIGNATURE-----

--qFgkTsE6LiHkLPZw--

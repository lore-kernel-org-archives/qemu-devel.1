Received: from eggs.gnu.org ([2001:4830:134:3::10]:34560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evQ8l-0001v8-Bb
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:17:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evQ8k-0004pT-JJ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:17:35 -0400
References: <20180306204819.11266-1-stefanha@redhat.com>
	<20180306204819.11266-2-stefanha@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <700879b4-0d9f-3ed6-9317-504fd43f7e5e@redhat.com>
Date: Mon, 12 Mar 2018 17:17:18 +0100
MIME-Version: 1.0
In-Reply-To: <20180306204819.11266-2-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TpT76TlwZ3pyM0geOvl4YjC9PbjUOiL4R"
Subject: Re: [Qemu-devel] [PATCH 1/2] block: let
 blk_add/remove_aio_context_notifier() tolerate BDS changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefano Panella <spanella@gmail.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TpT76TlwZ3pyM0geOvl4YjC9PbjUOiL4R
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefano Panella <spanella@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <700879b4-0d9f-3ed6-9317-504fd43f7e5e@redhat.com>
Subject: Re: [PATCH 1/2] block: let blk_add/remove_aio_context_notifier()
 tolerate BDS changes
References: <20180306204819.11266-1-stefanha@redhat.com>
 <20180306204819.11266-2-stefanha@redhat.com>
In-Reply-To: <20180306204819.11266-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-06 21:48, Stefan Hajnoczi wrote:
> Commit 2019ba0a0197 ("block: Add AioContextNotifier functions to BB")
> added blk_add/remove_aio_context_notifier() and implemented them by
> passing through the bdrv_*() equivalent.
>=20
> This doesn't work across bdrv_append(), which detaches child->bs and
> re-attaches it to a new BlockDriverState.  When
> blk_remove_aio_context_notifier() is called we will access the new BDS
> instead of the one where the notifier was added!

And nice that we just did not do anything if there was no BDS (in
practice that can never happen, but still nice).

Also, I like your exclamation mark.  It makes this sound so excited! :D

> From the point of view of the blk_*() API user, changes to the root BDS=

> should be transparent.
>=20
> This patch maintains a list of AioContext notifiers in BlockBackend and=

> adds/removes them from the BlockDriverState as needed.
>=20
> Reported-by: Stefano Panella <spanella@gmail.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/block-backend.c | 63 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  block/trace-events    |  2 ++
>  2 files changed, 65 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--TpT76TlwZ3pyM0geOvl4YjC9PbjUOiL4R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqmqA4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AjYIH/Rct/xC0e2R9IK2C/FHq0vXtZcp4YImD
ztBZ898c8FiMTq1zX17GIFG6qj1i/mfgbLC3FQzsAXKNFCtx+dM+eJJftPah7d4b
/4MntsMk2Cq+K/b5JSnQ+6vVGN9mIZrZphMyyPmWreIyuGJtCZ0iFMTdVY3Ca6D+
qNug26tLwci29m6TLWpj5KAXT0odd+J9tMSoef27WdiclTfp+ohanx1L3DXdat/Z
LNeH9E7O1kF61SuMIokyV2AiJnFNPAUTsZlgMsuhoJYj8PSYkJ//FZuJKXyQGyks
FC5TpBtyottPUcWV4vtzZBCGpbhx+kTlbGU3PajuGdPis94ZqaLuGYQ=
=YsyC
-----END PGP SIGNATURE-----

--TpT76TlwZ3pyM0geOvl4YjC9PbjUOiL4R--

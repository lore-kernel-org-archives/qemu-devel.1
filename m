Received: from eggs.gnu.org ([2001:4830:134:3::10]:47704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1coPxh-00042b-8R
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1coPxg-0000up-DI
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:36:41 -0400
Date: Thu, 16 Mar 2017 15:36:33 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170316073633.GD17296@stefanha-x1.localdomain>
References: <20170313195547.21466-1-eblake@redhat.com>
	<20170313195547.21466-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Km1U/tdNT/EmXiR1"
Content-Disposition: inline
In-Reply-To: <20170313195547.21466-3-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 02/30] trace: Fix incorrect megasas
 trace parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Hannes Reinecke <hare@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, "open list:megasas" <qemu-block@nongnu.org>


--Km1U/tdNT/EmXiR1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2017 at 02:55:19PM -0500, Eric Blake wrote:
> hw/scsi/trace-events lists cmd as the first parameter for both
> megasas_iovec_overflow and megasas_iovec_underflow, but the caller
> was mistakenly passing cmd->iov_size twice instead of the command
> index.  Also, trace_megasas_abort_invalid is called with parameters
> in the wrong order.  Broken since its introduction in commit
> e8f943c3.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  hw/scsi/megasas.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks, applied to my tracing-next tree:
https://github.com/stefanha/qemu/commits/tracing-next

Stefan

--Km1U/tdNT/EmXiR1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYykCBAAoJEJykq7OBq3PI4kkIALa1tEKPHmVemyBPT2qMoTv5
vM5nwMqpIBMGSIdQO3Pbj2jrMpvhIw/lZZ/fP4lVW42bG8A/0PbGlrbW6kj7QL8q
gb20x7ro3wf3o39uAPw8AyNXM81znbpGSb8D87uRrDndFEBxklBvn8UOxeVTpN/8
XwzwcHkDJkAGzoDccbBVQ52O+olDANS1tr41gis3i4JdO7wIRigRhwWhVj32vxo+
BOww7rV3FAVG1Pe/b3RQXaZ37MvA2edMU0w1uKjguwyr4A69eR7R0xfFQO+sETtN
oInjeeqQmMQKAEVy3qoSoa6oHnqeprQR80LB0xKrb6MIigSC/Ta8AYetJx16JQ4=
=cDJf
-----END PGP SIGNATURE-----

--Km1U/tdNT/EmXiR1--

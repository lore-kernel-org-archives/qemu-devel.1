Received: from eggs.gnu.org ([2001:4830:134:3::10]:52852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOiQn-00034v-B8
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOiQk-0003xv-6f
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:41:17 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:44914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fOiQj-0003xE-Uv
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:41:14 -0400
Received: by mail-wr0-x236.google.com with SMTP id y15-v6so36040518wrg.11
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 04:41:13 -0700 (PDT)
Date: Fri, 1 Jun 2018 12:41:11 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180601114111.GJ8687@stefanha-x1.localdomain>
References: <20180522195038.25280-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6J7GEvtanOfV9oXA"
Content-Disposition: inline
In-Reply-To: <20180522195038.25280-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] hw: make virtio devices configurable
 via default-configs/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, ehabkost@redhat.com


--6J7GEvtanOfV9oXA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 22, 2018 at 09:50:38PM +0200, Paolo Bonzini wrote:
> This is only half of the work, because the proxy devices (virtio-*-pci,
> virtio-*-ccw, etc.) are still included unconditionally.  It is still a
> move in the right direction.
>=20
> Based-on: <20180522194943.24871-1-pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  default-configs/arm-softmmu.mak     |  1 +
>  default-configs/hppa-softmmu.mak    |  2 --
>  default-configs/pci.mak             |  4 +---
>  default-configs/riscv32-softmmu.mak |  4 ++--
>  default-configs/riscv64-softmmu.mak |  4 ++--
>  default-configs/s390x-softmmu.mak   |  5 +----
>  default-configs/virtio.mak          | 14 ++++++++++++++
>  hw/9pfs/Makefile.objs               |  6 ++++--
>  hw/block/Makefile.objs              |  6 ++----
>  hw/char/Makefile.objs               |  2 +-
>  hw/display/Makefile.objs            |  4 ++--
>  hw/input/Makefile.objs              |  6 +++---
>  hw/net/Makefile.objs                |  2 +-
>  hw/scsi/Makefile.objs               |  2 +-
>  hw/virtio/Makefile.objs             | 16 +++++++++-------
>  15 files changed, 44 insertions(+), 34 deletions(-)
>  create mode 100644 default-configs/virtio.mak

Per-device config variables are nice.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6J7GEvtanOfV9oXA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbETDXAAoJEJykq7OBq3PI8QgH/2Q1Lrt8g7iX7KOneq/q3pE1
HIwk98cvVjKzYzyiAP07VfIg7GPrTsGg3En1mjKMz/1OpjkDfWQKTa1y2dALcSW1
886RxxNprHdf2afCSYJ65rzsCEg3W0nfaXOYPRxuaY4gbMaf6dDEUpGlcxnQgpAk
82AkQRXqMEh7kMlP8TkL+Gs4YaOV2nq/SnLOzjzyNBLQJd9DKRRnSLIb2hLflEsW
X8zCDt+hqbcHiT6/tqYE0Kok52KW0ijjA1q/KvReHQdQIplcO7djjjVA5TJcnwvt
KzGL7L+wsVhEeyQjotUEQe+nHLaIkAYEZGEYaLgWYutp3ct912VOxLq6NXS8OG4=
=r/mX
-----END PGP SIGNATURE-----

--6J7GEvtanOfV9oXA--

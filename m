Received: from eggs.gnu.org ([208.118.235.92]:59626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eR1HR-0004mZ-Ji
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:40:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eR1HJ-0006mD-Ve
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:40:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1eR1HJ-0006kH-OD
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:40:45 -0500
References: <20171218183631.32357-1-cohuck@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <c8748f83-b98e-6dd2-ddf5-6620f6b36f30@redhat.com>
Date: Mon, 18 Dec 2017 20:40:36 +0100
MIME-Version: 1.0
In-Reply-To: <20171218183631.32357-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] tpm: move qdev_prop_tpm to hw/tpm/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, stefanb@linux.vnet.ibm.com, pbonzini@redhat.com
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, qemu-devel@nongnu.org, f4bug@amsat.org

On 18/12/2017 19:36, Cornelia Huck wrote:
> Building with --disable-tpm yields
>=20
> ../hw/core/qdev-properties-system.o: In function `set_tpm':
> /home/cohuck/git/qemu/hw/core/qdev-properties-system.c:274: undefined r=
eference to `qemu_find_tpm_be'
> /home/cohuck/git/qemu/hw/core/qdev-properties-system.c:278: undefined r=
eference to `tpm_backend_init'
> ../hw/core/qdev-properties-system.o: In function `release_tpm':
> /home/cohuck/git/qemu/hw/core/qdev-properties-system.c:291: undefined r=
eference to `tpm_backend_reset'
>=20
> Move the implementation of DEFINE_PROP_TPMBE to hw/tpm/ so that it is
> only built when tpm is actually configured, and build tpm_util in every
> case.
>=20
> Fixes: 493b78303532 ("qdev: add DEFINE_PROP_TPMBE")
> Reported-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> v1->v2: fix x86_64 build with mingw (always build tpm_util)
> ---
>  hw/core/qdev-properties-system.c | 64 --------------------------------=
------
>  hw/tpm/Makefile.objs             |  5 +--
>  hw/tpm/tpm_util.c                | 67 ++++++++++++++++++++++++++++++++=
++++++++
>  hw/tpm/tpm_util.h                |  3 ++
>  include/hw/qdev-properties.h     |  2 --
>  5 files changed, 73 insertions(+), 68 deletions(-)
>=20

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

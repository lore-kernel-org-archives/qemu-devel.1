Received: from eggs.gnu.org ([2001:4830:134:3::10]:48636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dS2eg-000836-5G
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:48:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dS2eb-0001n5-7m
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:48:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dS2eb-0001mP-0o
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:48:45 -0400
Date: Mon, 3 Jul 2017 11:48:38 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170703144838.GK12152@localhost.localdomain>
References: <20170629132310.18865-1-marcandre.lureau@redhat.com>
	<20170629132310.18865-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170629132310.18865-2-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/7] vmgenid: replace
 x-write-pointer-available hack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, anderson@redhat.com, berrange@redhat.com, lersek@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Ben Warren <ben@skyportsystems.com>

On Thu, Jun 29, 2017 at 03:23:04PM +0200, Marc-Andr=E9 Lureau wrote:
> This compat property sole function is to prevent the device from being
> instantiated. Instead of requiring an extra compat property, check if
> fw_cfg has DMA enabled.
>=20
> This has the additional benefit of handling other cases properly, like:
>=20
>   $ qemu-system-x86_64 -device vmgenid -machine none
>   qemu-system-x86_64: -device vmgenid: vmgenid requires DMA write suppo=
rt in fw_cfg, which this machine type does not provide
>   $ qemu-system-x86_64 -device vmgenid -machine pc-i440fx-2.9 -global f=
w_cfg.dma_enabled=3Doff
>   qemu-system-x86_64: -device vmgenid: vmgenid requires DMA write suppo=
rt in fw_cfg, which this machine type does not provide
>   $ qemu-system-x86_64 -device vmgenid -machine pc-i440fx-2.6 -global f=
w_cfg.dma_enabled=3Don
>   [boots normally]
>=20
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

--=20
Eduardo

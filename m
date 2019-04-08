Received: from eggs.gnu.org ([209.51.188.92]:37840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1hDcGe-0003wO-JT
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 17:57:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1hDcGd-0007ei-DS
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 17:57:28 -0400
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20190404121015.28634-1-pl@kamp.de>
References: <20190404121015.28634-1-pl@kamp.de>
Message-ID: <155476063977.3739.16390356140711847238@sif>
Date: Mon, 08 Apr 2019 16:57:19 -0500
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH] megasas: fix mapped frame
 size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: fam@euphon.net, pbonzini@redhat.com, hare@suse.com, qemu-stable@nongnu.org

Quoting Peter Lieven (2019-04-04 07:10:15)
> the current value of 1024 bytes (16 * MFI_FRAME_SIZE) we map is not enoug=
h to hold
> the maximum number of scatter gather elements we advertise. We actually n=
eed a
> maximum of 2048 bytes. This is 128 max sg elements * 16 bytes (sizeof (un=
ion mfi_sgl)).
> =

> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Lieven <pl@kamp.de>

Is there any chance of getting this in for v4.0.0-rc3 tomorrow? Also
hoping to pull it in for v3.0.1.

> ---
>  hw/scsi/megasas.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
> index a56317e026..5ad762de23 100644
> --- a/hw/scsi/megasas.c
> +++ b/hw/scsi/megasas.c
> @@ -477,7 +477,7 @@ static MegasasCmd *megasas_enqueue_frame(MegasasState=
 *s,
>  {
>      PCIDevice *pcid =3D PCI_DEVICE(s);
>      MegasasCmd *cmd =3D NULL;
> -    int frame_size =3D MFI_FRAME_SIZE * 16;
> +    int frame_size =3D MEGASAS_MAX_SGE * sizeof(union mfi_sgl);
>      hwaddr frame_size_p =3D frame_size;
>      unsigned long index;
> =

> -- =

> 2.17.1
> =

> =

>=20

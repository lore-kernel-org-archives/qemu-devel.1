Received: from eggs.gnu.org ([2001:4830:134:3::10]:57573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1d32lC-0002Dh-GR
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:52:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1d32l9-0000Cq-E2
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:52:14 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1d32l9-0000CB-1t
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:52:11 -0400
Received: by mail-wr0-x244.google.com with SMTP id w50so21255331wrc.0
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 08:52:10 -0700 (PDT)
From: Dmitry Fleytman <dmitry@daynix.com>
Message-Id: <2E376036-BD22-4492-B00B-AEEC4F2E4954@daynix.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Tue, 25 Apr 2017 18:52:07 +0300
In-Reply-To: <20170425130623.3649-1-ppandit@redhat.com>
References: <20170425130623.3649-1-ppandit@redhat.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vmw_pvscsi: check message ring page count
 at initialisation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, YY Z <bigbird475958471@gmail.com>


> On 25 Apr 2017, at 16:06 PM, P J P <ppandit@redhat.com> wrote:
>=20
> Vmware Paravirtual SCSI emulation uses command descriptors to
> process SCSI commands. These come with their message ring buffers.
> A guest could set the message ring page count to an arbitrary value
> resulting in infinite loop. Add check to avoid it.

Hello P J P,

Except the commit message that does not exactly correspond to what this =
patch does,

Reviewed-by: Dmitry Fleytman <dmitry@daynix.com>


Thanks for the patch,
Dmitry.

>=20
> Reported-by: YY Z <bigbird475958471@gmail.com>
> Signed-off-by: P J P <ppandit@redhat.com>
> ---
> hw/scsi/vmw_pvscsi.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
> index 7557546..4a106da 100644
> --- a/hw/scsi/vmw_pvscsi.c
> +++ b/hw/scsi/vmw_pvscsi.c
> @@ -202,7 +202,7 @@ pvscsi_ring_init_msg(PVSCSIRingInfo *m, =
PVSCSICmdDescSetupMsgRing *ri)
>     uint32_t len_log2;
>     uint32_t ring_size;
>=20
> -    if (ri->numPages > PVSCSI_SETUP_MSG_RING_MAX_NUM_PAGES) {
> +    if (!ri->numPages || ri->numPages > =
PVSCSI_SETUP_MSG_RING_MAX_NUM_PAGES) {
>         return -1;
>     }
>     ring_size =3D ri->numPages * PVSCSI_MAX_NUM_MSG_ENTRIES_PER_PAGE;
> --=20
> 2.9.3
>=20

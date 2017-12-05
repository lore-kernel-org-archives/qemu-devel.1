Received: from eggs.gnu.org ([2001:4830:134:3::10]:58581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eMDwf-000691-MU
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:11:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eMDwc-0002qc-F6
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:11:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:30088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eMDwc-0002qQ-8p
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:11:34 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 742B36E770
	for <qemu-devel@nongnu.org>; Tue,  5 Dec 2017 14:11:33 +0000 (UTC)
References: <20171205071928.30242-1-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4d69a68f-05aa-2be7-01b1-48d66d5a4713@redhat.com>
Date: Tue, 5 Dec 2017 15:11:28 +0100
MIME-Version: 1.0
In-Reply-To: <20171205071928.30242-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] scsi-block: Add share-rw option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 05/12/2017 08:19, Fam Zheng wrote:
> Scsi-block doesn't use the DEFINE_BLOCK_PROPERTIES() macro so it didn't
> gain the share-rw back when it was added to all other storage devices.
> This option is meaningful here, and need to be used when attaching a
> shared storage to guest.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  hw/scsi/scsi-disk.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 12431177a7..ac65830666 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -3009,6 +3009,7 @@ static const TypeInfo scsi_cd_info = {
>  static Property scsi_block_properties[] = {
>      DEFINE_BLOCK_ERROR_PROPERTIES(SCSIDiskState, qdev.conf),         \
>      DEFINE_PROP_DRIVE("drive", SCSIDiskState, qdev.conf.blk),
> +    DEFINE_PROP_BOOL("share-rw", SCSIDiskState, qdev.conf.share_rw, false),
>      DEFINE_PROP_UINT16("rotation_rate", SCSIDiskState, rotation_rate, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> 

Queued, thanks.

Paolo

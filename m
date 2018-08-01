Received: from eggs.gnu.org ([2001:4830:134:3::10]:37145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fkrkS-0003in-PE
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 10:05:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fkrkP-00015f-JY
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 10:05:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49380 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fkrkP-00015Q-9M
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 10:05:05 -0400
References: <1533076133-22745-1-git-send-email-linux@roeck-us.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <21e51156-6b14-c0be-f62b-00997d659db5@redhat.com>
Date: Wed, 1 Aug 2018 16:04:59 +0200
MIME-Version: 1.0
In-Reply-To: <1533076133-22745-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] scsi: mptsas: Mark as storage device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 01/08/2018 00:28, Guenter Roeck wrote:
> mptsas1068 is currently listed as uncategorized device.
> Mark it as storage device.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  hw/scsi/mptsas.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
> index 4176e87..929404f 100644
> --- a/hw/scsi/mptsas.c
> +++ b/hw/scsi/mptsas.c
> @@ -1431,6 +1431,7 @@ static void mptsas1068_class_init(ObjectClass *oc, void *data)
>      dc->reset = mptsas_reset;
>      dc->vmsd = &vmstate_mptsas;
>      dc->desc = "LSI SAS 1068";
> +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>  }
>  
>  static const TypeInfo mptsas_info = {
> 

Queued, thanks.

Paolo

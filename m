Received: from eggs.gnu.org ([2001:4830:134:3::10]:41055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fkfrC-0002FJ-7m
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 21:23:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fkfr9-0005me-5N
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 21:23:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34328 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fkfr9-0005lD-0Q
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 21:23:15 -0400
Date: Wed, 1 Aug 2018 09:23:11 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180801012311.GB14577@lemon.usersys.redhat.com>
References: <1533076133-22745-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533076133-22745-1-git-send-email-linux@roeck-us.net>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Tue, 07/31 15:28, Guenter Roeck wrote:
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
> -- 
> 2.7.4
> 

Reviewed-by: Fam Zheng <famz@redhat.com>

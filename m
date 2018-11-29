Received: from eggs.gnu.org ([2001:4830:134:3::10]:49881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cminyard@mvista.com>) id 1gSOVK-0006oX-AX
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:45:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cminyard@mvista.com>) id 1gSOVF-0005V7-Cx
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:45:26 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cminyard@mvista.com>) id 1gSOVF-0005Uh-19
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:45:21 -0500
Received: by mail-ot1-x342.google.com with SMTP id f18so2122251otl.11
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 07:45:20 -0800 (PST)
References: <20181126182844.23109-1-minyard@acm.org>
From: Corey Minyard <cminyard@mvista.com>
Message-ID: <d7a7cb4a-a55d-ec84-4bd8-89ef3fad7ebf@mvista.com>
Date: Thu, 29 Nov 2018 09:45:17 -0600
MIME-Version: 1.0
In-Reply-To: <20181126182844.23109-1-minyard@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH] pc:piix4: Update smbus I/O space after a
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 11/26/18 12:28 PM, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
>
> Otherwise it won't be set up correctly and won't work after
> miigration.

Any opinions on this?  I think this would be good for 3.1. Without
this when a migration occurs on piix4 the SMBus address space
appears in the wrong place.  I'm not sure how bad that is, but
SMBus certainly ceases to work.

-corey


> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> ---
>   hw/acpi/piix4.c | 1 +
>   1 file changed, 1 insertion(+)
>
> A rather obvious fix, in hindsight :).
>
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index e330f24c71..2f4dd03b83 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -173,6 +173,7 @@ static int vmstate_acpi_post_load(void *opaque, int version_id)
>       PIIX4PMState *s = opaque;
>   
>       pm_io_space_update(s);
> +    smbus_io_space_update(s);
>       return 0;
>   }
>   

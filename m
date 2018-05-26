Received: from eggs.gnu.org ([2001:4830:134:3::10]:56305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMQqE-0004Kf-Is
	for qemu-devel@nongnu.org; Sat, 26 May 2018 00:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMQqB-0001sh-AG
	for qemu-devel@nongnu.org; Sat, 26 May 2018 00:30:06 -0400
Received: from mail-qt0-x235.google.com ([2607:f8b0:400d:c0d::235]:38061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMQqB-0001rj-6d
	for qemu-devel@nongnu.org; Sat, 26 May 2018 00:30:03 -0400
Received: by mail-qt0-x235.google.com with SMTP id m9-v6so9109921qtb.5
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 21:30:03 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1527266793-301361-1-git-send-email-mst@redhat.com>
	<1527266793-301361-13-git-send-email-mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e23940cc-9c1d-df04-ef45-88969d18704a@amsat.org>
Date: Sat, 26 May 2018 01:29:58 -0300
MIME-Version: 1.0
In-Reply-To: <1527266793-301361-13-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 12/20] vhost-scsi: drop an unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

On 05/25/2018 01:47 PM, Michael S. Tsirkin wrote:
> No reason for vhost-scsi to pull in migration headers directly.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/scsi/vhost-scsi-common.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
> index 77e9897..e2a5828 100644
> --- a/hw/scsi/vhost-scsi-common.c
> +++ b/hw/scsi/vhost-scsi-common.c
> @@ -17,7 +17,6 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
> -#include "migration/migration.h"
>  #include "hw/virtio/vhost.h"
>  #include "hw/virtio/vhost-scsi-common.h"
>  #include "hw/virtio/virtio-scsi.h"
> 

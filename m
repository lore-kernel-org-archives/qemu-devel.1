Received: from eggs.gnu.org ([209.51.188.92]:38052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gij1r-0008R1-LW
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 11:54:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gij1p-0005iK-Nm
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 11:54:31 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gij1m-0005d5-Tl
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 11:54:27 -0500
Received: by mail-wm1-x343.google.com with SMTP id y8so6625878wmi.4
	for <qemu-devel@nongnu.org>; Sun, 13 Jan 2019 08:54:18 -0800 (PST)
References: <20190113143641.38936-1-lifei1214@126.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <a97369ab-c264-4a08-9b9b-a05701c36457@gmail.com>
Date: Sun, 13 Jan 2019 18:54:29 +0200
MIME-Version: 1.0
In-Reply-To: <20190113143641.38936-1-lifei1214@126.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] hw/misc/edu: add msi_uninit() for
 pci_edu_uninit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <lifei1214@126.com>, qemu-devel@nongnu.org, shirley17fei@gmail.com
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>



On 1/13/19 4:36 PM, Fei Li wrote:
> From: Fei Li <shirley17fei@gmail.com>
>
> Let's supplement the msi_uninit() when failing to realize
> the pci edu device.
>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: Fei Li <shirley17fei@gmail.com>
> ---
>   hw/misc/edu.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> index cdcf550dd7..4feb7503de 100644
> --- a/hw/misc/edu.c
> +++ b/hw/misc/edu.c
> @@ -367,6 +367,7 @@ static void pci_edu_uninit(PCIDevice *pdev)
>   {
>       EduState *edu = EDU(pdev);
>   
> +    msi_uninit(pdev);
>       qemu_mutex_lock(&edu->thr_mutex);
>       edu->stopping = true;
>       qemu_mutex_unlock(&edu->thr_mutex);

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel

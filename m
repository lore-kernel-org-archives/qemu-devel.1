Received: from eggs.gnu.org ([209.51.188.92]:33072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmidS-0001Qs-9V
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:17:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmidQ-0005ip-5r
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:17:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gmidP-0005WR-Vh
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:17:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so7327251wrs.10
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 09:17:24 -0800 (PST)
References: <20190124162045.10474-1-sourav.jb1988@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <242af973-21e9-9753-7263-839d118c7be5@redhat.com>
Date: Thu, 24 Jan 2019 18:17:22 +0100
MIME-Version: 1.0
In-Reply-To: <20190124162045.10474-1-sourav.jb1988@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw: sd: set category of the sd memory card
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kumar sourav <sourav.jb1988@gmail.com>, qemu-trivial@nongnu.org
Cc: thuth@redhat.com, f4bug@amsat.org, qemu-devel@nongnu.org

On 1/24/19 5:20 PM, kumar sourav wrote:
> Sets the category of the sd memory card as DEVICE_CATEGORY_STORAGE.
> Devices should be assigned to one of DEVICE_CATEGORY_XXXX.
> 
> Signed-off-by: kumar sourav <sourav.jb1988@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/sd/sd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index d4356e9b73..aaab15f386 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -2121,6 +2121,7 @@ static void sd_class_init(ObjectClass *klass, void *data)
>      dc->vmsd = &sd_vmstate;
>      dc->reset = sd_reset;
>      dc->bus_type = TYPE_SD_BUS;
> +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>  
>      sc->set_voltage = sd_set_voltage;
>      sc->get_dat_lines = sd_get_dat_lines;
> 

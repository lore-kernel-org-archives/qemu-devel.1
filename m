Received: from eggs.gnu.org ([209.51.188.92]:39457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gomA1-0006nP-TI
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 04:28:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gom9t-0004Sd-UD
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 04:27:57 -0500
References: <20190124162045.10474-1-sourav.jb1988@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <bec07d22-d33f-ed5b-8b96-deb431f2d189@vivier.eu>
Date: Wed, 30 Jan 2019 10:27:40 +0100
MIME-Version: 1.0
In-Reply-To: <20190124162045.10474-1-sourav.jb1988@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] hw: sd: set category of the
 sd memory card
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

On 24/01/2019 17:20, kumar sourav wrote:
> Sets the category of the sd memory card as DEVICE_CATEGORY_STORAGE.
> Devices should be assigned to one of DEVICE_CATEGORY_XXXX.
> 
> Signed-off-by: kumar sourav <sourav.jb1988@gmail.com>
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

Applied to my trivial-patches branch.

Thanks,
Laurent

Received: from eggs.gnu.org ([209.51.188.92]:59222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1go2ub-0005Ts-Ew
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:09:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1go2ua-0001ap-Lv
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:09:01 -0500
References: <20190124162045.10474-1-sourav.jb1988@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ad3a3e07-a598-a2b6-91f9-199ebd8b26bd@redhat.com>
Date: Mon, 28 Jan 2019 10:08:52 +0100
MIME-Version: 1.0
In-Reply-To: <20190124162045.10474-1-sourav.jb1988@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: f4bug@amsat.org, qemu-devel@nongnu.org

On 2019-01-24 17:20, kumar sourav wrote:
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

Reviewed-by: Thomas Huth <thuth@redhat.com>

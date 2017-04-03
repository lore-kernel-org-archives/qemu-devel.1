Received: from eggs.gnu.org ([2001:4830:134:3::10]:51105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cv4BM-0007q6-GQ
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:46:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cv4BH-0004bJ-Gi
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:46:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cv4BH-0004aj-BP
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:46:11 -0400
References: <20170401004624.30886-1-ehabkost@redhat.com>
	<20170401004624.30886-15-ehabkost@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <40d94c49-7941-59e3-bcdc-40a2c9358c11@redhat.com>
Date: Mon, 3 Apr 2017 17:46:02 +0200
MIME-Version: 1.0
In-Reply-To: <20170401004624.30886-15-ehabkost@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 14/19] fw_cfg: Remove user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Gabriel L . Somlo" <somlo@cmu.edu>

On 04/01/17 02:46, Eduardo Habkost wrote:
> fw_cfg won't work with -device, as:
> * fw_cfg_init1() won't get called for the device;
> * The device won't appear at /machine/fw_cfg, and won't work with
>   the -fw_cfg command-line option.
> 
> Remove the user_creatable flag from the device class.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Gabriel L. Somlo <somlo@cmu.edu>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/nvram/fw_cfg.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 60bf4fdd2e..316fca9bc1 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -1101,11 +1101,6 @@ static void fw_cfg_io_class_init(ObjectClass *klass, void *data)
>  
>      dc->realize = fw_cfg_io_realize;
>      dc->props = fw_cfg_io_properties;
> -    /*
> -     * FIXME: Set only for compatibility on q35 machine-type.
> -     * Probably never meant to be user-creatable
> -     */
> -    dc->user_creatable = true;
>  }
>  
>  static const TypeInfo fw_cfg_io_info = {
> @@ -1172,11 +1167,6 @@ static void fw_cfg_mem_class_init(ObjectClass *klass, void *data)
>  
>      dc->realize = fw_cfg_mem_realize;
>      dc->props = fw_cfg_mem_properties;
> -    /*
> -     * FIXME: Set only for compatibility on q35 machine-type.
> -     * Probably never meant to be user-creatable
> -     */
> -    dc->user_creatable = true;
>  }
>  
>  static const TypeInfo fw_cfg_mem_info = {
> 

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

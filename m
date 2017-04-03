Received: from eggs.gnu.org ([2001:4830:134:3::10]:51799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv1Kq-00006n-FT
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:43:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv1Kp-0008CF-NA
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:43:52 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170401004624.30886-1-ehabkost@redhat.com>
	<20170401004624.30886-6-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8eafa845-6623-af22-30c7-427083d6ee31@amsat.org>
Date: Mon, 3 Apr 2017 09:43:36 -0300
MIME-Version: 1.0
In-Reply-To: <20170401004624.30886-6-ehabkost@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC 05/19] pflash_cfi01: Remove user_creatable
 flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On 03/31/2017 09:46 PM, Eduardo Habkost wrote:
> TYPE_CFI_PFLASH01 devices need to be mapped by
> pflash_cfi01_register() and can't be used with -device. Remove
> user_creatable from the device class.
>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: qemu-block@nongnu.org
> Cc: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/block/pflash_cfi01.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index f48dc20035..594d4cf6fe 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -927,11 +927,6 @@ static void pflash_cfi01_class_init(ObjectClass *klass, void *data)
>      dc->props = pflash_cfi01_properties;
>      dc->vmsd = &vmstate_pflash;
>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> -    /*
> -     * FIXME: Set only for compatibility on q35 machine-type.
> -     * Probably never meant to be user-creatable
> -     */
> -    dc->user_creatable = true;
>  }
>
>
>

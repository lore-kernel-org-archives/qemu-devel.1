Received: from eggs.gnu.org ([209.51.188.92]:35372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1golz8-00024u-PV
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 04:16:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1golz6-0004cF-9i
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 04:16:42 -0500
References: <20190124144606.4352-1-sourav.jb1988@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <7363e637-7a98-31d9-c08a-3a829b7303bd@vivier.eu>
Date: Wed, 30 Jan 2019 10:16:15 +0100
MIME-Version: 1.0
In-Reply-To: <20190124144606.4352-1-sourav.jb1988@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] hw: edu: set category of
 the edu device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kumar sourav <sourav.jb1988@gmail.com>, qemu-trivial@nongnu.org
Cc: thuth@redhat.com, jslaby@suse.cz, qemu-devel@nongnu.org

On 24/01/2019 15:46, kumar sourav wrote:
> Sets the category of edu device as DEVICE_CATEGORY_MISC.
> Devices should be assigned to one of DEVICE_CATEGORY_XXXX.
> 
> Signed-off-by: kumar sourav <sourav.jb1988@gmail.com>
> ---
>  hw/misc/edu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> index ceaf688bfb..91af452c9e 100644
> --- a/hw/misc/edu.c
> +++ b/hw/misc/edu.c
> @@ -399,6 +399,7 @@ static void edu_instance_init(Object *obj)
>  
>  static void edu_class_init(ObjectClass *class, void *data)
>  {
> +    DeviceClass *dc = DEVICE_CLASS(class);
>      PCIDeviceClass *k = PCI_DEVICE_CLASS(class);
>  
>      k->realize = pci_edu_realize;
> @@ -407,6 +408,7 @@ static void edu_class_init(ObjectClass *class, void *data)
>      k->device_id = 0x11e8;
>      k->revision = 0x10;
>      k->class_id = PCI_CLASS_OTHERS;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>  }
>  
>  static void pci_edu_register_types(void)
> 


Applied to my trivial-patches branch.

Thanks,
Laurent

Received: from eggs.gnu.org ([209.51.188.92]:42445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGVD-0001be-Q8
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:16:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGUq-00068L-24
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:16:31 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gwGUU-0005O7-5c
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:16:11 -0500
Received: by mail-wm1-f67.google.com with SMTP id t15so4662098wmi.5
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 17:13:31 -0800 (PST)
References: <20190220005124.24224-1-richardw.yang@linux.intel.com>
	<20190220005124.24224-2-richardw.yang@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3e749228-df17-9924-65f3-5a88fc654581@redhat.com>
Date: Wed, 20 Feb 2019 02:13:29 +0100
MIME-Version: 1.0
In-Reply-To: <20190220005124.24224-2-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] pc-dimm: remove check on pc-dimm
 hotpluggable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, xiaoguangrong.eric@gmail.com

On 2/20/19 1:51 AM, Wei Yang wrote:
> Function acpi_memory_plug_cb() is only invoked when dev is a PCDIMM,
> which is hotpluggable. This means it is not necessary to check this
> property again.
> 
> This patch removes this check.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> v2:
>   * remove unused dc
> ---
>  hw/acpi/memory_hotplug.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
> index 8c7c1013f3..cb5284d36f 100644
> --- a/hw/acpi/memory_hotplug.c
> +++ b/hw/acpi/memory_hotplug.c
> @@ -264,11 +264,6 @@ void acpi_memory_plug_cb(HotplugHandler *hotplug_dev, MemHotplugState *mem_st,
>                           DeviceState *dev, Error **errp)
>  {
>      MemStatus *mdev;
> -    DeviceClass *dc = DEVICE_GET_CLASS(dev);
> -
> -    if (!dc->hotpluggable) {
> -        return;
> -    }
>  
>      mdev = acpi_memory_slot_status(mem_st, dev, errp);
>      if (!mdev) {
> 

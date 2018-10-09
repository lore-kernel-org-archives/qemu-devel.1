Received: from eggs.gnu.org ([2001:4830:134:3::10]:41939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9pk3-0000QX-Dk
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 06:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9pjz-0003WA-CY
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 06:59:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g9pjz-0003Vq-5T
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 06:59:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id z204-v6so1463574wmc.5
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 03:59:51 -0700 (PDT)
References: <20181005092024.14344-1-david@redhat.com>
	<20181005092024.14344-4-david@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0ef4ef1f-e430-bb4b-60b8-9684b33e6176@redhat.com>
Date: Tue, 9 Oct 2018 12:59:42 +0200
MIME-Version: 1.0
In-Reply-To: <20181005092024.14344-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 03/16] memory-device: improve "range
 conflicts" error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Auger Eric <eric.auger@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 05/10/2018 11:20, David Hildenbrand wrote:
> Handle id==NULL better and indicate that we are dealing with memory
> devices.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/mem/memory-device.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
> index 7c706fadfc..0624184c40 100644
> --- a/hw/mem/memory-device.c
> +++ b/hw/mem/memory-device.c
> @@ -175,7 +175,8 @@ uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
>          if (ranges_overlap(md_addr, md_size, new_addr, size)) {
>              if (hint) {
>                  const DeviceState *d = DEVICE(md);
> -                error_setg(errp, "address range conflicts with '%s'", d->id);
> +                error_setg(errp, "address range conflicts with memory device"
> +                           " id='%s'", d->id ? d->id : "(unnamed)");
>                  goto out;
>              }
>              new_addr = QEMU_ALIGN_UP(md_addr + md_size, align);
> 

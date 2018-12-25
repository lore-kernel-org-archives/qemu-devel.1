Received: from eggs.gnu.org ([208.118.235.92]:34858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gbkkD-00045f-PR
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 06:19:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gbkkA-000061-Iv
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 06:19:29 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gbkkA-0008TF-CP
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 06:19:26 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so12779018wmd.0
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 03:19:25 -0800 (PST)
References: <20181224154922.3338-1-wainersm@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d11ccc45-819f-7f16-cbb3-68b518cb3169@redhat.com>
Date: Tue, 25 Dec 2018 12:19:23 +0100
MIME-Version: 1.0
In-Reply-To: <20181224154922.3338-1-wainersm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/core: fix whitespace in a sentence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, ehabkost@redhat.com

On 12/24/18 4:49 PM, Wainer dos Santos Moschetta wrote:
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/core/machine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 4439ea663f..a0beeeb2a9 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -591,7 +591,7 @@ static void machine_class_init(ObjectClass *oc, void *data)
>      object_class_property_add_bool(oc, "dump-guest-core",
>          machine_get_dump_guest_core, machine_set_dump_guest_core, &error_abort);
>      object_class_property_set_description(oc, "dump-guest-core",
> -        "Include guest memory in  a core dump", &error_abort);
> +        "Include guest memory in a core dump", &error_abort);
>  
>      object_class_property_add_bool(oc, "mem-merge",
>          machine_get_mem_merge, machine_set_mem_merge, &error_abort);
> 

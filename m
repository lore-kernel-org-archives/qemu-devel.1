Received: from eggs.gnu.org ([2001:4830:134:3::10]:41164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gX2qe-0000eq-4s
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:38:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gX2qX-0002dv-Ul
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:38:37 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gX2qV-0002WH-Q9
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:38:32 -0500
Received: by mail-wr1-f67.google.com with SMTP id z5so17318689wrt.11
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 03:38:27 -0800 (PST)
References: <20181212003147.29604-1-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ca246525-69ab-abf8-7352-d5b1d73b1925@redhat.com>
Date: Wed, 12 Dec 2018 12:38:24 +0100
MIME-Version: 1.0
In-Reply-To: <20181212003147.29604-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] virt: Fix broken indentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

On 12/12/18 1:31 AM, Eduardo Habkost wrote:
> I introduced indentation using tabs instead of spaces in another
> commit.  Peter reported the problem, and I failed to fix that
> before sending my pull request.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: 951597607696 ("virt: Eliminate separate instance_init functions")
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/arm/virt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 17f1b49d11..5b678237b7 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1854,7 +1854,7 @@ static const TypeInfo virt_machine_info = {
>      .instance_size = sizeof(VirtMachineState),
>      .class_size    = sizeof(VirtMachineClass),
>      .class_init    = virt_machine_class_init,
> -	.instance_init = virt_instance_init,
> +    .instance_init = virt_instance_init,
>      .interfaces = (InterfaceInfo[]) {
>           { TYPE_HOTPLUG_HANDLER },
>           { }
> 

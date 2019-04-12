Received: from eggs.gnu.org ([209.51.188.92]:46106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEypL-0000iR-72
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEypI-0007wH-C8
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:14:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEypD-0007pd-99
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:14:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so11702209wmd.0
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 09:14:40 -0700 (PDT)
References: <20190412152713.16018-1-marcandre.lureau@redhat.com>
	<20190412152713.16018-2-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6cf497b7-ca7f-791b-2975-3cce6f53819d@redhat.com>
Date: Fri, 12 Apr 2019 18:14:38 +0200
MIME-Version: 1.0
In-Reply-To: <20190412152713.16018-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] vl: constify VGAInterfaceInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com, kraxel@redhat.com

On 4/12/19 5:27 PM, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  vl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index c696ad2a13..0a96232e95 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2026,7 +2026,7 @@ typedef struct VGAInterfaceInfo {
>      const char *class_names[2];
>  } VGAInterfaceInfo;
>  
> -static VGAInterfaceInfo vga_interfaces[VGA_TYPE_MAX] = {
> +static const VGAInterfaceInfo vga_interfaces[VGA_TYPE_MAX] = {
>      [VGA_NONE] = {
>          .opt_name = "none",
>      },
> @@ -2072,7 +2072,7 @@ static VGAInterfaceInfo vga_interfaces[VGA_TYPE_MAX] = {
>  
>  static bool vga_interface_available(VGAInterfaceType t)
>  {
> -    VGAInterfaceInfo *ti = &vga_interfaces[t];
> +    const VGAInterfaceInfo *ti = &vga_interfaces[t];
>  
>      assert(t < VGA_TYPE_MAX);
>      return !ti->class_names[0] ||
> @@ -2087,7 +2087,7 @@ static void select_vgahw(const char *p)
>  
>      assert(vga_interface_type == VGA_NONE);
>      for (t = 0; t < VGA_TYPE_MAX; t++) {
> -        VGAInterfaceInfo *ti = &vga_interfaces[t];
> +        const VGAInterfaceInfo *ti = &vga_interfaces[t];
>          if (ti->opt_name && strstart(p, ti->opt_name, &opts)) {
>              if (!vga_interface_available(t)) {
>                  error_report("%s not available", ti->name);
> 

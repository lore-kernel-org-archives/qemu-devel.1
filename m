Received: from eggs.gnu.org ([2001:4830:134:3::10]:44930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7h18-0007MU-Nv
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7h13-0001dr-3O
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:16:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g7h12-0001cc-AB
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:16:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id d2-v6so1673680wro.7
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 06:16:34 -0700 (PDT)
References: <20181003121138.22037-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <433a7066-f22e-7b8a-db10-fe7ff45918db@redhat.com>
Date: Wed, 3 Oct 2018 15:16:32 +0200
MIME-Version: 1.0
In-Reply-To: <20181003121138.22037-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] gtk: fix uninitialized variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com

On 03/10/2018 14:11, Paolo Bonzini wrote:
> zoom_to_fit is never initialized to false, Coverity complains
> (not sure why GCC does not).
> 
> Fixes: e8b1386ea1719525a1a92df03377764703fe8c64
> Cc: kraxel@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  ui/gtk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 3ddb5fe162..ec935fff90 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -2136,7 +2136,7 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
>                                QemuConsole *con, int idx,
>                                GSList *group, GtkWidget *view_menu)
>  {
> -    bool zoom_to_fit;
> +    bool zoom_to_fit = false;
>  
>      vc->label = qemu_console_get_label(con);
>      vc->s = s;
> 

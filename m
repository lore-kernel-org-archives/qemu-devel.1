Received: from eggs.gnu.org ([2001:4830:134:3::10]:46250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG21T-0005uk-Po
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:47:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG21N-0004py-Ow
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:47:15 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:45789)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG21N-0004pN-Kp
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:47:09 -0400
Received: by mail-qk0-x243.google.com with SMTP id x22so24486706qkb.12
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 05:47:09 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-23-git-send-email-mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b29d125b-e667-b47f-e315-458910c21725@amsat.org>
Date: Tue, 8 May 2018 09:47:03 -0300
MIME-Version: 1.0
In-Reply-To: <1525376963-79623-23-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 22/67] ui: use local path for local headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: kwolf@redhat.com, peter.maydell@linaro.org

On 05/03/2018 04:51 PM, Michael S. Tsirkin wrote:
> When pulling in headers that are in the same directory as C file (as
> opposed to one in include/), we should use its relative path, without a
> directory. Directory based path works more or less by accident.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  ui/gtk.c          | 2 +-
>  ui/input-keymap.c | 2 +-
>  ui/input-legacy.c | 2 +-
>  ui/spice-input.c  | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/ui/gtk.c b/ui/gtk.c
> index bb3214c..e723304 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -66,7 +66,7 @@
>  #define VC_SCALE_STEP   0.25
>  
>  #ifdef GDK_WINDOWING_X11
> -#include "ui/x_keymap.h"
> +#include "x_keymap.h"
>  
>  /* Gtk2 compat */
>  #ifndef GDK_IS_X11_DISPLAY
> diff --git a/ui/input-keymap.c b/ui/input-keymap.c
> index 3d4e66b..87cc301 100644
> --- a/ui/input-keymap.c
> +++ b/ui/input-keymap.c
> @@ -1,6 +1,6 @@
>  #include "qemu/osdep.h"
>  #include "sysemu/sysemu.h"
> -#include "ui/keymaps.h"
> +#include "keymaps.h"
>  #include "ui/input.h"
>  
>  #include "standard-headers/linux/input.h"
> diff --git a/ui/input-legacy.c b/ui/input-legacy.c
> index e5d4db1..549654e 100644
> --- a/ui/input-legacy.c
> +++ b/ui/input-legacy.c
> @@ -26,7 +26,7 @@
>  #include "qapi/qapi-commands-ui.h"
>  #include "sysemu/sysemu.h"
>  #include "ui/console.h"
> -#include "ui/keymaps.h"
> +#include "keymaps.h"
>  #include "ui/input.h"
>  
>  struct QEMUPutMouseEntry {
> diff --git a/ui/spice-input.c b/ui/spice-input.c
> index 3d41aa1..a426c03 100644
> --- a/ui/spice-input.c
> +++ b/ui/spice-input.c
> @@ -23,7 +23,7 @@
>  #include "qemu-common.h"
>  #include "ui/qemu-spice.h"
>  #include "ui/console.h"
> -#include "ui/keymaps.h"
> +#include "keymaps.h"
>  #include "ui/input.h"
>  
>  /* keyboard bits */
> 

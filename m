Received: from eggs.gnu.org ([2001:4830:134:3::10]:50491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecVg8-0002oR-1P
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 07:21:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecVg3-0001ZG-Bj
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 07:21:52 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecVg3-0001Z2-7X
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 07:21:47 -0500
Received: by mail-qt0-x242.google.com with SMTP id 33so3311427qtv.1
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 04:21:47 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180117164118.8510-1-berrange@redhat.com>
	<20180117164118.8510-4-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <33388738-2ac7-c926-9c41-b6284d7200c2@amsat.org>
Date: Fri, 19 Jan 2018 09:21:43 -0300
MIME-Version: 1.0
In-Reply-To: <20180117164118.8510-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 3/4] ui: fix alphabetical ordering of
 keymaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 01/17/2018 01:41 PM, Daniel P. Berrange wrote:
> The qcode-to-linux keymaps was accidentally added in the wrong place
> by
> 
>   commit de80d78594b4c3767a12d8d42debcf12cbf85a5b
>   Author: Owen Smith <owen.smith@citrix.com>
>   Date:   Fri Nov 3 11:56:28 2017 +0000
> 
>     ui: generate qcode to linux mappings
> 
> breaking the alphabetical ordering of keymaps
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  Makefile           | 2 +-
>  include/ui/input.h | 6 +++---
>  ui/input-keymap.c  | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index c62e96b6c7..e3f960905f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -236,10 +236,10 @@ KEYCODEMAP_FILES = \
>  		 ui/input-keymap-qcode-to-atset1.c \
>  		 ui/input-keymap-qcode-to-atset2.c \
>  		 ui/input-keymap-qcode-to-atset3.c \
> +		 ui/input-keymap-qcode-to-linux.c \
>  		 ui/input-keymap-qcode-to-qnum.c \
>  		 ui/input-keymap-qcode-to-sun.c \
>  		 ui/input-keymap-qnum-to-qcode.c \
> -		 ui/input-keymap-qcode-to-linux.c \
>  		 $(NULL)
>  
>  GENERATED_FILES += $(KEYCODEMAP_FILES)
> diff --git a/include/ui/input.h b/include/ui/input.h
> index e6c9b483b0..bf3d0d1060 100644
> --- a/include/ui/input.h
> +++ b/include/ui/input.h
> @@ -80,6 +80,9 @@ extern const guint16 qemu_input_map_qcode_to_atset2[];
>  extern const guint qemu_input_map_qcode_to_atset3_len;
>  extern const guint16 qemu_input_map_qcode_to_atset3[];
>  
> +extern const guint qemu_input_map_qcode_to_linux_len;
> +extern const guint16 qemu_input_map_qcode_to_linux[];
> +
>  extern const guint qemu_input_map_qcode_to_qnum_len;
>  extern const guint16 qemu_input_map_qcode_to_qnum[];
>  
> @@ -89,7 +92,4 @@ extern const guint16 qemu_input_map_qcode_to_sun[];
>  extern const guint qemu_input_map_qnum_to_qcode_len;
>  extern const guint16 qemu_input_map_qnum_to_qcode[];
>  
> -extern const guint qemu_input_map_qcode_to_linux_len;
> -extern const guint16 qemu_input_map_qcode_to_linux[];
> -
>  #endif /* INPUT_H */
> diff --git a/ui/input-keymap.c b/ui/input-keymap.c
> index 32cc224e39..1f60caf314 100644
> --- a/ui/input-keymap.c
> +++ b/ui/input-keymap.c
> @@ -9,10 +9,10 @@
>  #include "ui/input-keymap-qcode-to-atset1.c"
>  #include "ui/input-keymap-qcode-to-atset2.c"
>  #include "ui/input-keymap-qcode-to-atset3.c"
> +#include "ui/input-keymap-qcode-to-linux.c"
>  #include "ui/input-keymap-qcode-to-qnum.c"
>  #include "ui/input-keymap-qcode-to-sun.c"
>  #include "ui/input-keymap-qnum-to-qcode.c"
> -#include "ui/input-keymap-qcode-to-linux.c"
>  
>  int qemu_input_linux_to_qcode(unsigned int lnx)
>  {
> 

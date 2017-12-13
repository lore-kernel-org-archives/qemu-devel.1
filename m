Received: from eggs.gnu.org ([2001:4830:134:3::10]:43432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=513001ac0=anthony.perard@citrix.com>)
	id 1eP9Or-0002kc-Gd
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:56:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=513001ac0=anthony.perard@citrix.com>)
	id 1eP9On-0008CD-L6
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:56:49 -0500
Received: from smtp02.citrix.com ([66.165.176.63]:27643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=513001ac0=anthony.perard@citrix.com>)
	id 1eP9On-0008Bg-CS
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:56:45 -0500
Date: Wed, 13 Dec 2017 15:04:55 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20171213150455.GG2216@perard.uk.xensource.com>
References: <20171212141044.2582-1-berrange@redhat.com>
	<20171212141044.2582-2-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20171212141044.2582-2-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 1/4] hw: convert virtio-input-hid device
 to keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

On Tue, Dec 12, 2017 at 02:10:41PM +0000, Daniel P. Berrange wrote:
> diff --git a/Makefile b/Makefile
> index ab0354c153..5aaff5fe1e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -227,6 +227,7 @@ KEYCODEMAP_CSV = $(SRC_PATH)/ui/keycodemapdb/data/keymaps.csv
>  
>  KEYCODEMAP_FILES = \
>  		 ui/input-keymap-linux-to-qcode.c \
> +		 ui/input-keymap-qcode-to-linux.c \
>  		 ui/input-keymap-qcode-to-qnum.c \
>  		 ui/input-keymap-qnum-to-qcode.c \
>  		 $(NULL)

FYI, there is a patch on the mailing list that does just generate the
new keymap:
<20171103115631.15175-2-owen.smith@citrix.com>
([PATCH v5 1/4] ui: generate qcode to linux mappings)

> diff --git a/include/ui/input.h b/include/ui/input.h
> index f8cee43f65..6f56d868c7 100644
> --- a/include/ui/input.h
> +++ b/include/ui/input.h
> @@ -71,6 +71,9 @@ void qemu_remove_mouse_mode_change_notifier(Notifier *notify);
>  extern const guint qemu_input_map_linux_to_qcode_len;
>  extern const guint16 qemu_input_map_linux_to_qcode[];
>  
> +extern const guint qemu_input_map_qcode_to_linux_len;
> +extern const guint16 qemu_input_map_qcode_to_linux[];
> +
>  extern const guint qemu_input_map_qcode_to_qnum_len;
>  extern const guint16 qemu_input_map_qcode_to_qnum[];
>  
> diff --git a/ui/input-keymap.c b/ui/input-keymap.c
> index 3a19a169f5..6e543d651f 100644
> --- a/ui/input-keymap.c
> +++ b/ui/input-keymap.c
> @@ -6,6 +6,7 @@
>  #include "standard-headers/linux/input.h"
>  
>  #include "ui/input-keymap-linux-to-qcode.c"
> +#include "ui/input-keymap-qcode-to-linux.c"
>  #include "ui/input-keymap-qcode-to-qnum.c"
>  #include "ui/input-keymap-qnum-to-qcode.c"

-- 
Anthony PERARD

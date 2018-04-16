Received: from eggs.gnu.org ([2001:4830:134:3::10]:43157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7uE9-000387-7W
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 22:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7uE8-0008Gm-FD
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 22:50:45 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180414142739.23375-1-mjt@msgid.tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fbdc319a-d816-1135-116a-1db5438325c3@amsat.org>
Date: Sun, 15 Apr 2018 23:50:35 -0300
MIME-Version: 1.0
In-Reply-To: <20180414142739.23375-1-mjt@msgid.tls.msk.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH trivial for-2.12] Makefile:
 install gtk message catalogs if CONFIG_GTK=y too, not only =m
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

Hi Michael,

On 04/14/2018 11:27 AM, Michael Tokarev wrote:
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 727ef118f3..8644c2e918 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -856,7 +856,7 @@ ifneq ($(BLOBS),)
>  		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/$$x "$(DESTDIR)$(qemu_datadir)"; \
>  	done
>  endif
> -ifeq ($(CONFIG_GTK),m)
> +ifneq ($(filter $(CONFIG_GTK),y m),)

Or simply:

ifdef CONFIG_GTK

>  	$(MAKE) -C po $@
>  endif
>  	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/keymaps"
> 

Regards,

Phil.

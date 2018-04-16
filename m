Received: from eggs.gnu.org ([2001:4830:134:3::10]:36105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f8104-0005w6-RL
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 06:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f80zz-00014t-SB
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 06:04:40 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f80zz-00014V-OJ
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 06:04:35 -0400
Received: by mail-qt0-x242.google.com with SMTP id p9so12330972qtn.0
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 03:04:35 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180416093719.2543-1-mjt@msgid.tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3d86cad3-4a6f-ec71-7e4a-ce4b4a0ffc20@amsat.org>
Date: Mon, 16 Apr 2018 07:04:30 -0300
MIME-Version: 1.0
In-Reply-To: <20180416093719.2543-1-mjt@msgid.tls.msk.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12] Makefile: install gtk message
 catalogs if CONFIG_GTK=y too, not only =m
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Bruce Rogers <brogers@suse.com>

On 04/16/2018 06:37 AM, Michael Tokarev wrote:
> Fixes 722cd7496474cebb2218f21e038592fad8603365
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 727ef118f3..d71dd5bea4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -856,7 +856,7 @@ ifneq ($(BLOBS),)
>  		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/$$x "$(DESTDIR)$(qemu_datadir)"; \
>  	done
>  endif
> -ifeq ($(CONFIG_GTK),m)
> +ifdef CONFIG_GTK
>  	$(MAKE) -C po $@
>  endif
>  	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/keymaps"
> 

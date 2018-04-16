Received: from eggs.gnu.org ([2001:4830:134:3::10]:32776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f887D-0003e1-Hp
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 13:40:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f887C-0002MY-Ja
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 13:40:31 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:41405)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f887C-0002M4-AR
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 13:40:30 -0400
Received: by mail-oi0-x241.google.com with SMTP id 188-v6so15329225oih.8
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 10:40:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180416093719.2543-1-mjt@msgid.tls.msk.ru>
References: <20180416093719.2543-1-mjt@msgid.tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Apr 2018 18:40:09 +0100
Message-ID: <CAFEAcA_6_bZOZDpUSwCzu96v3kj5ZPdj-yCOnLTYBVv3dvRxMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bruce Rogers <brogers@suse.com>

On 16 April 2018 at 10:37, Michael Tokarev <mjt@tls.msk.ru> wrote:
> Fixes 722cd7496474cebb2218f21e038592fad8603365
>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 727ef118f3..d71dd5bea4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -856,7 +856,7 @@ ifneq ($(BLOBS),)
>                 $(INSTALL_DATA) $(SRC_PATH)/pc-bios/$$x "$(DESTDIR)$(qemu_datadir)"; \
>         done
>  endif
> -ifeq ($(CONFIG_GTK),m)
> +ifdef CONFIG_GTK
>         $(MAKE) -C po $@
>  endif
>         $(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/keymaps"
> --
> 2.11.0

Applied, thanks.

-- PMM

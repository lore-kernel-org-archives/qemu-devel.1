Received: from eggs.gnu.org ([2001:4830:134:3::10]:44941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f80Px-0001Bd-Kp
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 05:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f80Pw-0004hE-Sb
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 05:27:21 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:37876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f80Pw-0004eu-Mc
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 05:27:20 -0400
Received: by mail-ot0-x242.google.com with SMTP id y46-v6so16616528otd.4
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 02:27:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180414142739.23375-1-mjt@msgid.tls.msk.ru>
References: <20180414142739.23375-1-mjt@msgid.tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Apr 2018 10:26:59 +0100
Message-ID: <CAFEAcA_isnmigyPV=bZtyJ3r++8pc__7b9z12FEtd6SHJum9mg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH trivial for-2.12] Makefile: install gtk
 message catalogs if CONFIG_GTK=y too, not only =m
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 14 April 2018 at 15:27, Michael Tokarev <mjt@tls.msk.ru> wrote:
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
>                 $(INSTALL_DATA) $(SRC_PATH)/pc-bios/$$x "$(DESTDIR)$(qemu_datadir)"; \
>         done
>  endif
> -ifeq ($(CONFIG_GTK),m)
> +ifneq ($(filter $(CONFIG_GTK),y m),)
>         $(MAKE) -C po $@
>  endif
>         $(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/keymaps"
> --
> 2.11.0

"trivial" and "for 2.12" don't make much sense together at this point in
the release cycle. Is this important enough to go into rc4, or not?

thanks
-- PMM

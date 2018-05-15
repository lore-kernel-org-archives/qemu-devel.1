Received: from eggs.gnu.org ([2001:4830:134:3::10]:43628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIcGS-0000M6-Do
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:53:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIcGO-0001o3-G4
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:53:24 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:42492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIcGO-0001mp-CA
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:53:20 -0400
Received: by mail-qt0-x241.google.com with SMTP id c2-v6so878506qtn.9
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 08:53:20 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180515153039.27514-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ff4985f3-a3c8-4f4d-fd10-c6b7ed4b26c2@amsat.org>
Date: Tue, 15 May 2018 12:53:16 -0300
MIME-Version: 1.0
In-Reply-To: <20180515153039.27514-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] ccid-card-passthru: fix regression in
 realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

On 05/15/2018 12:30 PM, Marc-André Lureau wrote:
> Since cc847bfd16d894fd8c1a2ce25f31772f6cdbbc74, CCID card-passthru
> fails to intialize, because it changed a debug line to an error,
> probably by mistake. Change it back to a DPRINTF debug.

Oops.

> (solves Boxes creating VM with smartcard passthru failing to start)
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/usb/ccid-card-passthru.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
> index 7684db0cb3..25fb19b0d7 100644
> --- a/hw/usb/ccid-card-passthru.c
> +++ b/hw/usb/ccid-card-passthru.c
> @@ -345,7 +345,7 @@ static void passthru_realize(CCIDCardState *base, Error **errp)
>      card->vscard_in_pos = 0;
>      card->vscard_in_hdr = 0;
>      if (qemu_chr_fe_backend_connected(&card->cs)) {
> -        error_setg(errp, "ccid-card-passthru: initing chardev");
> +        DPRINTF(card, D_INFO, "ccid-card-passthru: initing chardev");
>          qemu_chr_fe_set_handlers(&card->cs,
>              ccid_card_vscard_can_read,
>              ccid_card_vscard_read,
> 

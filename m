Received: from eggs.gnu.org ([209.51.188.92]:48667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gs5Ta-0007sa-Kk
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 07:41:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gs5TV-0007OL-Cf
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 07:41:50 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:63458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gs5TL-0007Ad-SI
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 07:41:38 -0500
Date: Fri, 8 Feb 2019 13:41:17 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20190208072744.10687-1-kraxel@redhat.com>
Message-ID: <alpine.BSF.2.21.9999.1902081339360.66579@zero.eik.bme.hu>
References: <20190208072744.10687-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH] sdl2: drop qemu_input_event_send_key_qcode
 call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, 8 Feb 2019, Gerd Hoffmann wrote:
> qkbd_state_key_event() does that for us.
>
> Fixes: 07333e1ca3 kbd-state: use state tracker for sdl2
> Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Fixes my problem.

Tested-by: BALATON Zoltan <balaton@eik.bme.hu>

Thank you,
BALATON Zoltan

> ---
> ui/sdl2-input.c | 3 ---
> 1 file changed, 3 deletions(-)
>
> diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
> index 664364a5e5..fb345f45fb 100644
> --- a/ui/sdl2-input.c
> +++ b/ui/sdl2-input.c
> @@ -54,8 +54,5 @@ void sdl2_process_key(struct sdl2_console *scon,
>                 break;
>             }
>         }
> -    } else {
> -        qemu_input_event_send_key_qcode(con, qcode,
> -                                        ev->type == SDL_KEYDOWN);
>     }
> }
>

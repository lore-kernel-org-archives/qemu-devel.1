Received: from eggs.gnu.org ([2001:4830:134:3::10]:50596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1eFhku-0005yE-AD
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:36:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1eFhkt-0005ou-84
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:36:32 -0500
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:36731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1eFhkt-0005oG-2V
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:36:31 -0500
Received: by mail-it0-x244.google.com with SMTP id 187so2094181iti.1
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 06:36:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510926167-23326-15-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1510926167-23326-15-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Fri, 17 Nov 2017 15:36:10 +0100
Message-ID: <CACXAS8Ds+1KBZ2ji03R64iMvZUVOa3U2dUpRTNbcTfrk-hcO8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 14/15] sparc64: introduce trace-events for
 hw/sparc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Fri, Nov 17, 2017 at 2:42 PM, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> This is in preparation for switching code in hw/sparc64 from DPRINTF over to
> trace events.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

> ---
>  Makefile.objs           |    1 +
>  hw/sparc64/trace-events |    1 +
>  2 files changed, 2 insertions(+)
>  create mode 100644 hw/sparc64/trace-events
>
> diff --git a/Makefile.objs b/Makefile.objs
> index 285c6f3..c8b1bba 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -140,6 +140,7 @@ trace-events-subdirs += hw/input
>  trace-events-subdirs += hw/timer
>  trace-events-subdirs += hw/dma
>  trace-events-subdirs += hw/sparc
> +trace-events-subdirs += hw/sparc64
>  trace-events-subdirs += hw/sd
>  trace-events-subdirs += hw/isa
>  trace-events-subdirs += hw/mem
> diff --git a/hw/sparc64/trace-events b/hw/sparc64/trace-events
> new file mode 100644
> index 0000000..9284b1f
> --- /dev/null
> +++ b/hw/sparc64/trace-events
> @@ -0,0 +1 @@
> +# See docs/devel/tracing.txt for syntax documentation.
> --
> 1.7.10.4
>



-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu

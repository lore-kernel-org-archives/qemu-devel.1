Received: from eggs.gnu.org ([2001:4830:134:3::10]:60060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eGa2G-0000C6-6v
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 19:34:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eGa2F-0006Xx-E0
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 19:34:04 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eGa2F-0006Xs-9K
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 19:34:03 -0500
Received: by mail-qk0-x243.google.com with SMTP id o6so5594692qkh.3
	for <qemu-devel@nongnu.org>; Sun, 19 Nov 2017 16:34:03 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1510926167-23326-15-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f7bfe57e-c70f-8150-3289-50441c061f73@amsat.org>
Date: Sun, 19 Nov 2017 12:14:29 -0300
MIME-Version: 1.0
In-Reply-To: <1510926167-23326-15-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com

Hi Mark,

On 11/17/2017 10:42 AM, Mark Cave-Ayland wrote:
> This is in preparation for switching code in hw/sparc64 from DPRINTF over to
> trace events.

This could be squashed with next commit,

Either way:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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
> 

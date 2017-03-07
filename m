Received: from eggs.gnu.org ([2001:4830:134:3::10]:45042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1clEJo-0008VH-Bv
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 07:34:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1clEJk-0003vb-C5
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 07:34:20 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:26167)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1clEJk-0003v9-54
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 07:34:16 -0500
Date: Tue, 7 Mar 2017 13:34:14 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <1488876018-31576-1-git-send-email-kraxel@redhat.com>
Message-ID: <alpine.BSF.2.20.1703071331280.81187@zero.eik.bme.hu>
References: <1488876018-31576-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] ohci: relax link check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, programmingkidx@gmail.com, qemu-ppc@nongnu.org, hsp.cat7@gmail.com

On Tue, 7 Mar 2017, Gerd Hoffmann wrote:
> The strict td link limit added by commit "95ed569 usb: ohci: limit the
> number of link eds" causes problems with macos guests.  Lets raise the
> limit.
>
> Reported-by: Programmingkid <programmingkidx@gmail.com>
> Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

I've also tested that this fixes mouse under MorphOS as well. However I'm 
not sure that this limit is correct for every possible USB devices so this 
may need to be increased in the future if a device is found needing more 
linked TDs.

> ---
> hw/usb/hcd-ohci.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> index fe8406a..3ada35e 100644
> --- a/hw/usb/hcd-ohci.c
> +++ b/hw/usb/hcd-ohci.c
> @@ -42,7 +42,7 @@
>
> #define OHCI_MAX_PORTS 15
>
> -#define ED_LINK_LIMIT 4
> +#define ED_LINK_LIMIT 32
>
> static int64_t usb_frame_time;
> static int64_t usb_bit_time;
>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:53267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1clopo-0007ww-Mw
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 22:33:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1clopj-0008MO-Oq
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 22:33:48 -0500
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <1488876018-31576-1-git-send-email-kraxel@redhat.com>
Date: Wed, 8 Mar 2017 22:33:38 -0500
Content-Transfer-Encoding: 7bit
Message-Id: <CC67C949-3050-4CD7-90EA-B260E4B89ADF@gmail.com>
References: <1488876018-31576-1-git-send-email-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ohci: relax link check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, hsp.cat7@gmail.com, qemu-ppc@nongnu.org


On Mar 7, 2017, at 3:40 AM, Gerd Hoffmann wrote:

> The strict td link limit added by commit "95ed569 usb: ohci: limit the
> number of link eds" causes problems with macos guests.  Lets raise the
> limit.
> 
> Reported-by: Programmingkid <programmingkidx@gmail.com>
> Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
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
> -- 
> 1.8.3.1

Reviewed-by: John Arbuckle <programmingkidx@gmail.com>

Tested with Mac OS 10.4 and Mac OS 9.2.

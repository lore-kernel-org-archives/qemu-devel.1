Received: from eggs.gnu.org ([2001:4830:134:3::10]:44721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cdt1T-0001wP-0u
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 01:25:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cdt1R-000315-Tl
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 01:25:03 -0500
Received: from mail-it0-x229.google.com ([2607:f8b0:4001:c0b::229]:32786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cdt1R-00030v-ON
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 01:25:01 -0500
Received: by mail-it0-x229.google.com with SMTP id d9so23397770itc.0
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 22:25:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5899ac3e.1033240a.944d5.9a2d@mx.google.com>
References: <5899ac3e.1033240a.944d5.9a2d@mx.google.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 15 Feb 2017 14:25:00 +0800
Message-ID: <CAKXe6SLOXdgQRXe=tdUqoppG5a033UEP3oompaxN7gG1EvHz0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] usb: ohci: fix error return code in
 servicing iso td
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Li Qiang <liqiang6-s@360.cn>

Ping...

2017-02-07 19:15 GMT+08:00 Li Qiang <liq3ea@gmail.com>:

> From: Li Qiang <liqiang6-s@360.cn>
>
> It should return 1 if an error occurs when reading iso td.
> This will avoid an infinite loop issue in ohci_service_ed_list.
>
> Signed-off-by: Li Qiang <liqiang6-s@360.cn>
> ---
>  hw/usb/hcd-ohci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> index 4a63f3b..21c93e0 100644
> --- a/hw/usb/hcd-ohci.c
> +++ b/hw/usb/hcd-ohci.c
> @@ -727,7 +727,7 @@ static int ohci_service_iso_td(OHCIState *ohci, struct
> ohci_ed *ed,
>      if (ohci_read_iso_td(ohci, addr, &iso_td)) {
>          trace_usb_ohci_iso_td_read_failed(addr);
>          ohci_die(ohci);
> -        return 0;
> +        return 1;
>      }
>
>      starting_frame = OHCI_BM(iso_td.flags, TD_SF);
> --
> 1.8.3.1
>
>

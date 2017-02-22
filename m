Received: from eggs.gnu.org ([2001:4830:134:3::10]:38604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgXoi-0005CN-Pl
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:22:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgXoe-0004TG-8M
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:22:52 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgXoe-0004SH-4J
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:22:48 -0500
Received: by mail-qk0-x243.google.com with SMTP id r90so588510qki.3
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 06:22:48 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1487760990-115925-1-git-send-email-liqiang6-s@360.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cb4466dc-90f7-e969-33be-0298f3e4ae21@amsat.org>
Date: Wed, 22 Feb 2017 11:22:44 -0300
MIME-Version: 1.0
In-Reply-To: <1487760990-115925-1-git-send-email-liqiang6-s@360.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] usb: ohci: fix error return code in
 servicing td
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, Li Qiang <liqiang6-s@360.cn>, ppandit@redhat.com

On 02/22/2017 07:56 AM, Li Qiang wrote:
> It should return 1 if an error occurs when reading td.
> This will avoid an infinite loop issue in ohci_service_ed_list.
>
> Signed-off-by: Li Qiang <liqiang6-s@360.cn>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/usb/hcd-ohci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> index 21c93e0..fe8406a 100644
> --- a/hw/usb/hcd-ohci.c
> +++ b/hw/usb/hcd-ohci.c
> @@ -1001,7 +1001,7 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
>      if (ohci_read_td(ohci, addr, &td)) {
>          trace_usb_ohci_td_read_error(addr);
>          ohci_die(ohci);
> -        return 0;
> +        return 1;
>      }
>
>      dir = OHCI_BM(ed->flags, ED_D);
>

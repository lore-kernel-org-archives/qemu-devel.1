Received: from eggs.gnu.org ([2001:4830:134:3::10]:48669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1e4kNM-00075s-1m
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:10:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1e4kNK-0001FQ-Vt
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:10:55 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:50492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1e4kNK-0001CK-Qv
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:10:54 -0400
Received: by mail-io0-x241.google.com with SMTP id 97so5189715iok.7
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 02:10:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1508059309-28458-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1508059309-28458-1-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 18 Oct 2017 11:10:32 +0200
Message-ID: <CACXAS8Afsmewn0J_kW+9bqoVZOHZwEJEwKJ_MnzFNM77XDaqBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] sun4u: fix assert when adding NICs which
 aren't the in-built model
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

On Sun, Oct 15, 2017 at 11:21 AM, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> Commit 8d93297 introduced a bug whereby non-inbuilt NICs are realized before
> setting the default MAC address causing an assert. Switch NIC creation
> over from pci_create_simple() to pci_create() which works exactly the
> same except omitting the realize as originally intended.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

> ---
>  hw/sparc64/sun4u.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 2edd1cc..bf89252 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -490,10 +490,10 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>                  memcpy(&macaddr, &nd->macaddr.a, sizeof(MACAddr));
>                  onboard_nic = true;
>              } else {
> -                pci_dev = pci_create_simple(pci_busB, -1, "sunhme");
> +                pci_dev = pci_create(pci_busB, -1, "sunhme");
>              }
>          } else {
> -            pci_dev = pci_create_simple(pci_busB, -1, nd->model);
> +            pci_dev = pci_create(pci_busB, -1, nd->model);
>          }
>
>          dev = &pci_dev->qdev;
> --
> 1.7.10.4
>



-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu

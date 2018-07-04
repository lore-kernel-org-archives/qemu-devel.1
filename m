Received: from eggs.gnu.org ([2001:4830:134:3::10]:46454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fakpd-0002xh-9g
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 12:40:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fakpa-0003q7-1p
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 12:40:41 -0400
Date: Wed, 4 Jul 2018 18:40:35 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180704144400.9419-1-f4bug@amsat.org>
Message-ID: <alpine.BSF.2.21.1807041838350.151@zero.eik.bme.hu>
References: <20180704144400.9419-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ppc440_uc: Fix a copy/paste error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org

On Wed, 4 Jul 2018, Philippe Mathieu-Daud=C3=A9 wrote:
> Missed in 3c409c1927e, hopefully reported by Coverity.

Apparently Coverity did report it and Paolo already notified me about=20
that. I was about to send a patch but you were faster. Thank you very=20
much.

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> Fixes: Coverity CID 1393788 (Copy-paste error)
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> hw/ppc/ppc440_uc.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
> index 0bbaa6844a..09ccda548f 100644
> --- a/hw/ppc/ppc440_uc.c
> +++ b/hw/ppc/ppc440_uc.c
> @@ -935,7 +935,7 @@ static void dcr_write_dma(void *opaque, int dcrn, u=
int32_t val)
>                     if (wptr) {
>                         cpu_physical_memory_unmap(wptr, wlen, 1, didx);
>                     }
> -                    if (wptr) {
> +                    if (rptr) {
>                         cpu_physical_memory_unmap(rptr, rlen, 0, sidx);
>                     }
>                 }
>

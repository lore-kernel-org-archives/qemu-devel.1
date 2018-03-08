Received: from eggs.gnu.org ([2001:4830:134:3::10]:49227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu0LI-0007as-Bi
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:32:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu0LH-00050K-4N
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:32:40 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180308111305.C9F56745707@zero.eik.bme.hu>
	<20180308144845.0D7647456CD@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ff8b93cc-921c-6e0c-b847-b0ae286a2049@amsat.org>
Date: Thu, 8 Mar 2018 15:32:33 -0300
MIME-Version: 1.0
In-Reply-To: <20180308144845.0D7647456CD@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] ppc440_pcix: Change some error_report
 to qemu_log_mask(LOG_UNIMP, ...)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 03/08/2018 08:08 AM, BALATON Zoltan wrote:
> Using log unimp is more appropriate for these messages and this also
> silences them by default so they won't clobber make check output when
> tests are added for this board.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
> v2: Use defined format string for printing hwaddr instead of casting.

Thanks.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> I guess this does not invalidate the R-b tag of v1 so I've added that too.
> 
>  hw/ppc/ppc440_pcix.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
> index ab2626a..1dc5d7f 100644
> --- a/hw/ppc/ppc440_pcix.c
> +++ b/hw/ppc/ppc440_pcix.c
> @@ -286,8 +286,9 @@ static void ppc440_pcix_reg_write4(void *opaque, hwaddr addr,
>          break;
>  
>      default:
> -        error_report("%s: unhandled PCI internal register 0x%lx", __func__,
> -                     (unsigned long)addr);
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: unhandled PCI internal register 0x%"HWADDR_PRIx"\n",
> +                      __func__, addr);
>          break;
>      }
>  }
> @@ -377,8 +378,9 @@ static uint64_t ppc440_pcix_reg_read4(void *opaque, hwaddr addr,
>          break;
>  
>      default:
> -        error_report("%s: invalid PCI internal register 0x%lx", __func__,
> -                     (unsigned long)addr);
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: invalid PCI internal register 0x%" HWADDR_PRIx "\n",
> +                      __func__, addr);
>          val = 0;
>      }
>  
> 

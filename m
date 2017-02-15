Received: from eggs.gnu.org ([2001:4830:134:3::10]:33050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cdwv1-0001ZE-7b
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:34:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cdwuy-00051U-2r
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:34:39 -0500
References: <CA+O_+ExjKRNyfbXWzh7RRHgTjqTBC+WscYCiBGyjLK2XOvoPmQ@mail.gmail.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <97012317-0db8-a272-1802-7a402ebe78a5@msgid.tls.msk.ru>
Date: Wed, 15 Feb 2017 13:34:34 +0300
MIME-Version: 1.0
In-Reply-To: <CA+O_+ExjKRNyfbXWzh7RRHgTjqTBC+WscYCiBGyjLK2XOvoPmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/acpi/tco.c: fix tco timer stop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Pavlikevich <ipavlikevich@gmail.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org

06.02.2017 17:44, Igor Pavlikevich wrote:
> TCO timer does not actually stop
> 
> Signed-off-by: Igor Pavlikevich <ipavlikevich@gmail.com>
> ---
>  hw/acpi/tco.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/acpi/tco.c b/hw/acpi/tco.c
> index 8ce7daf..b4adac8 100644
> --- a/hw/acpi/tco.c
> +++ b/hw/acpi/tco.c
> @@ -49,6 +49,7 @@ static inline void tco_timer_reload(TCOIORegs *tr)
>  static inline void tco_timer_stop(TCOIORegs *tr)
>  {
>      tr->expire_time = -1;
> +    timer_del(tr->tco_timer);
>  }
> 
>  static void tco_timer_expired(void *opaque)
> 

I'm not sure this is really trivial change.
Can you elaborate a bit please?

And please Cc qemu-devel@ too (doing this now).

Thanks,

/mjt

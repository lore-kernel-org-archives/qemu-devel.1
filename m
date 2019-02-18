Received: from eggs.gnu.org ([209.51.188.92]:58660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gvrB7-0005cL-Ll
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 17:14:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gvqxz-0006BM-Lq
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 17:00:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gvqxx-0005kI-5N
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 17:00:45 -0500
Received: by mail-wm1-f66.google.com with SMTP id y185so750227wmd.1
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 14:00:27 -0800 (PST)
References: <20190214125107.22178-1-peter.maydell@linaro.org>
	<20190214125107.22178-8-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1d552313-760c-da28-056b-6e8c65ff1688@redhat.com>
Date: Mon, 18 Feb 2019 23:00:25 +0100
MIME-Version: 1.0
In-Reply-To: <20190214125107.22178-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 07/14] hw/char/pl011: Use '0x' prefix when
 logging hex numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 2/14/19 1:51 PM, Peter Maydell wrote:
> The pl011 logs when the guest makes a bad access. It prints
> the address offset in hex but confusingly omits the '0x'
> prefix; add it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/char/pl011.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index 29f4e5eb224..e5dd448f854 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -143,7 +143,7 @@ static uint64_t pl011_read(void *opaque, hwaddr offset,
>          break;
>      default:
>          qemu_log_mask(LOG_GUEST_ERROR,
> -                      "pl011_read: Bad offset %x\n", (int)offset);
> +                      "pl011_read: Bad offset 0x%x\n", (int)offset);
>          r = 0;
>          break;
>      }
> @@ -232,7 +232,7 @@ static void pl011_write(void *opaque, hwaddr offset,
>          break;
>      default:
>          qemu_log_mask(LOG_GUEST_ERROR,
> -                      "pl011_write: Bad offset %x\n", (int)offset);
> +                      "pl011_write: Bad offset 0x%x\n", (int)offset);
>      }
>  }
>  
> 

Received: from eggs.gnu.org ([209.51.188.92]:54395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWsS-0002Xe-Ug
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWeK-0007W5-QW
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:09:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEWeK-0007VR-Ee
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:09:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so6509851wrq.8
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 03:09:40 -0700 (PDT)
References: <20190325090047.122981-1-ysato@users.sourceforge.jp>
	<20190401140318.80498-1-ysato@users.sourceforge.jp>
	<20190401140318.80498-13-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <09399349-5134-7347-b86d-d28c9fd1803d@redhat.com>
Date: Thu, 11 Apr 2019 12:09:38 +0200
MIME-Version: 1.0
In-Reply-To: <20190401140318.80498-13-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v6 12/12] include/hw/regiserfields.h:
 Add 8bit and 16bit registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org

Hi Yoshinori,

Note about the patch subject:
- typo in regiserfields (missing 't') -> registerfields
- I'd simply use "hw/registerfields: Add 8bit and 16bit register macros"

On 4/1/19 4:03 PM, Yoshinori Sato wrote:
> Some RX peripheral using 8bit and 16bit registers.
> Added 8bit and 16bit APIs.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  include/hw/registerfields.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/hw/registerfields.h b/include/hw/registerfields.h
> index 2659a58737..f6bf911990 100644
> --- a/include/hw/registerfields.h
> +++ b/include/hw/registerfields.h
> @@ -22,6 +22,14 @@
>      enum { A_ ## reg = (addr) };                                          \
>      enum { R_ ## reg = (addr) / 4 };
>  
> +#define REG8(reg, addr)                                                  \
> +    enum { A_ ## reg = (addr) };                                          \
> +    enum { R_ ## reg = (addr) };
> +
> +#define REG16(reg, addr)                                                  \
> +    enum { A_ ## reg = (addr) };                                          \
> +    enum { R_ ## reg = (addr) / 2 };
> +
>  /* Define SHIFT, LENGTH and MASK constants for a field within a register */
>  
>  /* This macro will define R_FOO_BAR_MASK, R_FOO_BAR_SHIFT and R_FOO_BAR_LENGTH
> @@ -40,6 +48,8 @@
>  #define FIELD_EX64(storage, reg, field)                                   \
>      extract64((storage), R_ ## reg ## _ ## field ## _SHIFT,               \
>                R_ ## reg ## _ ## field ## _LENGTH)
> +#define FIELD_EX8  FIELD_EX32
> +#define FIELD_EX16 FIELD_EX32
>  
>  /* Extract a field from an array of registers */
>  #define ARRAY_FIELD_EX32(regs, reg, field)                                \

For completeness, what about adding FIELD_DP8() and FIELD_DP16()?

Regards,

Phil.

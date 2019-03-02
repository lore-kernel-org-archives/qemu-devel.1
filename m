Received: from eggs.gnu.org ([209.51.188.92]:59492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0A1u-0002bt-AM
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 14:10:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0A1t-0003Jx-L5
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 14:10:38 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:52157)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h0A1t-0003JS-EX
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 14:10:37 -0500
Received: by mail-wm1-f53.google.com with SMTP id n19so1094955wmi.1
	for <qemu-devel@nongnu.org>; Sat, 02 Mar 2019 11:10:36 -0800 (PST)
References: <20190301202921.21209-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b2d06943-feef-789d-dab7-482bc78a7ea2@redhat.com>
Date: Sat, 2 Mar 2019 20:10:34 +0100
MIME-Version: 1.0
In-Reply-To: <20190301202921.21209-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target/arm: Fix PC test for LDM (exception
 return)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 3/1/19 9:29 PM, Richard Henderson wrote:
> Found by inspection: Rn is the base register against which the
> load began; I is the register within the mask being processed.
> The exception return should of course be procesed from the loaded PC.

"processed"

> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 8f7f5b95aa..ad879e3480 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -10612,7 +10612,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>                              } else if (i == rn) {
>                                  loaded_var = tmp;
>                                  loaded_base = 1;
> -                            } else if (rn == 15 && exc_return) {
> +                            } else if (i == 15 && exc_return) {
>                                  store_pc_exc_ret(s, tmp);
>                              } else {
>                                  store_reg_from_load(s, i, tmp);
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

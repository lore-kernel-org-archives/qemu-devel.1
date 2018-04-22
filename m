Received: from eggs.gnu.org ([2001:4830:134:3::10]:48099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fAKnp-0004aR-5E
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 15:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fAKnk-0008Bz-Op
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 15:37:37 -0400
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233]:36420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fAKnk-0008BR-IC
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 15:37:32 -0400
Received: by mail-pg0-x233.google.com with SMTP id i6so6860028pgv.3
	for <qemu-devel@nongnu.org>; Sun, 22 Apr 2018 12:37:32 -0700 (PDT)
References: <1524250517-28032-1-git-send-email-cota@braap.org>
	<1524250517-28032-7-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1c046420-d44b-a2dc-0932-144aff26b1fa@linaro.org>
Date: Sun, 22 Apr 2018 09:37:27 -1000
MIME-Version: 1.0
In-Reply-To: <1524250517-28032-7-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/18] target/mips: use lookup_and_goto_ptr
 on BS_STOP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 04/20/2018 08:55 AM, Emilio G. Cota wrote:
> The TB after BS_STOP is not fixed (e.g. helper_mtc0_hwrena
> changes hflags, which ends up changing the TB flags via
> cpu_get_tb_cpu_state). This requires a full lookup (i.e.
> with flags) via lookup_and_goto_ptr instead of gen_goto_tb,
> since the latter only looks at the PC for in-page goto's. Fix it.
> 
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/mips/translate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

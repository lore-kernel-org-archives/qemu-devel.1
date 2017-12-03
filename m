Received: from eggs.gnu.org ([2001:4830:134:3::10]:52266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eLW0M-0004Ge-Ry
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 10:16:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eLW0H-00011R-SN
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 10:16:30 -0500
Received: from mail-pl0-x231.google.com ([2607:f8b0:400e:c01::231]:33974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eLW0H-00010v-NA
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 10:16:25 -0500
Received: by mail-pl0-x231.google.com with SMTP id d21so8969562pll.1
	for <qemu-devel@nongnu.org>; Sun, 03 Dec 2017 07:16:25 -0800 (PST)
References: <1512153879-5291-1-git-send-email-peter.maydell@linaro.org>
	<1512153879-5291-7-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <09877af2-5542-8f26-1acf-db2935431fcd@linaro.org>
Date: Sun, 3 Dec 2017 07:16:21 -0800
MIME-Version: 1.0
In-Reply-To: <1512153879-5291-7-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/7] target/arm: Factor MPU lookup code out
 of get_phys_addr_pmsav8()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 12/01/2017 10:44 AM, Peter Maydell wrote:
> For the TT instruction we're going to need to do an MPU lookup that
> also tells us which MPU region the access hit. This requires us
> to do the MPU lookup without first doing the SAU security access
> check, so pull the MPU lookup parts of get_phys_addr_pmsav8()
> out into their own function.
> 
> The TT instruction also needs to know the MPU region number which
> the lookup hit, so provide this information to the caller of the
> MPU lookup code, even though get_phys_addr_pmsav8() doesn't
> need to know it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 130 +++++++++++++++++++++++++++++++---------------------
>  1 file changed, 79 insertions(+), 51 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

Received: from eggs.gnu.org ([209.51.188.92]:52189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gvQkU-0008Rw-Ut
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 13:01:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gvQkT-0005lf-VX
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 13:01:06 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gvQkR-0005hR-RV
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 13:01:05 -0500
Received: by mail-pf1-x444.google.com with SMTP id s22so7357984pfh.4
	for <qemu-devel@nongnu.org>; Sun, 17 Feb 2019 10:01:03 -0800 (PST)
References: <20190214125107.22178-1-peter.maydell@linaro.org>
	<20190214125107.22178-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <49f30287-716a-567d-577a-576d14700e07@linaro.org>
Date: Sun, 17 Feb 2019 10:00:59 -0800
MIME-Version: 1.0
In-Reply-To: <20190214125107.22178-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 2/14/19 4:51 AM, Peter Maydell wrote:
> The pl011 logs when the guest makes a bad access. It prints
> the address offset in hex but confusingly omits the '0x'
> prefix; add it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/char/pl011.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

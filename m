Received: from eggs.gnu.org ([2001:4830:134:3::10]:32873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1enrAj-0007yP-88
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:32:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1enrAf-0007hj-BP
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:32:21 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:33696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1enrAf-0007hF-4u
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:32:17 -0500
Received: by mail-pl0-x244.google.com with SMTP id x18so593039pln.0
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 11:32:17 -0800 (PST)
References: <1518751105-17211-1-git-send-email-cota@braap.org>
	<1518751105-17211-3-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <57eafadc-9855-2561-0815-ff644919d5d0@linaro.org>
Date: Mon, 19 Feb 2018 11:32:13 -0800
MIME-Version: 1.0
In-Reply-To: <1518751105-17211-3-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] target/sh4: convert to TranslatorOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

On 02/15/2018 07:18 PM, Emilio G. Cota wrote:
> This was fairly straightforward since it had already been converted
> to DisasContextBase; just had to add TARGET_TOO_MANY to the switch
> in tb_stop.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/sh4/translate.c | 175 +++++++++++++++++++++++++------------------------
>  1 file changed, 90 insertions(+), 85 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

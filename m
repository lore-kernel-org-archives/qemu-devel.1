Received: from eggs.gnu.org ([2001:4830:134:3::10]:52859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5jtu-0005mu-2c
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:24:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5jtt-0004xj-9R
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:24:54 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:38475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f5jtt-0004x9-2j
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:24:53 -0400
Received: by mail-pf0-x241.google.com with SMTP id y69so7085355pfb.5
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 20:24:53 -0700 (PDT)
References: <1523038800-2494-1-git-send-email-cota@braap.org>
	<1523038800-2494-6-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c2e3fea5-637e-fab3-3372-8ef9fb9baa07@linaro.org>
Date: Tue, 10 Apr 2018 13:24:46 +1000
MIME-Version: 1.0
In-Reply-To: <1523038800-2494-6-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 05/17] target/sparc: convert to
 TranslatorOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

On 04/07/2018 04:19 AM, Emilio G. Cota wrote:
> Notes:
> 
> - Moved the cross-page check from the end of translate_insn to
>   init_disas_context.
> 
> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/sparc/translate.c | 174 +++++++++++++++++++++++------------------------
>  1 file changed, 86 insertions(+), 88 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

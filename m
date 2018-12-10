Received: from eggs.gnu.org ([2001:4830:134:3::10]:43139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWQul-00054E-OL
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 14:08:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWQug-0003HV-QK
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 14:08:23 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gWQug-0003H3-Ir
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 14:08:18 -0500
Received: by mail-ot1-x344.google.com with SMTP id t5so11545818otk.1
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 11:08:18 -0800 (PST)
References: <20181207085635.4291-1-mark.cave-ayland@ilande.co.uk>
	<20181207085635.4291-6-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e7958108-bfa2-0610-eb35-fc6edda581e8@linaro.org>
Date: Mon, 10 Dec 2018 13:08:14 -0600
MIME-Version: 1.0
In-Reply-To: <20181207085635.4291-6-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 5/6] target/ppc: convert VMX logical
 instructions to use vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 12/7/18 2:56 AM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/translate.c              |  1 +
>  target/ppc/translate/vmx-impl.inc.c | 64 ++++++++++++++++++++++---------------
>  2 files changed, 40 insertions(+), 25 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

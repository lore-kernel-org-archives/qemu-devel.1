Received: from eggs.gnu.org ([209.51.188.92]:54301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1xlg-00029F-3r
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:29:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1xle-0008RG-8d
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:29:20 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41831)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1xlZ-0007yq-Gv
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:29:14 -0500
Received: by mail-pf1-x443.google.com with SMTP id d25so12073464pfn.8
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 10:28:40 -0800 (PST)
References: <20190307180520.13868-1-mark.cave-ayland@ilande.co.uk>
	<20190307180520.13868-6-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fffc013a-dfc0-af87-9097-34595e278755@linaro.org>
Date: Thu, 7 Mar 2019 10:28:37 -0800
MIME-Version: 1.0
In-Reply-To: <20190307180520.13868-6-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/7] target/ppc: improve avr64_offset()
 and use it to simplify get_avr64()/set_avr64()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 3/7/19 10:05 AM, Mark Cave-Ayland wrote:
> By using the VsrD macro in avr64_offset() the same offset calculation can be
> used regardless of the host endian. This allows get_avr64() and set_avr64() to
> be simplified accordingly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/cpu.h                    |  5 +++++
>  target/ppc/translate.c              | 16 ++--------------
>  target/ppc/translate/vmx-impl.inc.c |  5 -----
>  3 files changed, 7 insertions(+), 19 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

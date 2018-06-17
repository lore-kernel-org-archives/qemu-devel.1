Received: from eggs.gnu.org ([2001:4830:134:3::10]:55321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUQTI-0006oj-Ai
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 01:43:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUQTE-0002if-9Q
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 01:43:28 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:44584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fUQTD-0002hQ-Qg
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 01:43:24 -0400
Received: by mail-pf0-x243.google.com with SMTP id h12-v6so6664814pfk.11
	for <qemu-devel@nongnu.org>; Sat, 16 Jun 2018 22:43:23 -0700 (PDT)
References: <20180615073303.502-1-mark.cave-ayland@ilande.co.uk>
	<20180615073303.502-2-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3dab573c-438b-7255-f83c-1e30e5f3fd38@linaro.org>
Date: Sat, 16 Jun 2018 19:43:16 -1000
MIME-Version: 1.0
In-Reply-To: <20180615073303.502-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v4 1/1] SPARC64: add icount support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com, cota@braap.org

On 06/14/2018 09:33 PM, Mark Cave-Ayland wrote:
> This patch adds gen_io_start()/gen_io_end() to various instructions as required
> in order to boot my OpenBIOS test images on qemu-system-sparc64 with icount
> enabled.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/sparc/translate.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 110 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

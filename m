Received: from eggs.gnu.org ([2001:4830:134:3::10]:54375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG4Rw-0004vX-2M
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:55:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG4Rq-0002KN-5j
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:54:59 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:38990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG4Rn-0002JQ-Er
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:54:52 -0400
Received: by mail-wm1-x334.google.com with SMTP id y144-v6so1899123wmd.4
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 08:54:50 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-64-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a6a37f1b-da7e-13a9-daa8-3aee6c992768@linaro.org>
Date: Fri, 26 Oct 2018 16:54:45 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-64-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 64/71] sparc: convert to
 cpu_has_work_with_iothread_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

On 10/25/18 3:46 PM, Emilio G. Cota wrote:
> Soon we will call cpu_has_work without the BQL.
> 
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/sparc/cpu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

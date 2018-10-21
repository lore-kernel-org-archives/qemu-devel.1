Received: from eggs.gnu.org ([2001:4830:134:3::10]:39637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDQi-0004yl-Lq
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:06:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDF7-0002UF-U6
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 08:54:09 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:50978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDF7-0002U9-NS
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 08:54:05 -0400
Received: by mail-wm1-x32e.google.com with SMTP id i8-v6so7575961wmg.0
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 05:54:05 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-9-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <70a1af22-e297-9ad9-da1a-01bd937117c9@linaro.org>
Date: Sun, 21 Oct 2018 13:54:01 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-9-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 08/56] cpu: define cpu_halted helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 10/19/18 2:05 AM, Emilio G. Cota wrote:
> cpu->halted will soon be protected by cpu->lock.
> We will use these helpers to ease the transition,
> since right now cpu->halted has many direct callers.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qom/cpu.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

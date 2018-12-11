Received: from eggs.gnu.org ([2001:4830:134:3::10]:60493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWjyX-0003dZ-Un
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:29:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWjyX-0002Uj-3s
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:29:33 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gWjyV-0002S1-AH
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:29:31 -0500
Received: by mail-ot1-x342.google.com with SMTP id s5so14361976oth.7
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 07:29:29 -0800 (PST)
MIME-Version: 1.0
References: <20181207103631.28193-1-richard.henderson@linaro.org>
	<20181207103631.28193-7-richard.henderson@linaro.org>
In-Reply-To: <20181207103631.28193-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Dec 2018 15:29:18 +0000
Message-ID: <CAFEAcA_owe2OumDoTq-xCW+2_SUV0OEOuVWGGo1UZ-SzHS1d=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 06/26] target/arm: Rearrange decode in
 disas_data_proc_1src
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>

On Fri, 7 Dec 2018 at 10:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Now properly signals unallocated for REV64 with SF=0.
> Allows for the opcode2 field to be decoded shortly.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:34211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC5o2-0003VQ-1i
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:33:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC5no-0002GE-9H
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:33:16 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gC5nn-0002Fb-Pv
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:33:08 -0400
Received: by mail-pf1-x442.google.com with SMTP id c25-v6so9952118pfe.6
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 09:33:07 -0700 (PDT)
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <794027d9-80ca-225f-b1c2-cf32b92c76f4@linaro.org>
Date: Mon, 15 Oct 2018 09:33:02 -0700
MIME-Version: 1.0
In-Reply-To: <20181005154910.3099-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 07/21] accel/tcg/cputlb: convert
 tlb_flush debugging into trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, cota@braap.org, Pavel.Dovgaluk@ispras.ru, Paolo Bonzini <pbonzini@redhat.com>, vilanova@ac.upc.edu, Richard Henderson <rth@twiddle.net>

On 10/5/18 8:48 AM, Alex Bennée wrote:
> +    trace_tlb_flush_all_work(cpu->cpu_index);
>      tlb_flush_nocheck(cpu);
> +    trace_tlb_flush_work_complete(__LINE__, cpu->cpu_index);

Why is __LINE__ an interesting argument to a trace function?


r~

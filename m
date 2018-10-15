Received: from eggs.gnu.org ([2001:4830:134:3::10]:34915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gC7WU-00028r-FJ
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 14:23:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gC7WL-0003ql-LW
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 14:23:18 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gC7WL-0003pr-5T
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 14:23:13 -0400
Received: by mail-wr1-x441.google.com with SMTP id x12-v6so22461066wru.8
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 11:23:12 -0700 (PDT)
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-8-alex.bennee@linaro.org>
	<794027d9-80ca-225f-b1c2-cf32b92c76f4@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <794027d9-80ca-225f-b1c2-cf32b92c76f4@linaro.org>
Date: Mon, 15 Oct 2018 19:23:09 +0100
Message-ID: <87efcr3w8i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, cota@braap.org, Pavel.Dovgaluk@ispras.ru, Paolo Bonzini <pbonzini@redhat.com>, vilanova@ac.upc.edu, Richard Henderson <rth@twiddle.net>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 10/5/18 8:48 AM, Alex Benn=C3=A9e wrote:
>> +    trace_tlb_flush_all_work(cpu->cpu_index);
>>      tlb_flush_nocheck(cpu);
>> +    trace_tlb_flush_work_complete(__LINE__, cpu->cpu_index);
>
> Why is __LINE__ an interesting argument to a trace function?

Yeah - I wanted a unique key for each flush but that wasn't an opaque
char ptr to a __FUNC__. I guess I should just go ahead and have a type
enum? Can such a thing be exported via trace-events easily though?

--
Alex Benn=C3=A9e

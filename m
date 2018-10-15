Received: from eggs.gnu.org ([2001:4830:134:3::10]:42928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gC7kF-0006LP-3t
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 14:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gC7kE-0003Cl-99
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 14:37:35 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1gC7kD-00036P-VG
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 14:37:34 -0400
Received: by mail-pg1-x542.google.com with SMTP id 23-v6so9564967pgc.8
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 11:37:25 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-8-alex.bennee@linaro.org>
	<794027d9-80ca-225f-b1c2-cf32b92c76f4@linaro.org>
	<87efcr3w8i.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b5ffdcef-13c3-9d56-492d-828a07779336@twiddle.net>
Date: Mon, 15 Oct 2018 11:37:22 -0700
MIME-Version: 1.0
In-Reply-To: <87efcr3w8i.fsf@linaro.org>
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, cota@braap.org, Pavel.Dovgaluk@ispras.ru, Paolo Bonzini <pbonzini@redhat.com>, vilanova@ac.upc.edu

On 10/15/18 11:23 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 10/5/18 8:48 AM, Alex Bennée wrote:
>>> +    trace_tlb_flush_all_work(cpu->cpu_index);
>>>      tlb_flush_nocheck(cpu);
>>> +    trace_tlb_flush_work_complete(__LINE__, cpu->cpu_index);
>>
>> Why is __LINE__ an interesting argument to a trace function?
> 
> Yeah - I wanted a unique key for each flush but that wasn't an opaque
> char ptr to a __FUNC__. I guess I should just go ahead and have a type
> enum? Can such a thing be exported via trace-events easily though?

I don't think so, at the moment.  I dunno what's best really.


r~

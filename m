Received: from eggs.gnu.org ([2001:4830:134:3::10]:52657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cpvls-0000N5-60
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:46:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cpvlp-0001WG-2U
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:46:44 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:38476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cpvlo-0001Uf-Pw
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:46:40 -0400
Received: by mail-wm0-x22b.google.com with SMTP id t189so62017797wmt.1
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 04:46:40 -0700 (PDT)
References: <20170224112109.3147-1-alex.bennee@linaro.org>
	<20170224112109.3147-12-alex.bennee@linaro.org>
	<f7a4cba9-12da-fbb3-684f-68b4a11fbe97@vivier.eu>
	<87y3wr8zs2.fsf@linaro.org>
	<e3f645d0-ea92-b28d-bb2b-9c831dd8b264@vivier.eu>
	<87var7ocr9.fsf@linaro.org>
	<3a41adf2-0771-86ee-2805-77997c46207a@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <3a41adf2-0771-86ee-2805-77997c46207a@redhat.com>
Date: Mon, 20 Mar 2017 11:47:03 +0000
Message-ID: <87lgs0npag.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 11/24] tcg: enable thread-per-vCPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Laurent Vivier <laurent@vivier.eu>, peter.maydell@linaro.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, KONRAD Frederic <fred.konrad@greensocs.com>, Richard Henderson <rth@twiddle.net>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 17/03/2017 21:43, Alex Bennée wrote:
>> There is currently cpu->running which is set/cleared by
>> cpu_exec_start/end. Although if we crash between cpu_exec_start and
>> sigsetjmp the same sort of brokenness might happen.
>
> I think cpu_exec_start/end should be moved into cpu_exec itself (but
> probably just in 2.10).

Sure. Although hopefully we can resist the temptation to insert segging
code into that small window in the meantime ;-)

>
> Paolo
>
>> Anyway understood now. If anyone has any suggestions for neater stuff
>> over the weekend please shout, otherwise I'll probably just hack
>> handle_cpu_signal to do:
>>
>>    cpu = current_cpu;
>>    if (!cpu->running) {
>>       /* we weren't running or translating JIT code when the signal came */
>>       return 1;
>>    }


--
Alex Bennée

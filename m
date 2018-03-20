Received: from eggs.gnu.org ([2001:4830:134:3::10]:45946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ey5J6-0005t7-Ld
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 20:39:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ey5J1-0003UG-OL
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 20:39:16 -0400
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:40441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ey5J1-0003Sp-Hy
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 20:39:11 -0400
Received: by mail-pg0-x235.google.com with SMTP id g8so7611324pgv.7
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 17:39:11 -0700 (PDT)
References: <20180319031545.29359-1-richard.henderson@linaro.org>
	<cb280617-9d27-4f04-ae0d-f30130bd5b8f@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bc6e6998-cfcb-09ec-600f-f3c55e208186@linaro.org>
Date: Tue, 20 Mar 2018 08:39:06 +0800
MIME-Version: 1.0
In-Reply-To: <cb280617-9d27-4f04-ae0d-f30130bd5b8f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] tcg: Really fix cpu_io_recompile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Pavel.Dovgaluk@ispras.ru, peter.maydell@linaro.org

On 03/19/2018 11:54 PM, Paolo Bonzini wrote:
> On 19/03/2018 04:15, Richard Henderson wrote:
>> We have confused the number of instructions that have been
>> executed in the TB with the number of instructions needed
>> to repeat the I/O instruction.
>>
>> We have used cpu_restore_state_from_tb, which means that
>> the guest pc is pointing to the I/O instruction.  The only
>> time the answer to the later question is not 1 is when
>> MIPS or SH4 need to re-execute the branch for the delay
>> slot as well.
>>
>> We must rely on cpu->cflags_next_tb to generate the next TB,
>> as otherwise we have a race condition with other guest cpus
>> within the TB cache.
>>
>> Fixes: 0790f86861079b1932679d0f011e431aaf4ee9e2
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>
>> My v1 raced with Paolo's pull request, so v2 now fixes Pavel's fix.
> 
> Thanks, let me know if you prefer to send a pull request yourself, or if
> I should include it in the next.

I'm at Linaro Connect this week.  Please include this in your next.


r~

Received: from eggs.gnu.org ([2001:4830:134:3::10]:49505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bijan.mottahedeh@oracle.com>) id 1gLJhA-0005Tz-Sk
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 22:12:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bijan.mottahedeh@oracle.com>) id 1gLJh6-00056u-9b
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 22:12:24 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bijan.mottahedeh@oracle.com>)
	id 1gLJh5-00055x-UE
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 22:12:20 -0500
References: <1541616504-68526-1-git-send-email-bijan.mottahedeh@oracle.com>
	<1541616504-68526-2-git-send-email-bijan.mottahedeh@oracle.com>
	<47f78310-56e7-ba5e-0fb1-99830750e49b@linaro.org>
From: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Message-ID: <7cfea6b6-b0eb-f276-edc7-da2e7f77ded0@oracle.com>
Date: Fri, 9 Nov 2018 19:12:08 -0800
MIME-Version: 1.0
In-Reply-To: <47f78310-56e7-ba5e-0fb1-99830750e49b@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [RFC QEMU 1/2] arm/virt: Initialize generic timer
 scale factor dynamically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: kvmarm@lists.cs.columbia.edu, Karl Heubaum <karl.heubaum@oracle.com>

On 11/8/2018 6:21 AM, Richard Henderson wrote:
> On 11/7/18 7:48 PM, Bijan Mottahedeh wrote:
>>   
>> +static void set_system_clock_scale(void)
>> +{
>> +    unsigned long cntfrq_el0;
>> +
>> +    asm volatile("mrs %0, cntfrq_el0" : "=r"(cntfrq_el0));
>> +
>> +    if (cntfrq_el0 == 0) {
>> +        cntfrq_el0 = GTIMER_SCALE_DEF;
>> +    }
>> +
>> +    system_clock_scale = NANOSECONDS_PER_SECOND / (int)cntfrq_el0;
>> +}
> This only works for kvm.
>
> For TCG you need to use the default always.  In particular, it won't even
> compile for an x86 host.
>
>
> r~
Is it ok to ifdef the asm statement with CONFIG_KVM, or what would be 
the correct way to account for TCG vs. KVM?

Thanks.

--bijan

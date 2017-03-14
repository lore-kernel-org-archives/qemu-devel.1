Received: from eggs.gnu.org ([2001:4830:134:3::10]:46461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnpgf-0000eB-Jm
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:52:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnpgb-0008BM-Ne
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:52:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cnpgb-0008B0-ID
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:52:37 -0400
References: <a7977444b25641cc86352a6818a4df3a@EXCHCS32.ornl.gov>
	<000601d29710$edf987b0$c9ec9710$@ru> <874lyxqpl4.fsf@linaro.org>
	<000001d29cbb$f396a800$dac3f800$@ru>
	<be7ee11c-4c10-cee8-a35e-7905e0c44881@redhat.com>
	<000801d29cbd$12ab64a0$38022de0$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ff7cbd70-e284-a823-f4d0-99595a73f5b8@redhat.com>
Date: Tue, 14 Mar 2017 17:52:34 +0100
MIME-Version: 1.0
In-Reply-To: <000801d29cbd$12ab64a0$38022de0$@ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] -rtc clock=vm with -icount 1,
 sleep=off introduces unexpected delays in device interactions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, =?UTF-8?Q?'Alex_Benn=c3=a9e'?= <alex.bennee@linaro.org>
Cc: "'Nutaro, James J.'" <nutarojj@ornl.gov>, mttcg@greensocs.com, qemu-devel@nongnu.org



On 14/03/2017 13:18, Pavel Dovgalyuk wrote:
>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
>> On 14/03/2017 13:10, Pavel Dovgalyuk wrote:
>>> This is not the same.
>>> BQL helped in making execution deterministic - no io and timer
>>> callbacks were performed while CPU is executing.
>>> Now iothread and CPU thread work simultaneously and timers can't
>>> query virtual time correctly, because (if we could query number of executed
>>> instructions) it may have different values on different runs.
>>>
>>> I guess you'll have to bring kicking CPU back on iothread invocation
>>> to make execution deterministic in icount mode.
>>
>> Timers are fixed by my patch.  I/O should also work if its effects are
>> only apparent at given QEMU_CLOCK_VIRTUAL values.
> 
> Can you point me on that patch?

I sent a pull request now, but it doesn't fix record/replay.

https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg02621.html

Paolo

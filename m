Received: from eggs.gnu.org ([208.118.235.92]:37508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fzgWW-0004eX-Hm
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 07:08:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fzgWO-000148-RN
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 07:08:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41250 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fzgWO-00013J-Jl
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 07:07:52 -0400
References: <20180703085250.28380.33220.stgit@pasha-VirtualBox>
	<004001d41777$78daa890$6a8ff9b0$@ru>
	<11934dd9-cf71-8640-622e-7eaec967a3b2@redhat.com>
	<001f01d449a2$475d3f50$d617bdf0$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fb80a07d-5eb3-a854-6d8d-a60283505b66@redhat.com>
Date: Tue, 11 Sep 2018 13:07:49 +0200
MIME-Version: 1.0
In-Reply-To: <001f01d449a2$475d3f50$d617bdf0$@ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] replay: wake up vCPU when replaying
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, maria.klimushenkova@ispras.ru

On 11/09/2018 09:37, Pavel Dovgalyuk wrote:
>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
>> On 09/07/2018 13:24, Pavel Dovgalyuk wrote:
>>> static void qemu_tcg_rr_wait_io_event(CPUState *cpu)
>>> {
>>>     while (all_cpu_threads_idle()) {
>>>         stop_tcg_kick_timer();
>>>         qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
>>>     }
>>>
>>>     start_tcg_kick_timer();
>>>
>>>     qemu_wait_io_event_common(cpu);
>>> }
>>>
>>> all_cpu_threads_idle() returns true when there is no queued work.
>>> But between this call and qemu_cond_wait() iothread may add queued work
>>> and the vCPU thread will sleep infinitely.
>>
>> Maybe queue_work_on_cpu is called outside BQL?
> 
> I don't remember now.
> However, rr series includes the better version of that patch.

Good, thanks.

Paolo

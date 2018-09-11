Received: from eggs.gnu.org ([2001:4830:134:3::10]:54570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fzdEk-0006pn-MN
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 03:37:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fzdEg-0006Qo-B3
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 03:37:26 -0400
Received: from mail.ispras.ru ([83.149.199.45]:56868)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fzdEg-0006Pn-2M
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 03:37:22 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180703085250.28380.33220.stgit@pasha-VirtualBox>
	<004001d41777$78daa890$6a8ff9b0$@ru>
	<11934dd9-cf71-8640-622e-7eaec967a3b2@redhat.com>
In-Reply-To: <11934dd9-cf71-8640-622e-7eaec967a3b2@redhat.com>
Date: Tue, 11 Sep 2018 10:37:22 +0300
Message-ID: <001f01d449a2$475d3f50$d617bdf0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH] replay: wake up vCPU when replaying
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, maria.klimushenkova@ispras.ru

> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> On 09/07/2018 13:24, Pavel Dovgalyuk wrote:
> > static void qemu_tcg_rr_wait_io_event(CPUState *cpu)
> > {
> >     while (all_cpu_threads_idle()) {
> >         stop_tcg_kick_timer();
> >         qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
> >     }
> >
> >     start_tcg_kick_timer();
> >
> >     qemu_wait_io_event_common(cpu);
> > }
> >
> > all_cpu_threads_idle() returns true when there is no queued work.
> > But between this call and qemu_cond_wait() iothread may add queued work
> > and the vCPU thread will sleep infinitely.
> 
> Maybe queue_work_on_cpu is called outside BQL?

I don't remember now.
However, rr series includes the better version of that patch.

Pavel Dovgalyuk

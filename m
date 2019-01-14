Received: from eggs.gnu.org ([209.51.188.92]:53923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1givHe-0002Jl-3M
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 00:59:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1givHd-0006rl-Bu
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 00:59:38 -0500
Received: from mail.ispras.ru ([83.149.199.45]:43442)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1givHZ-0006gk-DE
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 00:59:35 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <cover.1539860473.git.artem.k.pisarenko@gmail.com>
	<000601d4a8e8$a8a10170$f9e30450$@ru>
	<fa160cd8-483c-2eba-b459-8a0f50fb5e6d@redhat.com>
In-Reply-To: <fa160cd8-483c-2eba-b459-8a0f50fb5e6d@redhat.com>
Date: Mon, 14 Jan 2019 08:59:22 +0300
Message-ID: <000601d4abce$4bf706c0$e3e51440$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce attributes for timers
 subsystem and remove QEMU_CLOCK_VIRTUAL_EXT clock type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Artem Pisarenko' <artem.k.pisarenko@gmail.com>, qemu-devel@nongnu.org
Cc: 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>

> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> On 10/01/19 14:30, Pavel Dovgalyuk wrote:
> > Now timerlist_deadline_ns uses all virtual timers for deadline calculation (including
> external
> > ones).
> > qemu_start_warp_timer uses the deadline for setting warp timer (which should be
> deterministic).
> 
> Can you introduce a variant of qemu_clock_deadline_ns_all that ignores
> external timers, and use it in qemu_start_warp_timer?

Ok.

> timerlist_deadline_ns can be made static, so adding a bool argument to
> it is not a big issue for API cleanliness.
> 
> In fact, qemu_clock_deadline_ns_all is only ever used with
> QEMU_CLOCK_VIRTUAL, so you could also change it to
> 
> uint64_t virtual_clock_deadline_ns(bool include_external);

I started making changes and it seems that this parameter should never be true,
because this function is called either from cpus.c or from the tests.

Pavel Dovgalyuk

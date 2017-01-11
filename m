Received: from eggs.gnu.org ([2001:4830:134:3::10]:33840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cRD3n-0001s8-VF
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 02:11:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cRD3k-00031f-Pm
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 02:11:03 -0500
Received: from mail.ispras.ru ([83.149.199.45]:45566)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cRD3k-000306-IR
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 02:11:00 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <000301d259dc$f9d097c0$ed71c740$@ru>
	<000601d25a95$12b1b9f0$38152dd0$@ru>
	<20161220102126.GE5602@stefanha-x1.localdomain>
	<002501d25ab1$af024b00$0d06e100$@ru>
	<CAJSP0QXm9ssLC5C+gV_agkEW_fdUY=NWBMvHqMh55UhYTR276g@mail.gmail.com>
	<000301d25b4f$20018440$60048cc0$@ru>
	<CAJSP0QW1pOcthcEt16Pp5xQu3miUh2Leq3kn3yvQqWqhi1P=QQ@mail.gmail.com>
In-Reply-To: <CAJSP0QW1pOcthcEt16Pp5xQu3miUh2Leq3kn3yvQqWqhi1P=QQ@mail.gmail.com>
Date: Wed, 11 Jan 2017 10:10:59 +0300
Message-ID: <000801d26bd9$dca56db0$95f04910$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] qemu-2.8-rc4 is broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Stefan Hajnoczi' <stefanha@gmail.com>
Cc: 'qemu-devel' <qemu-devel@nongnu.org>, 'Paolo Bonzini' <pbonzini@redhat.com>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>, 'Peter Maydell' <peter.maydell@linaro.org>, =?UTF-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>

> From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> On Wed, Dec 21, 2016 at 5:57 AM, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
> >> -----Original Message-----
> >> From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> >> On Tue, Dec 20, 2016 at 11:10 AM, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
> >> >> From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> >> >> On Tue, Dec 20, 2016 at 10:45:44AM +0300, Pavel Dovgalyuk wrote:
> >> >> > It also fails much earlier when I enable logs with "-d int -D log".
> >> >> >
> >> >> Looks like a heap corruption bug since free() is failing.
> >> >
> >> > Seems to be a race condition.
> >> > When I add logs into invalidate_page_bitmap, the bug disappears.
> >> > It seems that someone tries to free the same page bitmap twice and simultaneously.
> >>
> >> Does the following workaround prevent the crashes?
> >>
> >> -global apic-common.vapic=off
> >
> > Yes, this option helps.
> > Thank you.
> 
> Good news.  This can be fixed in 2.8.1 once someone finds a solution.

It seems that something still goes wrong.
I'm using this workaround, but there is a kind of deadlock in translation.
call_rcu_thread hangs at some moment in qemu_event_wait.

As far as I understand, it is used by QHT in translate-all.c.
I can't get more information yet, because logging makes everything too slow.

Pavel Dovgalyuk

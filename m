Received: from eggs.gnu.org ([2001:4830:134:3::10]:50138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnm1M-0002XC-Ja
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnm1L-0006gh-Pg
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:57:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cnm1L-0006gb-K7
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:57:47 -0400
References: <20170303131113.25898-1-pbonzini@redhat.com>
	<20170303131113.25898-6-pbonzini@redhat.com>
	<871su1qfsu.fsf@linaro.org>
	<834de521-e5cc-8857-afeb-8734037f95f3@redhat.com>
	<87y3w9oxff.fsf@linaro.org>
	<2d503aaa-4853-a325-bc13-983528d02e09@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bb926742-7dbe-1147-4629-da565146a450@redhat.com>
Date: Tue, 14 Mar 2017 13:57:40 +0100
MIME-Version: 1.0
In-Reply-To: <2d503aaa-4853-a325-bc13-983528d02e09@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/5] icount: process QEMU_CLOCK_VIRTUAL
 timers in vCPU thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org



On 14/03/2017 11:05, Paolo Bonzini wrote:
>=20
>=20
> On 13/03/2017 19:15, Alex Benn=C3=A9e wrote:
>>> Well yeah, it's all those that pass qemu_clock_use_for_deadline.
>>
>> Have you done any testing with record/replay? So far I have one
>> reproducible run and one failure. However it is not entirely clear to =
me
>> how I am meant to cleanly halt and stop a machine so I don't corrupt t=
he
>> replay log.
>=20
> No, I haven't tried RR.

Tried now, it doesn't work but I won't have time to fix it.

I tried "-kernel /path/to/bzImage -icount 3,rr=3Drecord,rrfile=3Dreplay.b=
in
-net none".  record works, replay hangs.  The hang is at a "pause"
instruction.  With "-d in_asm" it still hangs, but a bit later (still in
the firmware).

Paolo

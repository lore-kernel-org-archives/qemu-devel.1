Received: from eggs.gnu.org ([2001:4830:134:3::10]:38080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnpET-00080b-N5
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:23:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnpEP-0001pE-7b
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:23:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cnpEP-0001ns-1g
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:23:29 -0400
References: <20170303131113.25898-1-pbonzini@redhat.com>
	<20170303131113.25898-6-pbonzini@redhat.com>
	<871su1qfsu.fsf@linaro.org>
	<834de521-e5cc-8857-afeb-8734037f95f3@redhat.com>
	<87y3w9oxff.fsf@linaro.org>
	<2d503aaa-4853-a325-bc13-983528d02e09@redhat.com>
	<bb926742-7dbe-1147-4629-da565146a450@redhat.com>
	<87r31zq2xa.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <328f4f7d-0b24-b673-eea1-0fe251851581@redhat.com>
Date: Tue, 14 Mar 2017 17:23:26 +0100
MIME-Version: 1.0
In-Reply-To: <87r31zq2xa.fsf@linaro.org>
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



On 14/03/2017 16:43, Alex Benn=C3=A9e wrote:
>>
>> I tried "-kernel /path/to/bzImage -icount 3,rr=3Drecord,rrfile=3Drepla=
y.bin
>> -net none".  record works, replay hangs.  The hang is at a "pause"
>> instruction.  With "-d in_asm" it still hangs, but a bit later (still =
in
>> the firmware).
> I'm happy to keep digging.
>=20
> So to be clear when you do the record step how do you save your state
> before you replay?

Here it hangs on the replay way before the end of the record, so it
wasn't an issue.

Paolo

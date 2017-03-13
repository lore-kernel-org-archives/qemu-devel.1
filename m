Received: from eggs.gnu.org ([2001:4830:134:3::10]:37566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cnPpH-0003L5-R3
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 09:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cnPpD-0006IJ-Rc
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 09:15:51 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:34537)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cnPpD-0006IA-Jl
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 09:15:47 -0400
Received: by mail-wr0-x22a.google.com with SMTP id l37so103437328wrc.1
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 06:15:47 -0700 (PDT)
References: <20170307155054.5833-1-alex.bennee@linaro.org>
	<001801d29bf5$dcba37d0$962ea770$@ru>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <001801d29bf5$dcba37d0$962ea770$@ru>
Date: Mon, 13 Mar 2017 13:16:01 +0000
Message-ID: <8760jdqpv2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 00/11] MTTCG fix-ups for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com, qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com


Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:

> Hi,
>
>> From: mttcg-request@listserver.greensocs.com [mailto:mttcg-request@listserver.greensocs.com]
>>
>> The next thing on my list it to look at the icount problems and review
>> Paolo's fixes for it. However those fixes should go in a separate
>> series and I assume via Paolo's tree.
>
> Do you mean those problems that completely broke icount?

Completely broke is a bit strong. Certainly I tested icount on my
patches but I missed the pathological failure mode that led to the
interaction between the BQL lock breaking patch and running a real
guest. It didn't break icount so much as slow down guests so much they
never got round to finishing their IRQ handling.

That certainly seems to be fixed by Paolo's patches.

> Are you going to fix it?

Yes. It is certainly not intentional to regress icount and it needs to
be fixed before we release 2.9.

If you can point me towards the record/replay test cases I'll make sure
I run them on the updated series.

>
>
>> Alex Bennée (9):
>>   vl/cpus: be smarter with icount and MTTCG
>>   target/i386/cpu.h: declare TCG_GUEST_DEFAULT_MO
>>   cpus.c: add additional error_report when !TARGET_SUPPORT_MTTCG
>>   sparc/sparc64: grab BQL before calling cpu_check_irqs
>>   s390x/misc_helper.c: wrap IO instructions in BQL
>>   target/xtensa: hold BQL for interrupt processing
>>   translate-all: exit cpu_restore_state early if translating
>>   target/arm/helper: make it clear the EC field is also in hex
>>   hw/intc/arm_gic: modernise the DPRINTF
>>
>> Paolo Bonzini (1):
>>   target-i386: defer VMEXIT to do_interrupt
>>
>> Yongbok Kim (1):
>>   target/mips: hold BQL for timer interrupts
>
>
> Pavel Dovgalyuk


--
Alex Bennée

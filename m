Received: from eggs.gnu.org ([2001:4830:134:3::10]:57896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fpXgG-0000ss-4i
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 07:40:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fpXgF-0003yt-A1
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 07:40:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36120 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fpXgF-0003yX-4B
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 07:40:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 438D181663F1
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 11:40:06 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <6c9bcc5b-21f0-60a8-bb8d-56861c2d4bd9@redhat.com> (Paolo
	Bonzini's message of "Fri, 10 Aug 2018 12:19:08 +0200")
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-3-quintela@redhat.com>
	<6c9bcc5b-21f0-60a8-bb8d-56861c2d4bd9@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 14 Aug 2018 13:40:02 +0200
Message-ID: <87ftzhw50t.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 02/22] config: CONFIG_SERIAL* is already
 in pci.mak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 08/08/2018 13:48, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  default-configs/alpha-softmmu.mak       | 2 --
>>  default-configs/arm-softmmu.mak         | 2 --
>>  default-configs/hppa-softmmu.mak        | 3 ---
>>  default-configs/i386-softmmu.mak        | 2 --
>>  default-configs/mips-softmmu-common.mak | 2 --
>>  default-configs/ppc-softmmu.mak         | 1 -
>>  default-configs/ppcemb-softmmu.mak      | 2 --
>>  default-configs/sh4-softmmu.mak         | 2 --
>>  default-configs/sh4eb-softmmu.mak       | 2 --
>>  default-configs/sparc64-softmmu.mak     | 2 --
>>  default-configs/x86_64-softmmu.mak      | 2 --
>>  11 files changed, 22 deletions(-)
>
> I don't think CONFIG_SERIAL_ISA should be in pci.mak though

agreed.

>, and
> CONFIG_SERIAL is a dependency of both CONFIG_SERIAL and
> CONFIG_SERIAL_PCI.

I guess you here mean CONFIG_SERIAL_ISA or CONFIG_SERIAL_PCI.  That is
not enough.  CONFIG_SERIAL really means CONFIG_SERIAL_COMMON, and things
like riscv* require it (i.e. basically all the weird(*) boards have a
serial port)



> Perhaps introduce a superio.mak with all the legacy
> ISA devices?

What are the surperio.mak or isa.mak.  And once there, what are the isa
devices?  Weird things that came to my mind that can't be disabled:

- mmmouse
- serial-isa
- fdc
- vmport
- vga-isa (this is another weird thing)
- ipmi-isa?
- what else?

Later, Juan.

(*): weird here means that they don't have PCI available.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:60755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpXsE-0000LE-7x
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 07:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpXsB-0002jI-6Z
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 07:52:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36436 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fpXsB-0002j2-0K
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 07:52:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 814A1818F03C
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 11:52:26 +0000 (UTC)
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-3-quintela@redhat.com>
	<6c9bcc5b-21f0-60a8-bb8d-56861c2d4bd9@redhat.com>
	<87ftzhw50t.fsf@trasno.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1169fde5-2c97-bf04-d3eb-8b43d49b37f6@redhat.com>
Date: Tue, 14 Aug 2018 13:52:24 +0200
MIME-Version: 1.0
In-Reply-To: <87ftzhw50t.fsf@trasno.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On 14/08/2018 13:40, Juan Quintela wrote:
>> CONFIG_SERIAL is a dependency of both CONFIG_SERIAL and
>> CONFIG_SERIAL_PCI.
> 
> I guess you here mean CONFIG_SERIAL_ISA or CONFIG_SERIAL_PCI.  That is
> not enough.  CONFIG_SERIAL really means CONFIG_SERIAL_COMMON, and things
> like riscv* require it

Right, I would put

   CONFIG_SERIAL=y
   CONFIG_SERIAL_ISA=y

in superio.mak and

   CONFIG_SERIAL=y
   CONFIG_SERIAL_PCI=y

in pci.mak.

>> Perhaps introduce a superio.mak with all the legacy
>> ISA devices?
> What are the surperio.mak or isa.mak.  And once there, what are the isa
> devices?  Weird things that came to my mind that can't be disabled:
> 
> - mmmouse

msmouse is a character device backend, not a device model

> - serial-isa
> - fdc
> - vmport
> - vga-isa (this is another weird thing)
> - ipmi-isa?
> - what else?

SuperIO is RTC, I8254, I8257, I8259, ISA serial, parallel, floppy.  They
can all be disabled (well, no guarantee that it compiles but the option
is there).

Paolo

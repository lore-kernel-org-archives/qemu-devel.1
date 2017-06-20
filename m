Received: from eggs.gnu.org ([2001:4830:134:3::10]:50767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dNGvL-0003kx-BI
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 07:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dNGvG-00033j-FG
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 07:02:19 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:36708)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dNGvG-00033D-37
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 07:02:14 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <CADR1n+V8R1LOGzbwdBDt5axeZ0mqh=WSCsfUo0Vr2nmE6BYqTQ@mail.gmail.com>
Date: Tue, 20 Jun 2017 14:02:02 +0300
In-Reply-To: <CADR1n+V8R1LOGzbwdBDt5axeZ0mqh=WSCsfUo0Vr2nmE6BYqTQ@mail.gmail.com>
	(Jayanto Minocha's message of "Mon, 19 Jun 2017 14:15:21 -0700")
Message-ID: <8760fqorbp.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Tracing guest virtual addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jayanto Minocha <jayanto@gmail.com>
Cc: qemu-devel@nongnu.org

Jayanto Minocha writes:

> Hi,
> I think there have been a few threads on the mailing list regarding tracing
> guest virtual addresses for load and store instructions, but I have been
> unable to get it to work. I am trying this for an AArch64 machine, and am
> using the softmmu.

> The tracing infrastructure provides the following event:

> vcpu tcg guest_mem_before(...).

> But that is only used to instrument the cpu_ld/cpu_st macros, which is only
> called in the case of a tlb miss.

> I've been going over the archives, and it looks like I need to instrument
> tcg_out_tlb_load. Am I on the right path ?

That event should trace all guest memory accesses performed by the CPU. If you
found any case where this does not hold, it is likely a bug and I'd appreciate
it if you can point me to the smallest possible failing example.


Thanks,
  Lluis

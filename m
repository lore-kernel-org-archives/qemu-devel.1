Received: from eggs.gnu.org ([2001:4830:134:3::10]:49948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpZ1L-0003YZ-Sv
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 09:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpZ1H-0008Qv-R4
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 09:05:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36246 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fpZ1H-0008QH-Lp
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 09:05:55 -0400
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-3-quintela@redhat.com>
	<6c9bcc5b-21f0-60a8-bb8d-56861c2d4bd9@redhat.com>
	<87ftzhw50t.fsf@trasno.org>
	<1169fde5-2c97-bf04-d3eb-8b43d49b37f6@redhat.com>
	<CAFEAcA-OY_4v3apC4xcB7HQwN=BGqdxuQenhnPntOXqybUx5hA@mail.gmail.com>
	<e23307f9-981f-1322-3dc1-136bc83b8ad9@redhat.com>
	<CAFEAcA-F3aemS1-OuRYOmg_20V3qeX2EhMNRQ6wxbjud=k=98g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3358abaa-65ea-e9fa-b382-f49bde1f3ca7@redhat.com>
Date: Tue, 14 Aug 2018 15:05:50 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-F3aemS1-OuRYOmg_20V3qeX2EhMNRQ6wxbjud=k=98g@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 14/08/2018 14:57, Peter Maydell wrote:
> On 14 August 2018 at 13:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On 14/08/2018 14:06, Peter Maydell wrote:
>>> What about the boards that use the serial.c code but do not
>>> have PCI, ISA or a superio chip? That is, all the boards/devices
>>> that call serial_mm_init() directly to create a memory-mapped
>>> 16550.
>>
>> They just add
>>
>>    CONFIG_SERIAL=y
>>
>> to the .mak file.
> 
> ...but the patch that has kicked off this thread is *removing*
> CONFIG_SERIAL=y from the various .mak files...

Probably because they were including pci.mak.  Indeed CONFIG_SERIAL=y
should remain in the
ARM/HPPA/Microblaze/MIPS/Mozie/NiOS2/OpenRISC/PPC/RiscV/SH/SPARC64/Xtensa
.mak files.

Another possibility would be to split .mak files per-machine, and
include the per-machine file in the toplevel.

Thanks,

Paolo

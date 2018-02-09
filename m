Received: from eggs.gnu.org ([2001:4830:134:3::10]:54400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1ekGWb-0000YR-6C
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 16:48:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1ekGWa-0007pH-5J
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 16:48:05 -0500
Received: from mail-ua0-x242.google.com ([2607:f8b0:400c:c08::242]:32850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatol.pomozov@gmail.com>)
	id 1ekGWa-0007os-0k
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 16:48:04 -0500
Received: by mail-ua0-x242.google.com with SMTP id p12so6091640uad.0
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 13:48:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180129200210.GT6141@localhost.localdomain>
References: <20171012235439.19457-1-anatol.pomozov@gmail.com>
	<20171012235439.19457-2-anatol.pomozov@gmail.com>
	<20180115144944.GG32271@localhost.localdomain>
	<CAOMFOmU4pLtJMQ_SLqffpritydx4ghs9gUJBfyVT+zN_fudCRA@mail.gmail.com>
	<20180129200210.GT6141@localhost.localdomain>
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Fri, 9 Feb 2018 13:48:02 -0800
Message-ID: <CAOMFOmXrp8x18Jph8ipR+m52FxdjcpaLoHP_Xh-4F6X95pG+8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/4] multiboot: Change multiboot_info from
 array of bytes to a C struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi Kevin

Is the patch series look good? Are there any other unresolved issues?

On Mon, Jan 29, 2018 at 12:02 PM, Kevin Wolf <kwolf@redhat.com> wrote:
> Am 29.01.2018 um 19:21 hat Anatol Pomozov geschrieben:
>> Hi
>>
>> On Mon, Jan 15, 2018 at 6:49 AM, Kevin Wolf <kwolf@redhat.com> wrote:
>> > Am 13.10.2017 um 01:54 hat Anatol Pomozov geschrieben:
>> >> Using C structs makes the code more readable and prevents type conversion
>> >> errors.
>> >>
>> >> Borrow multiboot1 header from GRUB project.
>> >>
>> >> Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
>> >> ---
>> >>  hw/i386/multiboot.c         | 124 +++++++++------------
>> >>  hw/i386/multiboot_header.h  | 254 ++++++++++++++++++++++++++++++++++++++++++++
>> >>  tests/multiboot/mmap.c      |  14 +--
>> >>  tests/multiboot/mmap.out    |  10 ++
>> >>  tests/multiboot/modules.c   |  12 ++-
>> >>  tests/multiboot/modules.out |  10 ++
>> >>  tests/multiboot/multiboot.h |  66 ------------
>> >>  7 files changed, 339 insertions(+), 151 deletions(-)
>> >>  create mode 100644 hw/i386/multiboot_header.h
>> >>  delete mode 100644 tests/multiboot/multiboot.h
>> >
>> > This is a good change in general. However, I'm not sure if we should
>> > really replace the header used in the tests. After all, the tests also
>> > test whether things are at the right place, and if there is an error in
>> > the header file, we can only catch it if the tests keep using their own
>> > definitions.
>>
>> The added multibooh.h is from GRUB - the developers of multiboot. I
>> think we can trust it. Having a single header will make future tests
>> maintainence easier.
>>
>> But if you feel strongly that qemu tests should use it's own version
>> of multiboot header then I can add it back.
>
> No, I don't feel strongly, just wanted to mention that there is an
> advantage of having a separate header in case you had not thought of it.
> The decision is up to you.

I think it is better to use one standard trusted header. This way we
reduce maintenance cost.

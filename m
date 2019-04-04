Received: from eggs.gnu.org ([209.51.188.92]:40557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hBqkZ-00005H-FD
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 21:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hBqkT-0005eA-Iu
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 21:00:59 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:33340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hBqkR-0005WZ-8F
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 21:00:57 -0400
Received: by mail-pf1-x442.google.com with SMTP id i19so461249pfd.0
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 18:00:50 -0700 (PDT)
Date: Wed, 03 Apr 2019 18:00:48 -0700 (PDT)
In-Reply-To: <CAKmqyKOAMGBcgRscu9QzpQYsA=qTeGgkK+03F=0YRhtzUFaXVw@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-8467ed04-3f36-4b0c-a53c-270a3ef88074@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 4.0 v2 0/2] Update the QEMU PLIC
 addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alistair23@gmail.com
Cc: Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org

On Wed, 03 Apr 2019 16:32:11 PDT (-0700), alistair23@gmail.com wrote:
> On Wed, Mar 27, 2019 at 8:23 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> On Wed, 27 Mar 2019 11:51:15 PDT (-0700), Alistair Francis wrote:
>> > This series updates the PLIC address to match the documentation.
>> >
>> > This fixes: https://github.com/riscv/opensbi/issues/97
>> >
>> > V2:
>> >  - Squash patches to ensure biesctability
>> >
>> > Alistair Francis (2):
>> >   riscv: plic: Fix incorrect irq calculation
>> >   riscv: plic: Log guest errors
>> >
>> >  hw/riscv/sifive_plic.c      | 16 +++++++++++-----
>> >  hw/riscv/sifive_u.c         |  2 +-
>> >  include/hw/riscv/sifive_e.h |  2 +-
>> >  include/hw/riscv/sifive_u.h |  4 ++--
>> >  include/hw/riscv/virt.h     |  2 +-
>> >  5 files changed, 16 insertions(+), 10 deletions(-)
>> >
>> > --
>> > 2.21.0
>>
>> Thanks, I've got these on for-master.  I'll let them sit for a bit to see if
>> there are any other comments, but
>>
>> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
>
> Ping! Just want to make sure these make it into 4.0

Thanks, this got lost in the shuffle.  I just forwarded along the PR.

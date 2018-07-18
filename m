Received: from eggs.gnu.org ([2001:4830:134:3::10]:42761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ffu3b-0001Kn-DI
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 17:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ffu3a-0000oX-Hw
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 17:32:23 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:47083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ffu3a-0000nu-9Z
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 17:32:22 -0400
Received: by mail-lj1-x244.google.com with SMTP id 203-v6so5343795ljj.13
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 14:32:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8b9563c3-1e1d-4a34-8995-48e90aaea9fd@redhat.com>
References: <cover.1531859179.git.alistair.francis@wdc.com>
	<8b9563c3-1e1d-4a34-8995-48e90aaea9fd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 18 Jul 2018 14:31:50 -0700
Message-ID: <CAKmqyKOfS3qKKr8mvVsgcObXKX=6VBAiLG1yHb9DVJhWwWJsPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 0/5] riscv: Fix introspection problems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Alistair Francis <alistair.francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Michael Clark <mjc@sifive.com>, Markus Armbruster <armbru@redhat.com>

On Wed, Jul 18, 2018 at 12:22 AM, Thomas Huth <thuth@redhat.com> wrote:
> On 17.07.2018 22:27, Alistair Francis wrote:
>> This is based on Thomas's work fixing introspection problems [1] and
>> applied to the RISC-V port.
>>
>> 1: https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg03261.html
>>
>> Alistair Francis (5):
>>   sifive_e: Fix crash when introspecting the device
>>   sifive_u: Fix crash when introspecting the device
>>   virt: Fix crash when introspecting the device
>>   riscv_hart: Fix crash when introspecting the device
>>   spike: Fix crash when introspecting the device
>>
>>  hw/riscv/riscv_hart.c |  7 +++----
>>  hw/riscv/sifive_e.c   | 12 ++++++------
>>  hw/riscv/sifive_u.c   | 15 +++++++--------
>>  hw/riscv/spike.c      | 10 ++++------
>>  hw/riscv/virt.c       |  5 ++---
>>  5 files changed, 22 insertions(+), 27 deletions(-)
>
> That's interesting, these issues did not appear in my tests (modified
> tests/device-introspect-test.c with hmp("info qtree")). Likely because
> device-introspect-test only checks with the "none" machine ==> one more
> reason to test here with all machines, too (I suggested such a patch a
> couple of months ago) ...

What happened to the patch? More tests would be super handy.

Alistair

>
>  Thomas
>
>

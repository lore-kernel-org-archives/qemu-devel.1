Received: from eggs.gnu.org ([2001:4830:134:3::10]:53918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fhk1d-0000Mp-9n
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 19:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fhk1c-0004SM-Ay
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 19:13:57 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:38162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fhk1c-0004S5-36
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 19:13:56 -0400
Received: by mail-lj1-x243.google.com with SMTP id p6-v6so1954574ljc.5
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 16:13:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d10ee58e-2b2b-7064-ae13-c07ba2040a07@redhat.com>
References: <cover.1531859179.git.alistair.francis@wdc.com>
	<8b9563c3-1e1d-4a34-8995-48e90aaea9fd@redhat.com>
	<CAKmqyKOfS3qKKr8mvVsgcObXKX=6VBAiLG1yHb9DVJhWwWJsPw@mail.gmail.com>
	<d10ee58e-2b2b-7064-ae13-c07ba2040a07@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 23 Jul 2018 16:13:24 -0700
Message-ID: <CAKmqyKNuqj=VgXRtVzHWjj3udYjYdEU5ENZQUpWeDAG2RdFxTQ@mail.gmail.com>
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

On Thu, Jul 19, 2018 at 12:59 AM, Thomas Huth <thuth@redhat.com> wrote:
> On 18.07.2018 23:31, Alistair Francis wrote:
>> On Wed, Jul 18, 2018 at 12:22 AM, Thomas Huth <thuth@redhat.com> wrote:
>>> On 17.07.2018 22:27, Alistair Francis wrote:
>>>> This is based on Thomas's work fixing introspection problems [1] and
>>>> applied to the RISC-V port.
>>>>
>>>> 1: https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg03261.html
>>>>
>>>> Alistair Francis (5):
>>>>   sifive_e: Fix crash when introspecting the device
>>>>   sifive_u: Fix crash when introspecting the device
>>>>   virt: Fix crash when introspecting the device
>>>>   riscv_hart: Fix crash when introspecting the device
>>>>   spike: Fix crash when introspecting the device
>>>>
>>>>  hw/riscv/riscv_hart.c |  7 +++----
>>>>  hw/riscv/sifive_e.c   | 12 ++++++------
>>>>  hw/riscv/sifive_u.c   | 15 +++++++--------
>>>>  hw/riscv/spike.c      | 10 ++++------
>>>>  hw/riscv/virt.c       |  5 ++---
>>>>  5 files changed, 22 insertions(+), 27 deletions(-)
>>>
>>> That's interesting, these issues did not appear in my tests (modified
>>> tests/device-introspect-test.c with hmp("info qtree")). Likely because
>>> device-introspect-test only checks with the "none" machine ==> one more
>>> reason to test here with all machines, too (I suggested such a patch a
>>> couple of months ago) ...
>>
>> What happened to the patch? More tests would be super handy.
>
> It was only a RFC since at that point in time, there were lots of other
> crashes, so it could not be merged yet:
>
> http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg05033.html
>
> I think the other crashes are now fixed, too, so we could consider this
> again. I'll put it on my TODO list to respin it for 3.1 ...

It looks super useful! I'll use this to test the RISC-V stuff a bit
more as well.

Alistair

>
>  Thomas

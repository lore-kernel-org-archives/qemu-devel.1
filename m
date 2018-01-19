Received: from eggs.gnu.org ([2001:4830:134:3::10]:39536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1ecbWz-0006rs-7h
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:36:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1ecbWx-00006m-Vc
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:36:49 -0500
Received: from mail-ua0-x244.google.com ([2607:f8b0:400c:c08::244]:38756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatol.pomozov@gmail.com>)
	id 1ecbWx-00006c-Qt
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:36:47 -0500
Received: by mail-ua0-x244.google.com with SMTP id t7so1701641uae.5
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 10:36:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2f56a075-ba01-4329-b46c-33b3d40000cb@oracle.com>
References: <1513877118-3149-1-git-send-email-jack.schwartz@oracle.com>
	<20180115155413.GJ32271@localhost.localdomain>
	<2f56a075-ba01-4329-b46c-33b3d40000cb@oracle.com>
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Fri, 19 Jan 2018 10:36:46 -0800
Message-ID: <CAOMFOmXs17F4WnLZ_ThvYoNDO7R557vf3QNHSYq6RR_WvkL3uA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH QEMU v1 0/4] multiboot: bss_end_addr can be
 zero / cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jack Schwartz <jack.schwartz@oracle.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, daniel.kiper@oracle.com, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, QEMU Developers <qemu-devel@nongnu.org>

Hello Jack

On Wed, Jan 17, 2018 at 12:06 PM, Jack Schwartz
<jack.schwartz@oracle.com> wrote:
> Hi Kevin and Anatol.
>
> Kevin, thanks for your review.
>
> More inline below...
>
> On 01/15/18 07:54, Kevin Wolf wrote:
>>
>> Am 21.12.2017 um 18:25 hat Jack Schwartz geschrieben:
>>>
>>> Properly account for the possibility of multiboot kernels with a zero
>>> bss_end_addr.  The Multiboot Specification, section 3.1.3 allows for
>>> kernels without a bss section, by allowing a zeroed bss_end_addr
>>> multiboot
>>> header field.
>>>
>>> Do some cleanup to multiboot.c as well:
>>> - Remove some unused variables.
>>> - Use more intuitive header names when displaying fields in messages.
>>> - Change fprintf(stderr...) to error_report
>>
>> There are some conflicts with Anatol's (CCed) multiboot series:
>> https://lists.nongnu.org/archive/html/qemu-devel/2017-10/msg03003.html
>>
>> None if these should be hard to resolve, but it would be good if you
>> could agree with each other whose patch series should come first, and
>> then the other one should be rebased on top of that.
>
> Anatol,
>
> from my side, there are pros and cons to either patch set going in first,
> but advantages to either are pretty negligible.  Pro for you going first: I
> can use the constants you will define in header files.  Pro for me going
> first: your merge should be about the same as if you went first (since my
> changes are small, more localized and affect only multiboot.c) and my merge
> will be easier.
>
> What are your thoughts?

Please move ahead with your patches. I'll rebase my changes on top of yours.

>>
>> Testing:
>>    1) Ran the "make check" test suite.
>>    2) Booted multiboot kernel with bss_end_addr=0.  (I rolled my own
>>       grub multiboot.elf test "kernel" by modifying source.)  Verified
>>       with gdb that new code that reads addresses/offsets from multiboot
>>       header was accessed.
>>    3) Booted multiboot kernel with non-zero bss_end_addr.
>>    4) Uncommented DEBUG_MULTIBOOT in multiboot.c and verified messages
>> worked.
>>    5) Code has soaked in an internal repo for two months.
>> Can you integrate your test kernel from 2) in tests/multiboot/ so we can
>> keep this as a regression test?
>
> Kevin and alias,
>
> Before I proceed with adding my multiboot test file, I'll clarify here that
> I started with a version from the grub2 tree.  In that file I expanded a
> header file, also from the same tree.  Neither file had any license header,
> though the tree I got them from (Dated October 2017) contains the GNU GPLv3
> license file.
>
> I'll need to check with my company before I can say I can deliver this file.
> If I deliver it, I'll add a header stating the GPL license, that it came
> from grub2 and to check its repository for contributors.
>>>
>>> Jack Schwartz (4):
>>>    multiboot: bss_end_addr can be zero
>>>    multiboot: Remove unused variables from multiboot.c
>>>    multiboot: Use header names when displaying fields
>>>    multiboot: fprintf(stderr...) -> error_report()
>>
>> Apart from the conflicts, the patches look good to me.
>
>     Thanks,
>     Jack
>>
>>
>> Kevin
>>
>

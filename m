Received: from eggs.gnu.org ([2001:4830:134:3::10]:35372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1ebtyB-0001zA-8w
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 15:06:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1ebty4-0006PM-Uu
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 15:05:59 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jack.schwartz@oracle.com>)
	id 1ebty4-0006MC-N9
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 15:05:52 -0500
References: <1513877118-3149-1-git-send-email-jack.schwartz@oracle.com>
	<20180115155413.GJ32271@localhost.localdomain>
From: Jack Schwartz <jack.schwartz@oracle.com>
Message-ID: <2f56a075-ba01-4329-b46c-33b3d40000cb@oracle.com>
Date: Wed, 17 Jan 2018 12:06:15 -0800
MIME-Version: 1.0
In-Reply-To: <20180115155413.GJ32271@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Kevin Wolf <kwolf@redhat.com>, Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: ehabkost@redhat.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, daniel.kiper@oracle.com, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org

Hi Kevin and Anatol.

Kevin, thanks for your review.

More inline below...

On 01/15/18 07:54, Kevin Wolf wrote:
> Am 21.12.2017 um 18:25 hat Jack Schwartz geschrieben:
>> Properly account for the possibility of multiboot kernels with a zero
>> bss_end_addr.  The Multiboot Specification, section 3.1.3 allows for
>> kernels without a bss section, by allowing a zeroed bss_end_addr multi=
boot
>> header field.
>>
>> Do some cleanup to multiboot.c as well:
>> - Remove some unused variables.
>> - Use more intuitive header names when displaying fields in messages.
>> - Change fprintf(stderr...) to error_report
> There are some conflicts with Anatol's (CCed) multiboot series:
> https://lists.nongnu.org/archive/html/qemu-devel/2017-10/msg03003.html
>
> None if these should be hard to resolve, but it would be good if you
> could agree with each other whose patch series should come first, and
> then the other one should be rebased on top of that.
Anatol,

from my side, there are pros and cons to either patch set going in=20
first, but advantages to either are pretty negligible.=C2=A0 Pro for you=20
going first: I can use the constants you will define in header files.=C2=A0=
=20
Pro for me going first: your merge should be about the same as if you=20
went first (since my changes are small, more localized and affect only=20
multiboot.c) and my merge will be easier.

What are your thoughts?
> Testing:
>    1) Ran the "make check" test suite.
>    2) Booted multiboot kernel with bss_end_addr=3D0.  (I rolled my own
>       grub multiboot.elf test "kernel" by modifying source.)  Verified
>       with gdb that new code that reads addresses/offsets from multiboo=
t
>       header was accessed.
>    3) Booted multiboot kernel with non-zero bss_end_addr.
>    4) Uncommented DEBUG_MULTIBOOT in multiboot.c and verified messages =
worked.
>    5) Code has soaked in an internal repo for two months.
> Can you integrate your test kernel from 2) in tests/multiboot/ so we ca=
n
> keep this as a regression test?
Kevin and alias,

Before I proceed with adding my multiboot test file, I'll clarify here=20
that I started with a version from the grub2 tree.=C2=A0 In that file I=20
expanded a header file, also from the same tree.=C2=A0 Neither file had a=
ny=20
license header, though the tree I got them from (Dated October 2017)=20
contains the GNU GPLv3 license file.

I'll need to check with my company before I can say I can deliver this=20
file.=C2=A0 If I deliver it, I'll add a header stating the GPL license, t=
hat=20
it came from grub2 and to check its repository for contributors.
>> Jack Schwartz (4):
>>    multiboot: bss_end_addr can be zero
>>    multiboot: Remove unused variables from multiboot.c
>>    multiboot: Use header names when displaying fields
>>    multiboot: fprintf(stderr...) -> error_report()
> Apart from the conflicts, the patches look good to me.
 =C2=A0=C2=A0=C2=A0 Thanks,
 =C2=A0=C2=A0=C2=A0 Jack
>
> Kevin
>

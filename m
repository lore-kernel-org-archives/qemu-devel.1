Received: from eggs.gnu.org ([2001:4830:134:3::10]:35959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1etOFp-0005Eb-MM
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 20:52:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1etOFl-0005Zz-Oc
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 20:52:29 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jack.schwartz@oracle.com>)
	id 1etOFl-0005Xo-FA
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 20:52:25 -0500
From: Jack Schwartz <jack.schwartz@oracle.com>
References: <1513877118-3149-1-git-send-email-jack.schwartz@oracle.com>
	<20180115155413.GJ32271@localhost.localdomain>
	<45620ce8-23c6-3ad5-2393-a5f48c2a9f58@oracle.com>
	<20180305081302.GA4789@localhost.localdomain>
Message-ID: <8cfdcb24-5137-a7e6-91de-ab705a22bd78@oracle.com>
Date: Tue, 6 Mar 2018 17:52:08 -0800
MIME-Version: 1.0
In-Reply-To: <20180305081302.GA4789@localhost.localdomain>
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
To: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, Anatol Pomozov <anatol.pomozov@gmail.com>, konrad.wilk@oracle.com, daniel.kiper@oracle.com, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ppandit@redhat.com

Hi Kevin and everyone.

On 2018-03-05 00:13, Kevin Wolf wrote:
> Am 02.03.2018 um 20:32 hat Jack Schwartz geschrieben:
>> Hi Kevin.
>>
>> On 2018-01-15 07:54, Kevin Wolf wrote:
>>> Am 21.12.2017 um 18:25 hat Jack Schwartz geschrieben:
>>>> Properly account for the possibility of multiboot kernels with a zer=
o
>>>> bss_end_addr.  The Multiboot Specification, section 3.1.3 allows for
>>>> kernels without a bss section, by allowing a zeroed bss_end_addr mul=
tiboot
>>>> header field.
>>>>
>>>> Do some cleanup to multiboot.c as well:
>>>> - Remove some unused variables.
>>>> - Use more intuitive header names when displaying fields in messages.
>>>> - Change fprintf(stderr...) to error_report
>>> There are some conflicts with Anatol's (CCed) multiboot series:
>>> https://lists.nongnu.org/archive/html/qemu-devel/2017-10/msg03003.htm=
l
>>>
>>> None if these should be hard to resolve, but it would be good if you
>>> could agree with each other whose patch series should come first, and
>>> then the other one should be rebased on top of that.
>>>
>>>> Testing:
>>>>     1) Ran the "make check" test suite.
>>>>     2) Booted multiboot kernel with bss_end_addr=3D0.  (I rolled my =
own
>>>>        grub multiboot.elf test "kernel" by modifying source.)  Verif=
ied
>>>>        with gdb that new code that reads addresses/offsets from mult=
iboot
>>>>        header was accessed.
>>>>     3) Booted multiboot kernel with non-zero bss_end_addr.
>>>>     4) Uncommented DEBUG_MULTIBOOT in multiboot.c and verified messa=
ges worked.
>>>>     5) Code has soaked in an internal repo for two months.
>>> Can you integrate your test kernel from 2) in tests/multiboot/ so we =
can
>>> keep this as a regression test?
>> If need be, would you be willing to accept updated versions of these p=
atches
>> (with another review, of course) without the test file?=C2=A0 I will d=
eliver the
>> test file later once I get company approvals.=C2=A0 I don't want the t=
est file to
>> continue holding everything up in the meantime.
> Sure, let's move forward with what we have now. Please keep me CCed whe=
n
> you send a new version and I'll give it a review and hopeuflly get it
> merged.
>
> Kevin
Thanks, Kevin.

Patches have not changed, and I verified they still work on a current=20
repo.=C2=A0 (Multiboot.c has had a one-line change regarding a header fil=
e,=20
so I rebuilt and re-tested to make sure.)

Links again, for your reference:

1/4 multiboot: bss_end_addr can be zero
http://patchwork.ozlabs.org/patch/852049/

2/4 multiboot: Remove unused variables from multiboot.c
http://patchwork.ozlabs.org/patch/852045/

3/4 multiboot: Use header names when displaying fields
http://patchwork.ozlabs.org/patch/852046/

4/4 multiboot: fprintf(stderr...) -> error_report()
http://patchwork.ozlabs.org/patch/852051/

 =C2=A0=C2=A0=C2=A0 Thanks,
 =C2=A0=C2=A0=C2=A0 Jack

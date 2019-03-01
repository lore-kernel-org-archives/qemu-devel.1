Received: from eggs.gnu.org ([209.51.188.92]:51710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzmOp-0007Jl-Iz
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 12:56:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzmOo-00029N-Gh
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 12:56:43 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gzmOo-00026j-9f
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 12:56:42 -0500
Received: by mail-wr1-x443.google.com with SMTP id d17so26763594wre.10
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 09:56:39 -0800 (PST)
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
	<1549390526-24246-14-git-send-email-pbonzini@redhat.com>
	<87sgw6k02i.fsf@zen.linaroharston>
	<20190301171343.dyuqan3ok6gzuotw@steredhat>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190301171343.dyuqan3ok6gzuotw@steredhat>
Date: Fri, 01 Mar 2019 17:56:36 +0000
Message-ID: <87o96ujx63.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 13/76] pvh: Add x86/HVM direct boot ABI
 header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org


Stefano Garzarella <sgarzare@redhat.com> writes:

> On Fri, Mar 01, 2019 at 04:53:57PM +0000, Alex Benn=C3=A9e wrote:
>>
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>
>> > From: Liam Merwick <Liam.Merwick@oracle.com>
>> >
>> > The x86/HVM direct boot ABI permits Qemu to be able to boot directly
>> > into the uncompressed Linux kernel binary with minimal firmware involv=
ement.
>> >
>> > 	https://xenbits.xen.org/docs/unstable/misc/pvh.html
>> >
>> > This commit adds the header file that defines the start_info struct
>> > that needs to be populated in order to use this ABI.
>> >
>> > The canonical version of start_info.h is in the Xen codebase.
>> > (like QEMU, the Linux kernel uses a copy as well).
>> >
>> > Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
>> > Reviewed-by: Konrad Rzeszutek Wilk <Konrad.Wilk@oracle.com>
>> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>
>> This has changed behaviour of a boot. Previously:
>>
>>   qemu-system-i386 -serial mon:stdio -nographic -device \
>>      isa-debugcon,chardev=3Dserial0 -kernel ./tests/hello
>>
>
> Hi Alex,
> is your image in multiboot format?

AFAICT yes, I'm not super familiar with x86 so I'm mostly cribbing from:

  https://github.com/doug65536/qemu-bmibug

> I sent a patch few weeks ago that fix the loading of multiboot images:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg596424.html

That certainly fixes things. Although I'm wondering if it's worth making
my test image PVH compatible anyway (if it's easy to do) as all I really
want to do is exercise the softmmu code. It might be simpler to use
paravirtualised serial ports rather than banging an IO port, IDK?

>
> Thanks,
> Stefano
>
>> would boot seabios which then loads the -kernel. Now we get:
>>
>>   qemu-system-i386: Error loading uncompressed kernel without PVH ELF No=
te
>>
>> I'm personally not overly concerned (and being able to boot directly
>> sounds like a win for my test case). However is this likely to break
>> anybodies existing workflow?
>>
>> Are there any examples of the minimum setup for a directly booted i386
>> kernel image anywhere?
>>
>> --
>> Alex Benn=C3=A9e
>>


--
Alex Benn=C3=A9e

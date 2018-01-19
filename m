Received: from eggs.gnu.org ([2001:4830:134:3::10]:43178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ecZW1-0000Xj-JF
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:27:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ecZVw-000137-T3
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:27:41 -0500
Received: from mail-qt0-f178.google.com ([209.85.216.178]:39449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1ecZVw-00012h-P5
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:27:36 -0500
Received: by mail-qt0-f178.google.com with SMTP id f4so5127614qtj.6
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 08:27:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8tuBBcdOJCnUSUVQbXqJ0RU9NA2rGMv_RBcCWKO2QQrA@mail.gmail.com>
References: <20180117144756.31049-1-marcandre.lureau@redhat.com>
	<595f00e6-d5ad-b7c6-29be-7c6e135f9d12@redhat.com>
	<CAFEAcA_M7FazuMDpne5Fr=hQUmfp75BHqttYOWV+HJ9zinW6mA@mail.gmail.com>
	<CAMxuvazG-y3XpE09oBRCJtB1OcNSbOP4heyGXYFHpLMbFj7VnA@mail.gmail.com>
	<CAFEAcA-Z4PbC+Ze7uGriu-V+qJcLMVjEjeYJsrMbgemnHAu6bQ@mail.gmail.com>
	<CAFEAcA9gv3LsbPkYpqsotZ-7Xigx1obkwMjGxF3ttnxDDK=+KA@mail.gmail.com>
	<CAMxuvazc7W_CtOwZ7XqAjZaJpy_PSq=6Uf9bS7+siyoowPPX4w@mail.gmail.com>
	<CAFEAcA8tuBBcdOJCnUSUVQbXqJ0RU9NA2rGMv_RBcCWKO2QQrA@mail.gmail.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Fri, 19 Jan 2018 17:27:35 +0100
Message-ID: <CAMxuvaxQnjNjVRBWcfVeN=f3G=8eL8XB_v_FZJKicP4_-tWyAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Dump patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Jan 19, 2018 at 5:21 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 19 January 2018 at 16:08, Marc-Andre Lureau <mlureau@redhat.com> wrote:
>> Hi
>>
>> On Fri, Jan 19, 2018 at 4:29 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> On 19 January 2018 at 15:24, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>> On 19 January 2018 at 14:35, Marc-Andre Lureau <mlureau@redhat.com> wrote:
>>>>> I have not found how to translate a python 'buffer' to a bytes string
>>>>> in 2.6.
>>>>
>>>> A local python expert suggests that "bytes(buffer)" should work.
>>>
>>> ...and that it ought to work if handed a memoryview too, so do we
>>> just want
>>>
>>>    self.elf.add_vmcoreinfo_note(bytes(vmcoreinfo))
>>>
>>
>> Yes, I tested on 2.6 and 3.6, it works. I'll send a new patch.
>
> Testing 2.7 as well would probably not be a bad plan. Apparently
> this works because:
>  * on python 3, bytes(memoryview) and memoryview.to_bytes() are the same
>  * gdb gives us a memoryview only if python 3
>  * so we don't have to handle the case of getting a memoryview and
>    being python 2 (in which case we would need to use memoryview.to_bytes()
>    as bytes() would do the wrong thing)

I just tested with 2.7 as well, works fine too.

Updated patch sent.

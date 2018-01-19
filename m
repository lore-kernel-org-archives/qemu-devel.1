Received: from eggs.gnu.org ([2001:4830:134:3::10]:38161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ecZDx-0002Nc-E0
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:09:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ecZDu-0001kQ-8U
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:09:01 -0500
Received: from mail-qt0-f170.google.com ([209.85.216.170]:38398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1ecZDu-0001k9-3w
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:08:58 -0500
Received: by mail-qt0-f170.google.com with SMTP id z10so4973377qti.5
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 08:08:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9gv3LsbPkYpqsotZ-7Xigx1obkwMjGxF3ttnxDDK=+KA@mail.gmail.com>
References: <20180117144756.31049-1-marcandre.lureau@redhat.com>
	<595f00e6-d5ad-b7c6-29be-7c6e135f9d12@redhat.com>
	<CAFEAcA_M7FazuMDpne5Fr=hQUmfp75BHqttYOWV+HJ9zinW6mA@mail.gmail.com>
	<CAMxuvazG-y3XpE09oBRCJtB1OcNSbOP4heyGXYFHpLMbFj7VnA@mail.gmail.com>
	<CAFEAcA-Z4PbC+Ze7uGriu-V+qJcLMVjEjeYJsrMbgemnHAu6bQ@mail.gmail.com>
	<CAFEAcA9gv3LsbPkYpqsotZ-7Xigx1obkwMjGxF3ttnxDDK=+KA@mail.gmail.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Fri, 19 Jan 2018 17:08:57 +0100
Message-ID: <CAMxuvazc7W_CtOwZ7XqAjZaJpy_PSq=6Uf9bS7+siyoowPPX4w@mail.gmail.com>
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

Hi

On Fri, Jan 19, 2018 at 4:29 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 19 January 2018 at 15:24, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 19 January 2018 at 14:35, Marc-Andre Lureau <mlureau@redhat.com> wrote:
>>> I have not found how to translate a python 'buffer' to a bytes string
>>> in 2.6.
>>
>> A local python expert suggests that "bytes(buffer)" should work.
>
> ...and that it ought to work if handed a memoryview too, so do we
> just want
>
>    self.elf.add_vmcoreinfo_note(bytes(vmcoreinfo))
>

Yes, I tested on 2.6 and 3.6, it works. I'll send a new patch.

Thanks!
